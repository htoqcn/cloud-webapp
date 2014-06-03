<%@ page pageEncoding="utf-8" %><!DOCTYPE HTML>
<html>
	<head>
		<title>SQL Executor</title>
		<meta http-equiv="content" content="text/html; charset=UTF-8">
	</head>
	<body>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = request.getParameter("sql");
%>
		<form method="post">
			<table>
				<tr>
					<td>
						<textarea rows="10" cols="80" name="sql"><%= sql == null ? "" : sql %></textarea><br><input type="submit" value="Execute">
					</td>
				</tr>
				<tr>
					<td>
<%
	if (sql != null) {
		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			stmt = conn.createStatement();
			boolean ret = stmt.execute(sql);
			if (ret) {
				rs = stmt.getResultSet();
%>
						<table border="1">
							<thead>
<%
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int colCount = rsmd.getColumnCount();
				for (int i = 0; i < colCount; i++) {
%>
								<th><%= rsmd.getColumnName(i + 1) %></th>
<%
				}
%>
							</thead>
							<tbody>
<%
				while (rs.next()) {
%>
							<tr>
<%
					for (int i = 0; i < colCount; i++) {
%>
								<td><%= /*rsmd.getColumnType(i + 1) == java.sql.Types.VARCHAR ? new String(rs.getBytes(i + 1), "UTF-8") : */rs.getObject(i + 1) %></td>
<%
					}
%>
							</tr>
<%
				}
%>
							</tbody>
						</table>
<%
			} else {
%>
						Update count: <%= stmt.getUpdateCount() %>
<%
			}
		} finally {
			try {
				rs.close();
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
