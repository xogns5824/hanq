<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header2.jsp" %>
<%
String history = request.getParameter("history");
String p_id = "";
if(history != null)
{
	if(history.equals("pd"))
	{
		p_id = request.getParameter("p_id");
	}
}
String btype = request.getParameter("btype");
String wtype = request.getParameter("wtype");
String tmpIdx = request.getParameter("idx");
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");

int idx = 0;

String title = "", contents = "", writer = "", ismem = "n", sql="", type= "", args="";

if(p_id==""){
	args = "&cpage=" + tmpPage + "&schkind="+schkind+"&keyword="+keyword;
} else {
	args = "&cpage=" + tmpPage + "&schkind="+schkind+"&keyword="+keyword+"&p_id"+p_id;	
}

if(wtype.equals("up")){
	if(tmpIdx == null || tmpIdx.equals("")){
		out.println("<script>");
		out.println("location.replace('free_list.jsp')");
		out.println("<script>");
	} else {
		idx = Integer.valueOf(tmpIdx);
		args += "&idx" + idx;
	}
	sql ="select pb_title, pb_contents, pb_writer, pb_ismem from product_board where pb_idx="+idx+"";

	
	try {
		
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			title = rs.getString("pb_title");	// 제목
			contents = rs.getString("pb_contents");	// 글내용으로 사용자가 입력한 엔터키를 <br />태그로 변환
			writer = rs.getString("pb_writer");	// 작성자
			ismem = rs.getString("pb_ismem");	// 회원여부
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

if(btype == "q"){
	type = "Q & A";
	
}else if(btype == "q"){
	type = "REVIEW";
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
@font-face{font-family:'MADE TheArtist Script PERSONAL USE'; src:url('./font/MADE TheArtist Script PERSONAL USE.otf') format('woff');}
@font-face{font-family:'HMFMPYUN'; src:url('./font/a내손글씨L.ttf') format('truetype');}
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
<script src="../js/jquery-3.3.1.js"></script>
<script>
uploadFile = function() {
	var file = document.getElementById('board_form_file');
	var filedata = new FormData();
	
	if(!file.value) return;
	
	filedata.append('uploadfile', filefiles[0]);
	
	var _xml = new XMLHttpRequest();
	_xml.open('POST','./upload',true)
	_xml.onload = function(event) {
		if(_xml.status == 200){
			alert('Uploaded');
		} else {
			alert('Error');
		}
	};
	
	_xml.send(filedata);
};
</script>
</head>
<body>
<%@ include file="../include/inc_top2.jsp" %>
<div id="body_div">
<div id="board_form_logo">
<span class="board_span"><%=type %></span>
</div>
<form name="frm_borderform" id="frm_borderform" action="board_proc.jsp" method="post" >
<input type="hidden" name="ismem" value="<%=ismem %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="btype" value="<%=btype %>" />
<input type="hidden" name="cpage" value="<%=tmpPage %>" />
<input type="hidden" name="schkind" value="<%=schkind %>" />
<input type="hidden" name="p_id" value="<%=p_id %>" />
<input type="hidden" name="keyword" value="<%=keyword %>" />

<%if(wtype.equals("up")) {%>
<input type="hidden" name="idx" value="<%=idx %>" />
<%} %>
<table id="board_form_table">
<%if(type.equals("Q & A")) {%>
<tr>
<th>scategory</th>
<td>
<select name="board_form_category">
	<option value=0>상품문의</option>
	<option value=1>배송문의</option>
	<option value=2>환불/교환</option>
	<option value=3>결제문의</option>
	<option value=4>포인트</option>
	<option value=5>회원문의</option>
</select>
</td>
</tr>
<%} %>
<tr><th>subject</th><td><input type="text" name="board_form_subject" id="board_form_subject" size="20" style="width:100%; border:0; " /></td></tr>
<tr><th>writer</th><td><input type="text" name="board_form_writer" id="board_form_writer" size="20" style="width:100%; border:0; " value="<%=writer %>"/></td></tr>
<tr><td width="*" colspan="2"><textarea name="board_form_contents" id="board_form_contents" rows="10" style="width:100%; border:0; resize: none;"></textarea></td></tr>
<tr>
<%if((wtype.equals("in") && !isLogin) || (wtype.equals("up") && ismem.equals("n"))) {%>
<tr><th>password</th><td><input type="password" name="board_form_pwd" id="board_form_pwd" size="20" style="width:100%; border:0; "/></td></tr>
<%} %>
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
<%@ include file="../include/inc_footer.jsp" %>
<%@ include file="../include/inc_banner.jsp" %>
</body>
</html>