<%@ page pageEncoding="UTF-8" %>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
	final Map<String, String> CONTACTS = new HashMap<String, String>();
	CONTACTS.put("13856576142", "422(旧)");
	CONTACTS.put("13107725262", "546JW");
	CONTACTS.put("15889620867", "718@ShZh");
	CONTACTS.put("13866981904", "718@LuJ");
	CONTACTS.put("13728969927", "Amy");
	CONTACTS.put("13528847013", "Angel");
	CONTACTS.put("18602098072", "彼岸花");
	CONTACTS.put("15820750162", "不急羊");
	CONTACTS.put("13632760262", "陈姨(小姨同学)");
	CONTACTS.put("13685527133", "陈姨2");
	CONTACTS.put("13632760262", "陈观英");
	CONTACTS.put("13865235161", "陈孝珍");
	CONTACTS.put("13714539472", "陈亚丽");
	CONTACTS.put("13699790144", "崔金城");
	CONTACTS.put("13918142980", "发");             // who?
	CONTACTS.put("13689583870", "房东");           // who?
	CONTACTS.put("15556521618", "方雲");
	CONTACTS.put("15056251765", "方雲2");
	CONTACTS.put("15156568650", "方雲3");
	CONTACTS.put("13528715841", "方玉嫦");
	CONTACTS.put("15957429022", "丰玉婷");
	CONTACTS.put("13723789073", "付跃雄-老号");
	CONTACTS.put("13723728377", "广深车/高校");
	CONTACTS.put("13570895016", "郭佳曼");
	CONTACTS.put("15045814606", "郭泽江");
	CONTACTS.put("13510205091", "何成燕");
	CONTACTS.put("15019472359", "何琴艳");
	CONTACTS.put("13357353977", "何琴艳2");
	CONTACTS.put("13590283147", "贺林");
	CONTACTS.put("13510213706", "贺新");
	CONTACTS.put("13923888558", "胡贺军");
	CONTACTS.put("13656756909", "胡建峤");
	CONTACTS.put("13923726552", "胡茂伟");
	CONTACTS.put("75588282871", "环球资源");
	CONTACTS.put("13439066427", "黄鑫@北京");
	CONTACTS.put("13421386523", "黄鑫@深圳");
	CONTACTS.put("13798509340", "冀丽萍");
	CONTACTS.put("13602493593", "黎晨");
	CONTACTS.put("15919465579", "李娟");
	CONTACTS.put("13866685926", "理想年代903");
	CONTACTS.put("13855053916", "李秀方@大学");
	CONTACTS.put("15889620872", "李秀方@深圳");
	CONTACTS.put("13923857015", "梁艳");
	CONTACTS.put("13728278347", "梁莹");
	CONTACTS.put("13148865119", "刘件平");
	CONTACTS.put("13631634615", "刘小鑫");
	CONTACTS.put("15889757434", "刘子枫");
	CONTACTS.put("15302659027", "刘子枫3");
	CONTACTS.put("13434451508", "罗德才");
	CONTACTS.put("18688953536", "罗德才-新");
	CONTACTS.put("13980208800", "罗内江");
	CONTACTS.put("13966761231", "马小莉");
	CONTACTS.put("13537723226", "明珠荔景");
	CONTACTS.put("13543291276", "欧姆");            // who?
	CONTACTS.put("13590118470", "彭");
	CONTACTS.put("13915780637", "彭克霞");
	CONTACTS.put("15056958056", "青苹果");
	CONTACTS.put("13570352923", "丘春雁");
	CONTACTS.put("15820431186", "宋海涛");
	CONTACTS.put("13923774990", "苏维");
	CONTACTS.put("13865916777", "孙盼盼");
	CONTACTS.put("13691476376", "陶夫人");
	CONTACTS.put("13728665878", "万茂武");
	CONTACTS.put("13723446417", "王芳");
	CONTACTS.put("13632761736", "王倩");
	CONTACTS.put("13418455316", "吴毓群");
	CONTACTS.put("13717137457", "细细");
	CONTACTS.put("13570580541", "徐畅@联文");       // is it?
	CONTACTS.put("13682681858", "徐毓");
	CONTACTS.put("13731995229", "许成淑");
	CONTACTS.put("13083097588", "许成漳");
	CONTACTS.put("13713887669", "杨柳");            // is it?
	CONTACTS.put("18603020170", "杨显峰");
	CONTACTS.put("15385171830", "姚明珏3");
	CONTACTS.put("13510269762", "于敦澍");
	CONTACTS.put("13426062299", "张金发");
	CONTACTS.put("13855106002", "张坤鹏");
	CONTACTS.put("13410080032", "张舒基");
	CONTACTS.put("18929378061", "张舒基2");
	CONTACTS.put("13605546825", "胡静");
	CONTACTS.put("13418551415", "张显@深圳");
	CONTACTS.put("13798973986", "张馨");
	CONTACTS.put("15155960611", "张馨@合肥");
	CONTACTS.put("15221957281", "张馨@上海");
	CONTACTS.put("13526551701", "张翼");
	CONTACTS.put("13035589351", "张韵婷2");
	CONTACTS.put("18923746636", "圳租客1");
	CONTACTS.put("13691675994", "郑敬颂");
	CONTACTS.put("18680391106", "郑宇");
	CONTACTS.put("13865252025", "朱凤莲");
	CONTACTS.put("13510709229", "朱海波");
	CONTACTS.put("15000745449", "朱庆萍");

	CONTACTS.put("15956582981", "305");
	CONTACTS.put("13966373953", "416");
	CONTACTS.put("13865286435", "4162");
	CONTACTS.put("13856207999", "422");
	CONTACTS.put("18269798951", "430");
	CONTACTS.put("15345658052", "435");
	CONTACTS.put("13966367941", "518");
	CONTACTS.put("5523325975", "538");
	CONTACTS.put("18655295618", "538-3G");
	CONTACTS.put("13155218543", "538C");
	CONTACTS.put("5523711290", "538H");
	CONTACTS.put("5522059648", "538O");
	CONTACTS.put("18858189005", "546JW-新");
	CONTACTS.put("13485718849", "625");
	CONTACTS.put("13502257142", "626");            // is it?
	CONTACTS.put("13696531967", "626-HF");
	CONTACTS.put("13136155705", "650");
	CONTACTS.put("18868751946", "650-3G");
	CONTACTS.put("18814889736", "680NK");
	CONTACTS.put("15810769966", "688VCQ");
	CONTACTS.put("15920063082", "691YGK");
	CONTACTS.put("15021170697", "778");
	CONTACTS.put("13063442768", "778-2nd");
	CONTACTS.put("18721825412", "779");
	CONTACTS.put("75561941387", "包裹诈骗");
	CONTACTS.put("13723476080", "邓志明");
	CONTACTS.put("13530446512", "董婷");
	CONTACTS.put("15817357061", "董婷4");
	CONTACTS.put("75582255555", "飞哪旅行网");
	CONTACTS.put("13965102151", "韩晋");
	CONTACTS.put("75526431964", "金海岸管理处");
	CONTACTS.put("13510583139", "罗水梅");
	CONTACTS.put("75582834663", "某快易贷");
	CONTACTS.put("75527783749", "平安雷毅");
	CONTACTS.put("75527752300", "平安理财");
	CONTACTS.put("13751036696", "任昆鹏");
	CONTACTS.put("13501010357", "孙梦博");
	CONTACTS.put("79187761117", "推销1");
	CONTACTS.put("79187761054", "推销2");
	CONTACTS.put("75527330508", "推销3");
	CONTACTS.put("2151927936", "推销4");
	CONTACTS.put("4001007223", "推销5");
	CONTACTS.put("75561921211", "推销6");
	CONTACTS.put("4000131616", "推销7");
	CONTACTS.put("4001013720", "推销8");
	CONTACTS.put("2081164554", "推销9");
	CONTACTS.put("4007164430", "推销a");
	CONTACTS.put("75536845083", "推销联通");
	CONTACTS.put("2196987987", "推销浦发1");
	CONTACTS.put("2135317012", "推销浦发2");
	CONTACTS.put("13249078411", "文小军");
	CONTACTS.put("18260097724", "吴茜茜");
	CONTACTS.put("75561918500", "吸费电话");
	CONTACTS.put("75561285985", "英孚");
	CONTACTS.put("13425187286", "张杰");
	CONTACTS.put("75586013954", "招行超级网银");
	CONTACTS.put("13421399411", "圳租客2于");
	CONTACTS.put("13823672011", "周洁");
	CONTACTS.put("13480796650", "左");               // who?
	
	CONTACTS.put("13516696856", "董婷2");
	
	CONTACTS.put("18702974462", "包逸歆");
	CONTACTS.put("13416289085", "陈纪伯");
	CONTACTS.put("13798842107", "充值骗 子");
	CONTACTS.put("13865429566", "仇晶");
	CONTACTS.put("13718867657", "仇晶-旧");
	CONTACTS.put("15255597063", "丁玉芹(矾中)");
	CONTACTS.put("18603042246", "董婷3");
	CONTACTS.put("13856527019", "方雲4");
	CONTACTS.put("13855157534", "方雲5");
	CONTACTS.put("15813726491", "龚姜平");
	CONTACTS.put("15976663710", "佳缘-佛山");
	CONTACTS.put("13428932784", "付宇");
	CONTACTS.put("13590305387", "付宇介绍");
	CONTACTS.put("15017549300", "高奔娇");
	CONTACTS.put("13570401813", "广州阿欣");
	CONTACTS.put("13866152045", "后小强");
	CONTACTS.put("18675592668", "胡鹏");
	CONTACTS.put("13418946590", "家家顺陕西妹");
	CONTACTS.put("13828726604", "建行陈大堂");
	CONTACTS.put("13602694453", "金海岸罗新纯");
	CONTACTS.put("13418592640", "景海宁");
	CONTACTS.put("13195650173", "柯常喜");
	CONTACTS.put("15255060512", "柯旭-旧号？");
	CONTACTS.put("13053103381", "柯旭");
	CONTACTS.put("13798513011", "平安雷毅");
	CONTACTS.put("13699829997", "李昌荣");
	CONTACTS.put("13510440546", "李昌荣2");
	CONTACTS.put("15820490917", "李昌荣3");
	CONTACTS.put("13205196913", "李更春@苏州");
	CONTACTS.put("15056905388", "李红-蓝色雨");
	CONTACTS.put("13530360094", "李慧敏");
	CONTACTS.put("13933627049", "李志文");
	CONTACTS.put("13760139843", "林昆-旧号");
	CONTACTS.put("13828504947", "林昆");
	CONTACTS.put("13570229827", "刘欢");
	CONTACTS.put("13480148704", "刘子枫2");
	CONTACTS.put("13430955516", "罗海江");
	CONTACTS.put("18675528903", "毛浪花");
	CONTACTS.put("15889670401", "潘向荣");
	CONTACTS.put("13686855518", "任昆鹏荐驾校");
	CONTACTS.put("13760189408", "肉肉");
	CONTACTS.put("13701602974", "芮秀");
	CONTACTS.put("13425147122", "盛泽黎小芳");
	CONTACTS.put("13713005103", "宋伟");
	CONTACTS.put("15019483014", "索辉");
	CONTACTS.put("13434436368", "索辉-新");
	CONTACTS.put("15010805869", "谭博");
	CONTACTS.put("15899871681", "谭志华");
	CONTACTS.put("13661359853", "陶道有-旧号");
	CONTACTS.put("13685654777", "王大弟");
	CONTACTS.put("13798252144", "王璐？");
	CONTACTS.put("15161128481", "王敏@常州");
	CONTACTS.put("13866571612", "王强");
	CONTACTS.put("15202181011", "王晓光");
	CONTACTS.put("15820455602", "夏牧子");
	CONTACTS.put("13641406761", "谢苑");
	CONTACTS.put("13760222279", "熊振");
	CONTACTS.put("13760340767", "徐波");
	CONTACTS.put("13632554739", "徐晨");
	CONTACTS.put("18200981986", "徐晨2");
	CONTACTS.put("13721069426", "许峰唯");
	CONTACTS.put("15999657441", "徐垒");
	CONTACTS.put("13713887669", "杨柳");
	CONTACTS.put("18256590896", "姚明珏");
	CONTACTS.put("13817428698", "姚明珏2");
	CONTACTS.put("13723756074", "姚忠存");
	CONTACTS.put("15889671956", "曾莱蓓或张彤");
	CONTACTS.put("13861070927", "张锦");
	CONTACTS.put("18221654469", "张显@上海");
	CONTACTS.put("13508535603", "张韵婷");
	CONTACTS.put("13305651539", "朱保朝");
	CONTACTS.put("15955658639", "朱保朝2");
	CONTACTS.put("18055215618", "朱金玉");
	CONTACTS.put("18926762326", "朱世康");
	CONTACTS.put("18675603680", "朱世康2");
	CONTACTS.put("15219495886", "朱卫卫");
	CONTACTS.put("13826504310", "朱文明");

	CONTACTS.put("10657558020911", "财付通");
	CONTACTS.put("10657532589888", "交通银行(旧)");
	CONTACTS.put("10086", "中国移动");
	CONTACTS.put("13800138000", "中国移动138");
	CONTACTS.put("10658513", "移动微博");
	CONTACTS.put("10658186", "移动问候");
	CONTACTS.put("95511", "平安银行");
	CONTACTS.put("106575596120", "平安银行SP");
	CONTACTS.put("95528", "浦发银行");
	CONTACTS.put("95530", "东方航空");
	CONTACTS.put("95533", "建设银行");
	CONTACTS.put("95555", "招商银行");
	CONTACTS.put("95559", "交通银行");
	CONTACTS.put("95588", "工商银行");

	java.sql.Connection conn = null;
	java.sql.PreparedStatement pstmt = null;
	java.sql.ResultSet rs = null;
	try {
		javax.naming.Context ctx = new javax.naming.InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/mainDataSource");
		conn = ds.getConnection();

		pstmt = conn.prepareStatement("SELECT * FROM SMS_135");
		rs = pstmt.executeQuery();
		Map<String, List<String[]>> resultWithName = new TreeMap<String, List<String[]>>(), resultWithoutName = new TreeMap<String, List<String[]>>();
		while (rs.next()) {
			String partner = rs.getString("Partner");
			boolean noName = true;
			for (Map.Entry<String, String> entry : CONTACTS.entrySet()) {
				if (partner.endsWith(entry.getKey())) {
					noName = false;

					List<String[]> curVal = resultWithName.get(entry.getValue());
					if (curVal == null) {
						curVal = new LinkedList<String[]>();
						resultWithName.put(entry.getValue(), curVal);
					}
					curVal.add(new String[] {rs.getString("TheTime"), rs.getString("SendRecv"), rs.getString("Content")});
					break;
				}
			}
			if (noName) {
				List<String[]> curVal = resultWithoutName.get(partner);
				if (curVal == null) {
					curVal = new LinkedList<String[]>();
					resultWithoutName.put(partner, curVal);
				}
				curVal.add(new String[] {rs.getString("TheTime"), rs.getString("SendRecv"), rs.getString("Content")});
			}
		}

		out.println("联系人对话<br>");
		out.println("<table border=\"1\" width=\"100%\">");
		for (Map.Entry<String, List<String[]>> entry : resultWithName.entrySet()) {
			Collections.sort(entry.getValue(), new Comparator<String[]>() {
				public int compare(String[] arg1, String[] arg2) {
					return arg1[0].compareTo(arg2[0]);
				}
			});

			out.println("<tr>");
			out.print("<td width=\"20%\">");
			out.print(entry.getKey());
			out.println("</td>");
			out.println("<td>");
			out.println("<table border=\"1\" width=\"100%\">");
			for (String[] item : entry.getValue()) {
				out.print("<tr");
				if ("0".equals(item[1]))
					out.print(" bgcolor=\"#CCCCCC\"");
				out.println(">");
				out.println("<td>");
				out.println(item[2]);
				out.println("</td>");
				out.println("<td width=\"20%\">");
				out.println(item[0]);
				out.println("</td>");
				out.print("</tr>");
			}
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
		}
		out.println("</table><br><br><br>");

		out.println("非联系人对话<br>");
		out.println("<table broder=\"1\" width=\"100%\">");
		for (Map.Entry<String, List<String[]>> entry : resultWithoutName.entrySet()) {
			Collections.sort(entry.getValue(), new Comparator<String[]>() {
				public int compare(String[] arg1, String[] arg2) {
					return arg1[0].compareTo(arg2[0]);
				}
			});

			out.println("<tr>");
			out.print("<td width=\"20%\">");
			out.print(entry.getKey());
			out.println("</td>");
			out.println("<td>");
			out.println("<table border=\"1\" width=\"100%\">");
			for (String[] item : entry.getValue()) {
				out.print("<tr");
				if ("0".equals(item[1]))
					out.print(" bgcolor=\"#CCCCCC\"");
				out.println(">");
				out.println("<td>");
				out.println(item[2]);
				out.println("</td>");
				out.println("<td width=\"20%\">");
				out.println(item[0]);
				out.println("</td>");
				out.print("</tr>");
			}
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
		}
		out.println("</table><br><br><br>");
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