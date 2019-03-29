<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int[] o_situ = {0,0,0,0,0,0,0,0,0,0};
int[][] dateTotal = {{0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}};
int[][] dateCnt = {{0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}};
int[] cntTotal  = {0,0,0};
String tmpAvg = "";
float[] cntAvg = {0,0,0};
String[] date = {"","","",""};
String nowId = "id ='now' ";
float[] avg = {0,0,0};
int[] total = {0,0,0};
int[] pb_qtype = {0,0,0,0,0,0};
int count = 0;
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#wrapper { width:1200px; margin:0 auto; }
#contents { width:1200px; text-align:center; font-size:0.8em; margin-bottom:80px; padding-bottom:80px; }
#top 
{ 
	position:relative;
	width:1200px; 
	text-align:center;
	border:1px solid #c1c1c1;
}
#contents_top { width:1200px;height:150px; text-align:center; padding-top:20px; }
#contents_center_left, #contents_center_right
{
	padding:10px 9px;
	float:left;
	width:580px;
	height:750px; 
	text-align:center;
}
#tb_top th, #tb_top td 
{
	border:1px solid #c1c1c1;
}
#tb_top th 
{
	background:#f1e29a;
}

#tb_date th , #tb_member th, #tb_Qna th
{
	background:#EAEAEA;
}

#tb_date th, #tb_date td
{
	height:40px;
}
#tb_member, #tb_Qna
{
	height:100px;
}
#now { color:skyblue; }
#total { color:orange; }
</style>

