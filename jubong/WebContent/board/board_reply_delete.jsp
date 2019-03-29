<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 여기서는 frr_proc파일로 값만 잘 넘겨주면 되므로 실질적으로 많은 일을 하지 않는다. -->
<%
request.setCharacterEncoding("UTF-8");
String pridx = request.getParameter("pridx");
String idx = request.getParameter("idx");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
<form name="frm_pwd" action="board_reply_proc.jsp?pridx=<%=pridx %>&idx=<%=idx %>&wtype=del" method="post">	<!-- post를 get으로 바꿔서 동작하면 에러가 발생한다. 왜? ?이후에 붙인것들이 get방식인데 method마저 get방식을 사용하므로이다. 만일 method를 get방식으로 사용하고 싶다면 앞에 ?뒤를 hidden으로 사용하여야 한다. -->
<input type="password" name="pwd" /> <br /><br />
<input type="submit" value="확 인" />
<input type="button" value="닫 기" onclick="self.close();"/>
</form>
</body>
</html>