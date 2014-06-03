<%@ page import="java.math.BigDecimal" %><%@ page import="java.sql.Types" %><!DOCTYPE HTML>
<html>
	<head>
		<title>Import Account Book Ext</title>
	</head>
	<body>
<%
	String content = request.getParameter("content");
%>
		<form method="post">
			<table>
				<tr>
					<td>
						<textarea rows="25" cols="140" name="content"></textarea><br><input type="submit" value="Import">
					</td>
				</tr>
				<tr>
					<td>
<%
	if (content != null) {
		BigDecimal BD_100 = new BigDecimal(100);
		final java.util.regex.Pattern PATT_PIPE = java.util.regex.Pattern.compile("\\|"), PATT_LF = java.util.regex.Pattern.compile("\n");

		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO ACCOUNT_BOOK_EXT (Amount, TheDate, Description, Delta) VALUES (?, ?, ?, ?)");
			boolean error = false;
			String[] lines = PATT_LF.split(content);
			int count = 0;
			for (String line : lines) {
				line = line.trim();
				String[] cols = PATT_PIPE.split(line);
				String theDate = cols[0];
				Long amount = new BigDecimal(cols[1].trim()).multiply(BD_100).longValue();
				String description = cols[2];
				Long delta = new BigDecimal(cols[3].trim()).multiply(BD_100).longValue();
				pstmt.setObject(1, amount);
				pstmt.setObject(2, theDate);
				pstmt.setObject(3, description);
				pstmt.setObject(4, delta);

				pstmt.executeUpdate();
				count++;
			}
			out.println("Add items: " + count);
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
