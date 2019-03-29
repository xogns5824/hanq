<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
 *wtype : addr_list.jsp 로부터 wtype을 받아 proc에서 처리할때 구분을 짓기 위한 변수
 		: addr_list.jsp 에서 주소록 추가 버튼을 누를경우  wtype변수에는 in이 들어가고 수정 버튼을 누를경우 wtype변수에는 up이 들어간다.
 *isBasic : proc으로 값을 넘길 때 기본주소로 설정한 것인지 추가주소로 설정할 것인지에 대한 구분을 짓기 위한 변수
 addr_form.jsp 에서는 addr_list.jsp 에서 받아온 ma_idx 값을 이용하여 폼에 값을 뿌려주고, OK 버튼을 클릭할 시에 해당 값들을 가지고 addr_proc.jsp 로 이동함
*/
String wtype = request.getParameter("wtype");
String tmp_idx = "",title = "", name="", p1="", p2="", p3="", pNum="", zip="", addr1="", addr2="", isBasic="n";
int ma_idx = 0;

if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.href='addr_list.jsp'");
	out.println("</script>");
}
else if (wtype.equals("up"))
{
	tmp_idx = request.getParameter("ma_idx");
	if(tmp_idx == null || tmp_idx.equals(""))
	{
		out.println("<script>");
		out.println("location.href='addr_list.jsp'");
		out.println("</script>");
	}
	else
	{
		ma_idx = Integer.valueOf(tmp_idx);
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
#wrapper { width:1200px; margin:0 auto;}
#contents { text-align:center; }
#my_top { width:1200px; height:152px;}
#tb_addr th, #tb_addr td { border-top:2px solid black; border-bottom:2px solid black; height:60px;}
#addrForm { width:1200px; }
#box_addr { width:1200px; text-align:right; }
.btn_addr { border-radius:8px; color:black; border:1px solid black; background-color:#c1c1c1; height:40px; min-width:60px;}
.phone { width:70px;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function chkAddr(form)
{
	var zip = form.zip.value.trim();
	var addr1 = form.address1.value.trim();
	var addr2 = form.address2.value.trim();
	
	if(zip == "")
	{
		alert("우편번호를 입력해주세요.");
		form.zip.focus();
		return false;
	}
	else if (addr1 == "")
	{
		alert("주소를 입력해주세요.");
		form.address1.focus();
		return false;
	}
	else if (addr2 == "")
	{
		alert("나머지 주소를 입력해주세요.");
		form.address2.focus();
		return false;
	}
	return true;
	
}

var n ="";
function chkNum(val)
{
	var Number = val.value;
	
	if (isNaN(Number))
	{
		val.value=n;
		val.focus();
	}
	n = "";
}

</script>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	<%
	if(userId == null)
	{
		out.println("<script>");
		out.println("location.href='../member/login_form.jsp';");
		out.println("</script>");
	}
	%>
<%
//addr_list.jsp에서 주소록 수정을 버튼을 눌러 폼으로 왔을경우 wtype에는 up이 들어와서 폼에 값들을 뿌려줄 준비를 한다.
if(wtype.equals("up")) 
{
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		
		sql = "select ma_title,ma_phone,ma_name,ma_isbasic,ma_zip,ma_addr1,ma_addr2 from member_addr where ma_idx = "+ ma_idx;
		
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{
				
			title = rs.getString("ma_title");
			name = rs.getString("ma_name");
			pNum = rs.getString("ma_phone");
			p1 = pNum.substring(0,3);
			p2 = pNum.substring(4,pNum.lastIndexOf("-"));
			p3 = pNum.substring(pNum.lastIndexOf("-")+1, pNum.length());
			isBasic =rs.getString("ma_isbasic");
				zip = rs.getString("ma_zip");
			addr1 = rs.getString("ma_addr1");
			addr2 = rs.getString("ma_addr2");
			
		
		}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try
		{
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
%>
	<!-- contents -->
	<div id="contents">
			<h1>ADDRESS REGISTER</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<br /><br /><br /><br />
		<div id="addrForm">

			<form action="addr_proc.jsp?" method="post" name="addr_frm"  onsubmit="return chkAddr(this);">
			<input type="hidden" name="wtype" value="<%=wtype %>" />
			<input type="hidden" name="ma_idx" value="<%=tmp_idx %>" />
			<table width="1200" id="tb_addr" cellpadding="5" cellspacing="0">
				<tr><th>배송지명</th><td align="left"><input type="text" name="title"  value="<%=title%>"/></td></tr>
				<tr><th>성명</th><td align="left"><input type="text" name="name"value="<%=name%>" /></td></tr>
				<tr>
					<th>주소</th>
					<td align="left">
					<input type= "text" size="5" id="zip" maxlength="5" name="zip"value="<%=zip%>" onkeyup="chkNum(this);" />
					<input type="button" value="우편번호 검색" /><br />
					<input type="text" size="30" id="address1" name="address1" value="<%=addr1%>"/>&nbsp;<input type="text" size="30" id="address2"value="<%=addr2%>" name="address2"/>
					</td>
				</tr>
				<tr><th>휴대전화</th>
				<td align="left">
				<select name="phone1">
					<option value="010" <%=(p1.equals("010")) ? "selected='selected'" : "" %>>010</option>
					<option value="011" <%=(p1.equals("011")) ? "selected='selected'" : "" %>>011</option>
					<option value="017" <%=(p1.equals("017")) ? "selected='selected'" : "" %>>017</option>
				</select>
				-
				<input type="text" name="phone2" class="phone" value="<%=p2 %>" maxlength="4" onkeyup="chkNum(this);" /> - <input type="text" name="phone3"class="phone"  maxlength="4" value="<%=p3 %>" onkeyup="chkNum(this);"/></td></tr>
				<tr>
					<td colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="isBasic" id = "yb" value="y"  <%=(isBasic.equals("y")) ? "checked='checked'" :"" %>/><label for="yb">기본주소로 설정</label>
					<input type="radio" name="isBasic" id = "nb" value="n" <%=(isBasic.equals("n")) ? "checked='checked'" :"" %>/><label for="nb">추가주소로 설정</label>
					</td>
				</tr>
		
			</table>
			<br />
			<div id="box_addr"><input type="submit" class="btn_addr" value="OK" />&nbsp;&nbsp;&nbsp;<input type="button" class="btn_addr" value="CANCEL" onclick="history.back();"/></div>
			</form>
	</div>
</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>