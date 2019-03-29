<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String widx = "",pid="", isview = "n";
String po_color = "", tmp_size ="";
String[] wArr = {};
String[] color;
int[] size;
int po_size = 0;
widx =request.getParameter("widx");
pid =request.getParameter("pid");
Connection conn2 = null;
ResultSet rs2 = null;
Statement stmt2 = null;
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

if(widx == null || widx.equals(""))
{
	isview = "n";
}
else
{
	isview = "y";
}
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
	#wishList { width:1200px;}
	#wishList th { border-top:3px solid black; border-bottom:3px solid black; }
	#wishList td { border-bottom:1px solid black; }
	.wish_btn { width:120px; height:25px; background-color:#e8e8ff; border:1px solid #c1c1c1;color:black; margin-bottom:3px;}
	#chn_btn { background-color:#5a5a5a; color:#fff; }
	#btn_box { width:1200px; }
	#btn_box #left { float:left; }
	#btn_box #right { float:right; }
	#popup_box { position:absolute; top:300px; left:30%; width:800px; height:600px; border:1px solid black; z-index:1; background-color:#fff; visibility:hidden; }
	#exit_box { position:absolute; float:right; top:0px; right:0px; width:50px; height:45px; border-bottom:1px solid black;border-left:1px solid black; text-align:center; font-size:1.5em; padding-top:10px; font-weight:bold;}
	#exit_box:hover { cursor:pointer; color:#ff0000; background-color:#efefef; }
	#tb_popup th { border-top:1px solid black; border-bottom:1px solid black; background-color:#c1c1c1;}
	#tb_popup td { border-bottom:1px solid black; }
	#btn_popBox { position:absolute; top:90%; width:800px; text-align:center; }
	#contents_box {  width:720px; height:450px; overflow:auto; margin-left:35px; }
</style>
<script src="../js/jquery-3.3.1.js"></script>
<script>

$(document).ready(function() {
var isview = "<%=isview%>";
 
if(isview == "y")
{
	obj = document.getElementById("popup_box");
	obj.style.visibility="visible";
}
else
{
	obj = document.getElementById("popup_box");
	obj.style.visibility="hidden";
}
	
 
});

function check_all()
{	
	var obj = document.getElementsByName("chkall");
	var obj_a = document.getElementsByName("wIdx");
	var isChk = obj[0].checked;

	for (var i = 0;i < obj_a.length ;i++ )
	{
		obj_a[i].checked = isChk;
		//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	}
}

function wishDel(val)
{

	var isDel = false;
	if(confirm("정말 삭제하시겠습니까?"))
	{
		isDel= true;
	}
	

	if(isDel)
	{
		location.href="wish_proc.jsp?widx="+val+"&wtype=del";	
	}
}
count = 0;
function chkDel(frm)
{
	var obj_a = document.getElementsByName("wIdx");
	var str ="";
	var isDel = false;
	if(confirm("정말 삭제하시겠습니까?"))
	{
		isDel= true;
	}
	if(isDel)
	{
		for(var i = 0 ; i < obj_a.length ; i++)
		{
			if(obj_a[i].checked)
			{
				if(count > 0)
				{
					str += ",";
				}
				str += obj_a[i].value;
	
			
				count++;
			}
			
		}
		if(str =="")
		{
			alert("항목을 선택해주세요.");
		}
		else
		{
			location.href="wish_proc.jsp?widx="+str+"&wtype=del";
		}
	}
		
	
}

function chkCart(frm)
{
	var obj_a = document.getElementsByName("wIdx");
	var str ="";
	var isDel = false;
	if(confirm("선택한 상품을 장바구니에 담으시겠습니까?"))
	{
		isDel= true;
	}
	if(isDel)
	{
		for(var i = 0 ; i < obj_a.length ; i++)
		{
			if(obj_a[i].checked)
			{
				if(count > 0)
				{
					str += ",";
				}
				str += obj_a[i].value;
	
			
				count++;
			}
			
		}
		location.href="wish_list.jsp?widx="+str;	
	}
		
	
}

function order_pop(pid,widx)
{
	//obj = document.getElementById("popup_box");
	//obj.style.visibility="visible";
	location.href="wish_list.jsp?pid="+ pid +"&widx="+widx;
}

function exit_pop()
{
	location.href="wish_list.jsp";
}

function selectColor(val)
{
	location.href="wish_list.jsp?pid=<%=pid%>&widx=<%=widx%>&po_color="+val;	
}

function buy_it_now()
{	
		var frm = document.frm_order;
		if(frm.po_color.value == "")
		{
			alert("색상을 입력해주세요.");
			return false;
		}
		else if(frm.po_size.value =="")
		{
			alert("사이즈를 입력해주세요.");
			return false;
		}	
		else
		{
			frm.action = "../order/order_form.jsp";	
			frm.submit();
		}
}
/*
function add_to_cart(cnt)
{	var frm = document.frm_order;
	var obj = "";
	var obj2 = "";
	var chk = true;
	for(var i = 1 ; i < cnt+1 ; i++)
	{
		obj = document.getElementById("po_color"+i);
		obj2 = document.getElementById("po_size"+i);
		if(obj.value == "")
		{
			alert("색상을 입력해주세요.");
			chk = false;
		}
		else if(obj2.value =="")
		{
			alert("사이즈를 입력해주세요.");
			chk = false;
		}

	}
	
	if(chk)
	{
		frm.action = "../order/cart_proc.jsp";
		frm.submit();
	}
}
*/

function add_to_cart(cnt)
{
	var frm = document.frm_order;
	if(frm.po_color.value == "")
	{
		alert("색상을 입력해주세요.");
		return false;
	}
	else if(frm.po_size.value =="")
	{
		alert("사이즈를 입력해주세요.");
		return false;
	}
	else
	{
		frm.action = "./wish_proc.jsp";
		frm.submit();

	}
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
	<%

		if(userId == null || userId.equals(""))
		{
			out.println("<script>");
			out.println("location.replace('../member/login_form.jsp');");
			out.println("</script>");
		}
	%>
	<!-- contents -->
	<div id="contents">
		<h1>WISH LIST</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
			<br /><br /><br /><br />
		
		<div id="wishList">
			<form name="frm_wish" action="">
			<table width="1200" cellpadding="0" cellspacing="0">
				<tr>
					<th><input type="checkbox" name="chkall" onchange="check_all()"/></th>
					<th>이미지</th>
					<th>상품</th>
					<th>포인트</th>
					<th>배송비</th>
					<th>가격</th>
					<th width="10%">주문</th>
					
				</tr>
				<%
					try{
					Class.forName(driver);
					conn = DriverManager.getConnection(url, "root", "root");
					stmt = conn.createStatement();

					conn2 = DriverManager.getConnection(url, "root", "1234");
					stmt2 = conn2.createStatement();
		
					sql = "select w_idx, product.p_id, p_img,p_title,p_point, p_delivery, p_rprice from member_wishList, product where product.p_id = member_wishList.p_id and ml_id = '"+ userId +"' order by w_idx desc";
					rs = stmt.executeQuery(sql);
					if(rs.next())
					{
						do{		
							String p_id = rs.getString("p_id");
				%>
				<tr>
					<td >
					<input type="checkbox" name="wIdx" value="<%=rs.getInt("w_idx") %>" />
					</td>
					<td height="80">
					<a href="../product/product_detail.jsp?pid=<%=p_id%>"><img src="../image/<%=rs.getString("p_img") %>" width="80" height="100"alt="상품 이미지"/></a>
					</td>
					<td><a href="../product/product_detail.jsp?pid=<%=p_id%>"><%=rs.getString("p_title") %></a></td>
					<td><%=rs.getInt("p_point") %></td>
					<td><%=rs.getInt("p_delivery") %></td>
					<td><%=rs.getInt("p_rprice")%></td>
					<td>
					<input type="button" value="ADD TO CART" class="wish_btn" id="chn_btn" onclick="order_pop('<%=p_id%>','<%=rs.getString("w_idx")%>');"/><br />
					<input type="button" value="BUY IT NOW" class="wish_btn" onclick="order_pop('<%=p_id%>','<%=rs.getString("w_idx")%>');"/><br />
					<!--<input type="button" value="BUY IT NOW" class="wish_btn" onclick="location.href='../order/order_form.jsp?pid=<%=p_id%>';"/><br />-->
					<input type="button" value="DELETE" class="wish_btn" onclick="wishDel('<%=rs.getInt("w_idx")%>');"/>
					</td>
				</tr>
				<%
						}while(rs.next());
					}
					else
					{
						out.println("<tr><td colspan='7'>해당하는 위시리스트 목록이 없습니다.</td></tr>");
					}
					
					rs.close();
		%>
				
			</table>
			<div id="btn_box">
				<span id="left">
				선택상품을 <input type="button" value="삭제하기"  class="wish_btn"  onclick="chkDel(this.form);" />
				<!-- 		
				<input type="button" class="wish_btn"  id="chn_btn" value="장바구니에 담기" onclick="chkCart(this.form);"> 
				</span>
				<span id="right"><input type="button" value="전체 상품 주문" class="wish_btn"  onclick="location.href='../order/order_form.jsp';" />
				</span>
				-->
			</div>
			</form>
		</div>
		<%
		if(widx != null || !widx.equals(""))
		{
		%>
		<div id="popup_box">
			<div id="exit_box" onclick="exit_pop();">X</div>
			<h2>상품 주문</h2>
			<br />
			
			<form name="frm_order" action="../order/order_form.jsp" method="post">
			<div id="contents_box">
				<table id="tb_popup" width="700" cellpadding="0" cellspacing="0" >
					<tr>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>색상</th>
					<th>사이즈</th>
					<th>수량</th>
					</tr>
					<%
					wArr = widx.split(",");
					where += "(";
					for(int i = 0 ; i < wArr.length ; i++)
					{
						where += "w_idx = "+wArr[i];
						if(i < wArr.length-1)
						{
							where += " or ";
						}
					}
					where += ")";
					int count = 0;
					out.println("<script>");
					out.println("</script>");
					sql = "select product.p_id, w_idx, p_title, p_img from product,member_wishList where product.p_id = member_wishList.p_id and "+where;
					rs = stmt.executeQuery(sql);
					if(rs.next())
					{
						do{		
							String p_id = rs.getString("p_id");
							widx = rs.getString("w_idx");
							count++;
					%>
					<input type="hidden" name="pid" value="<%=p_id %>" />
					<input type="hidden" name="widx" value="<%=widx %>" />
					<tr>
					
					<td width="8%"><img src="../image/<%=rs.getString("p_img") %>" width="80" height="100" /></td>
					<td width="*"><%=rs.getString("p_title") %></td>		
					
					
					<td width="10%">
					
						<select name="po_color" id ="po_color" onchange="selectColor(this.value);">
							<option value="">색상 선택</option>
					
							<%
							rs2 = stmt2.executeQuery("select po_color from product_option where p_id = '"+ p_id +"' group by po_color");
							if(rs2.next())
							{
								do
								{
									out.println("<option value='"+ rs2.getString("po_color") +"' "+ (po_color.equals(rs2.getString("po_color"))?"selected='selected'" : "") +">"+ rs2.getString("po_color") +"</option>");
								}
								while(rs2.next());
							}
							rs2.close();
							%>
						</select>
					</td>
					<td width="10%">
					
						<select name="po_size" id = "po_size">
							<option value="">사이즈선택</option>
							<%
							rs2 = stmt2.executeQuery("select po_size from product_option where p_id = '"+ p_id +"' and po_color = '"+ po_color +"' ");
							if(rs2.next())
							{
								do
								{
									out.println("<option value='"+ rs2.getInt("po_size") +"' "+ (po_size == rs2.getInt("po_size")?"selected='selected'" : "") +">"+ rs2.getInt("po_size") +"</option>");
								}
								while(rs2.next());
							}
							rs2.close();
							%>
						</select>
						
					</td>
					<td width="10%">
					<select name="quantity">
					<%
					for (int j = 1 ; j <= 10 ; j++)
					{%>
					<option value="<%=j%>" ><%=j %>개</option>
					<%
					}
					%>
					</select>
					</td>
					</tr>
					
					<%
						}while(rs.next());
						
					}
					rs.close();
					%>
				</table>
				
			</div>
			<div id="btn_popBox">
			<input type="button" value="ORDER" class="wish_btn"  onclick="buy_it_now('<%=count %>');" />
			<input type="button" value="ADD TO CART" class="wish_btn" id="chn_btn"onclick="add_to_cart('<%=count %>');" />
			</div>
			<input type="hidden" name="wtype" value="cart" />
			<input type="hidden" name="count" value="<%=count %>" />
			</form>
		</div>
				<%
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
						rs2.close();
						stmt2.close();
						conn2.close();
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