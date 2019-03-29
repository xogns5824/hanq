<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../include/inc_header.jsp" %>
<%if(userId == null)
{
	out.println("<script>");
	out.println("location.href='./login_form.jsp';");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<h3>회원탈퇴를 진행하시겠습니까?</h3>
<form name ="f" action="member_proc.jsp" method="post">
<input type="text" name ="pw1" id="pw1" />
<input type="hidden" name="wtype" value="del" />
<input type="submit" value="확인"/>
</form>
<input type="button" value="취소" onclick="location.replace('info_form.jsp');"/>
</body>
</html>