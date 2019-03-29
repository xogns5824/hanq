<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String p_title = "", p_img = "";
String p_id = request.getParameter("pid");
String po_size = request.getParameter("po_size");
String po_color = request.getParameter("po_color");
String tmpQ = request.getParameter("quantity");
int tprice = 0;
int quantity = 1;
if(tmpQ == null || tmpQ.equals("")) {
	quantity =1;
} else {
	quantity = Integer.valueOf(tmpQ);
}

int p_rprice = 0, p_delivery = 0, p_point = 0, mc_id = 0;
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
	#cart_tb, #cart_sum { margin-left : 120px; width:960px; margin-bottom: 40px; }
	#cart_tb th, #cart_tb td, #cart_sum th, #cart_sum td{ border-top : 1px solid black; padding:10px; }
	#p_img { height:100px; widht:100px; }
	#del_btn { margin-top:4px; background-color:rgb(228,228,228); }
	.ord_btn { 
		position:relative; 
		right:-500px;
		margin-bottom:80px;
		background-color:rgb(64,64,64);
		color:white;
	}
	#ord_btn { background-color:rgb(64,64,64); color:white; }
	#goShop_btn { position:relative; right:-780px; background-color:rgb(228,228,228); }
	#option { color: #c2c2c2; }
	#sel_btn { background-color:rgb(228,228,228); }
</style>
<script src="../js/jquery-3.3.1.js"></script>
<script>
function check_all() {	
	var obj = document.getElementsByName("chkall");
	var obj_a = document.getElementsByName("cIdx");
	var isChk = obj[0].checked;

	for (var i = 0; i < obj_a.length; i++ ) {
		obj_a[i].checked = isChk; //체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	}
}
var count = 0;
function chkDel(frm) {
	var obj_a = document.getElementsByName("cIdx");
	var str ="";
	var isDel = false;
	if(confirm("정말 삭제하시겠습니까?")) {
		isDel= true;
	}
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
		if(str =="") {
			alert("항목을 선택해주세요.");
		}
		else {
			location.href="cart_proc.jsp?cidx="+str+"&wtype=del";
		}
	}
}

function cartDel(val) {
   var isDel = false;
   if(confirm("정말 삭제하시겠습니까?")) {
      isDel= true;
   }
   
	if(isDel) {
      location.href="cart_proc.jsp?cidx="+val+"&wtype=del";   
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
		<h1>CART</h1>
		<%@ include file="../include/inc_myinfo.jsp" %>
		<form name="frm_cart" action="cart_proc.jsp" method="post">
			<table id="cart_tb" width="100%" cellpadding="5">
			<%			
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				int totalPrice = 0, totalPoint = 0;
				sql = "select product.p_id, p_img, p_title, mc_cnt, mc_id, po_color, po_size, p_rprice, p_delivery from product,member_cart,product_option "; 
				sql += "where product.p_id = member_cart.p_id and product_option.po_idx = member_cart.po_idx and ml_id = '"+userId+"'"; 
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
					out.println("<tr><th width='3%'><input type='checkbox' name='chkall' onchange='check_all()'></th>"
							+"<th width='10%'>이미지</th><th width='*%'>상품이름</th>"
							+"<th width='10%'>상품금액</th><th width='10%'>수량</th>"
							+"<th width='6%'>배송비</th><th width='13%'>총 가격</th>"
							+"<th width='10%'>주문</th></tr>");
					do {
					p_id = rs.getString("p_id");
					p_img = rs.getString("p_img");
					p_title = rs.getString("p_title");
					tmpQ = rs.getString("mc_cnt");
					po_color = rs.getString("po_color");
					po_size = rs.getString("po_size");
					p_rprice = rs.getInt("p_rprice");
					p_delivery += rs.getInt("p_delivery");
					mc_id = rs.getInt("mc_id");
					quantity = Integer.valueOf(tmpQ);
					tprice = p_rprice * quantity;
					totalPoint += p_point * quantity;
					totalPrice += p_rprice * quantity;
					
					out.println("<tr height='80'><td><input type='checkbox' name='cIdx' value="+ rs.getInt("mc_id") +"></td>");
					out.println("<td><img src='../image/"+ p_img + "' id='p_img'></td>");
					out.println("<td align='center'>"+p_title+"<br><span id='option'> [옵션:"+po_color+"/"+po_size+"]</span></td>");
					out.println("<td align='center'>"+p_rprice+"</td>");
					out.println("<td align='center'>"+quantity+"</td>");
					out.println("<td align='center'>"+p_delivery+"</td>");
					out.println("<td align='center'>"+tprice+"</td>");
					out.println("<td align='center'><input type='button' id='ord_btn' value='구매하기' onclick=location.href='order_form.jsp?pid=" + p_id + "&po_size="+ po_size +"&po_color="+ po_color +"&quantity="+ quantity + "&mc_id="+mc_id+"'; </td>");
					out.println("<input type='button' value='삭제하기' id='del_btn' onclick='cartDel("+rs.getInt("mc_id")+")'></td></tr>");
					}while(rs.next());
					out.println("<tr><td colspan='8' align='left'>선택상품을 <input type='button' id='sel_btn' value='삭제하기' onclick='chkDel(this.form);'></td></tr>");
					out.println("<tr><td colspan='8' align='left'><input type='button' value='쇼핑계속하기' id='goShop_btn' onclick=location.href='../product/product_list.jsp'; /></td></tr>");
				} else {
					out.println("<tr><td colspan='8' align='center'>장바구니가 비어 있습니다.</td></tr>");
				}
				rs.close();
			%>
			</table>
			<table id="cart_sum" width="100%" cellpadding="5">
			<tr><th>총 상품금액</th> <th>총 배송비</th> <th>결제예정금액</th></tr>
			<tr align="center">
			<td><%= totalPrice %>원</td>
			<td>+<%= p_delivery %>원</td>
			<td>=<%= p_delivery + totalPrice %>원</td>
			</tr>
			</table>
			<input type="hidden" name="wtype" value="in">
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