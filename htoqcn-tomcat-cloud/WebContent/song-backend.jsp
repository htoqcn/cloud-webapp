<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@ page contentType="application/javascript;charset=UTF-8" %>
<%
	java.sql.Connection conn = null;
	java.sql.Statement stmt = null;
	java.sql.PreparedStatement pstmt = null;
	java.sql.ResultSet rs = null;
	
	try {
		javax.naming.Context ctx = new javax.naming.InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
		conn = ds.getConnection();

		String mode = request.getParameter("m");
		if (!"1".equals(mode)) {
			String theName = request.getParameter("tn");
			String name = null;
			if (theName == null || (name = theName.trim()).length() <= 0) {
%>alert('没有指定名字');<%
			} else {
				try {
					pstmt = conn.prepareStatement("INSERT INTO SONGS (TheName) VALUES (?)");
					pstmt.setString(1, name);
					pstmt.executeUpdate();
%>alert('添加成功');document.getElementById('the-name').select();<%
				} catch (SQLIntegrityConstraintViolationException sicve) {
%>alert('名称已经存在');<%
				}
			}
		}

		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT TheName FROM SONGS");
		out.print("document.getElementById('output').innerHTML = '<table border=\"1\">");
		java.util.Map<String, String> map = new java.util.TreeMap<String, String>();
		final char[] hexArray = "0123456789ABCDEF".toCharArray();
		while (rs.next()) {
			String itemName = rs.getString(1);
			byte[] bytes = itemName.getBytes("GBK");
			char[] hexChars = new char[bytes.length * 2];
			for ( int j = 0; j < bytes.length; j++ ) {
				int v = bytes[j] & 0xFF;
				hexChars[j * 2] = hexArray[v >>> 4];
				hexChars[j * 2 + 1] = hexArray[v & 0x0F];
			}
			map.put(new String(hexChars), itemName);
		}
		int cols = 7, status = 0;
		for (java.util.Map.Entry<String, String> entry : map.entrySet()) {
			if (status == 0)
				out.print("<tr>");

			out.print("<td>");
			out.print(entry.getValue());
			out.print("</td>");

			if (++status == cols) {
				out.print("</tr>");
				status = 0;
			}
		}
		if (status > 0) {
			while (status < cols) {
				out.print("<td>&nbsp;</td>");
	
				if (++status == cols) {
					out.print("</tr>");
				}
			}
		}
		out.println("</table>';");
	} finally {
		try {
			pstmt.close();
		} catch (Exception e) {}

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
