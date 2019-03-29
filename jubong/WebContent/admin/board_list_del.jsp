<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String[] value = request.getParameterValues("checkDel");
String type = request.getParameter("type");

String writer = "";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	if(type == null || type.equals(""))
	{
		out.println("<script>");
		out.println("location.replace('board_list.jsp');");
		out.println("</script>");
	}
	else if(type.equals("notice"))
	{
	
		for(String val : value){
			sql = "select n_writer from notice where n_idx = " + val;
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				writer = rs.getString("n_writer");
			} else {	
				out.println("<script>");
				out.println("location.replace('board_list.jsp');");
				out.println("</script>");
			}	
		
			sql = "delete from notice where n_idx = " + val ;
			
			result = stmt.executeUpdate(sql);
		}
	}
	else
	{

		for(String val : value){
			sql = "select pb_writer from product_board where pb_idx = " + val;
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				writer = rs.getString("pb_writer");
			} else {	
				out.println("<script>");
				out.println("location.replace('board_list.jsp');");
				out.println("</script>");
			}	
		
			sql = "delete from product_board where pb_idx = " + val ;
			
			result = stmt.executeUpdate(sql);
		}
	
	}
	if (result != 0) {
		out.println("<script>");
		out.println("location.replace('board_list.jsp');");
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