<%@ page import="java.math.BigDecimal" %><!DOCTYPE HTML>
<html>
	<head>
		<title>白银投资分析</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<style type="text/css">
table.datax td {
	font-family: Courier New;
	text-align: right;
}
		</style>
	</head>
	<body>
<%
	String date = request.getParameter("d");
	if (date != null) {
		final BigDecimal BD_100 = new BigDecimal(100.);
		final java.text.DecimalFormat DCF = new java.text.DecimalFormat("#.00");
		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement pstmt = null, pstmt0 = null;
		java.sql.ResultSet rs = null, rs0 = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("SELECT LEFT(TheDate, 6) AS month, SUM(Gain), SUM(ProcessFee), SUM(Interest) FROM TD_MAIN WHERE TheDate <= ? GROUP BY month ORDER BY month DESC");
			pstmt.setObject(1, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {%>
		<table>
			<tr>
				<td rowspan="4">
					<table class="datax" border="1" cellspacing="3" cellpadding="3">
						<thead>
							<tr>
								<th>月份</th>
								<th>总盈亏</th>
								<th>总手续费</th>
								<th>总递延费</th>
								<th>汇总</th>
							</tr>
						</thead>
						<tbody>
<%
				do {
					long gain = ((Number) rs.getObject(2)).longValue();
					long processFee = ((Number) rs.getObject(3)).longValue();
					long interest = ((Number) rs.getObject(4)).longValue();
					long item = gain + processFee + interest;%>
							<tr>
								<td><%= rs.getObject(1) %></td>
								<td><%= DCF.format(new BigDecimal(gain).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(processFee).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(interest).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(item).divide(BD_100)) %></td>
							</tr>
				<%} while (rs.next());%>
						</tbody>
					</table>
				</td>
				<td valign="top">说明：<br>1) 所有统计截至时间：<%= date %><br><br><br>
					<table class="datax" border="1" cellspacing="3" cellpadding="3">
						<thead>
							<tr>
								<th>年份</th>
								<th>总盈亏</th>
								<th>总手续费</th>
								<th>总递延费</th>
								<th>汇总</th>
							</tr>
						</thead>
						<tbody>
<%
				pstmt0 = conn.prepareStatement("SELECT LEFT(TheDate, 4) AS TheYear, SUM(GAIN) sg, SUM(ProcessFee) sp, SUM(INTEREST) si FROM TD_MAIN WHERE TheDate <= ? GROUP BY TheYear ORDER BY TheYear DESC");
				pstmt0.setObject(1, date);
				rs0 = pstmt0.executeQuery();
				long sumGain = 0L;
				long sumProcessFee = 0L;
				long sumInterest = 0L;
				long sumItem = 0L;
				while (rs0.next()) {
					long gain = ((Number) rs0.getObject(2)).longValue();
					long processFee = ((Number) rs0.getObject(3)).longValue();
					long interest = ((Number) rs0.getObject(4)).longValue();
					long item = gain + processFee + interest;
					sumGain += gain;
					sumProcessFee += processFee;
					sumInterest += interest;
					sumItem += item; %>
							<tr>
								<td><%= rs0.getObject(1) %></td>
								<td><%= DCF.format(new BigDecimal(gain).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(processFee).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(interest).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(item).divide(BD_100)) %></td>
							</tr>
				<%}
				rs0.close();%>
						</tbody>
						<tfoot>
							<tr>
								<td>合计</td>
								<td><%= DCF.format(new BigDecimal(sumGain).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(sumProcessFee).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(sumInterest).divide(BD_100)) %></td>
								<td><%= DCF.format(new BigDecimal(sumItem).divide(BD_100)) %></td>
							</tr>
						</tfoot>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top"><%
				stmt = conn.createStatement();

				long maxInterest = 0L;
				java.util.List<String> maxInterestDates = new java.util.LinkedList<String>();
				long minInterest = 0L;
				java.util.List<String> minInterestDates = new java.util.LinkedList<String>();

				rs0 = stmt.executeQuery("SELECT INTEREST, TheDate FROM TD_MAIN WHERE INTEREST = (SELECT MAX(INTEREST) FROM TD_MAIN)");
				while (rs0.next()) {
					maxInterest = rs0.getLong(1);
					maxInterestDates.add(rs0.getString(2));
				}
				rs0.close();

				rs0 = stmt.executeQuery("SELECT INTEREST, TheDate FROM TD_MAIN WHERE INTEREST = (SELECT MIN(INTEREST) FROM TD_MAIN)");
				while (rs0.next()) {
					minInterest = rs0.getLong(1);
					minInterestDates.add(rs0.getString(2));
				}
				rs0.close();

				long maxGain = 0L;
				java.util.List<String> maxGainDates = new java.util.LinkedList<String>();
				long minGain = 0L;
				java.util.List<String> minGainDates = new java.util.LinkedList<String>();

				rs0 = stmt.executeQuery("SELECT GAIN, TheDate FROM TD_MAIN WHERE GAIN = (SELECT MAX(GAIN) FROM TD_MAIN)");
				while (rs0.next()) {
					maxGain = rs0.getLong(1);
					maxGainDates.add(rs0.getString(2));
				}
				rs0.close();

				rs0 = stmt.executeQuery("SELECT GAIN, TheDate FROM TD_MAIN WHERE GAIN = (SELECT MIN(GAIN) FROM TD_MAIN)");
				while (rs0.next()) {
					minGain = rs0.getLong(1);
					minGainDates.add(rs0.getString(2));
				}
				rs0.close();

				long minProcessFee = 0L;
				java.util.List<String> minProcessFeeDates = new java.util.LinkedList<String>();

				rs0 = stmt.executeQuery("SELECT ProcessFee, TheDate FROM TD_MAIN WHERE ProcessFee = (SELECT MIN(ProcessFee) FROM TD_MAIN)");
				while (rs0.next()) {
					minProcessFee = rs0.getLong(1);
					minProcessFeeDates.add(rs0.getString(2));
				}
				rs0.close();

					%>递延费<br>
					<table class="datax" border="1" cellspacing="3" cellpadding="3">
						<tr>
							<td>最高</td>
							<td><%= DCF.format(new BigDecimal(maxInterest).divide(BD_100)) %></td>
							<td><%
								for (String itemDate : maxInterestDates) {
									out.print(itemDate);
									out.println("<br>");
								}
							%></td>
						</tr>
						<tr>
							<td>最低</td>
							<td><%= DCF.format(new BigDecimal(minInterest).divide(BD_100)) %></td>
							<td><%
								for (String itemDate : minInterestDates) {
									out.print(itemDate);
									out.println("<br>");
								}
							%></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					盈亏<br>
					<table class="datax" border="1" cellspacing="3" cellpadding="3">
						<tr>
							<td>最高</td>
							<td><%= DCF.format(new BigDecimal(maxGain).divide(BD_100)) %></td>
							<td><%
								for (String itemDate : maxGainDates) {
									out.print(itemDate);
									out.println("<br>");
								}
							%></td>
						</tr>
						<tr>
							<td>最低</td>
							<td><%= DCF.format(new BigDecimal(minGain).divide(BD_100)) %></td>
							<td><%
								for (String itemDate : minGainDates) {
									out.print(itemDate);
									out.println("<br>");
								}
							%></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					手续费<br>
					<table class="datax" border="1" cellspacing="3" cellpadding="3">
						<tr>
							<td>最多</td>
							<td><%= DCF.format(new BigDecimal(minProcessFee).divide(BD_100)) %></td>
							<td><%
								for (String itemDate : minProcessFeeDates) {
									out.print(itemDate);
									out.println("<br>");
								}
							%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
<%
			}
		} finally {
			try {
				rs0.close();
			} catch (Exception e) {
			}

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
	} else {
		out.println("No 'd=yyyyMMdd' parameter found.");
	}
%>
	</body>
</html>
