<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>
<%

String p_id = request.getParameter("p_id");   // 구매 상품
String po_size = request.getParameter("po_size");   // 구매 사이즈
String po_color = request.getParameter("po_color");   // 구매 컬러
int tmpQ = Integer.valueOf(request.getParameter("tmpQ"));   // 구매 수량
String mc_tmp = request.getParameter("mc_id");   // 장바구니
int mc_id = 0;
if(mc_tmp == null || mc_tmp.equals(""))
{
   mc_id = 0;
}
else
{
   mc_id = Integer.valueOf(mc_tmp);
}
String od_name = request.getParameter("ord_name");   // 주문자명
String od_zip = request.getParameter("ord_zip");   // 주문자 우편번호
String od_addr1 = request.getParameter("ord_addr1");   // 주문자 주소1
String od_addr2 = request.getParameter("ord_addr2");   // 주문자 주소2
String od_c1 = request.getParameter("ord_c1");   // 주문자 휴대폰1
String od_c2 = request.getParameter("ord_c2");   // 주문자 휴대폰2
String od_c3 = request.getParameter("ord_c3"); // 주문자 휴대폰3
String od_e1 = request.getParameter("ord_e1");   // 주문자 이메일1
String od_e2 = request.getParameter("ord_e2");   // 주문자 이메일2
String u = request.getParameter("o_point");
String t = request.getParameter("t_point");

int o_id = 0;
int u_point = 0;
int t_point = 0;

if(u == null || u.equals("")) {
   u_point = 0;
} else {
   u_point = Integer.valueOf(u);      // 사용한  포인트   
}
if(t == null || t.equals("")) {
   t_point = 0;
} else {
   t_point = Integer.valueOf(t);      // 총 적립예정 포인트   
}

int t_price = Integer.valueOf(request.getParameter("t_price"));      // 총 결제금액
String state = request.getParameter("state");
String p_contents = "";
if(state.equals("u")) {
   p_contents = "포인트 사용";
} else {
   p_contents = "구매한 상품 적립";
}

String d_name = request.getParameter("deli_name");   // 수령인 이름
String d_zip = request.getParameter("deli_zip");   // 수령인 주소
String d_addr1 = request.getParameter("deli_addr1");   // 수령인 주소1
String d_addr2 = request.getParameter("deli_addr2");   // 수령인 주소2
String d_c1 = request.getParameter("deli_c1");   //수령인 휴대폰1
String d_c2 = request.getParameter("deli_c2");   //수령인 휴대폰2
String d_c3 = request.getParameter("deli_c3");   // 수령인 휴대폰3
String d_msg = request.getParameter("deli_msg");   // 배송메세지
String p_method = request.getParameter("pay_method");   // 카드결제, 무통장입금(c:카드, d:무통장)

String ord_pwd = request.getParameter("ord_pwd");   // 비회원 주문비밀번호
String ord_pwd2 = request.getParameter("ord_pwd2"); // 비회원 주문비밀번호확인

String od_cell = od_c1 + "-" +  od_c2 + "-" + od_c3;
String od_email = od_e1 + "@" + od_e2;
String d_cell = d_c1 +"-"+ d_c2 +"-"+ d_c3;

