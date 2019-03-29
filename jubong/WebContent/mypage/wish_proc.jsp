<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>

<%

if(userId == null || userId.equals(""))
{
	out.println("<script>");
	out.println("location.replace('../member/login_form.jsp');");
	out.println("</script>");
}
String pid = "", wtype = "", widx = "",quantity = "", po_color = "", po_size ="";
String[] wArr = {};
wtype = request.getParameter("wtype");
if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("history.back();");
	out.println("</script>");
}
else if(wtype.equals("in"))
{
	pid = request.getParameter("pid");
	sql = "insert into member_wishList (ml_id, p_id) values ('"+ userId +"','"+ pid +"')";
}
else if(wtype.equals("del"))
{
	widx = request.getParameter("widx");
	wArr = widx.split(",");
	for(int i = 0 ; i < wArr.length ; i++)
	{
		where += "w_idx = "+wArr[i];
		if(i < wArr.length-1)
		{
			where += " or ";
		}
	}

	sql = "delete from member_wishList where "+ where;
}
else if(wtype.equals("cart"))
{
	po_size = request.getParameter("po_size");
	pid = request.getParameter("pid");
	po_color = request.getParameter("po_color");
	quantity = request.getParameter("quantity");
	widx = request.getParameter("widx");
}
try
{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	if(wtype.equals("in"))
	{
		rs = stmt.executeQuery("select count(*) as cnt from member_wishList where ml_id ='"+ userId +"' and p_id = '"+pid+"'");
		if(rs.next())
		{
			if(rs.getInt("cnt") > 0)
			{
				out.println("<script>");
				out.println("alert('이미 등록한 상품입니다.');");
				out.println("history.back();");
				out.println("</script>");
			}	
			else
			{
				result = stmt.executeUpdate(sql);
			}
		}

		rs.close();
	}
	if(wtype.equals("cart"))
	{
		result = stmt.executeUpdate("delete from member_wishList where w_idx = "+widx);
		if(result != 0)
		{

			out.println("<script>");
			out.println("location.replace('../order/cart_proc.jsp?wtype=in&pid="+pid+"&quantity="+ quantity +"&po_color="+ po_color +"&po_size="+po_size+"');");
			out.println("</script>");
		}
	}
	else if(wtype.equals("del"))
	{
		result = stmt.executeUpdate(sql);
	}
	if(result != 0)
	{	
		out.println("<script>");
		out.println("location.replace('wish_list.jsp');");
		out.println("</script>");
		
	}
	else
	{
		out.println("<script>");
		out.println("history.back();");
		out.println("</script>");
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
		stmt.close();
		conn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
%>
