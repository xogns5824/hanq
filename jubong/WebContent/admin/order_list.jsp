<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="inc_top.jsp" %>
<%@ page import="java.util.*" %>
<%
String  or = "", ft_date = "", ft_and = "", go = "", d = "", andSitu = "";
String tmpPage = request.getParameter("cpage");
String oid = request.getParameter("oid");
String[] status = request.getParameterValues("dealStatus");
String from = request.getParameter("from");
String to = request.getParameter("to");

if (from == null || to == null || from.equals("") || to.equals("")) {
   from = ""; to = "";   ft_and = ""; d = "";
} else {
   ft_and = " and ";
   ft_date = " (o_date between '" + from + "' and '" + to +"')";
   go = "&from=" + from + "&to=" + to;
}

int[] aa = {0,0,0,0,0,0};
if(status != null) {
   for(int i = 0 ; i < status.length ; i++) {
      aa[Integer.valueOf(status[i])] = 1;
      d += "&dealStatus="+status[i];
   }
}

String[] arrWhere = {"(o_situ = 0)","(o_situ = 1)","(o_situ = 2)","(o_situ = 3)","(o_situ > 3 and o_situ mod 2 = 0)","(o_situ > 3 and o_situ mod 2 = 1)"};
int cpage = 1, psize = 10, bsize = 10, sidx = 0;
//cpage : 현재 페이지번호, psize : 페이지크기, bsize : 블록크기, sidx : limit의 시작인덱스
if (tmpPage == null || tmpPage.equals("")) {
//현재 페이지번호가 없을 경우 무조건 1페이지로 셋팅
   cpage = 1;
} else {
//현재 페이지번호가 있을 경우 정수로 형변환함(여러 계산에서 사용되기도 하며, 인젝션 공격을 막기 위한 조치)
   cpage = Integer.valueOf(tmpPage);
}

sidx = (cpage - 1) * psize;   // limit의 시작인덱스

if(status != null && status.length > 0) {
   
   if(ft_date == null || ft_date.equals("")) {
      or = "(";
      andSitu = " and ";
   } else {
      or = "and (";
   }
   for(int i = 0 ; i < status.length ; i++) {
      if(i == status.length -1) {
         or += arrWhere[Integer.valueOf(status[i])] +")";
      } else {
         or += arrWhere[Integer.valueOf(status[i])] + " or ";
      }   
   }
} else {
   or = "";
}

sql = "select o_date, order_info.o_id, o_name, product.p_title, order_info.o_payment, o_situ "; 
sql += "from order_info, order_detail, product ";
sql +=   "where order_info.o_id = order_detail.o_id and product.p_id = order_detail.p_id " + ft_and + ft_date + andSitu + or;
sql += " order by o_date desc limit " + sidx + ", " + psize;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<style>
#wrapper { width:1200px; margin:0 auto; }
#contents { width:1200px; text-align:center; font-size:0.8em; }
#top { 
   position:relative;
   width:1200px; 
   padding-left:20px; 
   text-align:center;
   border:1px solid #c1c1c1;
}
#deli_tb th, #deli_tb td { border-bottom:1px solid black; padding:8px 0px 8px 0px; }
#deli_tb, #schBtn { margin:40px auto; font-size:1.2em;} 

#schBtn th, #schBtn td { border-bottom:1px solid black; padding:4px; }

#sch { border:1px solid black; background-color:black; color:white; padding:5px; width:50px; }
#hov:hover { color:#5f5f5f; font-weight:bold; }

