<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String search = "";
search = request.getParameter("search");
String id = "";
id = request.getParameter("id");
if(id == null) id ="";
if(search == null || search.equals(""))
{
	search = "e_pw";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center;}
	#name , #email , #id{
		width:200px; height:40px;
		color:353535
		}
	#searchOk { width:300px;
			height:40px;
			color:353535 
			}
	#PhoneNumber{
		width:60px; height:40px;
		color:353535
	}
	#sch_tb th { font-size :0.8em; }
</style>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
	<form action="search_proc.jsp?search=<%=search%>" method="post" name="f">
	<input type="hidden" name="stype" value="p" />
	<!-- 
	<input type="hidden" name="stype" value="i" />
	 -->
	<h2>Find PASSWORD</h2>
	<table width="307" border="0" cellspacing="0" cellpadding="10" align="center" id="sch_tb">
	<tr align="center">
		<td colspan="2"><input type="radio" name="searchPw" id="searchPw" <%=(search.equals("e_pw")) ? "checked='checked'" : "" %> value="e_pw" onclick="location.href='searchPw_form.jsp?search=e_pw&id=<%=id %>'"  />
		이메일
		<input type="radio" name="searchPw " id="searchPw" <%=(search.equals("p_pw")) ? "checked='checked'" : "" %> value="p_pw" onclick="location.href='searchPw_form.jsp?search=p_pw&id=<%=id %>'"/>
		휴대전화
	</td>
	</tr>
	<tr>
	<th width="24%">아이디</th><td><input type="text" name="id" id="id" value="<%=id %>" /></td>
	</tr>
	<tr>
	<th width="24%">이름</th><td><input type="text" name="name" id="name"  /></td>
	</tr>
	<%
	if(search.equals("e_pw"))
	{
	%>
	<tr>
	<th>이메일</th><td><input type="text" name="email" id="email"  /></td>
	</tr>
	
	<%
	}
	else if(search.equals("p_pw"))
	{
	%>
	<tr>
	<th>휴대전화</th>
	<td id="PhoneNumber">
	
	<input type="text" name="p1" id="PhoneNumber" maxlength="4"/>-<input type="text" name="p2" id="PhoneNumber" maxlength="4"/>-<input type="text" name="p3" id="PhoneNumber" maxlength="4"/>
	</td>
	</tr>
	<%
	}
	%>
	<tr>
	<td colspan="2"><input type="submit" value="ok" id="searchOk" /></td>
	</tr>
	</table>
	</form>
	
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>

</body>
</html>