</head>
<body>
<!-- 전체 영역 -->
<div id="wrapper">

	<!-- top 영역 -->
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	
	<!-- contents 영역 -->
	<div id="contents">
	
		<!-- contents 상단 영역 시작 -->
		<div id="contents_top">
		<!-- 
			주문의 상태를 표시하는 바
			입금전, 입금완료, 배송중, 취소신청/처리중, 교환신청/처리중, 반품신청/처리중
		 -->
		 <table width="1200" border="0" height="150" id="tb_top" cellspacing="0">
		 <tr height="20%">
		 <th width="14%" >입금전</th><th width="14%">입금완료</th><th width="14%">배송중</th><th width="14%">배송완료</th><th width="14%">취소신청/처리중</th><th width="14%">반품신청/처리중</th><th width="14%">교환신청/처리중</th>
		 </tr>
		 <tr height="80%">
		 <%
		 try
		 {				
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "root");
			stmt = conn.createStatement();
			sql = "select o_situ, count(o_id) as cnt from order_info group by o_situ";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				do{
					o_situ[rs.getInt("o_situ")] = rs.getInt("cnt");
				}while(rs.next());
			}
			rs.close();
		%>
		 <td><%=o_situ[0] %>건</td>
		 <td><%=o_situ[1] %>건</td>
		 <td><%=o_situ[2] %>건</td>
		 <td><%=o_situ[3] %>건</td>
		 <td><%=o_situ[4] %>건</td>
		 <td><%=o_situ[6] %>건</td>
		 <td><%=o_situ[8] %>건</td>
		 </tr>
		 </table>
		</div>
		<!-- contents 상단 영역 종료 -->
		
		<!-- contents 중간 좌측 영역 -->
		<div id="contents_center_left">
		<!-- 
		1. 날짜별 통계
		 - 날짜, 주문, 결제, 환불(취소/반품)
		 - 오늘 기준 3일전 부터 4일 후 까지 (일주일)
		 - 원(금액)
		 - 건(개수)
		2. 공지사항
		 - Subject, Date, Hit
		 - [공지사항] 제목 
		 -->
		 
		 <!-- 날짜별 통계 시작 -->
		 <h2>날짜별 통계</h2>
		 <table width="580" id ="tb_date" cellspacing="0" cellpadding="5" border="1">
		 <tr>
		 <th width="25%">날짜</th>
		 <th width="25%">주문</th>
		 <th width="25%">결제</th>
		 <th width="25%">환불(취소/반품)</th>
		 </tr>
		 <%
	
			Calendar c = Calendar.getInstance();
	 		for(int i = 0; i < 4 ; i++)
	 		{
	 			date[i] = (c.get(Calendar.MONTH) + 1) + "월 " + c.get(Calendar.DATE) + "일";
	 			c.add(Calendar.DATE, -1);
	 			System.out.println(date[i]);
	 		}
		 	
		 	sql = "	select o_situ, count(o_id) as cnt, sum(o_totalprice) as total, ";
		 	sql += "concat(if(month(o_date) >= 10,month(o_date),concat('0',month(o_date))) ";
		 	sql += ",'월 ',if(dayofmonth(o_date) >= 10, dayofmonth(o_date), ";
		 	sql += "concat('0',dayofmonth(o_date))),'일') as date, ";
		 	sql += "dayofyear(now()) - dayofyear(o_date) as i, ";
		 	sql += " if(o_situ < 1, 0, if(o_situ<4 , 1, if(o_situ >= 4 , 2, ''))) as j ";
		 	sql += " from order_info ";
		 	sql += "where dayofyear(now()) - dayofyear(o_date)  < 4 and year(o_date) = year(now())  ";
		 	sql += "group by dayofmonth(o_date), o_situ order by o_date ";
		 	rs = stmt.executeQuery(sql);
		 	if(rs.next())
		 	{
		 		do
		 		{
		 			int i = rs.getInt("i");
		 			int j = rs.getInt("j");
		 			dateTotal[i][j] = rs.getInt("total");
		 			dateCnt[i][j] = rs.getInt("cnt");
		 		}while(rs.next());
		 	}
		 for(int i = 3 ; i >= 0 ; i--)
		 {
		 %>
		 <tr <%=(i == 0) ? nowId : ""%>>
		 <td ><%=date[i] + ((i == 0) ? "(오늘)":"") %></td> 
		<%
		 for(int j = 0 ; j < 3 ; j++)
		 {
		%>
		 <td><%=dateTotal[i][j] %> 원<br />(<%=dateCnt[i][j] %> 건)</td>
		<%
		 }
		%>
		 </tr>
		 <%} %>
		<tr>
		<td>최근 7일 평균</td>
		<%
		sql ="select sum(o_totalprice) as total, avg(o_totalprice) as avg, count(*) as cnt, round((count(*) / 7),1) as cntAvg, ";
		sql +="if(o_situ < 1, 0, if(o_situ<4 , 1, if(o_situ >= 4 , 2, ''))) as i from order_info where dayofyear(now()) - dayofyear(o_date)  < 7 group by i;";
	 	rs = stmt.executeQuery(sql);
	 	if(rs.next())
	 	{
	 		do
	 		{
	 			int i = rs.getInt("i") ;
	 			avg[i] = rs.getFloat("avg");
	 			total[i] = rs.getInt("total");
	 			cntTotal[i] = rs.getInt("cnt");
	 			cntAvg[i] = rs.getFloat("cntAvg");
	 		}while(rs.next());
	 	}
	 	
	 	for(int i = 0 ; i < 3 ; i++)
	 	{
		%>
		<td><%=avg[i] %> 원<br />(<%=cntAvg[i] %> 건)</td>
		<%
		}
	 	%>
		</tr>
		<tr id="total">
		<td>최근 7일 합계</td>
	 	<%
	 	for(int i = 0 ; i < 3 ; i++)
	 	{
		%>
		<td><%=total[i] %> 원<br />(<%=cntTotal[i] %> 건)</td>
		<%
		}
	 	%>
		</tr>
		<tr>
		<td>최근 30일 평균</td>	 	
		<%
		sql ="select sum(o_totalprice) as total, avg(o_totalprice) as avg, count(*) as cnt, round((count(*) / 30),1) as cntAvg, ";
		sql +="if(o_situ < 1, 0, if(o_situ<4 , 1, if(o_situ >= 4 , 2, ''))) as i from order_info where dayofyear(now()) - dayofyear(o_date)  < 30 group by i;";
	 	rs = stmt.executeQuery(sql);
	 	if(rs.next())
	 	{
	 		do
	 		{
	 			int i = rs.getInt("i") ;
	 			avg[i] = rs.getFloat("avg");
	 			total[i] = rs.getInt("total");
	 			cntTotal[i] = rs.getInt("cnt");
	 			cntAvg[i] = rs.getFloat("cntAvg");
	 		}while(rs.next());
	 	}
	 	
		for(int i = 0 ; i < 3 ; i++)
	 	{
		%>
		<td><%=avg[i] %> 원<br />(<%=cntAvg[i] %> 건)</td>
		<%
		}
		%>
		</tr>
		<tr id="total">
		<td>최근 30일 합계</td>
	 	<%
	 	for(int i = 0 ; i < 3 ; i++)
	 	{
		%>
		<td><%=total[i] %> 원<br />(<%=cntTotal[i] %> 건)</td>
		<%
		}
	 	%>
		</tr>
		<tr id="tt">
		<td>총 합계</td>
		<%
		sql ="select sum(o_totalprice) as total, avg(o_totalprice) as avg, count(*) as cnt, ";
		sql +="if(o_situ < 1, 0, if(o_situ<4 , 1, if(o_situ >= 4 , 2, ''))) as i from order_info group by i;";
	 	rs = stmt.executeQuery(sql);
	 	if(rs.next())
	 	{
	 		do
	 		{
	 			int i = rs.getInt("i") ;
	 			avg[i] = rs.getFloat("avg");
	 			total[i] = rs.getInt("total");
	 			cntTotal[i] = rs.getInt("cnt");
	 		}while(rs.next());
	 	}
	
	 	for(int i = 0 ; i < 3 ; i++)
	 	{
		%>
		<td><%=total[i] %> 원<br />(<%=cntTotal[i] %> 건)</td>
		<%
		}
	 	%>
		</tr>
		 </table>
		 <!-- 날짜별 통계 종료 -->
		
		<!-- 공지사항 시작 -->
		<h2>Notice</h2>
		<table width="580" id ="tb_notice" cellspacing="0" cellpadding="5" border="1">
		<tr>
		<th width="70%">Subject</th><th width="20%">Date</th><th width="10%">Hit</th>
		</tr>
		<%
		sql = "select n_idx, n_title, n_date, n_read from notice order by n_date limit 3";
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{
			do
			{
					
		%>
		<tr>
		<td><a href="board_view_proc.jsp?btype=NOTICE&idx=<%=rs.getString("n_idx") %>"><%=rs.getString("n_title") %></a></td>
		<td><%=rs.getString("n_date").substring(0,10) %></td>
		<td><%=rs.getInt("n_read") %></td>
		</tr>
		<%
			}while(rs.next());
		}
		else
		{
			out.println("<tr><td colspan='3'>공지사항이 없습니다.</td></tr>");
		}
		%>
		</table>
		<!-- 공지사항 종료 -->
		</div>	
		
		<!-- contents 중간 우측 영역 -->
		<div id="contents_center_right">
		<!-- 
		1. 회원 현황
		 - 오늘 신규 회원, 탈퇴회원, 블랙리스트, Total
		2. Q&A 현황
		 - 상품문의, 배송문의, 환불/교환, 결제 문의, 포인트
		 - 0건(개수)
		3. Q&A
		 - Subject, Name, Date, 답변여부
		 -->
		 
		 <!-- 회원 현황 -->
		 <h2>회원 현황</h2>
		 <table width="580" id ="tb_member" cellspacing="0" cellpadding="5" border="1">
		 <tr height="20%">
		 <th width="25%">오늘 신규 회원</th>
		 <th width="25%">탈퇴 회원</th>
		 <th width="25%">블랙리스트</th>
		 <th width="25%">TOTAL</th>
		 </tr>
		 <%
		 sql="select sum(if(dayofyear(ml_joindate) = dayofyear(now()),1,0)) as newMember, sum(if(ml_situ = 3,1,0)) as leaveMember, sum(if(ml_situ = 2, 1,0)) as blackList, sum(if(ml_situ = 4, 1, 0)) as repos, count(*) as cnt from member_list";
		 rs = stmt.executeQuery(sql);
		 if(rs.next())
		 {
		 %>
		 <tr height="80%">
		 <td><%=rs.getInt("newMember") %> 명</td>
		 <td><%=rs.getInt("leaveMember") %> 명</td>
		 <td><%=rs.getInt("blackList") %> 명</td>
		 <td><%=rs.getInt("cnt") %> 명</td>
		 </tr>
		 <%
		 }
		 %>
		 </table>
		 
		 <!-- Q&A 현황 -->
		 <h2>Q&A 현황</h2>
		 <table width="580" id ="tb_Qna" cellspacing="0" cellpadding="5" border="1">
		 <tr height="20%">
		 <th width="16%">상품 문의</th>
		 <th width="16%">배송 문의</th>
		 <th width="16%">환불/교환 문의</th>
		 <th width="16%">결제 문의</th>
		 <th width="16%">포인트 문의</th>
		 <th width="16%">회원 문의</th>
		 </tr>
		 <tr height="80%">
 		 <%
		 sql="select count(*) as cnt, pb_qtype from product_board group by pb_qtype";
		 rs = stmt.executeQuery(sql);
		 if(rs.next())
		 {
			 do
			 {
			 	pb_qtype[rs.getInt("pb_qtype")] = rs.getInt("cnt");
			 }while(rs.next());
		 }
		 for(int i = 0 ; i < 6 ; i++) out.println("<td>"+pb_qtype[i]+" 건</td>");
		 %>
		 </tr>
		 </table>
		 <!-- Q&A 목록 -->
		 <h2>Q&A</h2> 
		 <table width="580" id ="tb_qnaList" cellspacing="0" cellpadding="5" border="1">
		 <tr>
		 <th width="8%">No.</th>
		 <th width="60%">Subject</th>
		 <th width="17%">Name</th>
		 <th width="15%">Date</th>
		 </tr>
		 <%
			sql = "select pb_idx, pb_title, pb_writer, pb_date from product_board where pb_type = 'q' order by pb_idx desc limit 7;";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				do
				{
					%>
					<tr>
					<td><%=++count %></td>
					<td><a href="board_view_proc.jsp?btype=QNA&idx=<%=rs.getInt("pb_idx")%>"><%=rs.getString("pb_title") %></a></td>
					<td><%=rs.getString("pb_writer") %></td>
					<td><%=rs.getString("pb_date").substring(0,10) %></td>
					</tr>
					<%
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='4'>등록된 리뷰가 없습니다.</td></tr>");
			}
		 %>
		 </table>
		</div>	
	</div>
	<%
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
		 %>
		 <br />
		<br />
</div>

</body>
</html>