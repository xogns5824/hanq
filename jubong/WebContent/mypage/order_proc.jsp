<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp"%>
<%
	String o_id = request.getParameter("oid");
	String rtype = request.getParameter("rtype");
	
	if(rtype.equals("ch"))
	{
		sql = "update order_info set o_situ = 8 where o_id = '"+ o_id +"'";
	}
	else if(rtype.equals("re"))
	{
		sql = "update order_info set o_situ = 6 where o_id = '"+ o_id +"'";
	}
	else if(rtype.equals("ce"))
	{
		sql = "update order_info set o_situ = 4 where o_id = '"+ o_id +"'";
	}
	
	try
	{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		result = stmt.executeUpdate(sql);
		out.println("<script>");
		out.println("location.replace('order_list.jsp');");
		out.println("</script>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		try
		{
			stmt.close();
			conn.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	%>