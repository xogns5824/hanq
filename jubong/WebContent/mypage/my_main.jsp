	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int[] o_situ = {0,0,0,0,0,0,0,0,0,0};


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { 
	text-align:center; 
	}
	#my_top { width:1200px; height:152px;}
	#my_contents { margin-top:100px;border:1px solid black;}

	.request { list-style:none; }
</style>

</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	<%
	if(userId == null)
	{
		out.println("<script>");
		out.println("location.href='../member/login_form.jsp';");
		out.println("</script>");
	}
	%>
	<%
	
	sql = "select count(o_id)as cnt, o_situ from order_info where ml_id = '"+userId+"' group by o_situ";
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
				o_situ[rs.getInt("o_situ")] = rs.getInt("cnt");
			}while(rs.next());
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
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	%>
	<!-- contents -->
	<div id="contents">
		<h1>MY SHOPPING</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<div id="my_contents">
		<table id ="tb_mypage" width="1200" height="90" cellpadding="0" border="0" cellspacing="0">
		<tr>
		<th colspan="5">나의 주문처리 현황 (최근 3개월 기준)</th>
		</tr>
		<tr>
		<td>입금전</td>
		<td>배송준비중</td>
		<td>배송중</td>
		<td>배송완료</td>
		<td rowspan="2">
		<ul>
		<li class="request">취소 : <%=o_situ[4] %></li>
		<li class="request">교환 : <%=o_situ[8] %></li>
		<li class="request">반품 : <%=o_situ[6] %></li>
		</ul>
		</td>
		</tr>
		<tr>
		<td><%=o_situ[0] %></td>
		<td><%=o_situ[1] %></td>
		<td><%=o_situ[2] %></td>
		<td><%=o_situ[3] %></td>
		</tr>
		</table>
		</div>
	</div>
	<!-- banner -->

	<%@ include file="../include/inc_banner.jsp" %>
	
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>