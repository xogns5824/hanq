<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

String[] strSitu = {"미입금","입금완료","배송중","배송완료","취소요청","취소완료","반품요청","반품완료","교환요청","교환완료"};
String oid ="";
oid = request.getParameter("oid");
String oDate = "", odColor = "", odSize = "", pTitle = "";
int oTotal = 0, oSitu = 0, pDelivery =0,count = 0;

if(oid == null || oid.equals(""))
{
	out.println("<script>");
	out.println("location.href='order_list.jsp'");
	out.println("</script>");
}

int orderCnt = 0;
	
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
	#orderDetail { width:1200px; }
	#tb_orderDetail th, #tb_orderDetail td{ border:1px solid black; }
	#tb_orderDetail .first_column{ border-left:0; }
	#tb_orderDetail	.last_column{ border-right:0; }
	#tb_orderDetail #total { border:0; padding-top:10px; }
	#receiver th { border-top:1px solid #c1c1c1; border-right:1px solid #c1c1c1; border-bottom:1px solid #c1c1c1; }
	#receiver td { border-top:1px solid #c1c1c1; border-bottom:1px solid #c1c1c1; padding:5px;}
</style>

</head>
<body>
<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
		<h1>ORDER DETAIL</h1>
		<%@ include file="../include/inc_mypage.jsp" %>
		<div id="orderDetail">
		<div id="orderInfo">
		<h3>주문상품정보</h3>
		<table width="1200"id ="tb_orderDetail" cellpadding="0" cellspacing="0">
			<tr>
				<th class="first_column">주문일자</th>
				<th>주문상품정보</th>
				<th>상품금액(수량)</th>
				<th>배송비(판매자)</th>
				<th class="last_column">주문상태</th>
			</tr>
			<%
			try
			{

				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				sql = "select count(o_id) as orderCnt from order_detail where o_id = '"+ oid + "'";
				rs = stmt.executeQuery(sql);
				if(rs.next())
				{
					orderCnt = rs.getInt("orderCnt");
				}
				rs.close();
				sql = "select order_detail.p_id as p_id,o_totalprice, o_date,od_color,od_size,p_title,o_situ, p_delivery, product.p_rprice as rprice, od_cnt";
				sql += " from order_info, order_detail, product";
				sql += " where order_info.o_id = order_detail.o_id and product.p_id = order_detail.p_id and order_info.o_id = '"+oid+"'";

				rs =stmt.executeQuery(sql);

				if(rs.next())
				{

					oDate = rs.getString("o_date");
					oDate = oDate.substring(0,oDate.indexOf(" "));
					oTotal = rs.getInt("o_totalprice");
					%>
					<tr>
						<td class="first_column" rowspan="<%=orderCnt%>"><%=oDate %></td>
					
					<%
					do
					{
						odColor = rs.getString("od_color");
						odSize = rs.getString("od_size");
						pTitle = rs.getString("p_title");
						pDelivery += rs.getInt("p_delivery");
						
					if(count > 0){%><tr><%} %>
					
					<td>(주문번호 : <%=oid %>)<br/>(상품번호 : <%=rs.getString("p_id") %>)<br /><%=pTitle %><br />[옵션 : <%=odColor %>,<%=odSize %>]</td>
					<td><%=(rs.getInt("rprice") * rs.getInt("od_cnt")) %>(<%=rs.getString("od_cnt") %>)</td>
					<td><%=pDelivery %>(주봉샵)</td>
					<td class="last_column"><%=strSitu[rs.getInt("o_situ")] %></td>
					
				</tr>
				<%
					count++;
					}while(rs.next());
					
				}
				else
				{
					out.println("<script>");
					out.println("location.href='order_list.jsp'");
					out.println("</script>");
				}
				rs.close();
				%>
				<tr><td colspan='5' align="right" id="total">상품금액 <%=oTotal%> + 배송비  <%=pDelivery %> = TOTAL <%=(oTotal + pDelivery)%> 원</td></tr>
		
		</table>
		
		</div>
		<div id="delInfo">
		<h3>배송지정보</h3>
		<table width="1200" id="receiver" cellpadding="0" cellspacing="0" border="0">
		<%
			sql = "select o_rname, o_rphone,  o_rzip, o_raddr1, o_raddr2, o_message from order_info where o_id='"+oid+"'";
			rs = stmt.executeQuery(sql);
			
			if(rs.next())
			{
		%>
				<tr>
				<th width="20%">수령자 이름</th><td width="*" align="left"><%=rs.getString("o_rname") %></td>
				</tr>
				<tr>
				<th>연락처</th><td align="left"><%=rs.getString("o_rphone") %></td>
				</tr>
				<tr>
				<th>주소</th>
				<td align="left">
				{<%=rs.getString("o_rzip") %>}<br />
				<%=rs.getString("o_raddr1") + " " + rs.getString("o_raddr2") %>
				</td>
				</tr>
				<tr>
				<th>배송시 요청사항</th><td align="left"><%=rs.getString("o_message") %></td>
				</tr>
			<%
			}
			else
			{
			%>
				<tr><td>수령인의 정보를 가져오지 못했습니다.</td></tr>
			<%
			}
			%>
		</table>
		
		</div>
		<br />
		<br />
		<div id="deliDesc">
		<h3>주문/배송 상태 안내</h3>
		<img src ="../image/delidesc.png" width="1200" height="300"/>
		</div>
		</div>
		<%	
		}
			catch(Exception e)
			{
				e.printStackTrace();
				out.println("가져오기실패");
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
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>