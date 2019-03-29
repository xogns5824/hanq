<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
if(isLogin)
{
	out.println("<script>");
	out.println("location.href='main.jsp';");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#admin_login_contents 
{
	width:600px;
	height:350px;
	margin:0 auto;
	margin-top:150px;
	border:1px solid black;	
	text-align:center;
	font-size : 1.8em;
}
#admin_login_contents #id, #admin_login_contents #pwd
{
	width:200px;
	height:40px;
	border:1px solid #c1c1c1;
}

#admin_login_contents tr
{
	height:60px;
}
#admin_login_contents .btn_login
{
	height:55px;
	width:120px;
	background:#bdbdbd;
	color:while;
	border:1px solid #c1c1c1;
	margin:0 5px;
}
</style>
<script>

</script>
</head>
<body>
<div id="admin_login_contents">
<h2>주봉샵 관리자 로그인</h2>
<div>
<form name="frm_admin_login" action="login_proc.jsp" method="post">
<table width="600" border="0">
<tr>
<td align="right" width="40%"><label for="id">아이디</label></td><td align="left" width="60%"><input type="text" name="id" id="id" /></td>
</tr>
<tr>
<td align="right" width="40%"><label for="pwd">비밀번호</label></td><td align="left" width="60%"><input type="password" name="pwd" id="pwd" /></td>
</tr>
<tr>
<td colspan="2"><input class="btn_login" type="submit" value="로그인" /><input class="btn_login" type="reset" value="다시작성" /><input class="btn_login" type="button" value="회원페이지로..."  onclick="location.href='../index.jsp';"/></td>
</tr>
</table>
</form>
</div>
</div>
</body>
</html>