<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<%

String id = request.getParameter("id");
String pw = request.getParameter("pwd");
sql = " select ml_id, ml_pwd , ml_name, ml_situ from member_list where ml_id = '" + id + "' and ml_pwd='" + pw + "'";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery(sql);
	
	String msg = "";	
		if (rs.next()) {
			if(rs.getInt("ml_situ") > 1)
			{
				out.println("<script>");
				out.println("alert('일반 회원은 로그인 불가능 합니다.');");
				out.println("</script>");
			}
			else
			{
				session.setAttribute("adminId", id);
				session.setAttribute("adminName", rs.getString("ml_name"));
				session.setAttribute("userId", id);
				session.setAttribute("userName", rs.getString("ml_name"));
				out.println("<script>");
				out.println("location.replace('main.jsp');");
				out.println("</script>");
			}
		} else {
			msg = "아이디나 비밀번호를 확인해 주세요";
		}
	if (!msg.equals("")) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.print("location.replace('login_form.jsp');");
		
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