<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#mypage_menu { 

width:1200px; height:70px; text-align:center; padding-top:10px;text-decoration:none;}
#mypage_menu ul li 
{ 
	font-size:1.5em; 
	color:#c1c1c1; 
	background-color:white;
	display:inline;
	list-style:none;
	margin-right:100px;
}
#mypage_menu a,#mypage_menu a:hover,#mypage_menu a:active 
{
	text-decoration:none;
	color:#c1c1c1;
	 
}
</style>
</head>
<body>
<div id="mypage_menu">
<ul>
<li><a href="order_list.jsp">ORDER LIST</a></li>
<li><a href="wish_list.jsp">WISH LIST</a></li>
<li><a href="point_list.jsp">MY POINT</a></li>
<li><a href="addr_list.jsp">ADDRESS</a></li>
<li><a href="myboard_list.jsp">MY BOARD</a></li>
</ul>
</div>
</body>
</html>