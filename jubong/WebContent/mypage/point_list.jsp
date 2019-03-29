<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String mpDate="",o_id ="",mpContent="",mpState="";

String[] strSitu = {"포인트상태","적립","사용"};
String situ = request.getParameter("situ");

if(situ == null || situ.equals(""))
{
	situ = "n";
}

int point = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { margin-bottom:50px;text-align:center; }
	#my_top { width:1200px; height:152px;}
	#pointList { width:1200px; margin-bottom:20px;}
	#tb_pointList th { border-top:3px solid black; border-bottom:3px solid black; }
	#tb_pointList td { border-bottom:1px solid black; }
	
	#situ { float:left; margin-bottom:3px; }
</style>
<script>
	function chnSitu(val)
	{
		location.replace("point_list.jsp?situ="+val);	
	}
</script>
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
	<!-- contents -->
	<div id="contents">	
		<h1>MY POINT</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<br /><br /><br /><br />
		<div id="pointList">
		<form name="frm_situ">
				<select name="o_situ" id="situ" onchange="chnSitu(this.value);">
					<option value="n" <%=(situ.equals("n")) ? "selected='selected'" : ""%>>포인트상태</option>
					<option value="u" <%=(situ.equals("u")) ? "selected='selected'" : ""%>>사용</option>
					<option value="y" <%=(situ.equals("y")) ? "selected='selected'" : ""%>>적립</option>
					
				</select>
			</form>
			<table width="1200"id ="tb_pointList" cellpadding="0" cellspacing="0">
			<tr>
				<th width="10%"class="first_column">적립날짜</th>
				<th width="8%">POINT</th>
				<th width="10%">주문번호</th>
				<th width="*">상세내용</th>
				<th width="10%" class="last_column">포인트 상태</th>
			</tr>
			<%
			try
			{

				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				if(situ.equals("n")) 
				{
					sql = "select mp_date, mp_point, o_id, mp_content, mp_state from member_point where ml_id = '"+userId+"'";
				}
				else
				{
					sql = "select mp_date, mp_point, o_id, mp_content, mp_state from member_point where ml_id = '"+userId+"' and mp_state ='"+ situ +"'";
				}

				rs =stmt.executeQuery(sql);

				if(rs.next())
				{

	
					do
					{			
						mpDate = rs.getString("mp_date");
						mpDate = mpDate.substring(0,mpDate.indexOf(" "));
						point = rs.getInt("mp_point");
						o_id = rs.getString("o_id");
						mpContent = rs.getString("mp_content");
						mpState = rs.getString("mp_state");
					%>
					<tr>
					<td height="80" class="first_column"><%=mpDate %></td>
					<td><%=point %></td>
					<td><%=o_id%></td>
					<td><%=mpContent %>(주봉샵)</td>
					<td class="last_column"><%=mpState%></td>
					
				</tr>
				
				<%
			
					}while(rs.next());
					
				}
				else
				{
					out.println("<tr><td colspan='5'>포인트 사용/적립 내역이 없습니다.</td></tr>");
				}

				
			}
		catch(Exception e)
		{
			e.printStackTrace();
			out.println("<script>");
			out.println("location.href='my_main.jsp'");
			out.println("</script>");
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
				out.println("<script>");
				out.println("location.href='my_main.jsp'");
				out.println("</script>");
			}
		}
		%>
		
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