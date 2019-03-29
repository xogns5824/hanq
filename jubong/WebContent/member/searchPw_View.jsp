<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center;}
	#contents h3 { font-size:0.8em; color:#c1c1c1; }
	#s {
		text-align:center;
		margin: 0 auto;
		width:600px; height:150px; border:1px solid black;
		color:353535;
		}
	#login{
			width:307px; height:40px;
			border:none; color:353535;
		  }
</style>

</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
<%
String search ="" , name ="" , email = "" ,stype ="",id= "";
search = request.getParameter("search");

id = request.getParameter("id");
name = request.getParameter("name");
email = request.getParameter("email");

sql = " select ml_id, ml_name , ml_email, ml_situ from member_list where ml_email = '" + email +"' and ml_id ='"+ id +"' and ml_name = '"+ name +"'"; 


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	String msg = "";	// 로그인이 안되었을 경우 보여줄 메시지
	
	if (rs.next()) {
		
		out.println("<br /><br /><h2>Find PASSWORD</h2>");
		
		out.print("<h3>"+ rs.getString("ml_name") +"님 저희 쇼핑몰을 이용해 주셔서 감사합니다.<br />비밀번호를 변경해 주세요.</h3>");
		out.println("<br /><div id ='s'>");
		if(rs.getInt("ml_situ") <2)
		{
			
		
		%>
		<br/><tr id="div"><br />
		<td >
		이메일 : <%=rs.getString("ml_email")%>으로 임시비밀번호를 발송해드렸습니다.<br />
		임시비밀번호로 로그인한 후 비밀번호를 변경해 주세요
		
		</td>
		</tr>
		<%
		}
		else
		{
			out.println("<tr id='div'><h2><font color='red'>탈퇴회원</font></h2><td align='center'>"+ rs.getString("ml_id") +"님은 탈퇴된 회원입니다.</td></tr>");
		}
		out.println("</div>");
		%>
	
		<%
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
	<tr ><br />
	<td >
	<a href = "../index.jsp"><input type="button" value="OK" id="login" /></a>
	</td>
	</tr>
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>

</body>
</html>