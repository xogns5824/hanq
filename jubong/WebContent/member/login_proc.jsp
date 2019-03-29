<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<%
String ismem ="";
ismem = request.getParameter("ismem");
String id="", pw="" ;
String orderPw="";
String history = "";
String pid= "", size="",color="", quantity ="";
history = request.getParameter("history");
if(history == null)
{
	history ="";
}
else
{
	pid=request.getParameter("pid");
	size = request.getParameter("po_size");
	color = request.getParameter("po_color");
	quantity = request.getParameter("quantity");
}
if(ismem == null || ismem.equals("")){
	out.println("<script>");
	out.println("location.replace('login_form.jsp');");
	out.println("</script>");
}else if(ismem.equals("y")){

	 id = request.getParameter("id");
	 pw = request.getParameter("pw");
	 
}else if(ismem.equals("n")){

	orderNumber = request.getParameter("orderNumber");
	 orderName = request.getParameter("orderName");
	 orderPw = request.getParameter("orderPw");
}
/* 회원과 비회원의 로그인 정보를 받아온다. */

%>


<% 
if(ismem.equals("y")){
	sql = " select ml_id, ml_pwd , ml_name, ml_situ from member_list where ml_id = '" + id + "' and ml_pwd='" + pw + "'";
	

}else if(ismem.equals("n")){
	sql="";
	sql = " select o_id, o_name  from order_info where o_id = '" + orderNumber + "' and o_name= '" + orderName;
	sql += "' and o_pwd='"+ orderPw+"'";
}

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery(sql);
	
	String msg = "";	// 로그인이 안되었을 경우 보여줄 메시지
	if(ismem.equals("y")){
		if (rs.next()) {
		// 사용자가 입력한 아이디와 비밀번호에 해당하는 회원이 있으면
				// 다른 페이지에서도 로그인 되었다는 것을 알기 위해 세션변수(속성)으로 설정
	
			if(rs.getInt("ml_situ") < 2)
			{
				if(history.equals("order"))
				{
					session.setAttribute("userId", id);
					session.setAttribute("userName", rs.getString("ml_name"));
					out.println("<script>");
					out.println("location.replace('../order/order_form.jsp?pid="+ pid +"&po_size="+ size +"&po_color="+ color +"&quantity="+ quantity+"');");
					out.println("</script>");
				}
				else
				{
						session.setAttribute("userId", id);
						session.setAttribute("userName", rs.getString("ml_name"));
						// 다른 페이지에서도 로그인 되었다는 것을 알기 위해 세션변수(속성)으로 설정
				}
			}
			else
			{
				out.println("<script>");
				out.println("alert('로그인이 불가능한 회원입니다.');");
				out.println("</script>");
			}
			out.println("<script>");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
		} else {
			msg = "아이디나 비밀번호를 확인해 주세요";
		}
	}else if(ismem.equals("n")){
	
		if (rs.next()) {
			// 비회원이 입력한 주문번호 와 주문자이름 와 주문자비밀번호에 해당하는 정보가 있으면
					session.setAttribute("orderNumber", orderNumber); // 주문자 번호 
					session.setAttribute("orderName", rs.getString("o_name"));// 주문자 이름
					// 다른 페이지에서도 로그인 되었다는 것을 알기 위해 세션변수(속성)으로 설정
		
					out.println("<script>");
					out.println("location.replace('../mypage/order_list.jsp');");
					out.println("</script>");
			
			} else {
				msg = "주문번호 와 주문자 이름 또는 주문자비밀번호를 확인해 주세요";
			}		
	}
	if (!msg.equals("")) {
		out.println("<script>");
		out.println("alert('" + msg + "')");
		out.print("location.replace('login_form.jsp?ismem="+ismem+"');");
		
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