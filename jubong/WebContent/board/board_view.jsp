<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header2.jsp" %>
<%
String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

if(tmpPage == null) tmpPage = "";
if(schkind == null) schkind = "";
if(keyword == null) keyword = "";
String args = "?cpage="+tmpPage+"&schkind="+schkind+"&keyword="+keyword;

int idx = 0;

if(tmpIdx == null){
	out.println("<script>");
	out.println("location.replace('qna_list.jsp');");
	out.println("</script>");
} else {
	idx = Integer.valueOf(tmpIdx);
}

String sql = "";
String pid = null, type1 = "", type2 = "", title = "", contents ="", writer ="", date ="", img = "", ismem = "";
int isView=0;

String pimg="", ptitle="", pcontect="";
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	sql = "select * from product_board where pb_idx=" + idx ;
	rs = stmt.executeQuery(sql);
	if (rs.next()) {
		isView = 1;
		pid = rs.getString("p_id");
		type1 = rs.getString("pb_type");
		type2 = rs.getString("pb_qtype");
		title = rs.getString("pb_title");
		writer = rs.getString("pb_writer");
		contents = rs.getString("pb_contents");
		date = rs.getString("pb_date").substring(0, 19);
		ismem = rs.getString("pb_ismem");
	}
	rs.close();
	if(!pid.equals("null")){
		sql = "select p_img, p_title, p_contact from product where p_id='"+pid+"'";
		rs = stmt.executeQuery(sql);
		if (rs.next()){	
			pimg = rs.getString("p_img");
			ptitle = rs.getString("p_title");
			pcontect = rs.getString("p_contact");
		}	
	} else {
		pid = "null";
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

switch (type2){
	case "0" : type2 = "상품문의";
			break;
	case "1" : type2 = "상품문의";
			break;
	case "2" : type2 = "상품문의";
			break;
	case "3" : type2 = "상품문의";
			break;
	case "4" : type2 = "상품문의";
			break;
	case "5" : type2 = "상품문의";
			break;
}

String btype = type1;

switch (type1){
case "q" : type1 = "Q & A";
		break;
case "r" : type1 = "REVIEW";
		break;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('./font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
@font-face{font-family:'HMFMPYUN'; src:url('./font/HMFMPYUN.TTF') format('truetype');}

#body_div {
	position:relative;
	margin:0 auto;
	width:1200px;
}

#qna_logo{
	position:relative;
	margin:20px auto;
	width:1200px;
	padding-top:30px;
}

#qna_logo .qna_span{
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

#product_simple{
	position:relative;
	margin:0 auto 10px auto;
	width:1000px;
	border-collapse: collapse;
	border-top:1px solid #ccc;
	border-bottom:1px solid #ccc;
}

#product_simple img{ width:140px; height:180px; }

#qna_table {
	position:relative;
	margin:0 auto; 
	width:1000px;
	overflow: auto;
	padding-bottom:100px;
	border-top:1px solid #929292;
}

#qna_table th, #qna_table td{ border-bottom : 1px solid #929292; padding : 10px 0px 10px 0px; }

#qna_table #contents{ padding-left : 30px; }

#buttonBox{
	position:relative;
	padding-left:480px;
	margin-bottom:40px;
}

#buttonBox input{
	width:80px;
	height:30px;
	text-align:center;
	font-weight:bold;
	font-size:13px;
	font-family:'HMFMPYUN';
	color:#696969;
	border:1px solid #eee;
	outline:1px solid #aaa;
	box-shadow:inset 0 2px 45px #ccc;
}

#board_reply{ position:relative; margin: 10px auto 40px auto; }

#board_reply_rego{
	position:relative;
	margin:0 auto;
	width:1000px;
	border-collapse: collapse;
	border-top:1px solid #000;
	border-bottom:1px solid #000;
}

#board_reply_List{
	position:relative;
	margin:20px auto;
	width:1000px;
	border-collapse: collapse;
	border-top:1px solid #ccc;
	border-bottom:1px solid #ccc;
}

#board_reply_rego th, #board_reply_rego td{ border:1px solid #ccc; }
</style>

<script>
function isDel() {
	if(confirm("정말 삭제하시겠습니까?")){
		<% if (ismem.equals("n")){%>
			window.open("board_delete.jsp?idx="+<%=idx%>, "a", "width=200, height=100, top=50, left=100,");
		<%} else { %>
			location.href="board_proc.jsp?wtype=del&idx="+<%=idx%>;
		<%}%>
	}
}

function replyUp(pr_idx){
	var writer = eval("document.frm.writer" + pr_idx + ".value");
	var contents= eval("document.frm.contents" + pr_idx + ".value");
	
	document.frm_reply.writer.value = writer;
	document.frm_reply.contents.value = contents;
	document.frm_reply.pridx.value = pr_idx;
	document.frm_reply.wtype.value = "up";
	document.frm_reply.smt.value = "수 정";
}

