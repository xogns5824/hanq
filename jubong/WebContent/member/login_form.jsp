<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String ismem = "";
String history ="";
ismem = request.getParameter("ismem");
String id= "";
String pid= "", size="",color="", quantity ="";
id = request.getParameter("id");
if(id == null) id ="";
if(ismem == null || ismem.equals(""))
{
	ismem = "y";
}
history = request.getParameter("history");
if(history == null)
{
	history = "";
}
else
{
	pid=request.getParameter("pid");
	size = request.getParameter("po_size");
	color = request.getParameter("po_color");
	quantity = request.getParameter("quantity");
}

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center; }

#in_pwd {
		width:131px; height:40px;
		border:none; color:353535;
		}
/*아이디찿기와 비밀번호 찿기 크기를 지정함*/ 
#login{
		width:307px; height:40px;
		border:none; color:353535;
	  }
/*로그인 회원가입 버튼 크기를 지정함*/
#id , #pw ,#order{
		width:300px; height:40px;
		color:353535;
			}
/*정보 입력칸 크기를 지정함*/
</style>
<script>
function nonOrder()
{
	var frm = document.f;
	frm.action="../order/order_form.jsp";
	frm.submit();
}

</script>

</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	<br /><br/>
	<!-- contents -->
	<div id="contents">
	<form action="login_proc.jsp?ismem=<%=ismem %>" method="post" align="center" name="f">
	<%
	if(history.equals("order"))
	{
	%>
		<input type="hidden" name="pid" value="<%=pid %>" />
		<input type="hidden" name="po_size" value="<%=size %>" />
		<input type="hidden" name="po_color" value="<%=color %>" />
		<input type="hidden" name="quantity" value="<%=quantity %>" />
		<input type="hidden" name="history" value="<%=history %>" />
	<%
	}
	%>
	<table width="307" border="0" cellspacing="0" cellpadding="10" align="center">
	<tr>
	<td><input type="radio" name="members" id="members1" <%=(ismem.equals("y")) ? "checked='checked'" : "" %> value="y" onclick="location.href='login_form.jsp?ismem=y'"  />
	회원
	<input type="radio" name="members" id="members1" <%=(ismem.equals("n")) ? "checked='checked'" : "" %> value="n" onclick="location.href='login_form.jsp?ismem=n'"/>
	비회원
</td>
</tr>
<!-- 회원과 비회원 분별을  위한 체크 부분 -->
<%
if(ismem.equals("y"))
{
%>
<tr>
<td><input type="text" name="id" id="id" value="<%=id %>" placeholder="아이디" /></td>
</tr>
<tr>
<td><input type="password" name="pw" id="pw" placeholder="비밀번호"/></td>
</tr>
<%
}
else if(ismem.equals("n"))
{
%>
<tr>
<td><input type="text" name="orderNumber" id="order" placeholder="주문 번호"/></td>
</tr>
<tr>
<td ><input type="text" name="orderName" id="order"placeholder="주문자 이름"/></td>
</tr>
<tr>
<td ><input type="password" name="orderPw" id="order"placeholder="주문자 비밀번호"/></td>
</tr>
<%
}
%>
<!--  "y"이면 아이디 비밀번호를 보여줌 "n"이면 주문번호 ,주문자명, 주문비밀번호를 보여준다. -->
<tr>
<td>
<input type="submit" value="로그인" id="login" />
</td>
</tr>
<!-- 폼의 액션 값으로 이동한다. -->
<tr>
<td>
<a href="join_agree.jsp"><input type="button" value="회원가입" id="login" /></a>

<!-- 약관 페이지로 이동한다. -->
</td>
</tr>
<tr >
<td id="find">
<a href="searchId_form.jsp"><input type="button" value="아이디 찾기" id="in_pwd"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="searchPw_form.jsp"><input type="button" value="비밀번호 찾기" id="in_pwd" /></a>
</td>
</tr>
<%
if(history.equals("order"))
{%>
<tr>
<td><input type="button" value="비회원 구매" id="login" onclick="nonOrder();" /></td>
</tr>
<%} %>
</table>
</form>
	
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>