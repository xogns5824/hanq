<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String idx = request.getParameter("idx");
String type = request.getParameter("btype");

if (type.equals("NOTICE")){
	out.println("<script>");
	out.println("location.replace('../board/notice_view.jsp?idx=" + idx + "&issa=" + issa + "');");
	out.println("</script>");
} else {
	out.println("<script>");
	out.println("location.replace('../board/board_view.jsp?idx=" + idx + "&issa=" + issa + "');");
	out.println("</script>");
} 
%>