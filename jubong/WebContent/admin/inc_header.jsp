<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%

request.setCharacterEncoding("UTF-8");
String adminId = "", adminName = "", sql = "", where = "", linkHead = "", linkTail = "",args=""	;
boolean isLogin = false;

boolean issa = false;
adminId = (String)session.getAttribute("adminId");
adminName = (String)session.getAttribute("adminName");
if(adminId != null)
{
	isLogin = true;
	if(adminId.equals("sa")){
		issa = true;
	}
}

Connection conn = null;
String driver = "org.mariadb.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/jubongshop";
Statement stmt = null;
ResultSet rs = null;
int result = 0;
%>