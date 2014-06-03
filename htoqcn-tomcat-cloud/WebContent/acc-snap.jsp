<%
	java.sql.Connection conn = null;
	java.sql.Statement stmt = null;
	java.sql.ResultSet rs = null;
	try {
		javax.naming.Context ctx = new javax.naming.InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM ACCOUNT_BOOK ORDER BY PayDate");
		final java.math.BigDecimal BD_100 = new java.math.BigDecimal(100.);
		final java.text.DecimalFormat DCF = new java.text.DecimalFormat("#.00");

		long balance = 499359L;
		String lastDate = null;
		long amountThatDay = 0L;
		int count = 0;
		while (rs.next()) {
			String curDate = rs.getString("PAYDATE");
			if (curDate.equals(lastDate)) {
			} else {
				out.print(lastDate);
				out.print(": ");
				out.print(DCF.format(new java.math.BigDecimal(balance).divide(BD_100)));
				out.println("<br>");
				amountThatDay = 0L;
			}
		
			long amount = rs.getLong("AMOUNT");
			balance -= amount;
			amountThatDay += amount;
			lastDate = curDate;
			count++;
		}
		if (amountThatDay != 0L) {
			out.print(lastDate);
			out.print(": ");
			out.print(DCF.format(new java.math.BigDecimal(balance).divide(BD_100)));
			out.println("<br>");
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
%>