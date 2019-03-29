<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/inc_header.jsp" %>
<%
String search ="", stype ="";
String name= "" , email ="" , PhoneNumber = "" , id = "";
String p1 = "" , p2 = "", p3 = "";
search = request.getParameter("search");
stype = request.getParameter("stype");

if(stype != null && stype.equals("i"))
{
		
		if(search == null || search.equals("")){
			out.println("<script>");
			out.println("location.replace('searchId_form.jsp');");
			out.println("</script>");
		}else if(search.equals("e_id")){
		
			 name = request.getParameter("name");
			 email = request.getParameter("email");
			 
		}else if(search.equals("p_id")){
		
			name = request.getParameter("name");
			 p1 = request.getParameter("p1");
			 p2 = request.getParameter("p2");
			 p3 = request.getParameter("p3");
			PhoneNumber = p1 + "-" + p2 + "-" + p3;
		}
}else if(stype.equals("p")){
		if(search == null || search.equals("")){
			out.println("<script>");
			out.println("location.replace('searchPw_form.jsp');");
			out.println("</script>");
		}else if(search.equals("e_pw")){
			 id =  request.getParameter("id");
			 name = request.getParameter("name");
			 email = request.getParameter("email");
			 
		}else if(search.equals("p_pw")){
			 id =  request.getParameter("id");
			 name = request.getParameter("name");
			 p1 = request.getParameter("p1").trim();
			 p2 = request.getParameter("p2").trim();
			 p3 = request.getParameter("p3").trim();
			PhoneNumber = p1 + "-" + p2 + "-" + p3;
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
<% 
if(stype.equals("i"))
{

	if(search.equals("e_id")){
		sql="";
		sql = " select  ml_name, ml_email, ml_id from member_list where ml_name = '" + name + "' and ml_email='" + email + "' ";
	
	}else if(search.equals("p_id")){
		sql="";
		sql = " select ml_name, ml_phone, ml_id  from member_list where ml_name = '" + name + "' and ml_phone='" + PhoneNumber+ "' ";
	}

}
else if(stype.equals("p"))
{
	if(search.equals("e_pw")){
		sql="";
		sql = " select ml_name,ml_email,ml_id from member_list where ml_name = '" + name + "' and ml_email='" + email + "' ";
		sql += " and ml_id = '" + id + "'";
		
	}else if(search.equals("p_pw")){
		sql="";
		sql = " select ml_name, ml_email, ml_id from member_list where ml_name = '" + name + "' and ml_phone='" + PhoneNumber +"' ";
		sql += " and ml_id= '" + id + "' ";
		out.println(sql);
	}
}
try { 
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	String msg = "";	// 로그인이 안되었을 경우 보여줄 메시지
	if(stype.equals("i"))
	{
		if(search.equals("e_id")){
			
			if (rs.next()) {
			// 이름과 이메일에 해당하는 값이 있으면 
						out.println("<script>");
						out.println("location.replace('searchId_view.jsp?name=" + name + "&email=" + email + "&search="+ search + "');");
						out.println("</script>");
				}else {
					msg = "아이디와 이메일에 해당하는 회원이 없습니다.";
				}
		}else if(search.equals("p_id")){
			if (rs.next()) {
				// 이름과 전화번호에 해당하는 값이 있으면 
						out.println("<script>");
						out.println("location.replace('searchId_view.jsp?name=" + name + "&PhoneNumber=" + PhoneNumber + "&search="+ search + "');");
						out.println("</script>");
					}else {
						msg = "아이디와 또는 휴대전화에 해당하는 회원이 없습니다.";
					}
		}
	}else if(stype.equals("p"))
	{
		if(search.equals("e_pw")){
			if (rs.next()) {
			// 이름과 이메일 과 아이디에 해당하는 값이 있으면 
				out.println("<script>");
				out.println("location.replace('searchPw_View.jsp?&id="+rs.getString("ml_id")+"&name="+ rs.getString("ml_name") +"&email=" + rs.getString("ml_email") + "&search="+ search + "');");
				out.println("</script>");
			}else {
				msg = "아이디 , 이름 , 이메일에 해당하는 회원이 없습니다.";
			}
		}else if(search.equals("p_pw")){
		
			if (rs.next()) {
				// 이름과 전화번호와 아이디에 해당하는 값이 있으면 
				out.println("<script>");
				out.println("location.replace('searchPw_View.jsp?&id="+rs.getString("ml_id")+"&name="+ rs.getString("ml_name") +"&email=" + rs.getString("ml_email") + "&search="+ search + "');");
				out.println("</script>");
						
				}else {
					msg = "아이디 , 휴대번호 , 이름 에 해당하는 회원이 없습니다.";
				}		
		}
	}
	if (!msg.equals("") ) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		if(stype.equals("i")){
		out.print("location.replace('searchId_form.jsp?');");
		}else if(stype.equals("p")){
		out.print("location.replace('searchPw_form.jsp?');");
		}
		out.println("</script>");
	}

} catch(Exception e) {
	out.println("<h3>DB작업에 실패하였습니다.</h3>");
	e.printStackTrace();
} finally {
	// 사용된 객체 닫기
	try {
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
</body>
</html>