</style>
<script src="../js/jquery-3.3.1.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script> 
$(document).ready(function() {

  //datepicker 한국어로 사용하기 위한 언어설정
  $.datepicker.setDefaults($.datepicker.regional['ko']);     

   // Datepicker            
   $(".datepicker").datepicker({
       showButtonPanel: true,
       dateFormat: "yy-mm-dd",
       onClose : function ( selectedDate ) {
       
           var eleId = $(this).attr("id");
           var optionName = "";

           if(eleId.indexOf("StartDate") > 0) {
               eleId = eleId.replace("StartDate", "EndDate");
               optionName = "minDate";
           } else {
               eleId = eleId.replace("EndDate", "StartDate");
               optionName = "maxDate";
           }

           $("#"+eleId).datepicker( "option", optionName, selectedDate );        
           $(".searchDate").find(".chkbox2").removeClass("on"); 
       }
   }); 

   $(".dateclick").dateclick();    // DateClick
   $(".searchDate").schDate();        // searchDate
   
});


function setSearchDate(start){

    var num = start.substring(0,1);
    var str = start.substring(1,2);

    var today = new Date();

    //var year = today.getFullYear();
    //var month = today.getMonth() + 1;
    //var day = today.getDate();
    
    var endDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#searchEndDate').val(endDate);
    
    if(str == 'd'){
        today.setDate(today.getDate() - num);
    }else if (str == 'w'){
        today.setDate(today.getDate() - (num*7));
    }else if (str == 'm'){
        today.setMonth(today.getMonth() - num);
        today.setDate(today.getDate() + 1);
    }

    var startDate = $.datepicker.formatDate('yy-mm-dd', today);
    $('#searchStartDate').val(startDate);
            
    // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
    $("#searchEndDate").datepicker( "option", "minDate", startDate );
    
    // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
    $("#searchStartDate").datepicker( "option", "maxDate", endDate );

}
</script>
</head>
<body>
<div id="wrapper">
<div id="top"></div>
<div id="contents">
   <div id="ord_Deli">
   <form method="get" >
   <table id="schBtn" width="800" border="1" cellspacing="0" cellpadding="0" >
   <tr>
      <th>기간</th>
      <td>                       
      <div class="clearfix">
       <!-- 시작일 -->
        <span class="dset">
            <input type="text" class="datepicker inpType" name="from" id="searchStartDate" value="<%=from%>">
            <a href="#none" class="btncalendar dateclick">달력</a>
        </span>
        <span class="demi">~</span>
       <!-- 종료일 -->
        <span class="dset">
            <input type="text" class="datepicker inpType" name="to" id="searchEndDate" value="<%=to%>" >
            <a href="#none" class="btncalendar dateclick">달력</a>
        </span>
          </div>
      </td> 
   </tr>
   <tr><th>거래상태</th><td>
      <input type="checkbox" id="natm" name="dealStatus" value="0" <%=(aa[0] == 1) ? "checked='checked'" : "" %>><label for="natm">미입금</label>
      <input type="checkbox" id="catm" name="dealStatus" value="1" <%=(aa[1] == 1) ? "checked='checked'" : "" %>><label for="catm">입금완료</label>
      <input type="checkbox" id="deling" name="dealStatus" value="2" <%=(aa[2] == 1) ? "checked='checked'" : "" %>><label for="deling">배송중</label>
      <input type="checkbox" id="complete" name="dealStatus" value="3" <%=(aa[3] == 1) ? "checked='checked'" : "" %>><label for="complete">배송 완료</label>
      <input type="checkbox" id="call" name="dealStatus" value="4" <%=(aa[4] == 1) ? "checked='checked'" : "" %>><label for="call">취소/반품/교환 요청</label>
      <input type="checkbox" id="finish" name="dealStatus" value="5" <%=(aa[5] == 1) ? "checked='checked'" : "" %>><label for="finish">취소/반품/교환  완료</label>
   </td></tr>
   <tr><td colspan="2" align="center"><input type="submit" id="sch" value="검색"></td></tr>
   </table>
   </form>
   <table id="deli_tb" width="1000" border="0" cellspacing="0" cellpadding="0">
   <tr>
   <th width="5%">번호</th>
   <th width="10%">주문일</th><th width="15%">주문번호</th><th width="8%">주문자</th>
   <th width="*">상품명</th><th width="13%">결제수단</th><th width="12%">주문상태</th>
   </tr>