String oid = "";
int olen = 0;
try {
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "root");
   

   // 주문 정보에 넣기
   stmt = conn.createStatement();
   rs = stmt.executeQuery("select max(o_id) as o_id from order_info ");
   if(rs.next())
   {
      o_id = Integer.valueOf(rs.getString("o_id"))+1;
      oid = o_id+"";
      olen = oid.length();
   }
   oid = "";
   for (int i = 0 ; i < 10 - olen ;i++)
   {
      oid += "0";
   }
   oid += o_id;
   rs.close();
   
   
   if (userId == null || userId.equals("")) {   // 비회원일 경우
      sql = "insert into order_info (o_id, o_pwd, o_name, o_phone, o_email, ";
      sql += "o_zip, o_addr1, o_addr2, o_rname, o_rphone, o_rzip, o_raddr1, o_raddr2, ";
      sql += "o_message, o_totalprice, o_payment, o_situ) values (";
      sql += "'"+oid+"', '" + ord_pwd + "', '" + od_name+ "', '" + od_cell + "', '";
      sql += od_email + "', '" + od_zip+ "', '" + od_addr1 + "', '" +od_addr2 + "', '";
      sql += d_name + "', '" + d_cell + "', '" + d_zip + "', '" + d_addr1 + "', '" + d_addr2 + "', '";
      sql += d_msg +"'," + t_price + ", '" + p_method + "'";
      
      if (p_method.equals("c")) {   // 카드 결제일 경우 주문상태는 1(입금완료)
         sql += ", 1)";
      } else {               // 무통장 일경우 주문상태 0(미입금)
          sql += ", 0)";
      }
      
   } else {   // 회원일 경우
      sql = "insert into order_info (o_id, ml_id, o_name, o_phone, o_email, ";
      sql += "o_zip, o_addr1, o_addr2, o_rname, o_rphone, o_rzip, o_raddr1, o_raddr2, ";
      sql += "o_message, o_totalprice, o_payment, o_mileage, o_point, o_situ) values (";
      sql += "'"+oid+"', '" + userId + "', '" + od_name+ "', '" + od_cell + "', '";
      sql += od_email + "', '" + od_zip+ "', '" + od_addr1 + "', '" +od_addr2 + "', '";
      sql += d_name + "', '" + d_cell + "', '" + d_zip + "', '" + d_addr1 + "', '" + d_addr2 + "', '";
      if (state.equals("u")) {
   
         sql += d_msg + "', " + t_price + ", '" + p_method + "', 0, " + u_point;
      }
      else
      {
         sql += d_msg + "', " + t_price + ", '" + p_method + "', "+ t_point +", 0 ";
      }
      if (p_method.equals("c")) {
         sql += ", 1)";
      } else {
          sql += ", 0)";
      }
   }
   
   result = stmt.executeUpdate(sql);
   stmt.close();
   
   // 구매상품포인트 적립 내역 넣기 
   if(userId != null)
   {
      sql = "insert into member_point (o_id, ml_id, mp_point, mp_content, mp_state) values";
      sql += "('"+oid+"', '" + userId + "', " + ((state.equals("y")) ? t_point : (-1)*u_point)+ ", '" + p_contents + "', '" + state + "')";
      stmt = conn.createStatement();
      result = stmt.executeUpdate(sql);
      stmt.close();
      
      // 회원의 사용한 포인트 내역 넣기
      if (state.equals("u")) {
         sql = "update member_list set ml_point = ml_point -" + u_point + " where ml_id = '" + userId + "'";
      } else {
         sql = "update member_list set ml_point = ml_point +" + t_point + " where ml_id = '" + userId + "'";
      }
      stmt = conn.createStatement();
      result = stmt.executeUpdate(sql);
      stmt.close();
   }
   // 총 재고량 줄이기
   sql = "update product set p_stock = p_stock -" + tmpQ + " where p_id = '" + p_id + "'";
   stmt = conn.createStatement();
   result = stmt.executeUpdate(sql);
   stmt.close();
   
   // 색깔, 사이즈에 해당하는 재고량 줄이기
   sql = "update product_option set po_stock = po_stock -" + tmpQ + " where p_id = '" + p_id + "' and ";
   sql += "po_color = '" + po_color + "' and po_size = '" + po_size + "'";
   stmt = conn.createStatement();
   result = stmt.executeUpdate(sql);
   stmt.close();
   
   // 주문 상세
   sql = "insert into order_detail (o_id, p_id, od_size, od_color, od_cnt) values";
   sql += "('"+oid+"', '" + p_id + "', '" + po_size + "', '" + po_color + "', '" + tmpQ +"')"; 
   stmt = conn.createStatement();
   result = stmt.executeUpdate(sql);
   
   if(result != 0 ) {
      if(mc_id != 0)
      {
          result = stmt.executeUpdate("delete from member_cart where mc_id ="+mc_id);
          if(result == 0)
          {
                out.println("<script>");
                out.println("alert('장바구니 삭제 실패.');");
                out.println("</script>");
          }
      }
      out.println("<script>");
      if(p_method.equals("c")) {
         out.println("alert('결제가 완료되었습니다.');"); 
      } else {
         out.println("alert('주문이 완료되었습니다.');");
      }
      if (userId != null) {
         out.println("location.replace('../mypage/order_list.jsp');");  
      } else {
         out.println("location.replace('order_view.jsp?o_id="+oid+"')");
      }
      out.println("</script>");
   } else {
      out.println("<script>");
      out.println("location.replace('../index.jsp');");
      out.println("</script>");
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