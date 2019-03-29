<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc_top.jsp" %>
<%
String  or = "", ft_date = "", ft_and = "", go = "", d = "";
int total = 0, noticecnt = 0, qnacnt = 0, reviewcnt = 0,lastPage=0;
String tmpPage = request.getParameter("cpage");
String schkind = request.getParameter("schkind");
String keyword = request.getParameter("keyword");
String from = request.getParameter("from");
String to = request.getParameter("to");
String search_btype = request.getParameter("search_btype");
String and ="", board_type="";

if (from == null || to == null || from.equals("") || to.equals("")) {
   from = ""; to = "";   ft_and = ""; d = "";
} else {
   ft_and = " and ";
   if(search_btype.equals("notice")){
      ft_date = " (n_date between '" + from + "' and '" + to +"')";
   } else {
      ft_date = " (pb_date between '" + from + "' and '" + to +"')";   
   }
   go = "&from=" + from + "&to=" + to;
}
if(search_btype == null || search_btype.equals("") || search_btype.equals("notice")) {
   search_btype = "notice";
   board_type="n";   
} else if (search_btype.equals("qna") || search_btype.equals("review")){
   board_type="pb";
}

String img = "", imglink = "";

int cpage = 1, psize = 7, bsize = 10, sidx = 0;

if(tmpPage == null || tmpPage.equals("")){
   cpage = 1;
} else {
   cpage = Integer.valueOf(tmpPage);
}
sidx = (cpage - 1) * psize;

if(schkind != null && keyword != null && !schkind.equals("") && !keyword.equals("")){
   if(schkind.equals("tc")){
      where += board_type+"_title like '%"+keyword+"%' or "+board_type+"_contents like '%"+keyword+"%' and ";
   } else if (schkind.equals("writer")){
      where += board_type+"_" +schkind+"= '"+keyword+"' and ";
   } else {
      where += board_type+"_"+ schkind + " like '%"+keyword+"%' and ";
   }
   args = "&schkind=" +schkind+ "&keyword=" + keyword ;
} else {
   schkind = "";
   keyword = "";
}
if(where != null) and = " and ";
try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "root");
   stmt = conn.createStatement();
   
   sql = "select count(*) from product_board";
   rs = stmt.executeQuery(sql);
   if(rs.next()) total += rs.getInt(1);
   rs.close();
   
   sql = "select count(*) from notice";
   rs = stmt.executeQuery(sql);
   if(rs.next()) { 
      total += rs.getInt(1);
      noticecnt += rs.getInt(1); 
   }
   rs.close();
   
   sql = "select count(*) from product_board where pb_type='q'";
   rs = stmt.executeQuery(sql);
   if(rs.next()) { 
      qnacnt += rs.getInt(1); 
   }
   rs.close();
   
   sql = "select count(*) from product_board where pb_type='r'";
   rs = stmt.executeQuery(sql);
   if(rs.next()) { 
      reviewcnt += rs.getInt(1); 
   }
   rs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#notice_logo{
   position:relative;
   margin:0 auto;
   width:1200px;
   padding-top:30px;
}

#notice_logo .notice_span{
   position:relative;
   margin-left:600px;
   margin-top:60px;
   text-align:center;
   fonst-weight:bold;
   font-family:'MADE TheArtist Script PERSONAL USE';
   font-size:30px;
   line-height:55px;
}

#board_list_div {
   position:relative;
   width:1200px;
   margin:0 auto;
}


#total_board_caption { float:right; }

#board_list_div ul, #board_list_div li {
   position : relative;
   list-style-type:none;
   float:left;
   margin-left:20px;
   top:5px;
}
#board_list_div table{ position : relative; width:1200px; }

#search_condition table { margin-bottom:30px; border:1px solid #000; }
#search_condition tr { height:40px; }
#search_condition th {border-right:1px solid #000;}
#search_condition td, #search_condition th { text-align : center; border-bottom:1px solid #000;}

#searchform { margin-bottom : 10px; }

#board_list_table { margin-bottom:20px; }
#board_list_table td, #board_list_table th  { height:40px; border-bottom:1px solid #000;}
#board_list_table .table_item { text-align : center; }