<%
try {
    Class.forName(driver);
    conn = DriverManager.getConnection(url, "root", "root");
    stmt = conn.createStatement();

    int num = 0;
   System.out.println(from+to);
    if ((ft_date == null || ft_date.equals("")) && (or == null || or.equals(""))) {   
       rs = stmt.executeQuery("select count(*) from order_info");
    } else {
       rs = stmt.executeQuery("select count(*) from order_info where " + ft_date + or );
    }
    
   if (rs.next())   num = rs.getInt(1);
   rs.close();

   rs = stmt.executeQuery(sql);
  
   String date = "", name = "", title = "", pay = "", situ = "", deli = "";
   int delivery = 0;
   if(rs.next()) {      // 검색된 게시물이 있으면
      int lastPage = ((num - 1) / psize )+ 1;   // 마지막 페이지 번호
      num = num - (cpage - 1) * psize;   // 게시물 개수 번호
        do {
            oid = rs.getString ("o_id");
           linkHead = "<a href='order_form.jsp?cpage=" + cpage + go + d;
         linkHead += "&oid=" + rs.getString("o_id") + "'>";
           date = rs.getString("o_date").substring(0, 10);
            name = rs.getString ("o_name");
            title = rs.getString("p_title");
            pay = rs.getString("o_payment");
            delivery = rs.getInt("o_situ");
            
            if (title.length() > 28) {
            title = title.substring(0, 28) + "...";
            } else {
            title = rs.getString("p_title");
          }
             
            if (pay.equals("c")) {
             situ = "신용카드";
            } else { situ = "무통장 입금";}
             
            if (delivery == 0) {
               deli = "미입금";
            } else if (delivery == 1) {
               deli = "입금완료";
            } else if (delivery == 2) {
               deli = "배송중";
            } else if (delivery == 3) {
               deli = "배송 완료";
            } else if (delivery == 4) {
               deli = "취소 요청";
            } else if (delivery == 5) {
               deli = "취소 완료";
            } else if (delivery == 6) {
               deli = "반품 요청";
            } else if (delivery == 7) {
               deli = "반품 완료";
            } else if (delivery == 8) {
               deli = "교환 요청";
            } else if (delivery == 9) {
               deli = "교환 완료";
            }
%>
<tr>
<td><%=num%></td>
<td><%=date%></td>
<td><%=linkHead%><span id="hov"><%=oid%></a></span></td>
<td><%=name %></td>
<td><%=title %></td>
<td><%=situ %></td>
<td><%=deli %></td></tr>
<%   
   num--;
} while(rs.next());
      
%>
</table>
<div id="paging" class="brd">
<a href="order_list.jsp?cpage=1<%=go %>">&lt;&lt;</a><!-- 첫페이지로 이동 -->
<%
      linkHead = "";
      linkTail = "";
      if (cpage > 1) {
         linkHead = "<a href='order_list.jsp?cpage=" + (cpage - 1) + go + d + "'>";
         linkTail = "</a>";
      }
      out.println(linkHead + "&lt;" + linkTail);
      int spage = (cpage - 1) / bsize * bsize + 1;
      for (int i = spage ; i < spage + bsize && i <= lastPage ; i++) {
         if (i == cpage) {
            out.println("&nbsp;<b>" + i + "</b>&nbsp;");
         } else {
            out.println("&nbsp;<a href='order_list.jsp?cpage=" + i + go + d + "'>" + i + "</a>&nbsp;");
         }
      }
      linkHead = "";
      linkTail = "";
      if (cpage < lastPage) {
         linkHead = "<a href='order_list.jsp?cpage=" + (cpage + 1) + go + d + "'>";
         linkTail = "</a>";
      }
      out.println(linkHead + "&gt;" + linkTail);
   
%>
   <a href="order_list.jsp?cpage=<%=lastPage + go %>">&gt;&gt;</a><!-- 마지막페이지로 이동 -->
</div>   
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
</div>
</body>
</html>