<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/inc_header2.jsp" %>
<%
String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if (tmpPage == null) tmpPage = "";
if (schkind == null) schkind = "";
if (keyword == null) keyword = "";
String args = "?cpage=" + tmpPage + "&schkind=" + schkind + "&keyword=" + keyword;

int idx = 0;
if(tmpIdx == null) {
	out.println("<script>");
	out.println("location.replace('notice_list.jsp');");
	out.println("<script>");
} else {
	idx = Integer.valueOf(tmpIdx);
}

String sql = "select n_title, n_contents, n_writer, n_date, n_read from notice where n_idx = " + idx;
int read = 0, isView = 0;
String title = "", contents = "", writer = "", date = "";
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if (rs.next()) {
		isView = 1;
		title = rs.getString("n_title");
		contents = rs.getString("n_contents").replace("\r\n","<br />");
		writer = rs.getString("n_writer");
		date = rs.getString("n_date").substring(0, 18);
		read = rs.getInt("n_read");
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('./font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
#notice_logo{
	position:relative;
	margin:0 auto;
	width:1200px;
	padding-top:30px;
}

#notice_logo .notice_span{
	position:relative;
	margin-left:600px;
	margin-top:60px;
	text-align:center;
	font-weight:bold;
	font-family:'MADE TheArtist Script PERSONAL USE';
	font-size:25px;
	line-height:55px;
	color:#696969;
}

#notice_view_div {
	position:relative;
	margin:0 auto; 
	width:1200px;
	overflow: auto;
	padding-bottom:100px;
}

#notice_view th, #notice_view td{
	border-bottom : 1px solid #929292;
	padding : 10px 0px 10px 0px;
}

#notice_view th {
	border-right : 1px solid #929292;
}

#notice_view td{
	border-bottom : 1px solid #929292;
	padding-left : 10px;
}

#notice_view .in_notive_view_th {
	position:relative;
	border-left : 1px solid #929292;
}

#notice_view #contents_td{
	padding-left:30px;
}

#notice_view .in_notive_view_tr {
	position:relative;
	border-top : 1px solid #929292;
}

#notice_view_div .notice_view_form{
	border-top : 1px solid #929292;
	width:1000px;
	margin-left : 100px;
	margin-top : 50px;
}

.notice_view_img{
	width:80px;
	height:60px;
	margin-top:20px;
	margin-left : 550px;
	cursor:pointer;
}

</style>
</head>
<body>
<%@include file="../include/inc_top2.jsp" %>
<div id="notice_logo">
<span class="notice_span">LIST</span>
</div>
<%
if(isView == 0) {
%>	
<div style="width:700px; text-align:center; font-weight:bold;">
해당 게시들이 삭제되었습니다.
</div>
<%	
} else {
%>
<div id="notice_view_div">
<form class="notice_view_form">
<table width="1000" border="0" cellpadding="5" cellspacing="0" id="notice_view">
<tr>
<th>제목</th><td colspan="3" width="*"><%=title %></td>
<th width="12%" class="in_notive_view_th">조회수</th><td width="10%" align="center"><%=read%></td>
</tr>
<tr><td height="250" colspan="7" valign="middle" id="contents_td"><%=contents %></td></tr>
<tr>
<th width="13%">작성자</th><td width="50%"><%=writer %></td>
<th width="13%" class="in_notive_view_th">작성일</th><td colspan="3"><%=date.substring(0, date.length() - 2)%></td>
</tr>
</table>
</form>
</div>
<%	
} 
%>
<%@include file="../include/inc_footer.jsp" %>
<%@include file="../include/inc_banner.jsp" %>
</body>
</html>