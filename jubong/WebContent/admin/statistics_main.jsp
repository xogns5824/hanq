<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int menu = 1, totalPrice = 0,totalSales = 0, count= 0 ,wCount = 0;
int nowYear = 0, nowMonth = 0, nowWeek =0, nowHour = 0;
String tmpMenu = "";
String[] week = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일","일요일"};
String[] printHour = {"00:00 ~ 00:59", "01:00 ~ 01:59", "02:00 ~ 02:59",
		"03:00 ~ 03:59", "04:00 ~ 04:59", "05:00 ~ 05:59", "06:00 ~ 06:59",
		"07:00 ~ 07:59", "08:00 ~ 08:59", "09:00 ~ 09:59", "10:00 ~ 10:59",
		"11:00 ~ 11:59", "12:00 ~ 12:59", "13:00 ~ 13:59", "14:00 ~ 14:59",
		"15:00 ~ 15:59", "16:00 ~ 16:59", "17:00 ~ 17:59", "18:00 ~ 18:59",
		"19:00 ~ 19:59", "20:00 ~ 20:59", "21:00 ~ 21:59", "22:00 ~ 22:59", "23:00 ~ 23:59"};
String[] printColor = {"black","red","yellow","white","brown"};
String[] printSize = {"250","255","260","265","270","275","280"};
String[] tmpSitu,tmpCate,tmpColor,tmpSize;
ArrayList<int[]> arrSales = new ArrayList<int[]>();
ArrayList<String[]> category = new ArrayList<String[]>();
ArrayList<String[]> situ = new ArrayList<String[]>();
ArrayList<String[]> color = new ArrayList<String[]>();
ArrayList<String[]> size = new ArrayList<String[]>();
ArrayList<String> arrWhere = new ArrayList<String>();
String cond_cate = "", cond_situ = "", cond_color = "", cond_size = "";
int[] check_situ = {0,0,0,0,0,0,0,0,0,0};
int[] check_cate = {0,0,0,0,0,0};
int[] check_color = {0,0,0,0,0};
int[] check_size = {0,0,0,0,0,0,0};
tmpCate = request.getParameterValues("category");
if(tmpCate != null)
{
	category.add(tmpCate);
	cond_cate = "(";
	for(int i = 0 ; i < category.get(0).length ; i++)
	{
		
		check_cate[(Integer.valueOf(category.get(0)[i]) -1)] = 1;
		if(i == category.get(0).length -1)
		{
			cond_cate += "p.pc_idx = "+ category.get(0)[i];
			System.out.println(Integer.valueOf(category.get(0)[i]));
		}
		else
		{
			cond_cate += "p.pc_idx = "+ category.get(0)[i] + " or ";
		}
	}
	cond_cate += ")";
	System.out.println(cond_cate);
	wCount++;
	arrWhere.add(cond_cate);
}
tmpSitu = request.getParameterValues("situ");

if(tmpSitu !=null)
{
	situ.add(tmpSitu);
	cond_situ = "(";
	for(int i = 0 ; i < situ.get(0).length ; i++)
	{
		
		check_situ[Integer.valueOf(situ.get(0)[i])] = 1;
		if(i == situ.get(0).length -1)
		{
			cond_situ += "o.o_situ = "+ situ.get(0)[i];
			System.out.println(Integer.valueOf(situ.get(0)[i]));
		}
		else
		{
			cond_situ += "o.o_situ = "+ situ.get(0)[i] + " or ";
		}
	}
	cond_situ += ")";
	System.out.println(cond_situ);
	wCount++;
	arrWhere.add(cond_situ);
}

tmpColor = request.getParameterValues("color");
if(tmpColor !=null)
{
	color.add(tmpColor);
	cond_color = "(";
	for(int i = 0 ; i < color.get(0).length ; i++)
	{
		
		check_color[Integer.valueOf(color.get(0)[i])] = 1;
		if(i == color.get(0).length -1)
		{
			cond_color += "od.od_color = '"+ printColor[Integer.valueOf(color.get(0)[i])] +"'";
			System.out.println(Integer.valueOf(color.get(0)[i]));
		}
		else
		{
			cond_color += "od.od_color = '"+ printColor[Integer.valueOf(color.get(0)[i])] + "' or ";
		}
	}
	cond_color += ")";
	System.out.println(cond_color);
	wCount++;
	arrWhere.add(cond_color);
}
tmpSize = request.getParameterValues("size");
if(tmpSize !=null)
{
	size.add(tmpSize);
	cond_size = "(";
	for(int i = 0 ; i < size.get(0).length ; i++)
	{
		
		check_size[Integer.valueOf(size.get(0)[i])] = 1;
		if(i == size.get(0).length -1)
		{
			cond_size += "od.od_size = "+ printSize[Integer.valueOf(size.get(0)[i])];
			System.out.println(Integer.valueOf(size.get(0)[i]));
		}
		else
		{
			cond_size += "od.od_size = "+ printSize[Integer.valueOf(size.get(0)[i])] + " or ";
		}
	}
	cond_size += ")";
	System.out.println(cond_size);
	wCount++;
	arrWhere.add(cond_size);
}

