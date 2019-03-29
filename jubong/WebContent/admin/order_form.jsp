<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_top.jsp" %>
<%
String go = "", d = "";
String tmpPage = request.getParameter("cpage");
String oid = request.getParameter("oid");
String[] status = request.getParameterValues("dealStatus");
String from = request.getParameter("from");
String to = request.getParameter("to");


if(from == null || to == null || status == null) {
	from = ""; to = ""; d = "";
}

if(status != null) {
	for(int i=0; i <status.length; i ++) {
		d += "&dealStatus=" + status[i];
	}
}
go = "cpage=" + tmpPage + "&from=" + from + "&to=" + to + d + "&oid=" + oid;

if (oid == null) {
	out.println("<script>");
	out.println("location.replace('main.jsp');");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#wrapper { width:1200px; margin:0 auto; }
#contents { width:1200px; font-size:0.8em; height:1500px; margin-top:80px;}
#top { 
	position:relative;
	width:1200px; 
	padding-left:20px; 
	border:1px solid #c1c1c1;
}
#contents p, #product_tb, #order_tb, #delivery_info, #paySum_tb{ margin-left : 120px; }
#product_tb, #order_tb, #delivery_info, #paySum_tb, #pay_td { width:960px; margin-bottom: 40px;}
#product_tb th, #product_tb td { border-top : 1px solid black; }
#order_tb th, #order_tb td { border-top : 1px solid black; padding:10px;}
#delivery_info th, #delivery_info td { border-top : 1px solid black; padding:10px; }
#paySum_tb th, #paySum_tb td { border-top : 1px solid black; padding:10px;}
.addr { margin-bottom:5px; }
#p_img { height:100px; widht:100px; }

