<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/inc_header2.jsp" %>
<% 
String p_id = request.getParameter("p_id");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

String where = " where pb_type = 'r'";
String args = "", img = "", imglink = "";;

int cpage = 1, psize = 7, bsize = 10, sidx = 0;

if(tmpPage == null || tmpPage.equals("")){
	cpage = 1;
} else {
	cpage = Integer.valueOf(tmpPage);
}
sidx = (cpage - 1) * psize;

if(schkind != null && keyword != null && !schkind.equals("") && !keyword.equals("")){
	if(schkind.equals("tc")){
		where += " and pb_title like '%"+keyword+"%' or pb_contents like '%"+keyword+"%' ";
	} else if (schkind.equals("writer")){
		where += " and pb_" +schkind+"= '"+keyword+"' ";
	} else {
		where += " and pb_"+ schkind + " like '%"+keyword+"%' ";
	}
	args = "&schkind=" +schkind+ "&keyword=" + keyword + "&p_id=" + p_id;
} else {
	schkind = "";
	keyword = "";
}


String sql = "select * from product_board " + where + " order by pb_idx desc limit " + sidx + ", " + psize;


try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	int num = 0;
	rs = stmt.executeQuery("select count(*) from product_board " + where);
	if(rs.next())	num = rs.getInt(1);
	rs.close();
	
	if(p_id != null){
		rs = stmt.executeQuery("select p_img from product where p_idx == "+p_id);
		rs.close();
		if (!rs.getString("p_img").equals("./image/none.gif")){
			
			imglink = "location.href='../product/product_detail.jsp?p_id="+rs.getString("p_id")+"'";
					
			img = "<img src='"+rs.getString("p_img")+"' id='img'/>";
		} else {
			img = "";
		}
	}
	
	rs = stmt.executeQuery(sql);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('./font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
#r_body{
	position:relative;
	width:1200px;
	margin:0 auto;
	padding-top:50px;
	margin-bottom:100px;
}

#nqr_div {
	position:relative;
	width:800px;
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

#r_table_div {
	position:relative;
	padding-left:100px;	
}

#r_table_div table {
	border-bottom:1px solid #a9a9a9;
}

#r_table_div td{
	border-top:1px solid #a9a9a9;
	padding: 5px 0px;
}

#r_table_div .twd{
	border-right:1px solid #a9a9a9;
}

#r_table_div #img{
	padding:1px 0px;
	width:95px;
	height:128px;
	cursor:pointer;
}

#rread_cursor{
	cursor:pointer;
}

#searchform {
	position:relative;
	padding: 20px 0px 20px 100px;
}

#r_paging{
	position:relative;
	width:1200px;
	text-align:center;
	top:30px;
	bottom:30px;
}

#r_paging .lr_btn{
	width:20px;
	height:20px;
}

#btn{
	position:relative;
	padding-left:1025px;
	top:-80px;
}

