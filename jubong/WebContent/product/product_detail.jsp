<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

String pid = "", po_color = "", tmp_size ="";
int po_size = 0, quantity = 1;
int a = 0;
String cookie2 = request.getHeader("Cookie");
String p ="";
String best = "";
int po_stock = 0;
String lined = "";
String args = "";
String tmpQ = "";
String cate = request.getParameter("cate");
lined = request.getParameter("lined");
ResultSet rs2 = null;
Statement stmt2 = null;
if(cate != null) args += "&cate="+cate;
if(lined != null) args +="&lined="+lined;
tmpQ =request.getParameter("quantity"); 
pid = request.getParameter("pid");
boolean chk = true;
// 쿠키 생성 부분 

po_color = request.getParameter("po_color");
tmp_size = request.getParameter("po_size");
if(po_color == null) po_color = "";
if(tmp_size == null || tmp_size.equals(""))
{
	po_size = 0;
}
else
{
	po_size = Integer.valueOf(tmp_size);
}

if(tmpQ == null || tmpQ.equals(""))
{
	quantity = 1;
}
else
{
	quantity = Integer.valueOf(tmpQ);
}
if (pid == null || pid.equals(""))
{
	out.println("<script>");
	out.println("location.href='product_list.jsp?"+args+"'");
	out.println("</script>");
}