tmpMenu = request.getParameter("menu");
if(tmpMenu == null || tmpMenu.equals(""))
{
	menu = 1;
}
else
{
	menu = Integer.valueOf(tmpMenu);
	
}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#wrapper { width:1200px; margin:0 auto; }
#contents { width:1200px; text-align:center; font-size:0.8em; }
#top 
{ 
	position:relative;
	width:1200px; 
	text-align:center;
	border:1px solid #c1c1c1;
}
#menuBtn_area, #condition_area, #staticTable_area
{
	width:1200px;
	padding:10px 0;
}
#menuBtn_area
{
	font-size:1.8em;
}
#condition_area th
{
	background:#c1c1c1;
	color:#fff;
}

</style>
<script src="../js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function() {
	$(this).change(function () {
		var frm = document.frm_static;
		frm.action = "statistics_main.jsp";
		frm.submit();
	});
	
});
function select_menu(num)
{
	var frm = document.frm_static;
	var menu = frm.menu;
	menu.value = num;
	frm.action = "statistics_main.jsp";
	frm.submit();
}
</script>
</head>
<body>
<div id="wrapper">
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	<%

	for(int i = 0 ; i < wCount ; i++)
	{
			where += " and "+arrWhere.get(i) ;
	}
	System.out.println("where " +where);
	if(menu == 1)
	{
		sql = "select sum(o_totalprice) as totalprice, month(o_date) as month, count(o.o_id) as cnt, month(now()) as nowMonth from order_info as o, order_detail as od, product as p where o.o_id = od.o_id and p.p_id = od.p_id and year(o_date) = year(now()) "+ where +" group by month(o_date);";
	}
	else if(menu == 2)
	{
		sql = "select sum(o_totalprice) as totalprice, year(o_date) as year, count(o.o_id) as cnt, year(now()) as nowYear from order_info as o, order_detail as od, product as p where o.o_id = od.o_id and p.p_id = od.p_id and year(o_date) between year(now()) -10 and year(now()) "+ where +" group by year(o_date) order by year(o_date) desc";
	}
	else if(menu == 3)
	{
		sql = "select sum(o_totalprice) as totalprice, weekday(o_date) as weekday, count(o.o_id) as cnt, weekday(now()) as nowWeek from order_info as o, order_detail as od, product as p where o.o_id = od.o_id and p.p_id = od.p_id and year(o_date) = year(now()) "+ where +" group by weekday(o_date)";
	}
	else if(menu == 4)
	{
		sql = "select sum(o_totalprice) as totalprice, hour(o_date) as hour, count(o.o_id) as cnt, hour(now()) as nowHour from order_info as o, order_detail as od, product as p where o.o_id = od.o_id and p.p_id = od.p_id and year(o_date) = year(now()) "+ where +" group by hour(o_date)";
	}
	try
	{				
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		if(rs.next())
		{
			do
			{
				if(menu == 1)
				{
					for(int i = 0; i < 12 ; i++)
					{
						nowMonth = rs.getInt("nowMonth");
						if(rs.getInt("month") == (i+1))
						{
							if(count < 1 )
							{
								arrSales.add(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});	
							}
							else
							{
								arrSales.set(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
							
						}
						else
						{
							if(count < 1 )
							{
								arrSales.add(i,new int[] {0,0});
							}
						}
					}
				}
				else if(menu == 2)
				{
					nowYear = rs.getInt("nowYear");
					for(int i = 0; i < 10 ; i++)
					{
						if(nowYear-i == rs.getInt("year"))
						{
							if(count < 1)
							{
								arrSales.add(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
							else
							{
								arrSales.set(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
						}
						else
						{
							arrSales.add(i,new int[] {0,0});
						}
					}
				}
				else if(menu == 3)
				{
					nowWeek = rs.getInt("nowWeek");
					for(int i = 0; i < 7 ; i++)
					{
						if(rs.getInt("weekday") == i)
						{
							if(count < 1)
							{
								arrSales.add(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
							else
							{
								arrSales.set(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
						}
						else
						{
							if(count < 1)
							{
								arrSales.add(i,new int[] {0,0});
							}
						}
					}
				}
				else if(menu == 4)
				{
					nowHour = rs.getInt("nowHour");
					for(int i = 0; i < 24 ; i++)
					{
						if(rs.getInt("hour") == i)
						{
							if(count < 1)
							{
								arrSales.add(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
							else
							{
								arrSales.set(i, new int[] {rs.getInt("totalprice"),rs.getInt("cnt")});
							}
						}
						else
						{
							if(count < 1)
							{
								arrSales.add(i,new int[] {0,0});
							}
						}
					}
				}
				count++;
			}while(rs.next());
		}
		else
		{
			rs.close();
			if(menu == 1) rs = stmt.executeQuery("select month(now()) as now");
			
			else if(menu == 2) rs = stmt.executeQuery("select year(now()) as now");
			
			else if(menu == 3) rs = stmt.executeQuery("select weekday(now()) as now");
			
			else if(menu == 4) rs = stmt.executeQuery("select hour(now()) as now");
		
			if(rs.next())
			{
				if(menu == 1)
				{
					nowMonth = rs.getInt("now");
					for(int i = 0; i < 12 ; i++)
					{
						arrSales.add(i,new int[] {0,0});
					}
				}
				else if(menu == 2)
				{
					nowYear = rs.getInt("now");
					for(int i = 0; i < 10 ; i++)
					{
						arrSales.add(i,new int[] {0,0});
					}
				}
				else if(menu == 3)
				{
					nowWeek = rs.getInt("now");
					for(int i = 0; i < 7 ; i++)
					{
						arrSales.add(i,new int[] {0,0});
					}
				}
				else if(menu == 4)
				{
					nowHour = rs.getInt("now");
					for(int i = 0; i < 24 ; i++)
					{
						arrSales.add(i,new int[] {0,0});
					}
				}
			}
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
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	%>
	<div id="contents">
	
	<!-- 통게 관리 메인 화면 -->
	<!-- 
	통계 관리에서는 구매자들의 요일별 매출 현황, 시간대별 매출 현황, 월별 매출 현황(1~12월), 년도별 매출 현황(10년)을 기준으로 하여
	카테고리, 주문 상태, 상품의 색상, 사이즈 등으로 조건으로 검색하여 매출을 볼 수 있다.
	1. 카테고리 : 로퍼, 구두, 워커, 운동화, 스니커즈, 샌들
	2. 주문 상태 : 미입금, 입금완료, 배송중, 배송완료, 환불(취소,반품,교환) 요청, 환불(취소,반품,교환) 완료
	3. 색상 : black, red, yellow, white, brown
	4. 사이즈 : 250, 255, 260, 265, 270, 275, 280
	- 요일별 매출현황(1년간)
	요일(일,월,화,수,목,금,토), 매출 금액, 매출 건수
	- 시간대별 매출현황(1년간)
	시간(1시간 주기(0~24시), 매출 금액, 매출 건수
	- 월별 매출현황(1년간)
	월(한달 주기(1~12월), 매출금액, 매출건수
	- 년도별(10년)
	년(1년 주기((올해-10)~올해), 매출 금액, 매출 건수
	-->
		<!-- 메뉴 버튼 영역 시작 -->
		<form method="post" name="frm_static">
		<input type="hidden" name="menu" value="<%=menu %>" />
		<div id="menuBtn_area">
		<a href="javascript:select_menu(1);">월별 매출현황</a> |
		<a href="javascript:select_menu(2);">년도별 매출현황</a> |
		<a href="javascript:select_menu(3);">요일별 매출현황</a> |
		<a href="javascript:select_menu(4);">시간대별 매출현황</a>
		</div>
		<!-- 메뉴 버튼 영역 종료 -->
		<!-- 조건 영역 시작 -->
		<div id="condition_area">
			<table width="1200" cellpadding="5" cellspacing="0" border="1">
			<tr>
			<!-- 1. 카테고리 : 로퍼, 구두, 워커, 운동화, 스니커즈, 샌들 -->
			<th width="20%">카테고리</th>
			<td width="*">
				<input type="checkbox" name="category" class="check" id="cate1" value="1" <%=check_cate[0] == 1 ? "checked='checked'": "" %> /><label for="cate1">로퍼</label>
				<input type="checkbox" name="category" class="check" id="cate2" value="2" <%=check_cate[1] == 1 ? "checked='checked'": "" %> /><label for="cate2">구두</label>
				<input type="checkbox" name="category" class="check" id="cate3" value="3" <%=check_cate[2] == 1 ? "checked='checked'": "" %> /><label for="cate3">워커</label>
				<input type="checkbox" name="category" class="check" id="cate4" value="4" <%=check_cate[3] == 1 ? "checked='checked'": "" %> /><label for="cate4">운동화</label>
				<input type="checkbox" name="category" class="check" id="cate5" value="5" <%=check_cate[4] == 1 ? "checked='checked'": "" %> /><label for="cate5">스니커즈</label>
				<input type="checkbox" name="category" class="check" id="cate6" value="6" <%=check_cate[5] == 1 ? "checked='checked'": "" %> /><label for="cate6">샌들</label>
			</td>
			</tr>
			<!-- 2. 주문 상태 : 미입금, 입금완료, 배송중, 배송완료, 환불(취소,반품,교환) 요청, 환불(취소,반품,교환) 완료 -->
			<tr>
			<th>주문 상태</th>
			<td>
				<input type="checkbox" name="situ" class="check" id="situ1" value="0" <%=check_situ[0] == 1 ? "checked='checked'" : "" %> /><label for="situ1">미입금</label>
				<input type="checkbox" name="situ" class="check" id="situ2" value="1" <%=check_situ[1] == 1 ? "checked='checked'" : "" %>/><label for="situ2">입금완료</label>
				<input type="checkbox" name="situ" class="check" id="situ3" value="2" <%=check_situ[2] == 1 ? "checked='checked'" : "" %>/><label for="situ3">배송중</label>
				<input type="checkbox" name="situ" class="check" id="situ4" value="3" <%=check_situ[3] == 1 ? "checked='checked'" : "" %>/><label for="situ4">배송완료</label>
				<input type="checkbox" name="situ" class="check" id="situ5" value="4" <%=check_situ[4] == 1 ? "checked='checked'" : "" %>/><label for="situ5">취소 요청</label>
				<input type="checkbox" name="situ" class="check" id="situ6" value="5" <%=check_situ[5] == 1 ? "checked='checked'" : "" %>/><label for="situ6">반품 요청</label>
				<input type="checkbox" name="situ" class="check" id="situ7" value="6" <%=check_situ[6] == 1 ? "checked='checked'" : "" %>/><label for="situ7">교환 요청</label>
				<input type="checkbox" name="situ" class="check" id="situ8" value="7" <%=check_situ[7] == 1 ? "checked='checked'" : "" %>/><label for="situ8">취소 완료</label>
				<input type="checkbox" name="situ" class="check" id="situ9" value="8" <%=check_situ[8] == 1 ? "checked='checked'" : "" %>/><label for="situ9">반품 완료</label>
				<input type="checkbox" name="situ" class="check" id="situ10" value="9" <%=check_situ[9] == 1 ? "checked='checked'" : "" %>/><label for="situ10">교환 완료</label>
			</td>
			</tr>
			<!-- 3. 색상 : black, red, yellow, white, brown -->
			<tr>
			<th>색상</th>
			<td>
				<input type="checkbox" name="color" class="check" id="color1" value="0" <%=check_color[0] == 1 ? "checked='checked'" : "" %> /><label for="color1">black</label>
				<input type="checkbox" name="color" class="check" id="color2" value="1" <%=check_color[1] == 1 ? "checked='checked'" : "" %> /><label for="color2">red</label>
				<input type="checkbox" name="color" class="check" id="color3" value="2" <%=check_color[2] == 1 ? "checked='checked'" : "" %> /><label for="color3">yellow</label>
				<input type="checkbox" name="color" class="check" id="color4" value="3" <%=check_color[3] == 1 ? "checked='checked'" : "" %> /><label for="color4">white</label>
				<input type="checkbox" name="color" class="check" id="color5" value="4" <%=check_color[4] == 1 ? "checked='checked'" : "" %> /><label for="color5">brown</label>
			</td>
			</tr>
			<!-- 4. 사이즈 : 250, 255, 260, 265, 270, 275, 280 -->
			<tr>
			<th>사이즈</th>
			<td>
				<input type="checkbox" name="size" class="check" id="size1" value="0" <%=check_size[0] == 1 ? "checked='checked'" : "" %> /><label for="size1">250</label>
				<input type="checkbox" name="size" class="check" id="size2" value="1" <%=check_size[1] == 1 ? "checked='checked'" : "" %> /><label for="size2">255</label>
				<input type="checkbox" name="size" class="check" id="size3" value="2" <%=check_size[2] == 1 ? "checked='checked'" : "" %> /><label for="size3">260</label>
				<input type="checkbox" name="size" class="check" id="size4" value="3" <%=check_size[3] == 1 ? "checked='checked'" : "" %> /><label for="size4">265</label>
				<input type="checkbox" name="size" class="check" id="size5" value="4" <%=check_size[4] == 1 ? "checked='checked'" : "" %> /><label for="size5">270</label>
				<input type="checkbox" name="size" class="check" id="size6" value="5" <%=check_size[5] == 1 ? "checked='checked'" : "" %> /><label for="size6">275</label>
				<input type="checkbox" name="size" class="check" id="size7" value="6" <%=check_size[6] == 1 ? "checked='checked'" : "" %> /><label for="size7">280</label>
			</td> 
			</tr>
			</table>
		</div>
		<!-- 조건 영역 종료 -->
		<!-- 통계 테이블 영역 시작 -->
		<div id="staticTable_area">
			<table width="1200" cellpadding="5" cellspacing="0" border="1" >
			<%
			if(menu == 1) // 월별 매출
			{
				out.println("<tr><th width='20%'>월</th><th width='40%'>매출 건수</th><th width='40%'>매출 금액</th></tr>");
				for(int i = 0 ; i < 12 ; i ++)
				{
					out.println("<tr>");
					out.println("<td>"+((nowMonth == i+1) ? "(이번 달)" : "" )+(i+1)+" 월</td>");
					out.println("<td>"+ arrSales.get(i)[0] +" 원</td>");
					out.println("<td>"+ arrSales.get(i)[1] +" 건</td>");
					out.println("</tr>");
					totalPrice += arrSales.get(i)[0];
					totalSales += arrSales.get(i)[1];
				}
				out.println("<tr><td colspan='3' align='right'>총 매출 : "+ totalPrice +"원 총 건수 : "+ totalSales +"건</td></tr>");
			}
			else if(menu == 2) // 년도별 매출
			{
				out.println("<tr><th width='20%'>년도</th><th width='40%'>매출 건수</th><th width='40%'>매출 금액</th></tr>");
				for(int i = 0 ; i < 10 ; i ++)
				{
					out.println("<tr>");
					out.println("<td>"+((nowYear-i == nowYear) ? "(올해)" : "" )+(nowYear-i)+" 년</td>");
					out.println("<td>"+ arrSales.get(i)[0] +" 원</td>");
					out.println("<td>"+ arrSales.get(i)[1] +" 건</td>");
					out.println("</tr>");
					totalPrice += arrSales.get(i)[0];
					totalSales += arrSales.get(i)[1];
				}
				out.println("<tr><td colspan='3' align='right'>총 매출 : "+ totalPrice +"원 총 건수 : "+ totalSales +"건</td></tr>");
			}
			else if(menu == 3) // 요일별 매출
			{
				out.println("<tr><th width='20%'>요일</th><th width='40%'>매출 건수</th><th width='40%'>매출 금액</th></tr>");
				for(int i = 0 ; i < 7 ; i ++)
				{
					out.println("<tr>");
					out.println("<td>"+((nowWeek == i) ? "(오늘)" : "" )+week[i]+"</td>");
					out.println("<td>"+ arrSales.get(i)[0] +" 원</td>");
					out.println("<td>"+ arrSales.get(i)[1] +" 건</td>");
					out.println("</tr>");
					totalPrice += arrSales.get(i)[0];
					totalSales += arrSales.get(i)[1];
				}
				out.println("<tr><td colspan='3' align='right'>총 매출 : "+ totalPrice +"원 총 건수 : "+ totalSales +"건</td></tr>");
			}
			else if(menu == 4) // 시간대별 매출
			{
				out.println("<tr><th width='20%'>시간</th><th width='40%'>매출 건수</th><th width='40%'>매출 금액</th></tr>");
				for(int i = 0 ; i < 24 ; i ++)
				{
					out.println("<tr>");
					out.println("<td>"+((nowHour == i) ? "(현재 시각)" : "" )+printHour[i]+"</td>");
					out.println("<td>"+ arrSales.get(i)[0] +" 원</td>");
					out.println("<td>"+ arrSales.get(i)[1] +" 건</td>");
					out.println("</tr>");
					totalPrice += arrSales.get(i)[0];
					totalSales += arrSales.get(i)[1];
				}
				out.println("<tr><td colspan='3' align='right'>총 매출 : "+ totalPrice +"원 총 건수 : "+ totalSales +"건</td></tr>");
			}
			%>
			</table>
		</div>
		</form>
		<!-- 통계 테이블 영역 종료 -->
	</div>
</div>
</body>
</html>