#option { color: #5f5f5f; font-weight:bold; font-size:1em;}
#addr_list { background-color: white; border:1px solid black;}
.zip_sch { background-color: #2d2d2d; border:1px solid black; color:white;}
#btn { margin-left:500px; } 
#u_btn { background-color:black; border:0px; color:white; margin-right:10px; width:90px; height:40px; }
#c_btn { background-color:white; border:1px solid black; width:90px; height:40px; }
</style>
</head>
<body>
<div id="wrapper">
<div id="top"></div>
<div id="contents">
<form name="ord_frm" action="order_proc.jsp?<%=go %>" method="post">
 <p id="info_st">주문 상품 정보<p>
   <table id="product_tb" width="100%" cellpadding="5">
   <tr>
   <th width="10%">이미지</th><th width="30%">상품이름</th>
   <th width="20%">상품금액</th>
   <th width="18%">배송비(판매자)</th><th width="12%">수량</th>
   </tr>
<%
try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	
	sql = "select product.p_img, p_title, product.p_rprice, p_delivery, o_payment, ";
	sql += "od_cnt, od_color, od_size, o_name, o_zip, o_addr1, o_addr2, o_phone, o_email, order_info.o_id ,o_date, o_situ, ";
	sql += "o_rname, o_rzip, o_raddr1, o_raddr2, o_rphone, o_message, o_point, o_totalprice ";
	sql += "from order_info, order_detail, product ";
	sql += "where order_info.o_id = order_detail.o_id and product.p_id = order_detail.p_id and order_detail.o_id = "+ oid;
	rs = stmt.executeQuery(sql);
    if (rs.next()) {
      String o_name = "", o_zip = "", o_addr1 = "", o_addr2 = "", o_p1 = "", o_p2 = "", o_p3 = "", o_payment = "", pay = "";
      int o_p = 0;
         String[] o_phone = rs.getString("o_phone").split("-");
         o_p1 = o_phone[0];
         o_p2 = o_phone[1];
         o_p3 = o_phone[2];
         o_name = rs.getString("o_name");
         o_zip   = rs.getString("o_zip");   
         o_addr1 = rs.getString("o_addr1");
         o_addr2 = rs.getString("o_addr2");
         o_payment = rs.getString("o_payment");
		 o_p = rs.getInt("o_situ");
         if (o_payment.equals("d")) {
        	 pay = "무통장 입금";
         } else { pay = "신용카드";}
         
      String o_e1 = "", o_e2 = "";
         String[] o_email = rs.getString("o_email").split("@");
         o_e1 = o_email[0];
         o_e2 = o_email[1];
         
         String d_name = "", d_zip = "", d_addr1 = "", d_addr2 = "", d_p1 = "", d_p2 = "", d_p3 = "";
         String[] d_phone = rs.getString("o_rphone").split("-");
         d_p1 = d_phone[0];
         d_p2 = d_phone[1];
         d_p3 = d_phone[2];
         d_name = rs.getString("o_rname");
         d_zip   = rs.getString("o_rzip");   
         d_addr1 = rs.getString("o_raddr1");
         d_addr2 = rs.getString("o_raddr2");
 %>
   <tr height="150" align="center">
   <td><img src="../image/<%= rs.getString("p_img") %>" id="p_img" /></td>
   <td><%= rs.getString("p_title") %><br><span id="option"> [옵션:<%=rs.getString("od_color") %>/<%=rs.getString("od_size")%>]</span></td>
   <td><%= rs.getInt("p_rprice") %> 원</td>
   <td><%= (rs.getInt("p_delivery")==0)? "무료배송" : "" %></td>
   <td><%= rs.getInt("od_cnt") %> 개</td>
   </tr>
   <tr>
   
   </tr>
   </table>
   <p>주문 정보<p>
   <table id="order_tb" width="100%" cellspacing="0" cellpadding="5">
   <tr><th width="13%" align="left"><label for="ord_name">주문자명</label></th>
   <td><input type="text" name="ord_name" id="ord_name" value=<%=o_name %> ></td></tr>
   <tr>
   <th align="left">주소</th>
   <td>
      <input type="text" size="5" maxlength="5" name="ord_zip" class="addr" value="<%=o_zip%>"><br>
      <input type="text" size="30" name="ord_addr1" class="addr" value="<%=o_addr1%>"><br>
      <input type="text" size="30" name="ord_addr2" class="addr" value="<%=o_addr2%>">
   </td>
   </tr>
   <tr>
   <th align="left"><label for="ord_c">휴대폰</label></th>
   <td>
      <select name="ord_c1" id="ord_cell1"> 
         <option value="010" <%=(o_p1.equals("010")) ? "selected='selected'" : ""%> >010</option>
         <option value="011" <%=(o_p1.equals("011")) ? "selected='selected'" : ""%> >011</option>
         <option value="016" <%=(o_p1.equals("016")) ? "selected='selected'" : ""%> >016</option>
         <option value="019" <%=(o_p1.equals("019")) ? "selected='selected'" : ""%> >019</option>
      </select> -
      <input type="text" name="ord_c2" id="ord_c2" maxlength="4" size="4" value="<%= o_p2 %>"/> -
      <input type="text" name="ord_c3" id="ord_c3" maxlength="4" size="4" value="<%= o_p3 %>"/>
   </td>
   </tr>
   <tr>
   <th align="left"><label for="ord_e1">이메일</label></th>
   <td>
      <input type="text" name="ord_e1" id="ord_e1" value="<%=o_e1 %>"/> @
      <select name="ord_e2" id="ord_e2">
         <option value="naver.com" <%=(o_e2.equals("naver.com")) ? "selected='selected'" : ""%> >네 이 버</option>
         <option value="nate.com" <%=(o_e2.equals("nate.com")) ? "selected='selected'" : ""%> >네 이 트</option>
         <option value="gmail.com" <%=(o_e2.equals("gmail.com")) ? "selected='selected'" : ""%> >지 메 일</option>
      </select>
   </td>
   </tr>
   <tr><th align="left">주문 번호</th><td><%=rs.getString("o_id") %></td></tr>
   <tr><th align="left">주문 일시</th><td><%=rs.getString("o_date").substring(0,10) %></td></tr>
   <tr><th align="left">주문 상태</th><td>
   	<select name="situ" >
   		<option value="0" <%=(o_p == 0) ? "selected='selected'" : "" %>>미입금</option>
   		<option value="1" <%=(o_p == 1) ? "selected='selected'" : "" %>>입금 완료</option>
   		<option value="2" <%=(o_p == 2) ? "selected='selected'" : "" %>>배송중</option>
   		<option value="3" <%=(o_p == 3) ? "selected='selected'" : "" %>>배송완료</option>
   		<option value="4" <%=(o_p == 4) ? "selected='selected'" : "" %>>취소 요청</option>
   		<option value="5" <%=(o_p == 5) ? "selected='selected'" : "" %>>취소 완료</option>
   		<option value="6" <%=(o_p == 6) ? "selected='selected'" : "" %>>반품 요청</option>
   		<option value="7" <%=(o_p == 7) ? "selected='selected'" : "" %>>반품 완료</option>
   		<option value="8" <%=(o_p == 8) ? "selected='selected'" : "" %>>교환 요청</option>
   		<option value="9" <%=(o_p == 9) ? "selected='selected'" : "" %>>교환 완료</option>
   	</select>
   </td></tr>
   </table>
   
   <p>배송 정보</p>
   <table id="delivery_info" width="100%" cellspacing="0" cellpadding="5">
      <tr><th width="17%" align="left"><label for="deli_name">받으시는 분</label></th>
         <td><input type="text" name="deli_name" id="deli_name" value="<%=d_name %>" ></td></tr>
      <tr>
      <th align="left"><label for="deli_addr">주소</label></th>
      <td>
         <input type="text" size="5" maxlength="5" name="deli_zip"  class="addr" value="<%=d_zip %>" /><br>
         <input type="text" size="30" name="deli_addr1" class="addr" value="<%=d_addr1 %>" ><br>
         <input type="text" size="30" name="deli_addr2" value="<%=d_addr2 %>" >
      </td>
      </tr>
      <tr>
      <th width="20%" align="left"><label for="deli_cell1">휴대폰</label></th>
      <td>
         <select name="deli_c1" id="deli_c1">
            <option value="010" <%=(d_p1.equals("010")) ? "selected='selected'" : ""%>>010</option>
            <option value="011" <%=(d_p1.equals("011")) ? "selected='selected'" : ""%>>011</option>
            <option value="016" <%=(d_p1.equals("016")) ? "selected='selected'" : ""%>>016</option>
            <option value="019" <%=(d_p1.equals("019")) ? "selected='selected'" : ""%>>019</option>
         </select> -
         <input type="text" name="deli_c2" id="deli_c2" maxlength="4" size="4" value="<%=d_p2 %>" /> -
         <input type="text" name="deli_c3" id="deli_c3" maxlength="4" size="4" value="<%=d_p3 %>" />
      </td>
      </tr>
      <tr>
         <th align="left">배송 메시지</th>
         <td><textarea cols="110" rows="4" name="deli_msg"><%=rs.getString("o_message")%></textarea><td>
      </tr>
   </table>
 	<p>최종 결제 금액</p>
	<table id="paySum_tb" width="100%" cellspacing="0" cellpadding="5">
	<tr><th align="left" colspan="3"><%=pay %></th></tr>
	<tr><th>총 주문 금액</th><th>사용된 포인트</th><th>총 결제 금액</th></tr>
	<tr>
	<td align="center"><%=rs.getInt("p_rprice") %> 원</td>
	<td align="center">- <%=rs.getInt("o_point") %> 포인트</td>
	<td align="center">= <%=rs.getInt("o_totalprice") %> 원</td>
	</tr>
	</table>
	<div id="btn">
		<input type="submit" id="u_btn" value="수 정" >
		<input type="button" id="c_btn" value="취 소" onclick="history.back();">
	</div>
</form>
<%        
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
</div>
</body>
</html>