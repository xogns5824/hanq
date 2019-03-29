<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<%
String title ="", name = "", cell="", zip = "",addr="", addr1 = "", addr2 = "", isBasic = "",c1 = "",c2 ="",c3 ="";
int ma_idx = 0;

if(userId == null) {
	out.println("<script>");
	out.println("location.href='../member/login_form.jsp';");
	out.println("</script>");
}

try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	sql = "select * from member_addr where ml_id = '"+ userId + "' order by ma_isbasic desc";
	rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
#basic { 
width:20px; 
padding:2px; 
margin-right:4px;
color:white; 
background-color:#0066cc; 
font-size:0.8em;
}

#list_tb th, #list_tb td {border-top:1px solid black;}

#p_sty p { margin:70px 0px 0px 20px; }
.sty_btn { background-color: #2d2d2d; color:white; padding:3px;}
#c_btn, #u_btn {margin-top:20px; width:70px; height:30px;}	
</style>
<script>
function addr_apply(name,zip,addr1,addr2,cell) {

	var c1 = cell.substring(0,3);
	var c2 = cell.substring(4,cell.lastIndexOf("-"));
	var c3 = cell.substring(cell.lastIndexOf("-")+1);
	opener.document.frm_order.ord_name.value = name;
	opener.document.frm_order.ord_zip.value = zip;
	opener.document.frm_order.ord_addr1.value = addr1;
	opener.document.frm_order.ord_addr2.value = addr2;
	opener.document.frm_order.ord_c1.value = c1;
	opener.document.frm_order.ord_c2.value = c2;
	opener.document.frm_order.ord_c3.value = c3;
	self.close();
}

</script>
<body>
<p id="p_sty"><strong>배송주소록 유의사항</strong></p>
<p> - 기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.</p>
<form action="order_form.jsp" method="post">
<table id="list_tb" width="100%" cellpadding="5" align="center">
<%

if(rs.next()) {
	out.println("<tr><th>배송지명</th><th>수령인</th><th>휴대전화</th><th>우편주소</th><th>주소</th><th>주소 적용</th></tr>");
do {	
	title = rs.getString("ma_title");
	name = rs.getString("ma_name");
	cell = rs.getString("ma_phone");
	isBasic =rs.getString("ma_isbasic");
	zip = rs.getString("ma_zip");
	addr1 = rs.getString("ma_addr1");
	addr2 = rs.getString("ma_addr2");
	ma_idx = rs.getInt("ma_idx");
	addr = addr1+addr2;
	
	out.println("<tr><td align='center'>"+(isBasic.equals("y")?"<span id='basic'>기본</span":"")+title+"</td>");
	out.println("<td align='center'>"+name+"</td>");
	out.println("<td align='center'>"+cell+"</td>");
	out.println("<td align='center'>"+zip+"</td>");
	out.println("<td align='center'>"+addr+"</td>");
	out.println("<td align='center'><input type='button' class='sty_btn' value='적용' onclick='addr_apply(&#39;"+name+"&#39;,&#39;"+zip+"&#39;,&#39;"+addr1+"&#39;,&#39;"+addr2+"&#39;,&#39;"+cell+"&#39;);' ></td>");
%>
<%
	}while(rs.next());
}else {
	out.println("<tr><td colspan='6' height='40' align='center'>등록한 주소가 없습니다.</td></tr>");
}
rs.close();
%>
<tr><td colspan="6" align="center">
	<input type="button" class="sty_btn" id="c_btn" value="취소" onclick="self.close();">
</td></tr>
</table>
</form>	
<%
}catch(Exception e) {
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
</body>
</html>