#board_list_paging { padding-left:550px; }
#board_list_paging img { width:20px;}
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<script src="../js/jquery-3.3.1.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript">
 var checkDelete = function() {
   if($('#check_all').prop('checked')){
      $('input[name=checkDel]').prop('checked', true);
   } else {
      $('input[name=checkDel]').prop('checked', false);
   }
}

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
<div id="board_list_div">
<!-- 총 게시글 수 캡션 시작 -->
<div id="notice_logo">
<span class="notice_span">BOARD</span>
</div>
<div id="total_board_caption">
<ul>
<li>총 게시글 수 : <%=total %> </li>
<li>NOTICE : <%=noticecnt %></li>
<li>Q & A : <%=qnacnt %></li>
<li>REVIEW: <%=reviewcnt %></li>
</ul>
</div>
<!-- 총 게시글 수 캡션 종료 -->
<!-- 검색 조건 버튼 시작 -->
<div id="search_condition">
<form name="userForm" method="get">
<table cellspacing="0" cellpadding="0" border="0">
<tr>
<th width="20%">카테고리</th>
   <td width="*">
   <input type="radio" name="search_btype" value="notice" checked="checked" /><label for="notice">NOTICE</label>
   <input type="radio" name="search_btype" value="qna" <%=search_btype.equals("qna")? "checked='checked'" : "" %> /><label for="qna">Q & A</label>
   <input type="radio" name="search_btype" value="review" <%=search_btype.equals("review")? "checked='checked'" : "" %> /><label for="review">REVIEW</label>
   </td>
</tr>
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
<tr>
<th>검색</th>
<td><select name="schkind" style="height:30px;">
   <option value="writer"> 작성자 </option>
   <option value="title"> 제목 </option>
   <option value="contents"> 내용 </option>
   <option value="tc"> 제목+내용 </option>
</select>
<input type="text" name="keyword" style="height:25px;"/>
</tr>
<tr><td colspan="2" align="center" style="border-bottom:0px;"><input type="submit" value="검 색" /></td></tr>
</table>
</form>
</div>
<!-- 검색 조건 버튼 종료 -->
<!-- 게시글 목록 시작 -->
<form action="board_list_del.jsp" method="post">
<table id="board_list_table" cellspacing="0" cellpadding="0" >
<tr>
<th width="5%" ><input type="checkbox" id="check_all" name="check_all" onclick="checkDelete()"/></th>
<th width="5%" >번호</th>
<th width="10%" >게시판타입</th>
<th width="*" >제목</th>
<th width="13%" >작성자</th>
<th width="20%" >작성일</th>
</tr>
<%   
   
   if(search_btype.equals("review")){
	   	if(where == null || where.equals("") && ft_date == null || ft_date.equals(""))
	   	{   
	   		sql = "select pb_idx, pb_title, pb_writer, pb_date, pb_type from product_board where pb_type='r' ";
        	sql += "order by pb_date desc limit " + sidx + ", " + psize;	
	   	}
	   	else
	   	{
	         sql = "select pb_idx, pb_title, pb_writer, pb_date, pb_type from product_board where pb_type='r'" + and;
	         sql += where +  ft_date + "order by pb_date desc limit " + sidx + ", " + psize;
	      
	   	}
      } else if(search_btype.equals("qna")){
  	   	if(where == null || where.equals("") && ft_date == null || ft_date.equals(""))
  	   	{
  	         sql = "select pb_idx, pb_title, pb_writer, pb_date, pb_type from product_board where pb_type='q' ";
  	         sql +="order by pb_date desc limit " + sidx + ", " + psize;
  	   		
  	   	}
  	   	else
  	   	{
  	         sql = "select pb_idx, pb_title, pb_writer, pb_date, pb_type from product_board where pb_type='q'" + and;
  	         sql += where + ft_date + "order by pb_date desc limit " + sidx + ", " + psize;
  	   		
  	   	}
      } else {
    	  if(where == null || where.equals("") && ft_date == null || ft_date.equals(""))
    	  {
    		  sql = "select n_idx, n_title, n_writer, n_date from notice ";
    	  }
    	  else
    	  {
    		  sql = "select n_idx, n_title, n_writer, n_date from notice where " + where + ft_date;
    	  }
			
         sql += "order by n_date desc limit " + sidx + ", " + psize;
      }
   int num = 0;
   
    if (ft_date == null || ft_date.equals("") ) {
       if(search_btype.equals("notice")){
          rs = stmt.executeQuery("select count(*) from notice");
          } else if(search_btype.equals("qna")){
             rs = stmt.executeQuery("select count(*) from product_board where pb_type='q'");
          } else {
             rs = stmt.executeQuery("select count(*) from product_board where pb_type='r'");
          }
    } else {
       if(search_btype.equals("notice")){
          rs = stmt.executeQuery("select count(*) from notice where " + where + ft_date );
          } else if(search_btype.equals("qna")){
        	  System.out.println(and + where + ft_date);
        	  System.out.println(":::" +ft_date);
        	  rs = stmt.executeQuery("select count(*) from product_board where pb_type='q' " + and + where + ft_date);
             
          } else {

        	  System.out.println(":::" +ft_date);
        	  System.out.println(and + where + ft_date);
             rs = stmt.executeQuery("select count(*) from product_board where pb_type='r' " + and + where + ft_date );
          }
    }
    if (rs.next())   num = rs.getInt(1);
   rs.close();
   
   rs = stmt.executeQuery(sql);
   String title="", writer="", date="", type="";
   int idx=0;
   if(rs.next()) {
      lastPage = ((num-1) / psize) + 1;
      num = num - (cpage - 1) * psize;
      do{
         if(search_btype.equals("review") || search_btype.equals("qna")){
            linkHead = "<a href='board_list.jsp?cpage=" + cpage + args;
            linkHead += "&pb_idx=" + rs.getInt(1) + "&search_btype="+ search_btype +"'>";
         } else {
            linkHead = "<a href='board_list.jsp?cpage=" + cpage + args;
            linkHead += "&n_idx=" + rs.getInt(1)  + "&search_btype="+ search_btype +"'>";
         }

         if(search_btype.equals("review") || search_btype.equals("qna")){
            idx = rs.getInt("pb_idx");
             title = rs.getString("pb_title");
             writer = rs.getString("pb_writer");
             date = rs.getString("pb_date").substring(0, 16);
             type = rs.getString("pb_type");
             if(type.equals("q")){
                type = "Q & A";   
             } else {
                type = "REVIEW";
             }
         } else {
            idx = rs.getInt("n_idx");
             title = rs.getString("n_title");
             writer = rs.getString("n_writer");
             date = rs.getString("n_date").substring(0, 16);
             type = "NOTICE";
         }
         
         if (title.length() > 28) {
            title = title.substring(0, 28) + "...";
            } else {
               if(search_btype.equals("notice")){
               title = rs.getString("n_title");
               } else {
                  title = rs.getString("pb_title");
               }
          }
%>
<tr>
<td class="table_item"><input type="checkbox" id="checkDel" name="checkDel" value="<%=idx %>"/></td>
<td class="table_item"><%=idx %></td>
<td class="table_item"><%=type %></td>
<td onclick="location.href='board_view_proc.jsp?idx=<%=idx%>&btype=<%=type%>'">&nbsp;&nbsp;<%=title %></td>
<td class="table_item"><%=writer %></td>
<td class="table_item"><%=date %></td>
</tr>
<%   
         num--;
      }while(rs.next());
   }
