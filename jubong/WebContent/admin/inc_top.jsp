<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
if(!isLogin)
{
	out.println("<script>");
	out.println("location.href='login_form.jsp';");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
a { color:#000; text-decoration:none; }
a:hover, a:linked, a:visited, a:selected { color:#000; }
#tab_box 
{ 
	position:relative; 
	text-align:center; 
	width:800px; 
	margin:0 auto;
}

#tab_box .btn_top 
{
	width:150px; 
	height:60px;
	color:#000; 
	background:#c1c1c1; 
	border:0;
	cursor:pointer;
}
#goUsers
{
	position:absolute;
	left:100px;
	top:20px;
}
#logout
{
	position:absolute;
	left:20px;
	top:20px;
	
}
#logout a , #goUsers a
{
	color:#FCFCFC;
	
}
#logout a:hover, #goUsers a:hover
{
	color:red;
}
body 
{
	margin:0;
}
</style>
</head>
<body>
<div id="tab_box">
<span id="logout"><a href="logout.jsp">로그아웃</a></span>
<span id="goUsers"><a href="../index.jsp">사용자 페이지로 이동</a></span>
<h1><a href="main.jsp">주봉샵</a></h1>
<input type="button" class="btn_top" value="상품 관리" onclick="location.href='product_list.jsp';">
<input type="button" class="btn_top" value="주문 배송관리" onclick="location.href='order_list.jsp';">
<input type="button" class="btn_top" value="고객 관리" onclick="location.href='member_list.jsp';">
<input type="button" class="btn_top" value="게시판 관리" onclick="location.href='board_list.jsp';">
<input type="button" class="btn_top" value="통계 관리" onclick="location.href='statistics_main.jsp';">
</div>
</body>
</html>