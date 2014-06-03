<%@ page import="java.math.BigDecimal" %><!DOCTYPE HTML>
<html>
	<head>
		<title>Import TD Main</title>
	</head>
	<body>
<%
	request.setCharacterEncoding("UTF-8");
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
<%!
private static String mergeNumber(String lastNumber, String curLine) {
	return "+".equals(curLine) ? lastNumber : curLine;
}

private static String mergeDatetime(String lastDatetime, String curLine) {
	// merge
	String result;
	if (lastDatetime == null) {
		result = curLine;
	} else {
		StringBuffer buf = new StringBuffer(lastDatetime.length());
		for (int i = 0; i < lastDatetime.length(); i++) {
			char ch = curLine.charAt(i);
			buf.append(ch == '-' ? lastDatetime.charAt(i) : ch);
		}

		result = buf.toString();
	}

	return result;
}
%>
<%
	if (content != null) {
		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO SMS_135 (Partner, SendRecv, TheTime, Content, Device) VALUES (?, ?, ?, ?, ?)");
			final java.util.regex.Pattern PAT_LF = java.util.regex.Pattern.compile("\\\n");
			final java.util.regex.Pattern PAT_PIPE = java.util.regex.Pattern.compile("\\|");
			String[] lines = PAT_LF.split(content);
			String lastNumber = null;
			String lastDatetime = null;
			int count = 0;
			for (int i = 0; i < lines.length; i++) {
				String line = lines[i].trim();
				if (line.length() <= 0)
					continue;
				String[] cols = PAT_PIPE.split(line);
				if (cols.length != 3) {
					out.println("Column count is not 3. line number: " + i + "<br>");
					break;
				}

				lastNumber = mergeNumber(lastNumber, cols[0].trim());
				lastDatetime = mergeDatetime(lastDatetime, cols[1].trim());
				// new SimpleMessage(lastNumber, hostNumber, lastDatetime, cols[2]).save();

				String realNumber = lastNumber;
				if (realNumber.startsWith("S"))
					realNumber = "106" + realNumber.substring(1);
				else if (realNumber.startsWith("T"))
					realNumber = "106550" + realNumber.substring(1);
				else if (realNumber.startsWith("F"))
					realNumber = "12520" + realNumber.substring(1);
				pstmt.setObject(1, realNumber);
				pstmt.setObject(2, 1);
				pstmt.setObject(3, lastDatetime);
				pstmt.setObject(4, cols[2]);
				pstmt.setObject(5, 1);
				pstmt.executeUpdate();
				count++;
			}
			out.println("Import items: " + count);
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
