<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String[] strSitu = {"미입금","입금완료","배송중","배송완료","취소요청","취소완료","반품요청","반품완료","교환요청","교환완료"};
String tmpSitu = request.getParameter("situ");
 
int situ = -1;
if(tmpSitu == null || tmpSitu.equals(""))
{
	situ = -1;
}
else
{
	situ = Integer.valueOf(tmpSitu);
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents {text-align:center; }
	#my_top { width:1200px; height:152px;}
	#orderList { width:1200px;}
	#orderList th { border-top:3px solid black; border-bottom:3px solid black; }
	#orderList td { border-bottom:1px solid black; }
	.order_btn { width:60px; height:25px; background-color:#e8e8ff; border:1px solid #c1c1c1;color:black; margin-bottom:3px;}
	#chn_btn { background-color:#5a5a5a; color:#fff; }
	#situ { float:left; margin-bottom:3px; }
</style>
<script>
	function chnSitu(val)
	{
		location.replace("order_list.jsp?situ="+val);	
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
		if(orderNumber == null)
		{
			out.println("<script>");
			out.println("location.replace('../member/login_form.jsp');");
			out.println("</script>");
		}
	}
	%>
	<!-- contents -->
	
	<div id="contents">
		
		<h1>ORDER LIST</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<br /><br /><br /><br />
		
		<div id="orderList">
			<form name="frm_situ">
				<select name="o_situ" id="situ" onchange="chnSitu(this.value);">
					<option value="-1" <%=(situ == -1) ? "selected='selected'" : ""%>>주문처리상태</option>
					<%
					for(int i = 0 ; i < strSitu.length ; i++)
					{
					%>
					<option value="<%=i %>" <%=(situ == i) ? "selected='selected'" : ""%>><%=strSitu[i] %></option>
					<%
					}
					%>
					
				</select>
			</form>
			<table width="1200" cellpadding="0" cellspacing="0">
				<tr>
					<th>주문날짜</th>
					<th>이미지</th>
					<th>상품</th>
					<th>수량</th>
					<th>가격</th>
					<th>주문상태</th>
					<th>교환/반품</th>
					
				</tr>
				<%
					try{
					Class.forName(driver);
					conn = DriverManager.getConnection(url, "root", "root");
					stmt = conn.createStatement();
					if(userId == null)
					{
						if(situ != -1)
						{
							sql = "select order_detail.p_id, order_info.o_id,o_date, p_img, p_title, od_cnt, (p_rprice * od_cnt) as total, o_situ ";
							sql +="from order_info,order_detail,product "; 
							sql +="where order_info.o_id = order_detail.o_id and order_detail.p_id = product.p_id and order_info.o_id ='"+ orderNumber +"' and o_situ = "+ situ +" order by o_date desc";
						}
						else
						{
							sql = "select order_detail.p_id, order_info.o_id, o_date, p_img, p_title, od_cnt, (p_rprice * od_cnt) as total, o_situ ";
							sql +="from order_info,order_detail,product "; 
							sql +="where order_info.o_id = order_detail.o_id and order_detail.p_id = product.p_id and order_info.o_id ='"+ orderNumber +"' order by o_date desc";
							
						}
					}
					else
					{
						if(situ != -1)
						{
							sql = "select order_detail.p_id, order_info.o_id,o_date, p_img, p_title, od_cnt, (p_rprice * od_cnt) as total, o_situ ";
							sql +="from order_info,order_detail,product "; 
							sql +="where order_info.o_id = order_detail.o_id and order_detail.p_id = product.p_id and ml_id ='"+ userId +"' and o_situ = "+ situ +" order by o_date desc";
						}
						else
						{
							sql = "select order_detail.p_id, order_info.o_id, o_date, p_img, p_title, od_cnt, (p_rprice * od_cnt) as total, o_situ ";
							sql +="from order_info,order_detail,product "; 
							sql +="where order_info.o_id = order_detail.o_id and order_detail.p_id = product.p_id and ml_id ='"+ userId +"' order by o_date desc";
							
						}
					}
					rs = stmt.executeQuery(sql);
					if(rs.next())
					{
						do{		
							String date = rs.getString("o_date");
				%>
				<tr>
				<td >
				<%=date.substring(0,date.indexOf(" ")) %><br />
				<input type="button" class="order_btn" value="상세보기" style="width:110px;" onclick="location.href='order_detail.jsp?oid=<%=rs.getString("o_id")%>'"/>
				</td>
				<td height="80">
				<a href="../product/product_detail.jsp?pid=<%=rs.getString("p_id")%>"><img src="../image/<%=rs.getString("p_img") %>" width="80" height="100"alt="상품 이미지"/></a>
			
				</td>
				<td><a href="../product/product_detail.jsp?pid=<%=rs.getString("p_id")%>"><%=rs.getString("p_title") %></a></td>
				<td><%=rs.getInt("od_cnt") %></td>
				<td><%=rs.getInt("total") %></td>
				<td><%=strSitu[rs.getInt("o_situ")]%></td>
				<td>
				<input type="button" value="교환" class="order_btn" id="chn_btn" onclick="location.href='order_proc.jsp?oid=<%=rs.getString("o_id")%>&rtype=ch'"/><br />
				<input type="button" value="반품" class="order_btn" onclick="location.href='order_proc.jsp?oid=<%=rs.getString("o_id")%>&rtype=re'"/><br />
				<input type="button" value="취소" class="order_btn" onclick="location.href='order_proc.jsp?oid=<%=rs.getString("o_id")%>&rtype=ce'"/></td>
				</tr>
				<%
						}while(rs.next());
					}
					else
					{
						out.println("<tr><td colspan='7'>해당하는 주문 목록이 없습니다.</td></tr>");
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