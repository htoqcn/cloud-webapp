<%@ page pageEncoding="utf-8" %><%@ page import="java.math.BigDecimal" %><!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content" content="text/html; charset=UTF-8">
		<title>Import SMS 135</title>
	</head>
	<body>
<%
	request.setCharacterEncoding("UTF-8");
	String content = request.getParameter("content");
	String io = request.getParameter("sendrecv");
	String partner = request.getParameter("partner");
	String theTime = request.getParameter("thetime");
	String device = request.getParameter("device");
%>
		<form method="post">
			<table>
				<tr>
					<td>
						Content: <textarea rows="4" cols="140" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td>Inbox/Sent: <select name="sendrecv"><option value="0">Inbox</option><option value="1">Sent</option></select></td>
				</tr>
				<tr>
					<td>Partner Number:<input type="text" name="partner"></td>
				</tr>
				<tr>
					<td>Time: <input type="text" name="thetime"></td>
				</tr>
				<tr>
					<td>Device: <select name="device"><option value="1">Nokia</option></td>
				</tr>
				<tr>
					<td><input type="submit" value="Add"></td>
				</tr>
				<tr>
					<td>
<%
	if (content != null) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO SMS_135 (Partner, SendRecv, TheTime, Content, Device) VALUES (?, ?, ?, ?, ?)");
			pstmt.setObject(1, partner);
			pstmt.setObject(2, io);
			pstmt.setObject(3, theTime);
			pstmt.setObject(4, content);
			pstmt.setObject(5, device);
			int ret = pstmt.executeUpdate();
			out.println("Successful. Return: " + ret);
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