String order ="";
String contact = "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#wrapper { width:1200px; margin:0 auto;}
#contents { text-align:center; }
#ta_detail th { background-color:#e8e8ff; }
.btn_pro { border:1px solid #dddddd; background-color:#fff; width:100px; height:40px;}
#detail_box { width:1200px; font-size:0.8em;}
.scroll_tab { width:1200px; height:30px; background-color:black; border:1px 0 1px 0 solid black; }
.scroll_tab li{ color:#fff; float:left; list-style:none; text-align:cetner; width:120px; height:28px;margin-top:2px;}
.scroll_tab li.select { color:#000; background-color:#fff; }
.detail_tab, .review_tab, .qna_tab { cursor:pointer; }
.detail_btn { width:1200px; text-align:right; }
.detail_btn .btn_de{ float:right; background-color:#c1c1c1; border-radius:7px; }
#po_color, #po_size { height:30px; }
.tb_detail th, .tb_detail td{ border-top:1px solid #c1c1c1; border-bottom:1px solid #c1c1c1; }

</style>

<script src="../js/jquery-3.3.1.js"></script>
<script>

$(document).ready(function() {
	 $(".detail_tab").click(function() {
		    $('html, body').stop().animate( { scrollTop : $('#detailView').offset().top },200 ); 
	 });
	 $(".review_tab").click(function() {
		    $('html, body').stop().animate( { scrollTop :  $("#review").offset().top  },200 ); 
	 });
	 $(".qna_tab").click(function() {
		    $('html, body').stop().animate( { scrollTop :  $("#qna").offset().top  },200 ); 
	 });
	

	 
});

function selectColor(val)
{
	location.href="product_detail.jsp?pid=<%=pid%>&quantity=<%=quantity%>&po_color="+val;	
}

function selectSize(value)
{
	var sel = document.getElementById("po_size");
	var val = value.substring(0,value.indexOf(","));
	var stock = value.substring(value.indexOf(",")+1,value.length);
	if(stock < 1)
	{
		alert("품절 상품은 선택할 수없습니다.");
		location.reload();
	}
	else
	{
		location.href="product_detail.jsp?pid=<%=pid%>&po_color=<%=po_color%>&quantity=<%=quantity%>&po_size="+val;
	}
}


function selectQuantity(val)
{
	location.href="product_detail.jsp?pid=<%=pid%>&po_color=<%=po_color%>&po_size=<%=po_size%>&quantity="+val;		
}

function goOrder(id,p,c,s,q,st)
{
	var pid = p;
	var color = c;
	var size = s;
	var quantity = q;
	var stock = st;
	if(stock > 0)
	{
		if(pid == "")
		{
			location.href="product_list.jsp";
		}
		
		if(color == "")
		{
			alert("색상을 선택해주세요.");
		}
		else if(size == 0)
		{
			alert("사이즈를 선택해주세요.");
		}
		else
		{
			if(id == "")
			{
				location.href="../member/login_form.jsp?history=order&pid="+ pid +"&po_size="+ size +"&po_color="+ color +"&quantity="+ quantity;
			}
			else
			{
				location.href="../order/order_form.jsp?pid="+ pid +"&po_size="+ size +"&po_color="+ color +"&quantity="+ quantity;
			}
		}
	}
	else if(stock < 1)
	{
		alert('품절 상품입니다.');
	}
}

function goCart(p,c,s,q,st)
{
	var pid = p;
	var color = c;
	var size = s;
	var quantity = q;
	var stock = st;
	if(stock > 0)
	{
		if(pid == "")
		{
			location.href="product_list.jsp";
		}
		
		if(color == "")
		{
			alert("색상을 선택해주세요.");
		}
		else if(size == 0)
		{
			alert("사이즈를 선택해주세요.");
		}
		else
		{
		location.href="../order/cart_proc.jsp?&wtype=in&pid="+ pid +"&po_size="+ size +"&po_color="+ color +"&quantity="+ quantity;
		}
	}
	else if(stock < 1)
	{
		alert('품절 상품입니다.');
	}
}
</script>
</head>
<body>

<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
	<br /><br /><h2>| Product Detail |</h2><br /><br />
	<!-- 상품 상세 -->
	<div id="detail_box">
	<table width="800" border="0" id="ta_detail" align="center" cellpadding="10">
	<tr>
		
		<%
		try
		{
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "root");
			stmt = conn.createStatement();
			int clength = 0;
			String linkHead = "", linkTail = "";
			String title ="", price= "", rprice="", point="", p_id="";
			int stock = 0;
			
			String src = "../image/";
			sql = "select p_stock,p_img,p_title,p_price,p_rprice,p_point,p_id,p_contact,p_isview,p_best from product where p_id = '"+pid+"' and p_isview = 1";
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				stock = rs.getInt("p_stock");
				best = rs.getString("p_best");
				src += rs.getString("p_img");
				contact = rs.getString("p_contact");
				title = rs.getString("p_title");
				price = rs.getString("p_price");
				rprice = rs.getString("p_rprice");
				point = rs.getString("p_point");
				p_id = rs.getString("p_id");
				if (cookie2 != null) // 생성된 쿠키가 있으면
				{
					Cookie cookies[] = request.getCookies();
					// 쿠키를 배열 형태로 생성
					for (int i = 0 ; i < cookies.length ; i++ )
					{
						
						if(cookies[i].getValue().equals(pid))
						{
							chk =false;
						}
					}
					
					if(chk)
					{
						if(cookies.length == 6)
						{
							a = 1;
						}
						else
						{
							a = cookies.length+1;
						}
						Cookie cookid = new Cookie("p_id"+a,pid);
						Cookie cookimg = new Cookie("p_img"+a,rs.getString("p_img"));
						cookid.setPath("/");
						cookid.setMaxAge(60*24*24);
						response.addCookie(cookid);
						cookimg.setPath("/");
						cookimg.setMaxAge(60*24*24);
						response.addCookie(cookimg);
					}
				}

			}
			else
			{
				out.println("<script>");
				out.println("alert('해당상품은 구매 하실 수 없습니다.');");
				out.println("location.href='product_list.jsp';");
				out.println("</script>");
			}
			rs.close();
		%>
		
		<td width="50%" align="right">
		<img src="<%=src%>" width="280" height="300"alt="상품 이미지"/>
		</td>
		<td width="50%" align="center">
		<table width="400" height="300" border="0">
		<tr>
			<th width="*">상품명</th>
			<td width="70%"><%=title %>
			<%
			if(best.equals("y")) out.println("<span id=''><img src='../image/custom_105.gif' width='56' height='13' alt='best'/></span>");
			%>
			</td>
		</tr>
		<tr>
			<th>소비자가</th>
			<td><del><%=price %></del></td>
		</tr>
		<tr>
			<th>판매가</th>
			<td><%=rprice %></td>
		</tr>
		<tr>
			<th>적립금</th>
			<td><%=point %></td>
		</tr>
		<tr>
			<th>상품코드</th>
			<td><%=p_id %></td>
		</tr>
		<%
		if(stock > 0) {%>
		<tr>
			<th>수량</th>
			<td>
			<form name="frm_quantity" >
			<select name="cnt" onchange="selectQuantity(this.value);">
				<%
		
				rs = stmt.executeQuery("select po_stock from product_option where p_id = '"+ pid +"' and po_color = '"+ po_color +"' and po_size ='"+ po_size +"'");
				if(rs.next())
				{
					stock = rs.getInt("po_stock");
				}
				
				rs.close();
			
				for (int i = 1 ; i <= 10 && i <= stock ; i++)
				{%>
				<option value="<%=i%>" <%=quantity == i ? "selected='selected'" : "" %>><%=i %>개</option>
				<%
				}
				%>
			</select>
			</form>
		</td>
		</tr>
		<tr>
		<th>Color</th>
		<td>
		<form name="frm_color">
			<select id="po_color" name="po_color" onchange="selectColor(this.value);">
				<option value="" >---------색상 선택---------</option>
			<%
			rs = stmt.executeQuery("select po_color from product_option where p_id = '"+ pid +"' group by po_color");
			if(rs.next())
			{
				do
				{
					out.println("<option value='"+ rs.getString("po_color") +"' "+ (po_color.equals(rs.getString("po_color"))?"selected='selected'" : "") +">"+ rs.getString("po_color") +"</option>");
				}
				while(rs.next());
			}
			
			rs.close();
			%>
			</select>
		</form>
		</td>
		</tr>
		<tr>
		<th>Size</th>
		<td>
		<form name="frm_size">
		<select id="po_size" name="po_size" onchange="selectSize(this.value);">
			<option value="">--------사이즈선택--------</option>

		<%
		rs = stmt.executeQuery("select po_size, po_stock from product_option where p_id = '"+ pid +"' and po_color = '"+ po_color +"' ");
		if(rs.next())
		{
			do
			{
				po_stock = rs.getInt("po_stock");
				out.println("<option value='"+ rs.getInt("po_size") +","+po_stock+"' "+ (po_size == rs.getInt("po_size")?"selected='selected'" : "") +" onclick='return ss("+po_stock+");'>"+ rs.getInt("po_size") +" " +  (po_stock < 1 ? "(품절)" : "")  + "</option>");
				
			}
			while(rs.next());
		}
		rs.close();
		%>
		</select>
		</form>
		</td>
		</tr>
		<%}
		else
		{%>
		<tr><td align="center" colspan="2"><font color="red" size="4"><b>품절 상품 입니다.</b></font></td></tr>
		<%} %>
		<tr>
		<td colspan="2">
		<input type="button" class ="btn_pro" value="BUY IT NOW" onclick="goOrder('<%=(userId == null) ? "" : userId %>','<%=pid%>','<%=po_color%>','<%=po_size%>','<%=quantity%>','<%=stock%>');"/>
		<input type="button" class ="btn_pro" value="ADD TO CART" onclick="goCart('<%=pid%>','<%=po_color%>','<%=po_size%>','<%=quantity%>','<%=stock%>');"/>
		<input type="button" class ="btn_pro" value="WISH LIST" onclick="location.href='../mypage/wish_proc.jsp?wtype=in&pid=<%=pid%>'"/>
		</td>
		</tr>
		</table>
		</td>
	
		</table>
	</div>
	<hr width="100%">
	<!-- 상품설명 및 Q&A, 리뷰 -->
	<div id="view_box">
		<div id="detailView">
		<br /><h2>| DETAIL VIEW |</h2><br />
			<div class="scroll_tab">
				<ul>
				<li class="select"><span class="detail_tab">DETAIL VIEW</li>
				<li><span class="review_tab">REVIEW</li>
				<li><span class="qna_tab">Q&A</li>
				</ul>
			</div>
			<div id="detail_contents">
				<%=contact %>
			</div>
		</div>
		<div id="review">
		<br /><h2>| REVIEW |</h2><br />
			<div class="scroll_tab">
				<ul>
				<li><span class="detail_tab">DETAIL VIEW</span></li>
				<li class="select"><span class="review_tab">REVIEW</span></li>
				<li><span class="qna_tab">Q&A</span></li>
				</ul>
			</div>
			<div id="review_contents">

			<table width="1200" cellspacing="0" cellpadding="5" class="tb_detail" border="0">
				<tr >
					<th width="8%">NO.</th>
					<th width="*">Subject</th>
					<th width="10%">Name</th>
					<th width="10%">Date</th>
					<th width="8%">Hits</th>
				</tr>
			<%
			sql="select pb_idx,pb_title,pb_writer,pb_date,pb_read from product_board where p_id = '"+ pid +"' and pb_type ='r'";
			rs = stmt.executeQuery(sql);
			int count = 0;
			if(rs.next())
			{
				do
				{
					count++;
			%>
				<tr >
					<td><%=count %></td>
					<td align="left"><a href="../board/board_view.jsp?idx=<%=rs.getString("pb_idx")%>"><%=rs.getString("pb_title") %></a></td>
					<td><%=rs.getString("pb_writer") %></td>
					<td><%=rs.getString("pb_date").substring(0,10) %></td>
					<td><%=rs.getString("pb_read") %></td>
				</tr>
				
			<%
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='5'>해당 상품의 리뷰가 없습니다.</td></tr>");
			}
			rs.close();
			%>
			</table>
			<span class="detail_btn"><input type="button" value="사용후기쓰기" class="btn_de" onclick="location.href='../board/board_form.jsp?wtype=in&history=pd&btype=r&p_id=<%=pid%>';"/>&nbsp;&nbsp;&nbsp;<input type="button" value="모두보기" class="btn_de" onclick="location.href='../board/review_list.jsp?btype=r';" /></span>
			</div>
		</div>
		<div id="qna">
		<br /><h2>| Q&A |</h2><br />
			<div class="scroll_tab">
				<ul>
				<li><span class="detail_tab">DETAIL VIEW</span></li>
				<li><span class="review_tab">REVIEW</span></li>
				<li class="select"><span class="qna_tab">Q&A</span></li>
				</ul>
			</div>
			<div id="qna_contents">
			
			<table width="1200" cellspacing="0" cellpadding="5" class="tb_detail" border="0">
				<tr>
					<th width="8%">NO.</th>
					<th width="*">Subject</th>
					<th width="10%">Name</th>
					<th width="10%">Date</th>
					<th width="8%">Hits</th>
				</tr>
			<%
			sql="select pb_idx,pb_title,pb_writer,pb_date,pb_read from product_board where p_id = '"+ pid +"' and pb_type ='q'";
			rs = stmt.executeQuery(sql);
			count = 0;
			if(rs.next())
			{
				do
				{
					count++;
			%>
				<tr>
					<td><%=count %></td>
					<td height="40"><a href="../board/board_view.jsp?<%=rs.getString("pb_idx")%>"><%=rs.getString("pb_title") %></a></td>
					<td><%=rs.getString("pb_writer") %></td>
					<td><%=rs.getString("pb_date").substring(0,10) %></td>
					<td><%=rs.getString("pb_read") %></td>
				</tr>
				
			<%
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='5'>해당 상품의 Q&A가 없습니다.</td></tr>");
			}
			
			%>
			</table>
			<span class="detail_btn"><input type="button" class="btn_de" value="상품문의하기" onclick="location.href='../board/board_form.jsp?wtype=in&history=pd&btype=q&p_id=<%=pid%>';"/>&nbsp;&nbsp;&nbsp;<input type="button" value="모두보기" class="btn_de"  onclick="location.href='../board/qna_list.jsp?btype=q';" /></span>
			</div>
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
	</div>
	
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>