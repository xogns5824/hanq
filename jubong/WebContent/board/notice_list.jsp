<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/inc_header2.jsp" %>
<%
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

String where = "";
String args = "";


int cpage = 1, psize = 10, bsize = 10, sidx = 0;

if (tmpPage == null || tmpPage.equals("")) {
	cpage = 1;
} else {
	cpage = Integer.valueOf(tmpPage);
}
sidx = (cpage - 1) * psize;	// limit 시작 인덱스

if (schkind != null && keyword != null && !schkind.equals("") && !keyword.equals("")) {

	if (schkind.equals("tc")) {

		where = " where n_title like '%" + keyword + "%' ";
		where += " or n_contents like '%" + keyword + "%' ";
	} else if (schkind.equals("writer")) {

		where = " where n_" + schkind + " = '" + keyword + "' ";
	} else {

		where = " where n_" + schkind + " like '%" + keyword + "%' ";
	}
	args = "&schkind=" + schkind + "&keyword=" + keyword;
} else {
	schkind = "";
	keyword = "";

}

String sql = "select n_idx, n_title, n_writer, n_date, n_read from notice" +where+ " order by n_idx desc limit " +sidx+", "+psize;

try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	int num = 0;
	rs = stmt.executeQuery("select count(*) from notice " + where);
	if(rs.next()) num = rs.getInt(1);
	rs.close();
	rs = stmt.executeQuery(sql);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('./font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
#notice_bottom {
	position:relative;
	width:1200px;
	margin:0 auto;
	margin-top:40px;
	margin-bottom:100px;
}

#nqr_div {
	position:relative;
	width:830px;
	padding-left:370px;
	padding-bottom:40px;
}

#nqr_div ul li{
	list-style-type:none;
	float:left;
	margin-left:30px;
	margin-bottom:40px;
}

#nqr_div li{
	width:110px;
	height:50px;
	text-align:center;
	font-weight:bold;
	font-size:25px;
	font-family:'MADE TheArtist Script PERSONAL USE';
	line-height:55px;
	color:#696969;
	
	border:1px solid #eee;
	outline:1px solid #aaa;
	
	box-shadow:inset 0 2px 45px #ccc;
}

#nqr_div li:hover{
	color:white;
	background-color:#000;
	cursor:pointer;
	
	box-shadow:inset 0 2px 45px #fff;
}

#notice_table  {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    width:1200px;
    margin:auto;
}

.notice_table_div {
	position:relative; 
	width:1200px; 
	margin:0 auto; 
}

#notice_table th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
#notice_table td {
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    padding:20px 5px;
}

#notice_table_tr:hover {background-color:#ccc;}
a:link {color:#000; text-decoration:none;}
a:visited {color:#000; text-decoration:none;}

#searchBox {
	position:relative; 
	width:1200px; 
	margin:0 auto; 
	top:25px;
}

#n_paging {
	position:relative;
	width:1200px;
	text-align:center;
	top:30px;
	bottom:30px;
}

#n_paging .lr_btn{
	width:20px;
	height:20px;
}

#notice_list_title{	cursor:pointer; }
</style>
</head>
<body>
<%@include file="../include/inc_top2.jsp" %>
<div id="notice_bottom">
<div id="nqr_div">
<ul>
<li><span onclick="location.href='notice_list.jsp'" class="nqr_span">NOTICE</span></li>
<li><span onclick="location.href='qna_list.jsp'" class="nqr_span">Q & A</span></li>
<li><span onclick="location.href='review_list.jsp'" class="nqr_span">REVIEW</span></li>
</ul>
</div>
<div class="notice_table_div">
<table id="notice_table" width="1000">
<tr align="center">
<th width="10%">no</th>
<th width="*">title</th>
<th width="20%">writer</th>
<th width="15%">date</th>
<th width="5%">read</th>
</tr>
<% 
	String title, writer, date, linkHead="", linkTail="";
	if(rs.next()){
		int lastPage = ((num - 1) / psize) + 1;	// lastpage는 num의 값이 바뀌기 전에 설정 (마지막 페이지 번호)
		num = num - (cpage - 1) * psize;	// 게시물 개수 번호
		do{
			linkHead = "location.href='notice_read.jsp?cpage=" + cpage + args + "&idx=" + rs.getInt("n_idx") + "'";
			if(rs.getString("n_title").length() > 28){
				title = rs.getString("n_title").substring(0, 28) + "...";
			} else {
				title = rs.getString("n_title");
			}
			date = rs.getString("n_date").substring(2,10).replace('-', '.');
%>
<tr id="notice_table_tr">
<td align="center"><%=num %></td>
<td onclick="<%=linkHead%>" id="notice_list_title"><strong><%=title %></strong></a></td>
<td align="center"><%=rs.getString("n_writer") %></td>
<td><%=date %></td>
<td align="center"><%=rs.getInt("n_read") %></td>
</tr>
<%
			num --;
		}while(rs.next());
%>
</table>
</div>
<!-- 검색 영역 시작 -->
<div id="searchBox">
<form name="frm_search" method="get" >
<select name="schkind">
	<option value="writer" <%=(schkind.equals("writer")) ? "selected" : "" %>>작성자</option>
	<option value="title" <%=(schkind.equals("title")) ? "selected" : "" %>>제목</option>
	<option value="contents" <%=(schkind.equals("contents")) ? "selected" : "" %>>내용</option>
	<option value="tc" <%=(schkind.equals("tc")) ? "selected" : "" %>>제목+내용</option>
</select>
<input type="text" name="keyword" value="<%=keyword %>" />
<input type="submit" value="검 색" />
</form>
</div>
<!-- 검색 영역 종료 -->
<div id="n_paging">
<a href="notice_list.jsp?cpage=1<%=args %>"><img src="../image/end_left.jpg" class="lr_btn"/></a>
<%
	linkHead="";
	linkTail="";
	if(cpage > 1){
		linkHead = "<a href='notice_list.jsp?cpage=" + (cpage - 1) + args +"'>";
		linkTail = "</a>";
	}
	out.println(linkHead + "<img src='../image/left.jpg' class='lr_btn'/>" + linkTail);
	
	int spage = (cpage - 1) / bsize * bsize + 1;
	for(int i = spage; i < spage + bsize && i <= lastPage; i++){
		if( i == cpage ){
			out.println("&nbsp;<b>" + i + "</b>&nbsp;");
		} else {
			out.println("&nbsp;<a href = 'notice_list.jsp?cpage="+ i + args +"'>" + i + "</a>&nbsp;");
		}
	}
	
	linkHead="";
	if(cpage < lastPage) {
		linkHead = "<a href='notice_list.jsp?cpage="+(cpage + 1) + args +"'>";
	}
	out.println(linkHead + "<img src='../image/reight.jpg' class='lr_btn' />" + linkTail);
%>
	<a href="notice_list.jsp?cpage=<%=lastPage + args %>"><img src="../image/end_right.jpg" class="lr_btn"/></a>
</div>
<%		
	} else {	// 검색된 게시물이 없으면
		out.println("<tr><td colspan='5' align='center'>검색결과가 없습니다.</td></tr></table>");
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
</div>
<%@include file="../include/inc_footer.jsp" %>
<%@include file="../include/inc_banner.jsp" %>
</body>
</html>