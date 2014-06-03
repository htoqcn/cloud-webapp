<%
	java.sql.Connection conn = null;
	java.sql.Statement stmt = null;
	try {
		javax.naming.Context ctx = new javax.naming.InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
		conn = ds.getConnection();

		stmt = conn.createStatement();
		stmt.executeUpdate("CREATE TABLE TestTable (ID INT PRIMARY KEY)");
	} finally {
		try {
			stmt.close();
		} catch (Exception e) {
		}

		try {
			conn.close();
		} catch (Exception e) {
		}
	}
%>