</style>
</head>
<body>
<%@ include file="../include/inc_top2.jsp" %>
<div id="r_body">
<div id="nqr_div">
<ul>
<li><span onclick="location.href='notice_list.jsp'" class="nqr_span">NOTICE</span></li>
<li><span onclick="location.href='qna_list.jsp'" class="nqr_span">Q & A</span></li>
<li><span onclick="location.href='review_list.jsp'" class="nqr_span">REVIEW</span></li>
</ul>
</div>
<div id="r_table_div">
<table width="1000" border="0" cellspacing="0" cellpadding="0" >
<tr>
<%
	String title, contents, writer, date,linkHead="", linkTail="";
	int imguse;
	if(rs.next()){
		int lastPage = ((num-1) / psize) + 1;
		num = num - (cpage - 1) * psize;
		imguse=0;
		do {
			linkHead = "location.href='review_read.jsp?cpage="+cpage+args+"&idx="+rs.getInt("pb_idx")+"'";
			if(rs.getString("pb_title").length()>28){
				title = rs.getString("pb_title").substring(0, 28) + "...";
			} else {
				title = rs.getString("pb_title");
			}
			
			if(rs.getString("pb_contents").length() > 30) {
				contents = rs.getString("pb_contents").substring(0,30) + "...";
			} else {
				contents = rs.getString("pb_contents");
			}
				
			date = rs.getString("pb_date").substring(0, 16);
%>
<td width="5%" rowspan="3" align="center"><%=rs.getInt("pb_idx") %></td>
<td width="5.5%" rowspan="3" ><a href="<%=imglink %>"><%=img %></a></td>
<td width="5%" align="center" bgcolor="#dbdbdb" class="twd"> 제목</td>
<td width="*" colspan="5" onclick="<%=linkHead%>" id="rread_cursor">&nbsp;&nbsp;&nbsp;<%=title %></td>
</tr>
<tr >
<td width="10%" align="center" bgcolor="#dbdbdb" class="twd">글쓴이</td>
<td width="20%" align="center" class="twd"><%=rs.getString("pb_writer") %></td>
<td width="10%" align="center" bgcolor="#dbdbdb" class="twd" >작성일</td>
<td width="20%" align="center" class="twd"><%=date %></td>
<td width="5%" align="center" bgcolor="#dbdbdb"><%=rs.getInt("pb_read") %></td>
</tr>
<tr <%=(imguse!=0) ? "height='60'" : "height='30'" %>>
<td width="*" colspan="6" onclick="<%=linkHead%>" id="qread_cursor"><%=contents %></td>
</tr>
<%	
		}while(rs.next());
%>
</table>
</div>
<div id="searchform">
<form>
<select name="schkind">
	<option value="writer" <%=(schkind.equals("writer")) ? "selected" : "" %>> 작성자 </option>
	<option value="title" <%=(schkind.equals("title")) ? "selected" : "" %>> 제목 </option>
	<option value="contents" <%=(schkind.equals("contents")) ? "selected" : "" %>> 내용 </option>
	<option value="tc" <%=(schkind.equals("tc")) ? "selected" : "" %>> 제목+내용 </option>
</select>
<input type="text" name="keyword" value="<%=keyword %>" />
<input type="submit" value="검 색" />
</form>
</div>
<div id="r_paging">
<a href="review_list.jsp?cpage=1<%=args %>"><img src="../image/end_left.jpg" class="lr_btn"/></a>
<%
	linkHead="";
	linkTail="";
	if(cpage > 1){
		linkHead = "<a href='review_list.jsp?cpage=" + (cpage - 1) + args +"'>";
		linkTail = "</a>";
	}
	out.println(linkHead + "<img src='../image/left.jpg' class='lr_btn'/>" + linkTail);
	
	int spage = (cpage - 1) / bsize * bsize + 1;
	for(int i = spage; i < spage + bsize && i <= lastPage; i++){
		if( i == cpage ){
			out.println("&nbsp;<b>" + i + "</b>&nbsp;");
		} else {
			out.println("&nbsp;<a href = 'review_list.jsp?cpage="+ i + args +"'>" + i + "</a>&nbsp;");
		}
	}
	
	linkHead="";
	if(cpage < lastPage) {
		linkHead = "<a href='review_list.jsp?cpage="+(cpage + 1) + args +"'>";
	}
	out.println(linkHead + "<img src='../image/reight.jpg' class='lr_btn' />" + linkTail);
%>
	<a href="review_list.jsp?cpage=<%=lastPage + args %>"><img src="../image/end_right.jpg" class="lr_btn"/></a>
</div>
<div id="btn">
<input type="button" value="글 쓰 기" onclick="location.href='board_form.jsp?btype=r&wtype=in';" />
</div>
<%
	} else {
		out.println("<tr><td colspan='5' align='center'> 검색결과가 없습니다. </td></tr></table>");
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