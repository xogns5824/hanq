<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%

String o_id = "", o_name = "", o_pwd = "";
o_id = request.getParameter("o_id");
String p_img = "", p_title = "", od_color = "", o_size = "";
int od_cnt = 0, o_totalprice = 0;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center; margin:0 auto; }
	#leftBox
	{
		position:absolute;
		width:598px;
		height:300px;
	}
	#rightBox
	{
		position:absolute;
		border:1px solid black;
		width:598px;
		height:300px;
		left:600px;
	}
	#box 
	{
		position:relative;
		width:1200px; 
		min-height:300px; 
	}
	
img { margin-bottom:10px; }

#ord_btn { 
   background-color: black; 
   color: white; 
   margin-right:10px; 
   width:130px;
   height:40px;  
   border:0px;
}

#shop_btn { 
   background-color: white; 
   color: black; 
   width:130px; 
   height:40px;  
   border:1px solid black;
}

#btn { padding:10px; margin-top:30px; border:0; }
#Info { border:1px solid red; height:500px; }
	
</style>

</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	<%
try {
      Class.forName(driver);
      conn = DriverManager.getConnection(url, "root", "root");
      sql = "select order_detail.o_id, o_name, o_pwd, order_detail.od_size, product.p_img, p_title, od_color,  od_cnt, order_info.o_totalprice "; 
      sql += "from order_info, order_detail, product ";
      sql += "where order_info.o_id = order_detail.o_id and product.p_id = order_detail.p_id and order_detail.o_id = '"+ o_id + "'";
      
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      
      if(rs.next()) {
         o_id = rs.getString("o_id");
         o_name = rs.getString("o_name");
         o_pwd = rs.getString("o_pwd");
         p_img = rs.getString("p_img");
         p_title = rs.getString("p_title");
         od_color = rs.getString("od_color");
         od_cnt = rs.getInt("od_cnt");
         o_size = rs.getString("od_size");
         o_totalprice = rs.getInt("o_totalprice");
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
	
	<!-- contents -->
	<div id="contents">
					
<form name="frm_view" action="../member/login_proc.jsp">
      <h1>주문 완료</h1>
      <div id="box">
      
			<div id="leftBox">
	            <img src="../image/<%=p_img%>" width="180"><br>
	            <%=p_title%><br> [옵션 : <%=od_color %> / <%=o_size%>]<br> 
	          	수량 : <%=od_cnt%><br>
	          	 총 결제 가격 : <%=o_totalprice%>
			</div>
			<div id="rightBox">
			   저희 쇼핑몰을 이용해 주셔서 감사합니다.<br>
		            비회원으로 구매하신 경우 조회시 
		            주문번호, 이름, 주문조회 비밀번호가 필요합니다.<br>
		            주문번호 : <b><%=o_id %></b><br>
		            이름 : <b><%=o_name %></b><br>
		            주문조회 비밀번호 : <b><%=o_pwd %></b><br> 
		            입니다.<br>
			</div>
	</div>
		
      <div id="btn">
         <input type="submit" id="ord_btn" value="주문조회 하러가기" />
         <input type="button" id="shop_btn" value="쇼핑 계속하기" onclick="location.href='../product/product_list.jsp';">
      </div>
      
      <input type="hidden" name="orderNumber" value="<%=o_id%>" />
      <input type="hidden" name="orderName" value="<%=o_name%>" />
      <input type="hidden" name="orderPw" value="<%=o_pwd%>" />
      <input type="hidden" name="ismem" value="n" /> 
      </form>


		
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>