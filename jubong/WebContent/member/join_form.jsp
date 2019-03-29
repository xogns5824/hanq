<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function reset()
	{
		obj_t =document.getElementById("email2");
		
		obj_t.disabled= false;
	}
	
	function select(obj)
	{
		obj_t = document.getElementById("email2");
		
		obj_t.value = obj.value;
		
		if(obj.value != "")
		{
			obj_t.disabled = true;
		}
		else if(obj.value == "")
		{
			obj_t.disabled = false;
		}
		
		
	}
	
	function sendIt(){
		 //아이디 입력여부 검사
		 var id =  document.frm.id.value;
		if(document.frm.id.value=="")
		 {
		  alert("아이디를 입력하지 않았습니다.")
		  document.frm.id.focus()
		 }
		 //아이디 유효성 검사 (영문소문자, 숫자만 허용)
		for (i=0;i<document.frm.id.value.length ;i++ )
		 {
		  ch=document.frm.id.value.charAt(i);
		   if (!(ch>='0' && ch<='9') && !(ch>='a' && ch<='z'))
		   {
		   alert ("아이디는 소문자, 숫자만 입력가능합니다.");
		   document.frm.id.focus();
		   document.frm.id.select();
		   document.frm.id.value="";
		   }
		 }
		 if(document.frm.id.value != "" && ((ch>='0' && ch<='9') || (ch>='a' && ch<='z')))
		 {
			 window.open("id_chk.jsp?id="+id, "a", "width=250,height=100,top=50,left=50");
		 }
		 
		 
		

		//아이디에 공백 사용하지 않기
		if (document.frm.id.value.indexOf(" ")>=0)
		 {
		  alert("아이디에 공백을 사용할 수 없습니다.");
		  document.frm.id.focus();
		  document.frm.id.select();
		  document.frm.id.value="";
		 }

		//아이디 길이 체크 (6~12자)
		if (document.frm.id.value.length<4 || document.frm.id.value.length>16)
		 {
		  alert ("아이디를 4~16자까지 입력해주세요.");
		  document.frm.id.focus();
		  document.frm.id.select();
		  document.frm.id.value="";
		 }
	}	
	
		function sendPw(){
		//비밀번호 입력여부 체크
		if(document.frm.pw1.value=="")
		 {
			  alert("비밀번호를 입력하지 않았습니다.");
			  document.frm.pw1.focus();
		 }

		//비밀번호 길이 체크(4~8자 까지 허용)
		if (document.frm.pw1.value.length<4 || document.frm.pw1.value.length>16)
		 {
			  alert ("비밀번호를 4~16자까지 입력해주세요.");
			  document.frm.pw1.focus();
			  document.frm.pw1.select();
			  document.frm.pw1.value="";
		 
		 }


		//비밀번호와 비밀번호 확인 일치여부 체크
		if (document.frm.pw1.value!=document.frm.pw2.value)
		 {
			  alert("비밀번호가 일치하지 않습니다")
			  document.frm.pw1.value="";
			  document.frm.pw2.value="";
			  document.frm.pw1.focus();
		
		 }
	}
		
		function signup(){
			var id = document.frm.id.value;
			if(id == ""){
				alert("아이디를 입력하세요");
				document.frm.id.focus();
				document.frm.id.value="";
				return false;
			}else if(document.frm.name.value == "" || document.frm.name.value == ""){
				alert("이름를 입력하세요");
				document.frm.name.focus();
				document.frm.name.value="";
				return false;
			}else if(document.frm.pw1.value == "" || document.frm.pw2.value == ""){
				alert("비밀번호를 입력하세요");
				document.frm.pw1.focus();
				document.frm.pw1.value="";
				return false;
			}else if(document.frm.p2.value == "" || document.frm.p3.value == "" ){
				alert("전화번호를 입력하세요");
				document.frm.p1.focus();
				document.frm.p1.value="";
				return false;
			}else if(document.frm.b1.value == "" || document.frm.b2.value == "" || document.frm.b3.value == "" ){
				alert("생년월일를 입력하세요");
				document.frm.b1.focus();
				document.frm.b1.value="";
				return false;
			}else if(document.frm.g1.value == "" || document.frm.g2.value == ""  ){
				alert("주소를 입력하세요");
				document.frm.g2.focus();
				document.frm.g2.value="";
				return false;
				
			}else if(document.frm.email.value == "" || document.frm.email2.value == ""){
				alert("이메일를 입력하세요");
				document.frm.email.focus();
				document.frm.email.value="";
				return false;
			}else if(document.frm.g1.value.length<1 || document.frm.g1.value.length>5 || document.frm.b3.value == "" ){
				alert("우편주소를 5글자 입력하세요");
				document.frm.g1.focus();
				document.frm.g1.value="";
				return false;
			}else if(docu)
			
			return true;
		}
		
	</script>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center; margin-left:250px; margin-top:30px;}
