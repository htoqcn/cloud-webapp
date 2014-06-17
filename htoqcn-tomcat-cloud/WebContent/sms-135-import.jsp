<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.StringReader"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@ page import="java.math.BigDecimal" %><!DOCTYPE HTML>
<html>
	<head>
		<title>Import SMS 135</title>
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
					<td>
<%
	if (content != null) {
		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO SMS_135 (Partner, SendRecv, TheTime, Content, Device) VALUES (?, ?, ?, ?, ?)");

			Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new ByteArrayInputStream(content.getBytes("UTF-8")));
			int count = 0;
			for (Node nodeSms = doc.getFirstChild(); nodeSms != null; nodeSms = nodeSms.getNextSibling()) {
				if (nodeSms instanceof Element) {
					Element elemSms = (Element) nodeSms;

					for (Node nodeItem = elemSms.getFirstChild(); nodeItem != null; nodeItem = nodeItem.getNextSibling()) {
						if (nodeItem instanceof Element) {
							Element elemItem = (Element) nodeItem;

							pstmt.setString(1, elemItem.getAttribute("partner"));
							pstmt.setString(2, elemItem.getAttribute("send_recv"));
							pstmt.setString(3, elemItem.getAttribute("the_time"));
							pstmt.setString(4, elemItem.getTextContent());
							pstmt.setInt(5, -1);
							pstmt.executeUpdate();
							count++;
						}
					}
					break;
				}
			}
			out.println("Import items: " + count);
		} finally {
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
