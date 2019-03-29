<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String[] category = {"로퍼","구두","워커","런닝화","스니커즈","샌들"};
String p_id = "",p_img ="", p_title ="", p_contact= "",p_best = "";
int cate = 0,pc_idx = 0, p_isview = 0, p_rprice = 0, p_point = 0, p_stock = 0, cpage = 0,oCnt = 0, count = 0,p_idx = 0;
String keyword = "",schkind = "", tmpCate = "",tmpPage= "", limit = "";
int startPage  = 0, endPage = 0, bsize = 10, ipp = 10, totalCount = 0, startCount = 0 ;
tmpCate = request.getParameter("cate"); 
if(tmpCate == null || tmpCate.equals(""))
{
	cate = 0;
}
else
{
	cate = Integer.valueOf(tmpCate);
	
}
keyword = request.getParameter("keyword");
if(keyword == null) keyword = "";
schkind = request.getParameter("schkind");
if(schkind == null) schkind = "";
tmpPage = request.getParameter("cpage");
if(tmpPage == null || tmpPage.equals(""))
{
	cpage = 1;
}
else
{
	cpage = Integer.valueOf(tmpPage);
}


limit = "limit "+ (cpage-1)*ipp + ", "+ ipp;
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
#contents_top
{
	position:relative;
	height:100px;
	width:1200px;
}
#left
{	
	margin-top:5px;
	position:relative;
	float:left;
}
#right
{
	margin-top:5px;
	position:relative;
	float:right;
}
.btn_ct
{
	margin:20px 5px;
	width:100px; 
	height:50px;
	color:#000; 
	background:#c1c1c1; 
	border:0;
}
#tb_list th, #tb_list td
{
	border-top:1px solid black;
	border-bottom:1px solid black;
}
</style>
<script>
function clickCate(cate)
{
	document.frm_search.cate.value = cate;
	document.frm_search.submit();
}

