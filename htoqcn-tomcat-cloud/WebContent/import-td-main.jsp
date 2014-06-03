<%@ page import="java.math.BigDecimal" %><!DOCTYPE HTML>
<html>
	<head>
		<title>Import TD Main</title>
	</head>
	<body>
<%
	String content = request.getParameter("content");
%>
		<form method="post">
			<table>
				<tr>
					<td>
						<textarea rows="25" cols="140" name="content"></textarea><br><input type="submit" value="Execute">
					</td>
				</tr>
				<tr>
					<td>Header should not be included. Duplicated date will throw exception.</td>
				</tr>
				<tr>
					<td>
<%
	if (content != null) {
		final BigDecimal BD_100 = new BigDecimal("100.00"), BD_476 = new BigDecimal("476.00");
		final java.util.regex.Pattern PATT_TAB = java.util.regex.Pattern.compile("\t"), PATT_LF = java.util.regex.Pattern.compile("\n");

		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			// Get the latest balance
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM TD_MAIN WHERE TheDate = (SELECT MAX(TheDate) FROM TD_MAIN)");
			BigDecimal balance = new BigDecimal(14000);
			if (rs.next()) {
				do {
					Number idle = (Number) rs.getObject("Idle");
					Number used = (Number) rs.getObject("Used");
					balance = new BigDecimal(idle.longValue() + used.longValue()).divide(BD_100);
				} while (rs.next());
			}
			rs.close();

			pstmt = conn.prepareStatement("INSERT INTO TD_MAIN VALUES (?, ?, ?, ?, ?, ?, ?)");
			boolean error = false;
			String[] lines = PATT_LF.split(content);
			for (String line : lines) {
				line = line.trim();
				String[] cols = PATT_TAB.split(line);
				String date = cols[1];
				BigDecimal idle = new BigDecimal(cols[2]);
				BigDecimal used = new BigDecimal(cols[4]);
				BigDecimal gain = new BigDecimal(cols[3]);
				BigDecimal processFee = new BigDecimal(cols[7]);
				BigDecimal ioFund = new BigDecimal(cols[8]);

				pstmt.setObject(1, date);
				pstmt.setObject(2, used.multiply(BD_100).longValue());
				pstmt.setObject(3, idle.multiply(BD_100).longValue());
				pstmt.setObject(4, gain.multiply(BD_100).longValue());
				pstmt.setObject(5, processFee.multiply(BD_100).longValue());
				pstmt.setObject(6, 0L);
				pstmt.setObject(7, ioFund.multiply(BD_100).longValue());
				balance = balance.add(gain).add(processFee).add(ioFund);
				BigDecimal curBal = idle.add(used);
				if (!balance.equals(curBal)) {
					BigDecimal offset = curBal.subtract(balance);

					if (offset.abs().compareTo(BD_476) > 0) {
						out.println("Error: [" + date + "] has offset: " + offset + "<br>");
						error = true;
						break;
					}
					pstmt.setObject(6, offset.multiply(BD_100).longValue());
					balance = curBal;
				}
				pstmt.addBatch();
			}

			if (!error) {
				int[] ret = pstmt.executeBatch();
				out.println("Update count: " + ret.length);
			}
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
			}

			try {
				pstmt.close();
			} catch (Exception e) {
			}

			try {
				stmt.close();
			} catch (Exception e) {
			}

			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}
%>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