%>
</table>
<input type="hidden" value="<%=search_btype %>" name="type"/>
<!-- 게시글 목록 종료 -->
<!-- 선택삭제 버튼 시작 -->
<div>
<input type="submit" value="선택삭제" />
</form>
<%
   if (search_btype.equals("notice")){
%>
<input type="button" value="글쓰기" style="float:right;" onclick="location.href='notice_form.jsp?wtype=in';"/>
<%
   }
%>
</div>
<!-- 선택삭제 버튼 종료-->
<!-- 페이징 시작 -->
<div id="board_list_paging">
<a href="board_list.jsp?cpage=1<%=args %>&search_btype=<%=search_btype %>"><img src="../image/end_left.jpg" class="lr_btn"/></a>
<%
   linkHead="";
   linkTail="";
   if(cpage > 1){
      linkHead = "<a href='board_list.jsp?cpage=" + (cpage - 1) + args + "&search_btype="+ search_btype +"'>";
      linkTail = "</a>";
   }
   out.println(linkHead + "<img src='../image/left.jpg' class='lr_btn'/>" + linkTail);
   int spage = (cpage - 1) / bsize * bsize + 1;
   for(int i = spage; i < spage + bsize && i <= lastPage; i++){
      if( i == cpage ){
         out.println("&nbsp;<b>" + i + "</b>&nbsp;");
      } else {
         out.println("&nbsp;<a href = 'board_list.jsp?cpage="+ i + args + "&search_btype="+ search_btype +"'>" + i + "</a>&nbsp;");
      }
   }
   
   linkHead="";
   linkTail="";
   if(cpage < lastPage) {
      linkHead = "<a href='board_list.jsp?cpage="+(cpage + 1) + args + "&search_btype="+ search_btype +"'>";
      linkTail = "</a>";
   }
   out.println(linkHead + "<img src='../image/reight.jpg' class='lr_btn' />" + linkTail);
%>
   <a href="board_list.jsp?cpage=<%=lastPage + args %>&search_btype=<%=search_btype %>"><img src="../image/end_right.jpg" class="lr_btn"/></a>
</div>
<!-- 페이징 종료 -->
</div>
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
</body>
</html>