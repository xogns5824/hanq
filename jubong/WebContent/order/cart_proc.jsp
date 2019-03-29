<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>

<%
String p_id ="", po_size ="", po_color ="", tmpQ ="";
if(userId == null)
{
	out.println("<script>");
	out.println("location.replace('../member/login_form.jsp');");
	out.println("</script>");
}
int po_idx = 0;
sql = "";

String pid = "", wtype = "", cidx = "";
String[] wArr = {};
wtype = request.getParameter("wtype");

if(wtype == null || wtype.equals("")) {
	out.println("<script>");
	out.println("history.back();");
	out.println("</script>");
} else if(wtype.equals("del")) {
	cidx = request.getParameter("cidx");
	wArr = cidx.split(",");
	for(int i = 0 ; i < wArr.length ; i++) {
		where += "mc_id = "+wArr[i];
		if(i < wArr.length-1) {
			where += " or ";
		}
	}

	sql = "delete from member_cart where " + where;
} else if(wtype.equals("in")) {
	p_id = request.getParameter("pid");
	po_size = request.getParameter("po_size");
	po_color = request.getParameter("po_color");
	tmpQ = request.getParameter("quantity");


}

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	if(wtype.equals("in")) {
		sql = "select po_idx from product_option where po_color = '" + po_color + "' and po_size = '" + po_size + "'";
	
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			po_idx = rs.getInt("po_idx");
		}
		rs.close();
	
		
		// 장바구니에 넣기
	

		sql = "select count(*) as cnt, member_cart.po_idx from member_cart, product_option "; 
		sql += "where product_option.po_idx = member_cart.po_idx and member_cart. p_id = '"+p_id+"' and po_color = '"+po_color+"' and po_size = '"+ po_size +"'";
	
		rs = stmt.executeQuery(sql);
		if(rs.next()) {
			if(rs.getInt("cnt") > 0) {
			sql = "update member_cart set mc_cnt = mc_cnt + " + tmpQ + " where po_idx = " + rs.getInt("po_idx");
			} else {
				sql = "insert into member_cart (ml_id, p_id, po_idx, mc_cnt) values (";
				sql += "'" + userId + "', '" + p_id + "', " + po_idx + ", " + tmpQ + ")";
			}
		}

		rs.close();
	}

	result = stmt.executeUpdate(sql);
	stmt.close();
	
	if(result != 0) {	// 장바구니에 넣었을 경우 장바구니 리스트로 감.
		out.println("<script>");
		out.println("location.replace('cart_list.jsp');");
		out.println("</script>");
	}
	
} catch(Exception e) {
	out.println("일시적인 장애가 생겼습니다. 잠시 후 [새로 고침]을 누르거나 첫화면으로 이동하세요.");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
