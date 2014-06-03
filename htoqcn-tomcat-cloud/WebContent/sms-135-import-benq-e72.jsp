<%@ page pageEncoding="UTF-8" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%
		Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new FileInputStream("D:/htoqcn/sms/BenQ-E72/All_2012_09_25_23_41.xml"));
		NodeList list = doc.getElementsByTagName("MESSAGE");
		int len = list.getLength();
		Date min = new Date(), max = new Date(0L);
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss"), df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		for (int i = 0; i < len; i++) {
			Element elem = (Element) list.item(i);
			String date = elem.getAttribute("Date");
			String time = elem.getAttribute("Time");

			Date ret = df.parse(date + ' ' + time);
			if (ret.before(min))
				min = ret;
			if (ret.after(max))
				max = ret;
		}
		System.out.print("count: ");
		System.out.println(len);
		System.out.println(min);
		System.out.println(max);

		java.sql.Connection conn = null;
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rs = null;
		try {
			javax.naming.Context ctx = new javax.naming.InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
			conn = ds.getConnection();

			pstmt = conn.prepareStatement("INSERT INTO SMS_135 (Partner, SendRecv, TheTime, Content, Device) VALUES (?, ?, ?, ?, ?)");
			out.println("<html><head><meta charset=\"UTF-8\"></head><body>Delete Device = 10 first, to clear all records from BENQ-E72.<br><table border=\"1\">");
			list = doc.getElementsByTagName("CONVERSATION");
			len = list.getLength();
			for (int i = 0; i < len; i++) {
				Element elem = (Element) list.item(i);
				out.println("<tr>");
				out.print("<td>");
				out.print(elem.getAttribute("Contact"));
				out.println("</td>");
				out.println("<td>");
				out.println("<table border=\"1\">");
				NodeList list0 = elem.getElementsByTagName("MESSAGE");
				int len0 = list0.getLength();
				for (int j = 0; j < len0; j++) {
					Element elem0 = (Element) list0.item(j);
					pstmt.setObject(1, elem.getAttribute("Contact"));
					pstmt.setObject(2, "1".equals(elem0.getAttribute("Direction")) ? "0" : "1");
					pstmt.setObject(3, df2.format(df.parse(elem0.getAttribute("Date") + ' ' + elem0.getAttribute("Time"))));
					pstmt.setObject(4, ((Element) elem0.getElementsByTagName("TEXT").item(0)).getTextContent());
					pstmt.setObject(5, 10);
					pstmt.executeUpdate();

					out.print("<tr bgcolor=\"");
					if ("1".equals(elem0.getAttribute("Direction")))
						out.print("#aaaaaa");
					else
						out.print("#ffffff");
					out.print("\">");
					out.print("<td>");
					out.print(elem0.getAttribute("Date"));
					out.print(' ');
					out.print(elem0.getAttribute("Time"));
					out.println("</td>");
					out.print("<td><pre>");
					out.print(((Element) elem0.getElementsByTagName("TEXT").item(0)).getTextContent());
					out.println("</pre></td>");
					out.println("</tr>");
				}
				out.println("</table>");
				out.println("</td>");
			}
			out.println("</table></body></html>");
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
%>