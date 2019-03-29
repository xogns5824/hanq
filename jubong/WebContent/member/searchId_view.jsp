<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String search ="" , name ="" , email = "" ,PhoneNumber = "";
search = request.getParameter("search");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center;}
	#contents h3 { font-size:0.8em; color:#c1c1c1; }
	#s, #b{
		text-align:center;
		margin: 0 auto;
		width:307px; height:150px; border:1px solid black;
		color:353535;
		}
	#login{
			width:307px; height:40px;
			border:none; color:353535;
		  }
</style>
<script>
function goLogin(i)
{
	var val = document.frm_id.sid.value;
	if(i == 1)
	{
		location.href="login_form.jsp?id="+val;
	}
	else if(i == 2)
	{
		location.href="searchPw_form.jsp?id="+val;
	}
}

</script>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
	<%
	if(search.equals("e_id")){
		name = request.getParameter("name");
		email = request.getParameter("email");
		sql="";
		sql = " select  ml_name, ml_email as s, ml_id, ml_joindate, ml_situ from member_list where ml_name = '" + name + "' and ml_email='" + email + "'";

	}else if (search.equals("p_id")){
		name = request.getParameter("name");
		PhoneNumber = request.getParameter("PhoneNumber");
		sql="";
		sql = " select ml_name, ml_phone as s, ml_id,ml_joindate, ml_situ from member_list where ml_name = '" + name + "' and ml_phone='" + PhoneNumber+ "'";

	}
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	String msg = "";	// 로그인이 안되었을 경우 보여줄 메시지
	int i = 0;
	ArrayList<String> id=new ArrayList<String>();
	
	if (rs.next()) {
		
		out.println("<br /><br /><h2>Find ID</h2>");
		
		out.print("<h3>저희 쇼핑몰을 이용해 주셔서 감사합니다.<br />다음정보로 기입된 아이디가 아래에 존재합니다</h3>");
		out.println("<form name='frm_id'>");
		out.println("<br /><div id ='s'>");
	%>
		<br/>
		이름 : <%=rs.getString("ml_name") %><br />
		<%if (search.equals("e_id")) {%>
		이메일 : <%=rs.getString("s") %><br />
		<%}else{ %>
		휴대전화 : <%=rs.getString("s") %><br />
		<%} %>
	<%
		do{	
			if(rs.getInt("ml_situ") < 2)
			{
				out.println("<input type='radio' name='sid' value='"+ rs.getString("ml_id") +"' />"+rs.getString("ml_id")+"(가입일 :"+rs.getString("ml_joindate").substring(0,10)+")<br/>");
			}
			else
			{
				out.println("<del>"+rs.getString("ml_id")+"(가입일 :"+rs.getString("ml_joindate").substring(0,10)+")</del><b>탈퇴계정</b><br/>");
			}
		} while(rs.next());
	
	out.println("</div>");
	out.println("</form>");
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
	<tr><br />
	<td >
	<input type="button" value="로그인" id="login" onclick="goLogin(1);" />
	<br /><br />
<input type="button" value="Find PASSWORD" id="login" onclick="goLogin(2);" />
	</td>
	</tr>
	
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>

</body>
</html>