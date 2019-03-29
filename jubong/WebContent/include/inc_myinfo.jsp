<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#member_info { position:relative;text-align:center; align:center; }
</style>
</head>
<body>
<div id="member_info">
	<table width="1000" height="80" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
		<td rowspan="2" align="center" width="30%">
		어서오세요 <%=(userId == null) ? orderName : userName %> 님 ^^*
		<br />
		
		<a href="../member/info_form.jsp"><img src="../image/modify.png" alt="회원정보수정"></a>
		</td>
		<td width="25%">Board</td>
		<td width="35%">Point</td>
		</tr>
		<tr>
		<%
		try
		{
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "root");
			stmt = conn.createStatement();
			sql = "select count(pb_idx) as cnt from product_board where pb_writer = '"+userId+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
		%>
				<td><%=rs.getString("cnt") %> 개</td>
		<%
			}
			else
			{
				out.println("<td>0개</td>");
			}
		
			rs.close();
			
			sql = "select ml_point from member_list where ml_id = '"+userId+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
			%>
			<td><%=rs.getString("ml_point") %> 포인트</td>
			<%
			}
			else
			{
				out.println("<td>0 포인트</td>");
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
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		%>
		</tr>
	</table>
</div>
</body>
</html>