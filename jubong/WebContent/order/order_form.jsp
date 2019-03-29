<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


String p_id = "", p_title = "", p_img = "", mc_tmp = "";
p_id = request.getParameter("pid");
int mc_id = 0;
if (p_id == null || p_id.equals("")) {
	out.println("<script>");
	out.println("location.replace('../index.jsp');");
	out.println("</script>");
}

int quantity = 1;
String po_size = request.getParameter("po_size");
String po_color = request.getParameter("po_color");
String tmpQ = request.getParameter("quantity");
mc_tmp = request.getParameter("mc_id");
if(mc_tmp == null || mc_tmp.equals(""))
{
	mc_tmp ="";
	mc_id = 0;
}
else	
{
	mc_id = Integer.valueOf(mc_tmp);
}
if(tmpQ == null || tmpQ.equals(""))
{
	quantity =1;
}
else
{
	quantity = Integer.valueOf(tmpQ);
}


int p_rprice = 0, p_delivery = 0, p_point = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	body { margin: 0px; }
	#contents {
		position:relative; 
		width:1200px; 
		border:1px solid #232323;
		margin:0 auto; 
		height:auto;
	}
	#contents h1 { text-align:center; }
	#contents p, #product_tb, #order_tb, #delivery_info, #paySum_tb, #pay_td { margin-left : 120px; }
	#product_tb, #order_tb, #delivery_info, #paySum_tb, #pay_td { width:960px; margin-bottom: 40px;}
	#product_tb th, #product_tb td { border-top : 1px solid black; }
	#order_tb th, #order_tb td { border-top : 1px solid black; padding:10px;}
	#delivery_info th, #delivery_info td { border-top : 1px solid black; padding:10px; }
	#paySum_tb th, #paySum_tb td { border-top : 1px solid black; padding:10px;}
	#pay_td { border-top : 1px solid black; border-bottom:1px solid black; font-size:0.8em; }
	.addr { margin-bottom:5px; }
	#p_img { height:100px; widht:100px; }
	.point_box { width:35%; border:1px solid #e7e7e7; height:35px; background-color:#fff; padding:3px 10px 3px 10px; float:center; }
	.pay_box { text-align:center; width:100%; margin-top:10px;}
	#pay_btn { background-color:#5a5a5a; color:#fff; height:35px; width:90%;  }
	.r { background-color:#e7e7e7; }
	#option { color: #c2c2c2; }
	
	#addr_list { background-color: white;}
	.asterisk { font-weight: bolder; color:red; }
</style>
<script>
var pwdChk = false;

var n ="";
function chkNum(val)
{
	var Number = val.value;
	if (isNaN(Number))
	{
		
		val.value=n;
		val.focus();
	}
	n = val.value;
}


function deliOrd() {
	document.frm_order.deli_name.value = document.frm_order.ord_name.value;
	document.frm_order.deli_zip.value = document.frm_order.ord_zip.value;
	document.frm_order.deli_addr1.value = document.frm_order.ord_addr1.value;
	document.frm_order.deli_addr2.value = document.frm_order.ord_addr2.value;
	document.frm_order.deli_c1.value = document.frm_order.ord_c1.value;
	document.frm_order.deli_c2.value = document.frm_order.ord_c2.value;
	document.frm_order.deli_c3.value = document.frm_order.ord_c3.value;
}

function deliNew() {
	document.frm_order.deli_name.value = "";
	document.frm_order.deli_zip.value = "";
	document.frm_order.deli_addr1.value = "";
	document.frm_order.deli_addr2.value = "";
	document.frm_order.deli_c1.value = "";
	document.frm_order.deli_c2.value = "";
	document.frm_order.deli_c3.value = "";
}


count = 0;
function chkDel(frm) {
   var obj_a = document.getElementsByName("wIdx");
   var str ="";
   var isDel = false;
   if(confirm("정말 삭제하시겠습니까?")) { isDel= true; }
   if(isDel) {
      for(var i = 0 ; i < obj_a.length ; i++) {
         if(obj_a[i].checked) {
            if(count > 0) {
               str += ",";
            }
            str += obj_a[i].value;
            count++;
         }
      }
      if(str == "") {
         alert("항목을 선택해주세요.");
      }
      else {
         location.href="wish_proc.jsp?widx="+str+"&wtype=del";
      }
   }  
}

function addrList() {
	var w = 900;	var h = 530;
	var x = window.screen.width / 2;
	var y = window.screen.height / 2;
	x = x - w / 2;
	y = y - h / 2;
	
	window.open("addr_popup.jsp", "pop", "top=" + y + ", left=" + x + ", width=" + w + ", height=" + h);
}

function chkOrd() {
	var id = frm_order.userId.value;
	var oname = frm_order.ord_name.value;
	var ozip = frm_order.ord_zip.value;
	var oaddr1 = frm_order.ord_addr1.value;
	var oaddr2 = frm_order.ord_addr2.value;
	var oc2 = frm_order.ord_c2.value;
	var oc3 = frm_order.ord_c3.value;
	var oe1 = frm_order.ord_e1.value;
	var oe2 = frm_order.ord_e2.value;
	var dname  = frm_order.deli_name.value;
	var dzip = frm_order.deli_zip.value;
	var daddr1 = frm_order.deli_addr1.value;
	var daadr2 = frm_order.deli_addr2.value;
	var dc2 = frm_order.deli_c2.value;
	var dc3 = frm_order.deli_c3.value;
	var pay = frm_order.pay_method.value;
	var w = 500;	var h = 300;
	var x = window.screen.width / 2;
	var y = window.screen.height / 2;
	x = x - w / 2;
	y = y - h / 2;

	if (oname == "") {
		alert("주문자은 필수입력사항입니다.");
		frm_order.ord_name.focus();	
	} else if (ozip == "" || oaddr1 == "" || oaddr2 == "") {
		alert("주소는 필수입력사항입니다.");
		
		if (dzip == "") {
			frm_order.ord_zip.focus();
		} else if (daddr1 == "") {
			frm_order.ord_addr1.focus();
		} else { frm_order.ord_addr2.focus(); }
		
	} else if (oc2 == "" || oc3 == "") {
		alert("휴대폰은 필수입력사항입니다.");
		
		if(oc2 == "") {
			frm_order.ord_c2.focus();
		} else { frm_order.ord_c3.focus(); }
		
	} else if (oe1 == "" || oe2 == "") {
		alert("이메일은 필수입력사항입니다.");
		return false;
	} else if(dname == "") {
		alert("받으시는 분은 필수입력사항입니다.");
		frm_order.deli_name.focus();
	} else if(dzip == "" || daddr1 == "" || daadr2 == "") {
		alert("주소는 필수입력사항입니다.");
		
		if (dzip == "") {
			frm_order.deli_zip.focus();
		} else if (daddr1 == "") {
			frm_order.deli_addr1.focus();
		} else { frm_order.deli_addr2.focus(); }
		
	} else if (dc2 == "" || dc3 == "") {
		alert("휴대폰은 필수입력사항입니다.");
		if(oc2 == "") {
			frm_order.deli_c2.focus();
		} else { frm_order.deli_c3.focus(); }

	} 
	else if(id == "null" && pwdChk == false)
	{
		alert("주문조회 비밀번호를 확인해주세요.");
		frm_order.ord_pwd2.focus();
	}
	else if(pay == "c") {
		window.open("go_popup.jsp", "pop", "top=" + y + ", left=" + x + ", width=" + w + ", height=" + h);
	}
	else {
		document.frm_order.submit();
		
	}
}


function pwdCheck() {
	var pwd = document.getElementById("ord_pwd").value;
	var pwdchk = document.getElementById("ord_pwd2").value;
	
	if (pwdchk == "") {
		document.getElementById("pwd_test").innerHTML = "";
		pwdChk = false;
	} else if (pwd != pwdchk) {
		document.getElementById("pwd_test").innerHTML = "<b><font Color=red size=2> 비밀번호가 일치하지않습니다.</font></b>";
		pwdChk = false;
	} else {
		document.getElementById("pwd_test").innerHTML = "<b><font Color=red size=2> 비밀번호가 일치합니다.</font></b>";
		pwdChk = true;
	}
}
</script>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
		<h1>ORDER</h1>
		<form name="frm_order" action="order_proc.jsp" method="post" onsubmit="ord_pay(this.form.pay_method.value)">
		<input type="hidden" name="userId" id ="userId" value="<%=userId %>" />
			<%
			if(mc_id != 0) {
			%>
			<input type="hidden" name="mc_id" value="<%=mc_id %>" />
			<%
			}
			%>
			<p>주문 상품 정보<p>
			<table id="product_tb" width="100%" cellpadding="5">
			<tr>
			<th width="5%"></th>
			<th width="10%">이미지</th><th width="30%">상품이름</th>
			<th width="20%">상품금액</th>
			<th width="10%">수량</th><th width="20%">배송비(판매자)</th>
			</tr>
			<%			
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				int totalPrice = 0, totalPoint = 0;
				sql = "select * from product where p_id = '" + p_id + "'";
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					do {
					p_img = rs.getString("p_img");
					p_id = rs.getString("p_id");
					p_title = rs.getString("p_title");
					p_rprice = rs.getInt("p_rprice");
					p_delivery = rs.getInt("p_delivery");
					p_point = rs.getInt("p_point");
					
					totalPoint += p_point * quantity;
					totalPrice += p_rprice * quantity;
			
			%>
			<tr height="150" align="center">
			<td><input type="checkbox"></td>
			<td><img src="../image/<%= p_img %>" id="p_img" /></td>
			<td><%= p_title %><br><span id='option'> [옵션:<%=po_color %>/<%=po_size%>]</span></td>
			<td><%= p_rprice %></td>
			<td><%= quantity %></td>
			<td><%= p_delivery %></td>
			</tr>
			<tr>
			<%
					}while(rs.next());
				}

				rs.close();
			%>
			<td colspan="6" align="right">상품구매금액 <%= totalPrice %> + 배송비 <%= p_delivery %> (무료) = TOTAL <%= totalPrice + p_delivery %>원</td>
			</tr>
			<tr>
			<td colspan="6" align="left">선택상품을 <input type="button" value="삭제하기"></td>
			</tr>
			</table>
			<% 
			sql = "select * from member_addr where ml_id = '" + userId + "' and ma_isbasic = 'y'";
			rs = stmt.executeQuery(sql);
			String ma_name = "", ma_zip = "", ma_addr1 = "", ma_addr2 = "", ma_p1 = "", ma_p2 = "", ma_p3 = "";
			if(rs.next()) {
				String[] ma_phone = rs.getString("ma_phone").split("-");
				ma_p1 = ma_phone[0];
				ma_p2 = ma_phone[1];
				ma_p3 = ma_phone[2];
				ma_name = rs.getString("ma_name");
				ma_zip	= rs.getString("ma_zip");	
				ma_addr1 = rs.getString("ma_addr1");
				ma_addr2 = rs.getString("ma_addr2");
			} rs.close();
			
			sql = "select ml_email from member_list where ml_id = '" + userId + "'";
			rs = stmt.executeQuery(sql);
			String ml_e1 = "", ml_e2 = "";
			if (rs.next()) {  
				String[] ml_email = rs.getString("ml_email").split("@");
				ml_e1 = ml_email[0];
				ml_e2 = ml_email[1];
			} 
			rs.close();
			%>
			<p>주문 정보<p>
			<table id="order_tb" width="100%" cellspacing="0" cellpadding="5">
			<tr><th width="10%" align="left"><label for="ord_name">주문자명<span class="asterisk">*</span></label></th>
			<td><input type="text" name="ord_name" id="ord_name" value=<%=ma_name %> ></td></tr>
			<tr>
			<th align="left">주소<span class="asterisk">*</span></th>
			<td>
				<input type="text" size="5" maxlength="5" name="ord_zip" class="addr" value="<%=ma_zip%>" onKeyup = "chkNum(this);">
				<input type="button" value="우편번호 검색" >&nbsp;
				<%if(userId != null) %><input type="button" value="주소록보기" id="addr_list" onclick="addrList()">
				<br>
				<input type="text" size="30" name="ord_addr1" class="addr" value="<%=ma_addr1%>"><br>
				<input type="text" size="30" name="ord_addr2" class="addr" value="<%=ma_addr2%>">
			</td>
			</tr>
			<tr>
			<th align="left"><label for="ord_c">휴대폰<span class="asterisk">*</span></label></th>
			<td>
				<select name="ord_c1" id="ord_cell1"> 
					<option value="010" <%=(ma_p1.equals("010")) ? "selected='selected'" : ""%> >010</option>
					<option value="011" <%=(ma_p1.equals("011")) ? "selected='selected'" : ""%> >011</option>
					<option value="016" <%=(ma_p1.equals("016")) ? "selected='selected'" : ""%> >016</option>
					<option value="019" <%=(ma_p1.equals("019")) ? "selected='selected'" : ""%> >019</option>
				</select> -
				<input type="text" name="ord_c2" id="ord_c2" maxlength="4" size="4" value="<%= ma_p2 %>" onKeyup = "chkNum(this);"/> -
				<input type="text" name="ord_c3" id="ord_c3" maxlength="4" size="4" value="<%= ma_p3 %>" onKeyup = "chkNum(this);"/>
			</td>
			</tr>
			<tr>
			<th align="left"><label for="ord_e1" align="left">이메일<span class="asterisk">*</span></label></th>
			<td>
				<input type="text" name="ord_e1" id="ord_e1" value="<%=ml_e1 %>"/> @
				<select name="ord_e2" id="ord_e2">
					<option value="">이메일 주소 입력</option>
					<option value="naver.com" <%=(ml_e2.equals("naver.com")) ? "selected='selected'" : ""%> >네 이 버</option>
					<option value="nate.com" <%=(ml_e2.equals("nate.com")) ? "selected='selected'" : ""%> >네 이 트</option>
					<option value="gmail.com" <%=(ml_e2.equals("gmail.com")) ? "selected='selected'" : ""%> >지 메 일</option>
				</select>
			</td>
			</tr>
			<%if (userId == null) { %>
			<tr>
			<th width="20%" align="left"><label for="ord_pwd">주문조회 비밀번호</label></th>
			<td><input type="password" name="ord_pwd" id="ord_pwd" ></td>
			</tr>
			<tr>
			<th width="25%" align="left"><label for="ord_pwd2">주문조회 비밀번호 확인</label></th>
			<td><input type="password" name="ord_pwd2" id="ord_pwd2" onkeyup="pwdCheck();"><span id="pwd_test"></span></td>
			</tr>
			<% } %>
			</table>
			
			<p>배송 정보</p>
			<table id="delivery_info" width="100%" cellspacing="0" cellpadding="5">
				<tr><th align="left">배송지선택</th>
					<td>
						<input type="radio"  name="deli" value="" id="deli_ord" onclick="deliOrd()">
							<label for="deli_ord">주문자 정보와 동일</label>
						<input type="radio" name="deli" value="" id="deli_new" onclick="deliNew()">
							<label for="deli_new">새로운 배송지</label>
					</td>
				</tr>
				<tr><th width="20%" align="left"><label for="deli_name">받으시는 분<span class="asterisk">*</span></label></th>
					<td><input type="text" name="deli_name" id="deli_name"></td></tr>
				<tr>
				<th align="left"><label for="deli_addr">주소<span class="asterisk">*</span></label></th>
				<td>
					<input type="text" size="5" maxlength="5" name="deli_zip"  class="addr" onKeyup="chkNum(this);" />
					<input type="button" value="우편번호 검색" /><br>
					<input type="text" size="30" name="deli_addr1" class="addr" ><br>
					<input type="text" size="30" name="deli_addr2" >
				</td>
				</tr>
				<tr>
				<th width="20%" align="left"><label for="deli_cell1">휴대폰<span class="asterisk">*</span></label></th>
				<td>
					<select name="deli_c1" id="deli_c1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="019">019</option>
					</select> -
					<input type="text" name="deli_c2" id="deli_c2" maxlength="4" size="4" onKeyup = "chkNum(this);" /> -
					<input type="text" name="deli_c3" id="deli_c3" maxlength="4" size="4" onKeyup = "chkNum(this);" />
				</td>
				</tr>
				<tr>
					<th align="left">배송 메시지</th>
					<td><textarea cols="110" rows="4" name="deli_msg"></textarea><td>
				</tr>
			</table>
			
			<p>결제 예정 금액</p>
			<table id="paySum_tb" width="100%" cellspacing="0" cellpadding="5">
			<tr>
				<th width="30%">총 주문 금액</th><th width="40%">총 사용 포인트</th><th width="*">총 결제 예정 금액</th>
			</tr>
			<tr>
				<td align="center"><%=totalPrice + p_delivery %> 원</td>
				<td align="center"><span id="usePoint">- 0 포인트</span></td>
				<td align="center"><span id="totalPrice">= <%=(totalPrice + p_delivery)%> 원</span></td>
			</tr>
			<tr>
				<td align="center">포인트</td>
				<% 
				int o_point = 0;
				sql = "select ml_point from member_list where ml_id = '" + userId + "'";
				rs = stmt.executeQuery(sql);
				
				if (rs.next()) o_point = rs.getInt("ml_point");
				rs.close();
				%>
				<td colspan="2"><input type="text" name="o_point" onkeyup="diffPrice(this)">&nbsp;포인트(총 사용가능 포인트 : <%=o_point %>포인트)<br><br>
				 - 최대 사용금액은 제한이 없습니다.<br>
				 - 포인트로만 결제 할 경우 결제금액이 0으로 보여지는 것은 정상이며 [결제하기]버튼을<br>
				&nbsp;&nbsp;누르면 주문이 완료됩니다.
				</td>
			</tr>
			</table>
			<script>	
			var n ="";
			function diffPrice(val) {	
				var obj = document.getElementById("usePoint");
				var obj_t = document.getElementById("totalPrice");
				var obj_l = document.getElementById("last_Price");
				 var Number = val.value;
				   if (isNaN(Number))
				   {
					   val.value=n;
				      val.focus();
				   }
				   n = val.value;
				if(val.value > <%=o_point %>) {
					alert('사용가능 적립금보다 많습니다.\n 적립금 사용금액을 다시 입력해 주세요. ');
					document.frm_order.o_point.value="";
					obj.innerHTML="- 0 포인트";
					document.frm_order.t_price.value = (<%=totalPrice%>);
				}
				else if(val.value > <%=totalPrice%>)
				{
					alert('사용 포인트는 판매가를 초과할 수 없습니다.');
					document.frm_order.o_point.value="";
					obj.innerHTML="- 0 포인트";
					document.frm_order.t_price.value = (<%=totalPrice%>);
				}
				else {

					obj.innerHTML="- "+val.value + " 포인트";
					document.frm_order.t_price.value = (<%=totalPrice%> - val.value);
					if(val.value > 0) {
						document.frm_order.state.value = "u";
					} else {
						document.frm_order.state.value = "y";
					}
				}

				obj_t.innerHTML = "= "+document.frm_order.t_price.value+" 원";
				obj_l.innerHTML = document.frm_order.t_price.value+" 원";
				
			}
			
			/*
			var n ="";
			function chkNum(val) {
			  
			}
			*/
			
			</script>
			<table id="pay_td" width="100%" cellspacing="0" cellpadding="5">
			<tr>
				<td>
					<input type="radio" name="pay_method" value="c" id="card" checked="checked">
					<label for="card">카드 결제</label><br>
					<input type="radio" name="pay_method" id="atm" value="d">
					<label for="atm">무통장 입금</label>
				</td>
			<td class="r" align="right">최종결제 금액 <span id="last_Price"><%=totalPrice + p_delivery %>원</span><br>
			</tr>						
			<tr>
			<td>- 최소 결제 가능 금액은 결제 금액에서 배송비를 제외한 금액입니다.<br>
			- 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</td>
			<td class="r">&nbsp;</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td class="r">
			<div class="pay_box">
			<span class="point_box">적립예정포인트 </span><span class="point_box"><%=totalPoint %> 포인트</span>
			</div>
			<div class="pay_box">
			<input type="button" value="결제하기" id="pay_btn" onclick="chkOrd();">
			<input type="hidden" name="t_price" value="<%=(totalPrice + p_delivery)%>" />
			<input type="hidden" name="t_point" value="<%=totalPoint %>">
			<input type="hidden" name="state" value="y">
			<input type="hidden" name="p_id" value="<%=p_id %>">
			<input type="hidden" name="po_size" value="<%=po_size %>">
			<input type="hidden" name="po_color" value="<%=po_color %>">
			<input type="hidden" name="tmpQ" value="<%=tmpQ %>">
			</div>
			</td>
			</tr>
			</table>
		</form>
<%
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
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</body>
</html>