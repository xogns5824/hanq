<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/inc_header2.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

int idx = 0, cpage = 0;
if(tmpPage == null || tmpIdx == null){
	out.println("<script>");
	out.println("location.replace('notice_list.jsp');");
	out.println("</script>");
}else{
	idx = Integer.valueOf(tmpIdx);
	cpage = Integer.valueOf(tmpPage);
}

if(schkind == null) schkind = "";
if(keyword == null) keyword = "";

String args = "?cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword + "&idx=" + idx;

String sql = "update product_board set pb_read = pb_read + 1 where pb_idx= " + idx;
int cnt = 0;
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url,"root","1234");
	stmt = conn.createStatement();
	
	int result = stmt.executeUpdate(sql);
	if(result != 0){
		out.println("<script>");
		out.println("location.replace('board_view.jsp" + args + "');");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("location.replace('qna_list.jsp");
		out.println("</script>");	
	}
}catch(Exception e){
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
}finally{
	try{
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>