function check_all() 
{	
	var obj = document.getElementsByName("chk_all");
	var obj_a = document.getElementsByName("chk_sel");
	var isChk = obj[0].checked;

	for (var i = 0;i < obj_a.length ;i++ )
	{
		obj_a[i].checked = isChk;
		//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	}
}

function isDel()
{
	var obj = document.frm_list;
	var obj_a = document.getElementsByName("chk_sel");
	var chk = false;
		//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	if(confirm('[!!!!!!!!!!!!!!!!주의!!!!!!!!!!!!!!!]\n해당 상품 들을 정말 삭제 하시겠습니까? \n선택한 상품은 완전히 삭제 됩니다.'))
	{

		for(var i = 0 ; i < obj_a.length ; i++)
		{
			
			if(obj_a[i].checked)
			{
				chk = true;
			}
		}
		if(!chk)
		{
			alert("항목을 선택해주세요.");
		}
		else
		{
			obj.action = "product_proc.jsp";
			obj.wtype.value="del";
	 		obj.submit();
		}
	}
}

function modifyItem(idx)
{
	var obj = document.frm_list;
	//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	if(confirm('해당 상품을 입력한 정보대로 수정하시겠습니까?'))
	{
			obj.action = "product_proc.jsp";
			obj.wtype.value="partUp";
			obj.idx.value = idx;
	 		obj.submit();
	}
}


</script>
</head>
<body>
<div id="wrapper">
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	<%args = "&cate="+cate;%>
	<div id="contents">
	<!-- contents top 메뉴 영역 시작 -->
		<div id="contents_top">
			<span id="left">
				<input type="button" class="btn_ct" value="ALL" onclick="clickCate(0);" />
				<input type="button" class="btn_ct" value="로퍼" onclick="clickCate(1);" />
				<input type="button" class="btn_ct" value="구두" onclick="clickCate(2);" />
				<input type="button" class="btn_ct" value="워커" onclick="clickCate(3);" />
				<input type="button" class="btn_ct" value="운동화" onclick="clickCate(4);" />
				<input type="button" class="btn_ct" value="스니커즈" onclick="clickCate(5);" />
				<input type="button" class="btn_ct" value="샌들" onclick="clickCate(6);" />
			</span>
			<span id="right"><input type="button" class="btn_ct" value="상품등록" onclick="location.href='product_form.jsp?wtype=in';" /></span>
			
		</div>
		<!-- contents top 메뉴 영역 종료 -->
		<!-- product_list 영역 시작 -->
		<div id="product_list">
			<form action="" method="post" name="frm_list"  enctype="multipart/form-data">
				<input type="hidden" name="wtype" value="del" />
				<input type="hidden" name="idx" value="" />
				<table width="1200" id="tb_list" cellpadding="5" cellspacing="0" border="0">
					<tr>
					<th width="3%"><input type="checkbox" name="chk_all" id="chk_all" value="" onchange="check_all();" /></th>
					<th width="3%">No.</th>
					<th width="10%">Image</th>
					<th width="*">Subject</th>
					<th width="15%">Price</th>
					<th width="15%">적립금</th>
					<th width="10%">상태</th>
					<th width="3%">주문</th>
					<th width="3%">재고</th>
					<th width="3%">Best</th>
					<th width="3%">&nbsp;</th>
					</tr>
					<%
					
					try
					{	
						if(cate != 0)
						{
							where = " where pc_idx = "+ cate + " ";
						}
						Class.forName(driver);
						conn = DriverManager.getConnection(url, "root", "root");
						stmt = conn.createStatement();
						if((schkind != null && !schkind.trim().equals("")) && (keyword != null && !keyword.trim().equals("")))
						{
							if(cate != 0)
							{
								where += " and "+schkind +" like '%"+ keyword +"%' ";
								System.out.println(where);
							}
							else
							{
								where = " where " + schkind +" like '%"+ keyword +"%' ";
								System.out.println(where);
							}
							args ="&schkind="+schkind+"&keyword="+keyword;
						}
						sql = "select count(*) as cnt from product "+where;
						rs = stmt.executeQuery(sql);
						if(rs.next())
						{
							totalCount = rs.getInt("cnt");
							endPage = ( (totalCount -1) / ipp ) +1;
							
							startCount = totalCount - ((cpage - 1)*ipp);
						}
						rs.close();
						out.println("<input type='hidden' name='args' value='"+args+"'/>");
						sql = "select p_idx ,p_id as id, p_img, p_title, pc_idx, p_contact, p_rprice, p_point, p_stock, p_isview, p_best, (select count(*) as cnt from order_detail where p_id = id) as oCnt from product "+ where +" order by p_regdate desc " + limit;
						rs = stmt.executeQuery(sql);
						if(rs.next())
						{
							count = startCount;
							do
							{
								p_idx = rs.getInt("p_idx");
								p_id = rs.getString("id");
								p_img = rs.getString("p_img");
								p_title = rs.getString("p_title");
								p_contact = rs.getString("p_contact");
								p_rprice = rs.getInt("p_rprice");
								p_point = rs.getInt("p_point");
								p_stock = rs.getInt("p_stock");
								p_isview = rs.getInt("p_isview");
								p_best = rs.getString("p_best");
								oCnt = rs.getInt("oCnt");

								

					 %>
					<tr>
					<td><input type="checkbox" name="chk_sel" value="<%=p_idx %>"/></td>
					<td><%=count %></td>
					<td><a href="product_form.jsp?p_id=<%=p_id%>&wtype=up"><img src="../image/<%=p_img%>" width="100" height="120"></a></td>
					<td><a href="product_form.jsp?p_id=<%=p_id%>&wtype=up"><%=p_title %></a></td>
					<td><input type="text" name="p_rprice<%=p_idx %>" value="<%=p_rprice%>" /></td>
					<td><input type="text" name="p_point<%=p_idx %>" value="<%=p_point%>" /></td>
					<td>
					<select name="p_isview<%=p_idx %>">
						<option value="0" <%=(p_isview == 0) ? "selected='selected'" : "" %>>[상품 미게시]</option>
						<option value="1" <%=(p_isview == 1) ? "selected='selected'" : "" %>>[판매중]</option>
						<option value="2" <%=(p_isview == 2) ? "selected='selected'" : "" %>>[품절]</option>
						<option value="3" <%=(p_isview == 3) ? "selected='selected'" : "" %>>[재입고중]</option>
						<option value="4" <%=(p_isview == 4) ? "selected='selected'" : "" %>>[판매중단]</option>
					</select>
					</td>
					<td><%=oCnt %> 건</td>
					<td><%=p_stock %> 개</td>
					<td><input type="checkbox" name="p_best<%=p_idx %>" value="y" <%=(p_best.equals("y")) ? "checked='checked'" : "" %>/></td>
					<td><input type="button" value="수정" onclick="modifyItem(<%=p_idx%>)" /> </td>
					</tr>
					<%		
								count--;
							}while(rs.next());
						}
						else
						{
							out.println("<tr><td colspan='11'>해당하는 상품의 목록이 없습니다.</td></tr>");
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
				</table>
			</form>
			<!-- 페이징 시작 -->
			<div id = "num" class="brd">
			<%
			if(endPage < cpage)
			{
				out.println("<script>");
				out.println("location.href='product_list.jsp?cpage=1"+args+"';");
				out.println("</script>");
			}
			if(cpage != 1) 
			{%>
				<a href="product_list.jsp?cpage=1<%=args %>&ipp=<%=ipp%>">&lt;&lt;</a>
			<%}else{%>
			&lt;&lt;
			<%}
			
			if(cpage > 1) // 현재 페이지 번호가 1보다 크면(현재 페이지의 이전 페이지가 존재하면)
			{ %>
				<a href="product_list.jsp?cpage=<%=(cpage -1) + args %>&ipp=<%=ipp%>">&lt;</a>
			<%}
			else{%>
			&lt;
			<%}
			int spage = (cpage-1) / bsize * bsize +1;
			// 각 블록의 시작 페이지 번호 
			for (int i = spage ;i < spage+bsize && i <= endPage ; i++) // 시작 페이지 번호 부터 블록의 크기만큼 또는 마지막 페이지까지 루프를 돔
			{
				if(i != (cpage)) // 현재 페이지 번호가 아니면 
				{
					out.println("<a href='product_list.jsp?"+args+"&cpage="+i+"&ipp="+ipp+"'>"+i+"</a>");
				}
				else // 현재 페이지 번호 이면(링크를 생략하고 ,굵게 표현)
				{
					out.println("<b>["+i+"]</b>");	
				}
				
			}
			if(cpage < endPage) // 현재 페이지 번호가 마지막 페이지 번호 보다 작으면(현재 페이지의 다음 페이지가 존재하면)
			{ %>
				<a href="product_list.jsp?cpage=<%=(cpage + 1) + args %>&ipp=<%=ipp%>">&gt;</a>
			<%}
			else{%>
			&gt;
			<%}
			
			if(cpage != endPage){
			%>
			<a href="product_list.jsp?cpage=<%=endPage + args %>&ipp=<%=ipp%>">&gt;&gt;</a>
			<%}else{
				%>&gt;&gt;
			<%}%>
			
			
			</div>
			<!-- 페이징 끝 -->
			<!-- 검색 시작 -->
			<div id="contents_bottom">
				<form action="" method="get" name="frm_search">
				<input type="hidden" name="cpage" value="<%=cpage %>" />
				<input type="hidden" name="cate" value="<%=cate %>" />
				<table width="1200" height="80">
				<tr height="80">
				<td align="left">
				<select name="schkind">
					<option value="p_title">제목</option>
				</select>
				<input type="text" name="keyword" value="<%=keyword%>"/>
				<input type="submit" value="검색" />
				</td>
				<td align="right"><input type="button" class="btn_ct" value="선택 삭제" onclick="isDel();"/></td>
				</tr>
				</table>
				</form>
			</div>
			<!-- 검색 끝 -->
		</div>
		<!-- product_list 영역 종료 -->
	</div>
	
</div>
</body>
</html>