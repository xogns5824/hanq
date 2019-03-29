<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<%

String sql1 = "",sql2="";
String id="", name ="", pw1="",p1="" , p2="" , p = "", p3="" ;
String b ="",b1="" , b2="",b3="" ,g1 ="" ,g2 ="",g3 ="",email_1,email ="",email2="";
String gender="",wtype="";
pw1 = request.getParameter("pw1");
wtype = request.getParameter("wtype");
if(wtype.equals("in") || wtype.equals("up")){
id = request.getParameter("id"); // 아이디를 받아온다. 

name = request.getParameter("name");

p1 = request.getParameter("p1").trim();
p2 = request.getParameter("p2").trim();
p3 = request.getParameter("p3").trim();
p = p1 +"-"+ p2 +"-"+ p3 ;

b1 = request.getParameter("b1");
b2 = request.getParameter("b2");
b3 = request.getParameter("b3");
b = b1 +"-"+ b2 +"-"+ b3;
}
if(wtype.equals("in")){
g1 = request.getParameter("g1").trim();
g2 = request.getParameter("g2").trim();
g3 = request.getParameter("g3").trim();
}
email = request.getParameter("email");
email2 = request.getParameter("email2");
if(email2 == null || email2.equals(""))
{
	email2 = request.getParameter("mail");
}
email_1 = email +"@"+ email2;

gender = request.getParameter("gender");
if(wtype.equals("in"))
{
	
sql = "insert into member_list (ml_id, ml_pwd, ml_name ,ml_phone, ml_birth, ml_email, ml_point ,ml_gender) values ";
sql += " ('"+id+"','"+pw1+"','"+name+"','"+p+"','"+b+"','"+email_1+"', 2000 ,'"+gender+"') ";

sql1 = " insert into member_addr (ml_id,ma_title,ma_name,ma_phone, ma_zip, ma_addr1 ,ma_addr2,ma_isbasic) values ";
sql1 += " ('"+id+"','기본주소','"+name+"','"+p+"','"+g1+"','"+g2+"','"+g3+"','y') ";

sql2 = " insert into member_point (ml_id ,mp_point, mp_content, mp_state ) values ";
sql2 += " ('"+id+"','2000','회원가입 축하금','y') ";
}else if(wtype.equals("up"))
{
	sql = "update member_list set ml_id = '" + id + "', ml_pwd = '" + pw1 + "', ";
	sql += "ml_name = '" + name + "', ml_phone = '" + p + "', ml_birth = '" + b + "', ml_email = '"+ email_1 + "', ml_gender = '"+gender;                  
	sql += "' where ml_id = '" + id + "'";
	
	
}
else if(wtype.equals("del"))
{
	sql = " update member_list set ml_situ = '2' where ml_id = '" + userId + "' and ml_pwd = '" + pw1 + "'";
}
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");

	stmt = conn.createStatement();
	if(wtype.equals("in"))
	{
		result = stmt.executeUpdate(sql);
		int result1 = stmt.executeUpdate(sql1);
		int result2 = stmt.executeUpdate(sql2);

		if (result != 0 && result1 != 0 && result2 != 0) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			out.println("<script>");
			out.println("alert('회원정보가 입력되었습니다.');");
			out.println("location.replace('login_form.jsp');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('회원정보가 입력되지 않았습니다.');");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
		}
	}else if(wtype.equals("up")){
		result = stmt.executeUpdate(sql);


		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보수정이 되었다면)
			out.println("<script>");
			out.println("alert('회원정보가 수정되었습니다.');");
			out.println("location.replace('../mypage/my_main.jsp');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보수정이 안됐다면)
			out.println("<script>");
			out.println("alert('회원정보가 입력되지 않았습니다.');");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
		}
	}else if (wtype.equals("del")) {
		result = stmt.executeUpdate(sql);
	//삭제한다. 

		if (result != 0 ) {	// 쿼리의 실행결과가 레코드 하나라도 적용이 되었다면(정보삭제 되었다면)
			out.println("<script>");
			out.println("alert('회원정보가 삭제되었습니다.');");
			out.println("location.replace('./logout.jsp');");
			out.println("</script>");
		} else {	// 쿼리의 실행결과가 레코드 하나도 적용이 안되었다면(정보삭제 안됐다면)
			out.println("<script>");
			out.println("alert('삭제에 실패했습니다.');");
			out.println("location.replace('../info_form.jsp');");
			out.println("</script>");
		}
	}
	
} catch(Exception e) {
	out.println("<h3>레코드 가져오기에 실패하였습니다.</h3>");
	out.println("<script>");
	out.println("alert('작업에 실패 했습니다. \n 다시 입력해주세요.');");
	out.println("history.back();");
	out.println("</script>");
	e.printStackTrace();
} finally {
	// 사용된 객체 닫기
	try {
		// PreparedStatement 사용		pstmt.close();
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