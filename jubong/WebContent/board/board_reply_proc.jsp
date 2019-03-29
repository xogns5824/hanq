<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header2.jsp" %>
<%
// 회원일 경우에는 writer가 자동으로 들어가는 값이 있어야 한다.
// 등록일 때 검사하는 부분도 추가하여야 한다.
request.setCharacterEncoding("UTF-8");
String btype = request.getParameter("btype");
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");		// 게시글 번호
String contents = request.getParameter("contents");	// 댓글 내용
String writer = request.getParameter("writer");		// 댓글 작성자
String pwd = request.getParameter("pwd").trim();	// 비밀번호
String pridx = request.getParameter("pridx");		// 댓글번호(수정, 삭제시 필요)
int pr_idx = 0;
// 사용자가 직접 손으로 입력하는 값들은 trim()메소드를 이용하여 불필요한 띄어쓰기를 삭제
int idx = 1;

String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null)	tmpPage = "";
if (schkind == null)	schkind = "";
if (keyword == null)	keyword = "";
String args = "&cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;
// 작업(입력, 수정, 삭제) 후 돌아갈 페이지의 정보를 알기위해


String sql = "", link = "";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	
	stmt = conn.createStatement();
	
	if (wtype.equals("in")) {	// 댓글 등록 이면
		idx = Integer.valueOf(tmpIdx);
		writer = writer.trim();
		contents = contents.trim();

		sql = "insert into product_reply (pb_idx, pr_writer, pr_pwd, pr_contents) ";
		sql += "values (" + idx + ", '" + writer + "', '" + pwd + "', '" + contents + "')";
		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_view.jsp?idx=" + idx + args +"&btype="+btype+"');"); 
			out.println("</script>");
		}
	} else if (wtype.equals("up")) {	// 댓글 수정 이면
		idx = Integer.valueOf(tmpIdx);
		writer = writer.trim();
		contents = contents.trim();
		if(pridx == null){	
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
		}else{
			pr_idx = Integer.valueOf(pridx);	// String으로 작업을 하여도 상관은 없다. 하지만 수정인데도 불구하고 안들어갔을 경우 에러를 내기 위하여 숫자로 바꾸어 줄 수 있다.
		}
		
		sql = "update product_reply set pr_contents ='"+ contents +"', pr_writer = '"+ writer +"' where pr_idx = "+ pr_idx +" and pr_pwd = '"+ pwd +"'";

		int result = stmt.executeUpdate(sql);
		if (result != 0) {	// 쿼리가 정상적으로 실행되었으면
			out.println("<script>");
			out.println("location.replace('board_view.jsp?idx=" + idx + args + "&btype="+btype+"');");	// args : 어느 페이지에 있는것을 등록해야하는 지 모르므로 가져간다. 
			out.println("</script>");
		} else {	// 적용된것이 하나도 없다. (idx가 틀린걸 수도 있다. 하지만 지금은 암호가 틀린 부분만 볼 것)
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");	// args : 어느 페이지에 있는것을 등록해야하는 지 모르므로 가져간다. 
			out.println("</script>");
		}
	} else if (wtype.equals("del")) {	// 댓글 삭제 이면
		
		idx = Integer.valueOf(tmpIdx);
	
		sql = "select pb_type from product_board where pb_idx = " + idx;
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			btype = rs.getString ("pb_type");
		} else {	
			out.println("<script>");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
		}
		
		if(pridx == null){
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
		} else {
			pr_idx = Integer.valueOf(pridx);
		}
		
		sql = "delete from product_reply where pr_idx = " + pr_idx + " and pr_pwd = '" + pwd + "'";
		
		int result = stmt.executeUpdate(sql);
		if (result != 0) {
			out.println("<script>");
			out.println("opener.location.reload();");
			out.println("self.close();");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('비밀번호가 잘못되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	
	} else {	// 잘못 들어왔을 경우
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