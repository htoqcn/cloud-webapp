<%@ page import="java.math.BigDecimal" %><%@ page import="java.sql.Types" %><!DOCTYPE HTML>
<html>
	<head>
		<title>Import Account Book</title><%-- SELECT month, sum(amount) from (SELECT SUBSTR(thedate, 1, 7) as month, amount from account_book where mod(flag, 10) < 2) group by month order by month --%>
	</head>
	<body>
<%
	String content = request.getParameter("content");
%>
		Import Steps:<br>
		1) Access http://j.life-py.appspot.com/bill-month-query and copy to this textarea<br>
		2) /import-account-book-ext.jsp
		3) Check MainID of ACCOUNT_BOOK_EXT
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
		final java.util.regex.Pattern PATT_PIPE = java.util.regex.Pattern.compile("\\|"), PATT_LF = java.util.regex.Pattern.compile("\n");

		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO ACCOUNT_BOOK (AddTime, Amount, TheDate, Description, PayDate, PayWay, Flag) VALUES (?, ?, ?, ?, ?, ?, ?)");
			boolean error = false;
			String[] lines = PATT_LF.split(content);
			int count = 0;
			for (String line : lines) {
				line = line.trim();
				String[] cols = PATT_PIPE.split(line);
				Long amount = Long.valueOf(cols[1]);
				String theDate = cols[2];
				String description = cols[3];
				String payDate = cols[4];

				if (cols[0].length() > 0)
					pstmt.setObject(1, cols[0]);
				else
					pstmt.setNull(1, Types.VARCHAR);
				pstmt.setObject(2, amount);
				pstmt.setObject(3, theDate);
				pstmt.setObject(4, description);
				pstmt.setObject(5, payDate);
				if (cols[5].length() > 0)
					pstmt.setObject(6, Integer.valueOf(cols[5]));
				else
					pstmt.setNull(6, Types.INTEGER);
				if (cols[6].length() > 0)
					pstmt.setObject(7, Integer.valueOf(cols[6]));
				else
					pstmt.setNull(7, Types.INTEGER);

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
