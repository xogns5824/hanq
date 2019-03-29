<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="inc_top.jsp" %>
<%
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");

int idx = 0;

String title = "", contents = "", writer = "";

if(wtype.equals("up")){
	if(!adminId.equals("sa")){
		out.println("<script>");
		out.println("location.replace('board_list.jsp')");
		out.println("<script>");
	} else {
		idx = Integer.valueOf(tmpIdx);
		args += "&idx" + idx;
	}
	sql ="select n_title, n_contents, n_writer from product_board where n_idx="+idx;
	
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			title = rs.getString("n_title");
			contents = rs.getString("n_contents");
			writer = rs.getString("n_writer");	
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
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('../board/font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
@font-face{font-family:'HMFMPYUN'; src:url('../board/font/a내손글씨L.ttf') format('truetype');}
#body_div { position:relative; width:1200px; margin:40px auto; }

#board_form_logo{
	position:relative;
	padding-left:80px;
	text-align:center;
	font-weight:bold;
	font-family:'MADE TheArtist Script PERSONAL USE';
	font-size:25px;
	line-height:55px;
	color:#696969;
}

#board_form_table{
	position:relative;
	border-top:1px solid #ccc;
	width:1000px;
	margin:50px auto;
}

#board_form_table th, #board_form_table td{
	height:40px;
	border-bottom:1px solid #ccc;
}

#btn_div{
	padding-left:500px;
}

#btn_div input{
  	width:80px;
	height:40px;
	text-align:center;
	font-weight:bold;
	font-size:25px;
	font-family:'HMFMPYUN';
	line-height:45px;
	color:#696969;
	border:1px solid #eee;
	outline:1px solid #aaa;
	box-shadow:inset 0 2px 45px #ccc;
	margin-left:30px;
}

#btn_div input:hover{
	color:white;
	background-color:#000;
	cursor:pointer;
	box-shadow:inset 0 2px 45px #fff;
}

</style>
</head>
<body>
<div id="body_div">
<div id="board_form_logo">
<span class="board_span">NOTICE</span>
</div>
<form name="frm_borderform" id="frm_borderform" action="notice_proc.jsp" method="post" >
<input type="hidden" name="wtype" value="<%=wtype %>" />
<table id="board_form_table">
<tr><th>subject</th><td><input type="text" name="board_form_subject" id="board_form_subject" size="20" style="width:100%; border:0; " /></td></tr>
<tr><th>writer</th><td><input type="text" name="board_form_writer" id="board_form_writer" size="20" style="width:100%; border:0; " value="주봉샵"/></td></tr>
<tr><td width="*" colspan="2"><textarea name="board_form_contents" id="board_form_contents" rows="10" style="width:100%; border:0; resize: none;"></textarea></td></tr>
<tr>
</table>
<div id="btn_div">
<%if(wtype.equals("in")) {%>
	<input type="submit" value="등록"/>
<%} else if(wtype.equals("up")) {%>
	<input type="submit" value="수정"/>
<%} %>
	<input type="reset" value="다시입력" />
</div>
</form>
</div>
</body>
</html>