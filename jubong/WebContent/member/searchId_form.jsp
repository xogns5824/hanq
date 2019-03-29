<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String search = "";
search = request.getParameter("search");

if(search == null || search.equals(""))
{
	search = "e_id";
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
	#name , #email {
		width:200px; height:40px;
		color:353535
		}
	#searchOk { width:300px;
			height:40px;
			color:353535 
			}
	#p1 ,#p2 ,#p3{
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
		<h2>Find ID</h2>
		<form action="search_proc.jsp?search=<%=search%>" method="post" name="f">
		<input type="hidden" name="stype" value="i" />
		<!-- 
		<input type="hidden" name="stype" value="p" />
		 -->
		<table width="307" border="0" cellspacing="0" cellpadding="10" align="center" id="sch_tb">
		<tr align="center" >
			<td colspan="2"><input type="radio" name="searchId" id="searchId" <%=(search.equals("e_id")) ? "checked='checked'" : "" %> value="e_id" onclick="location.href='searchId_form.jsp?search=e_id'"  />
			이메일
			<input type="radio" name="searchId " id="searchId" <%=(search.equals("p_id")) ? "checked='checked'" : "" %> value="p_id" onclick="location.href='searchId_form.jsp?search=p_id'"/>
			휴대전화
		</td>
		</tr>
		
		<tr>
		<th width="24%">이름</th><td><input type="text" name="name" id="name"  /></td>
		</tr>
		<%
		if(search.equals("e_id"))
		{
		%>
		<tr>
		<th>이메일</th><td><input type="text" name="email" id="email"  /></td>
		</tr>
		
		<%
		}
		else if(search.equals("p_id"))
		{
		%>
		<tr>
		<th>휴대전화</th>
		<td >
		<input type="text" name="p1" id="p1" maxlength="4"/>-<input type="text" name="p2" id="p2" maxlength="4"/>-<input type="text" name="p3" id="p3" maxlength="4"/>
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