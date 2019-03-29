<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_top.jsp" %>
<%
String go = "", d = "";
String tmpPage = request.getParameter("cpage");
String oid = request.getParameter("oid");
String[] status = request.getParameterValues("dealStatus");
String from = request.getParameter("from");
String to = request.getParameter("to");

if (oid == null) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}

if(from == null || to == null || status == null) {
	from = ""; to = ""; d = "";
}

if(status != null) {
	for(int i=0; i <status.length; i ++) {
		d += "&dealStatus=" + status[i];
	}
}
go = "cpage=" + tmpPage + "&from=" + from + "&to=" + to + d + "&oid=" + oid;


String o_name = request.getParameter("ord_name");   // 주문자명
String o_zip = request.getParameter("ord_zip");   // 주문자 우편번호
String o_addr1 = request.getParameter("ord_addr1");   // 주문자 주소1
String o_addr2 = request.getParameter("ord_addr2");   // 주문자 주소2
String o_c1 = request.getParameter("ord_c1");   // 주문자 휴대폰1
String o_c2 = request.getParameter("ord_c2");   // 주문자 휴대폰2
String o_c3 = request.getParameter("ord_c3"); // 주문자 휴대폰3
String o_e1 = request.getParameter("ord_e1");   // 주문자 이메일1
String o_e2 = request.getParameter("ord_e2");   // 주문자 이메일2

int situ = Integer.valueOf(request.getParameter("situ"));	// 주문상태 변경

String d_name = request.getParameter("deli_name");   // 수령인 이름
String d_zip = request.getParameter("deli_zip");   // 수령인 주소
String d_addr1 = request.getParameter("deli_addr1");   // 수령인 주소1
String d_addr2 = request.getParameter("deli_addr2");   // 수령인 주소2
String d_c1 = request.getParameter("deli_c1");   //수령인 휴대폰1
String d_c2 = request.getParameter("deli_c2");   //수령인 휴대폰2
String d_c3 = request.getParameter("deli_c3");   // 수령인 휴대폰3
String d_msg = request.getParameter("deli_msg");   // 배송메세지

String o_cell = o_c1 + "-" +  o_c2 + "-" + o_c3;
String o_email = o_e1 + "@" + o_e2;
String d_cell = d_c1 +"-"+ d_c2 + "-" + d_c3;

try {
Class.forName(driver);
conn = DriverManager.getConnection(url, "root", "root");
stmt = conn.createStatement();

	sql = "update order_info, order_detail set o_name = '"+ o_name +"', o_zip = '"+o_zip+"', ";
	sql += "o_addr1 = '"+ o_addr1 +"', o_addr2 = '"+ o_addr2 +"', o_phone = '"+o_cell+ "', ";
	sql += "o_email = '" + o_email + "', o_rname = '" + d_name + "', o_situ = " + situ + ", " ;
	sql += "o_rzip = '" + d_zip + "', o_raddr1 = '" + d_addr1 + "', o_raddr2 = '"+d_addr2+ "', ";
	sql += "o_rphone = '"+d_cell+"', o_message = '" + d_msg + "'";
	sql += "where order_info.o_id = order_detail.o_id and order_detail.o_id = '"+ oid +"'";
	out.println(sql);
	result = stmt.executeUpdate(sql);
	stmt.close();
	
	if(result != 0) {
		out.println("<script>");
		out.println("alert('정상적으로 수정되었습니다!');");
		out.println("location.replace('order_list.jsp?"+go+"');");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('수정 실패하였습니다.');");
		out.println("history.back();");
		out.println("</script>");
	}

} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>















