<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header2.jsp" %>
<%
request.setCharacterEncoding("UTF-8");


String p_id= request.getParameter("p_id");
String btype = request.getParameter("btype");
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String title = request.getParameter("board_form_subject");
String contents = request.getParameter("board_form_contents");
String writer = request.getParameter("board_form_writer");
String pwd = request.getParameter("board_form_pwd");

int scate = 0, idx = 0;
if(wtype.equals("in")&&wtype.equals("up")){
	if(btype.equals("q")){
		scate = Integer.valueOf(request.getParameter("board_form_category"));
	}
}

String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
String args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;


String sql = "", ismem = "n";
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");

	stmt = conn.createStatement();
	if (wtype.equals("in")) {	
		
		if (isLogin){
			writer = userId;
			pwd = "";
			ismem = "y";
		}else{	
			writer = writer.trim();
			pwd = pwd.trim();
		}
		title = title.trim();
		contents = contents.trim();
		
		sql = "select max(pb_idx) from product_board";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;
		
		sql = "insert into product_board (p_id, pb_writer, pb_pwd, pb_title, pb_contents, pb_ismem, pb_type) ";
		sql += "values ('"+p_id+"','" + writer + "', '" + pwd + "', '";
		sql += title + "', '" + contents + "', '" + ismem + "', '" + btype + "')";
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_view.jsp?idx=" + idx +"');");	// args : 어느 페이지에 있는것을 등록해야하는 지 모르므로 가져간다. 
			out.println("</script>");
		}
		
	} else if (wtype.equals("up")) {
		if (!isLogin) {	
			writer = writer.trim();
			pwd = pwd.trim();
		}
		title = title.trim();
		contents = contents.trim();
		ismem = request.getParameter("ismem");
		if(tmpIdx == null){
			if(btype.equals("q")){
				out.println("<script>");
				out.println("location.replace('qna_list.jsp');");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("location.replace('review_list.jsp');");
				out.println("</script>");
			}
		} else {
			idx = Integer.valueOf(tmpIdx);
		
		}
		
		
		if(ismem.equals("n")){
			sql = "update product_board set "; 
			sql += "pb_title = '"+title+"', pb_contents ='"+contents+"', ";
			sql += "pb_writer = '"+writer+"', pb_qtype = "+scate+", pb_type='"+btype+"'";
			sql += "where pb_idx = "+idx+" and pb_pwd = '"+pwd+"'";
		} else {
			sql = "update product_board set "; 
			sql += "pb_title = '"+title+"', pb_contents ='"+contents+"', pb_qtype = "+scate+", pb_type='"+btype+"'";
			sql += "where pb_idx = "+idx+" and pb_writer = '"+userId+"' ";
		}
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	
			out.println("<script>");
			out.println("location.replace('board_view.jsp?idx=" + idx + args + "');"); 
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("location.replace('board_view.jsp?idx=" + idx + args + "');");	 
			out.println("</script>");
		}
	} else if (wtype.equals("del")) {	
		if(tmpIdx == null){
			out.println("<script>");
			out.println("self.close();");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
		
		sql = "select pb_writer, pb_ismem, pb_type from product_board where pb_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			writer = rs.getString("pb_writer");
			ismem = rs.getString("pb_ismem");
			btype = rs.getString ("pb_type");
		} else {	
			out.println("<script>");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
		}

		if(ismem.equals("n")){
			sql = "delete from product_board where pb_idx = " + idx + " and pb_pwd = '" + pwd + "'";
		} else {
			sql = "delete from product_board where pb_idx = " + idx + " and pb_writer = '" + userId + "'";
		}
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {
			out.println("<script>");
			if(ismem.equals("n")){
				
				if(btype.equals("q")){
					out.println("opener.location.replace('qna_list.jsp');");
					out.println("self.close();");
				}
				if(btype.equals("r")){
					out.println("opener.location.replace('review_list.jsp');");
					out.println("self.close();");
				}
			} else {	
				if(btype.equals("q")){
					out.println("location.replace('qna_list.jsp');");	
				}
				if(btype.equals("r")){
					out.println("location.replace('review_list.jsp');");	
				}
			}
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	
	} else {
		if(btype.equals("q")){
			out.println("<script>");
			out.println("location.replace('qna_list.jsp');");
			out.println("</script>");
		}
		
		if(btype.equals("r")){
			out.println("<script>");
			out.println("location.replace('review_list.jsp');");
			out.println("</script>");
		}
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