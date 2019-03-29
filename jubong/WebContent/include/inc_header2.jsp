 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
request.setCharacterEncoding("UTF-8");
// request객체로 받아 올 값들에 대한 인코딩 방식 지정

String adminId ="",adminName ="",userId, userName, orderNumber="",orderName="";
boolean isLogin = false;
boolean isAdmin = false;
userId = (String)session.getAttribute("userId");
userName = (String)session.getAttribute("userName");
adminId = (String)session.getAttribute("adminId");
adminName = (String)session.getAttribute("adminName");
if(userId == null)
{
	orderNumber = (String)session.getAttribute("orderNumber");
	orderName = (String)session.getAttribute("orderName");
}
else
{
	isLogin = true;
}
if(adminId != null)
{
	isAdmin = true;
}
Connection conn = null;
String driver = "org.mariadb.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/jubongshop";
Statement stmt = null;
ResultSet rs = null;
%>