function replyDel(pr_idx){
	if(confirm("정말 삭제하시겠습니까?")){
		window.open("board_reply_delete.jsp?pridx="+pr_idx+"&idx="+<%=idx%>, "a", "width=200, height=100, top=50, left=100")
	}
}
</script>

</head>
<body>
<%@ include file="../include/inc_top2.jsp" %>
<div id="body_div">
<div id="qna_logo">
<span class="qna_span"><%=type1 %></span>
</div>
<!-- 상품 심플 이미지 시작 -->
<%
if (pid != null && !pid.equals("null")) { 
%>
<table id="product_simple" height="200">
<tr>
<td rowspan="3" align="center" width="160"><img src="../image/<%=pimg %>" /></td>
<td height="40" style="font-weight:bold;"><%=ptitle %></td> 
</tr>
<tr> <td valign="top"><%=pcontect %></td> </tr>
<tr> <td valign="bottom" style="padding-bottom:10px;"><input type="button" onclick="location.href='../product/product_detail.jsp?pid=<%=pid %>'" value="상품상세보기"></td> </tr>
</table>
<%}%>
<!-- 상품 심플 이미지 종료 -->
<!-- 게시판 시작 -->
<table id="qna_table">
<%if (type1.equals("Q & A")) {%>
<tr><th>scategory</th><td><%=type2 %></td></tr>
<%}%>
<tr><th>subject</th><td><%=title %></td></tr>
<tr><th>writer</th><td><%=writer %></td></tr>
<tr><td colspan="2" height="120" valign="middle" id="contents"><%=contents %></td></tr>
<tr><th>date</th><td><%=date %></td></tr>
</table>
<div id="buttonBox">
<% if(ismem.equals("n") || (ismem.equals("y") && isLogin && writer.equals(userId))) { %>
	<input type="button" value="글 수 정" onclick="location.href='board_form.jsp<%=args %>&idx=<%=idx %>&wtype=up&btype=<%=type1.equals("Q & A")?"q":"r"%>';" />&nbsp;&nbsp;&nbsp;
	<input type="button" value="글 삭 제" onclick="isDel();" />&nbsp;&nbsp;&nbsp;
<%} %>
<% if(type1.equals("Q & A")) {%>
	<input type="button" value="글 목 록" onclick="location.href='qna_list.jsp<%=args %>';" />
<%} else { %>
	<input type="button" value="글 목 록" onclick="location.href='review_list.jsp<%=args %>';" />
<%}%>
</div>
<!-- 게시판 종료 -->
</div>
<div id="board_reply">
<!-- 댓글 입력 폼 시작 -->
<form name="frm_reply" action="board_reply_proc.jsp?btype="+<%=btype%> method="post">
<input type="hidden" name="wtype" value="in" />
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="pridx" value="" />
<table id="board_reply_rego">
<tr align="center">
<th width="15%">작 성 자</th>
<td width="*" rowspan="4"><textarea name="contents" id="contents" rows="10" style="width:100%; border: 0; resize: none;"></textarea></td>
<td width="10%" rowspan="4"><input type="submit" name="smt" id="smt" value="등 록" /></td>
</tr>
<tr><td><input type="text" name="writer" class="ipt" size="20" style="width:100%; border: 0; "/></td></tr>
<tr><th align="center">비밀번호</th></tr>
<tr><td><input type="password" name="pwd" class="ipt" size="20" style="width:100%; border: 0;"/></td></tr>
</table>
</form>
<!-- 댓글 입력 폼 종료 -->

<!-- 댓글 목록 시작 -->
<form name="frm">
<%
sql="select pr_idx, pr_writer, pr_contents, pr_date from product_reply where pb_idx="+idx;
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		do{
%>
<input type="hidden" name="writer<%=rs.getInt("pr_idx")%>" value="<%=rs.getString("pr_writer") %>" />
<input type="hidden" name="contents<%=rs.getInt("pr_idx")%>" value="<%=rs.getString("pr_contents") %>" />
<table width="700" cellspacing="0" id="board_reply_List">
<tr height="40">
<td width="30%"><%=rs.getString("pr_writer") %></td>
<td width="*" align="right"><%=rs.getString("pr_date").substring(0, 19) %>&nbsp;
<span class="hand" onclick="replyUp(<%=rs.getInt("pr_idx")%>);" >[수정]</span>&nbsp;
<span onclick="replyDel(<%=rs.getInt("pr_idx")%>);" class="hand">[삭제]</span>&nbsp;
</td>
</tr>
<tr>
<td width="*" colspan="2" class="con" height="50" style="border-top:1px solid #ccc;">
<%=rs.getString("pr_contents").replace("\r\n","<br />") %>
</td>
</tr>
</table>
<%
		}while(rs.next());
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
<!-- 댓글 목록 종료 -->
</form>

<!-- 댓글 입력 폼 종료 -->
</div>
<%@ include file="../include/inc_footer.jsp" %>
<%@ include file="../include/inc_banner.jsp" %>
</body>
</html>