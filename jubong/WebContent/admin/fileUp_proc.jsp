<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>

<%
String uploadPath = request.getRealPath("/iamge");
int size = 10 * 1024 * 1024 ;
String name= "", subject ="", filename1 = "", filename2 = "", orifilename1 = "", orifilename2 = "";

try 
{
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
	name  = multi.getParameter("name");
	subject = multi.getParameter("subject");
	
	Enumeration files = multi.getFileNames();
	
	String file1 = (String)files.nextElement();
	filename1 = multi.getFilesystemName(file1);
	// 실제로 저장될 파일명
	orifilename1 = multi.getOriginalFileName(file1);
	// 파일의 원래 이름(저장하기 위해 바꾼 이름이 아닌)

	String file2 = (String)files.nextElement();
	filename2 = multi.getFilesystemName(file2);
	orifilename2 = multi.getOriginalFileName(file2);
	
	
} catch(Exception e)
{
	e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="filecheck" action="fileCheck.jsp" method="post">
<input type="hidden" name="name" value="<%=name %>" />
<input type="hidden" name="subject" value="<%=subject %>" />
<input type="hidden" name="filename1" value="<%=filename1 %>" />
<input type="hidden" name="filename2" value="<%=filename2 %>" />
<input type="hidden" name="orifilename1" value="<%=orifilename1 %>" />
<input type="hidden" name="orifilename2" value="<%=orifilename2 %>" />
</form>
<a href="#" onclick="javascript:filecheck.submit(); ">업로드 확인 및 다운로드</a>
</body>
</html>