</style>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
	<form name="frm" action="member_proc.jsp" method="post" onsubmit="return signup();" >
	<input type="hidden" name=wtype value="in" />
	<table width="700" cellspacing="0" cellpadding="0" border="0">
	<tr>
	<td align="left">
		<table width="700" border="0" cellspacing="1" cellpadding="10" bgcolor="#c1c1c1">
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">아이디</th>
		<td align="left">
			<input type="text" name="id" id="id" size="30" />
			<input type="button" value="아이디 중복 확인" onclick ="sendIt()"/><br />
			(영문 소문자/숫자 , 4~16자)
		</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF" width="20%"  >이름</th>
		<td width="*" align="left"><input type="text" name="name" id="name" size="30" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">비밀번호</th>
		<td align="left"><input type="password" size="30" id="pw1" name ="pw1"/>(영문 소문자/숫자 , 4~16자)</td>
		
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">비밀번호 확인</th>
		<td align="left"><input type="password" size="30" id="pw2" name ="pw2" /></td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">전화번호</th>
		<td align="left">
			<select  name ="p1" id="p1">
				<option value="010">010</option>
				<option value="010">011</option>
				<option value="010">016</option>
				<option value="010">019</option>
			</select> -
			<input type="text" size="5" maxlength="4" id="p2" name ="p2" onclick ="sendPw()"/> -
			<input type="text" size="5" maxlength="4" id="p3" name ="p3" />
		</td>
		</tr>
			<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">생년월일</th>
		<td align="left">
		 <!-- 1930 ~ 올해 -->
		 <select name="b1" id="b1">
		 
		<%
		Calendar c = Calendar.getInstance();
		int cyear = c.get(Calendar.YEAR);  // 올해의 년도
		int cmonth = c.get(Calendar.MONTH) + 1; // 현재 월
		int cday = c.get(Calendar.DATE);  // 현재 일
		String slt = ""; // 선택상태 여부
		
		for (int i = 1930 ; i <= cyear ; i++) {
		 slt = (i == cyear) ? " selected='selected'" : "";
		 out.println("<option value='" + i + "' " + slt + " >" + i + "</option>");
		}
		%>
		 </select>년
		 <select  name="b2" id="b2">
		<%
		String str = "";
		for (int i = 1 ; i <= 12 ; i++) {
		 str = (i < 10) ? "0" + i : i + "";
		 slt = (i == cmonth) ? " selected='selected'" : "";
		 out.println("<option value='" + str + "' " + slt + " >" + str + "</option>");
		}
		%>
		 </select>월
		 <select  name="b3" id="b3">
		<%
		str = "";
		for (int i = 1 ; i <= 31 ; i++) {
		 str = (i < 10) ? "0" + i : i + "";
		 slt = (i == cday) ? " selected='selected'" : "";
		 out.println("<option value='" + str + "' " + slt + " >" + str + "</option>");
		}
		%>
		 </select>일
		</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF" >주소</th>
		<td align="left">
			<input type="text" size="5" maxlength="5" id="g" name="g1"/>
			<input type="button" value="우편번호 검색" /><br />
			<input type="text" size="70" width="200" id="g" name="g2"/>(기본주소)<br />
			<input type="text" size="70" width="200" id="g" name="g3"/>(나머지주소)
		</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF">이메일</th>
		<td align="left">
			<input type="text" size="20" id="email" name ="email"/> @
			<input type="text" size="20" id="email2" name="email2" />
			<select name="mail" id="mail" onchange="select(this);" >
				<option value="">직접입력</option>
				<option value="naver.com">네 이 버</option>
				<option value="nate.com">다음</option>
				<option value="gmail.com">구글</option>
			</select>&nbsp;&nbsp;
			
		</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		<th bgcolor="#EFEFEF" >
		<label for="gender1">성 별</label></th>
		<td >
			<input type="radio" name="gender" id="gender1" value="m" />남
			<input type="radio" name="gender" id="gender2" value="f" checked="checked" />여
		</td>
		</tr>
		</table>
	</td>
	</tr>
	<tr>
	<td align="center"><br />
		<input type="submit" value="회원 가입" />&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="다시 입력" onclick="location.reload();"/>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="취소" onclick="location.replace('../index.jsp');"/>
	</td>
	</tr>
	</table>
	</form>

	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>

</body>
</html>