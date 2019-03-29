<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_header.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String title = request.getParameter("board_form_subject");
String contents = request.getParameter("board_form_contents");
String writer = request.getParameter("board_form_writer");

int scate = 0, idx = 0;

String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");

	stmt = conn.createStatement();
	if (wtype.equals("in")) {	
		
		if (isLogin){
			writer = adminId;
		}else{	
			writer = writer.trim();
		}
		title = title.trim();
		contents = contents.trim();
		
		sql = "select max(n_idx) from notice";
		rs = stmt.executeQuery(sql);
		if (rs.next())	idx = rs.getInt(1) + 1;
		
		sql = "insert into notice (n_writer, n_title, n_contents) ";
		sql += "values ('" + writer + "', '" + title + "',";
		sql += "'" + contents + "')";
		
		result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('../board/notice_view.jsp?idx=" + idx +"&issa="+issa+"');");	// args : 어느 페이지에 있는것을 등록해야하는 지 모르므로 가져간다. 
			out.println("</script>");
		}
		
	} else if (wtype.equals("up")) {
		if (!isLogin) {	
			writer = writer.trim();
		}
		title = title.trim();
		contents = contents.trim();
		
		if(tmpIdx == null){
			out.println("<script>");
			out.println("location.replace('board_list.jsp');");
			out.println("</script>");
		} else {
			idx = Integer.valueOf(tmpIdx);
		}
		
		
		sql = "update notice set "; 
		sql += "n_title = '"+title+"', n_contents ='"+contents+"'";
		sql += "where n_idx = "+idx+" and n_writer = '"+adminName+"' ";
		
		result = stmt.executeUpdate(sql);
		if (result != 0) {	
			out.println("<script>");
			out.println("location.replace('../board/notice_view.jsp?idx=" + idx +"&issa="+issa+"');"); 
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
		
		sql = "select n_writer from notice where n_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			writer = rs.getString("n_writer");
		} else {	
			out.println("<script>");
			out.println("location.replace('board_list.jsp');");
			out.println("</script>");
		}
		
		sql = "delete from notice where n_idx = " + idx + " and n_writer = '" + adminName + "'";
		
		result = stmt.executeUpdate(sql);
		if (result != 0) {
			out.println("<script>");
			out.println("location.replace('board_list.jsp');");
			out.println("</script>");
		}
	
	} else {
		out.println("<script>");
		out.println("location.replace('board_list.jsp');");
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