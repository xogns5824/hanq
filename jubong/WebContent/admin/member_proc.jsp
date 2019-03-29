<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
String ml_id = request.getParameter("ml_id");
String wtype= request.getParameter("wtype");
int ml_point = 0;

String name ="", pwd="",p = "",p1="" , p2="" ,  p3="" ;
String b ="",b1="" , b2="",b3="" ,email, email1 ="",email2="";
String situ="";
String point = "" ; //포인트 금액 받아오기 
String content ="" ,state="";// 포인트 내역 추가와 포인트 상태 받아오기 

String[] ArrayIdx = {};
if(wtype == null || wtype.equals(""))// 타입 없이 들어 왔으면 
{
	out.println("<script>");
	out.println("alert('회원정보가 입력되었습니다.');");
	out.println("location.replace('member_list.jsp');");
	out.println("</script>");
}
else if(wtype.equals("re")) // 블랙 리스트 시키기
{

	sql = " update member_list set ml_situ = '2' where ";
}else if(wtype.equals("del")){ // 회원 탈퇴 시키기 
	sql = " update member_list set ml_situ = '3' where ";
}else if(wtype.equals("update")){
	name= request.getParameter("name");
	pwd= request.getParameter("pwd");
	p1 = request.getParameter("p1").trim();
	p2 = request.getParameter("p2").trim();
	p3 = request.getParameter("p3").trim();
	p = p1 +"-"+ p2 +"-"+ p3 ;

	b1 = request.getParameter("b1");

	b2 = request.getParameter("b2");	
	if(b2.length() < 2)
	{
		b2 = "0"+b2;
	}
	b3 = request.getParameter("b3");
	if(b3.length() < 2)
	{
		b3 = "0"+b3;
	}
	b = b1 +"-"+ b2 +"-"+ b3;
	email1 = request.getParameter("email1");
	email2 = request.getParameter("email2");
	if(email2 == null || email2.equals(""))
	{
		email2 = request.getParameter("mail");
	}
	email = email1 +"@"+ email2;
	
	situ= request.getParameter("situ");
 
	sql = " update member_list set ml_name = '"+ name+"' ,ml_pwd = '"+ pwd+"', ml_birth = '"+  b +"',";
	sql += " ml_phone = '" + p + "' , ml_email = '" + email +"' , ml_situ = "+ situ + " where ml_id ='"+ ml_id + "' ";
	out.println(sql);
}else if (wtype.equals("point")){
	point = request.getParameter("point");
	content = request.getParameter("content");
	state = request.getParameter("state");
	
	sql = "insert into member_point (ml_id ,mp_point ,mp_content, mp_state) values ";
	sql += " ('"+ml_id+"' ," +point+" ,'"+ content +"','"+state+"' )";
	out.println(sql);
}

if(wtype.equals("re") || wtype.equals("del"))
{
	ArrayIdx = request.getParameterValues("chk_sel");
	if(ArrayIdx == null || ArrayIdx.equals(""))
	{
		out.println("<script>");
		out.println("location.replace('member_list.jsp');");
		out.println("</script>");	
	}
	for(int i = 0 ; i < ArrayIdx.length ; i++)
	{
		if(i == (ArrayIdx.length-1))
		{
			where += "ml_id = '"+ArrayIdx[i] +"'";	
		}
		else
		{
			where += " ml_id = '"+ArrayIdx[i] +"' or ";
		}
	}
	
	sql += where;
}
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");

	stmt = conn.createStatement();
	if(wtype.equals("re"))
	{  
		result = stmt.executeUpdate(sql);
	
		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			out.println("<script>");
			out.println("alert('블랙 리스트로 지정되었습니다.');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('블랙 리스트로 지정하지 못하였습니다. ');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
		}
	}else if (wtype.equals("del")){
		result = stmt.executeUpdate(sql);
		
		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			out.println("<script>");
			out.println("alert('회원이 정상적을 탈퇴 되었습니다.');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
			
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('탈퇴가 정상적으로 진행되지 않았습니다.');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
		}
	}else if (wtype.equals("update")){
		result = stmt.executeUpdate(sql);
		
		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			out.println("<script>");
			out.println("alert('회원 정보가 정상적으로 수정되었습니다.');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
			
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('회원 정보가 정상적으로 수정되지 않았습니다.');");
			out.println("location.replace('member_list.jsp');");
			out.println("</script>");
		}
	}else if (wtype.equals("point")){
		result = stmt.executeUpdate(sql);
		// 회원의 포인트가 바뀌어야함 ml_point + - 



		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			if(state.equals("y"))
			{
				sql ="update member_list set ml_point = ml_point + "+ point +" where ml_id = '"+ml_id+"'";
			}
			else
			{
				sql ="update member_list set ml_point = ml_point - "+ point +" where ml_id = '"+ml_id+"' and ml_point > "+point;
				System.out.println(sql);
			}

			result = stmt.executeUpdate(sql);
			if(result != 0)
			{
				out.println("<script>");
				out.println("alert('회원 포인트 내역이 추가 되었습니다.');");
				out.println("location.replace('member_form.jsp?ml_id="+ml_id+"');");
				out.println("</script>");
			}
			else
			{
				out.println("<script>");
				out.println("alert('회원 포인트 내역이 추가 되지 않았습니다.');");
				out.println("location.replace('member_form.jsp?ml_id="+ml_id+"');");
				out.println("</script>");
			}
			
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('회원 포인트 내역이 추가 되지 않았습니다.');");
			out.println("location.replace('member_form.jsp?ml_id="+ml_id+"');");
			out.println("</script>");
		}
		
	}
} catch(Exception e) {
	out.println("<h3>레코드 가져오기에 실패하였습니다.</h3>");
	e.printStackTrace();
} finally {
	// 사용된 객체 닫기
	try {

		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>