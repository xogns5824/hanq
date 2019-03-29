<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
String pid = "";
String best = "";
String lined = "";
String args = "";
String[] view = {"미게시","판매중","품절","재입고","판매중단"};
String cateTmp = request.getParameter("cate");

int cate = 1;
if(cateTmp != null)
{
	cate = Integer.valueOf(cateTmp);
}
args += "&cate="+cate;
String order ="";
lined = request.getParameter("lined");
if(lined != null && lined.equals("pd")) order = "p_rprice desc";
else if(lined != null && lined.equals("pa")) order = "p_rprice asc";
else if(lined != null && lined.equals("rd")) order = "p_regdate desc";
else if(lined != null && lined.equals("nd")) order = "p_title desc";
else order = "p_idx";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto; }
	#contents { font-size:0.8em; }
	#align { float:right; }
	#main_list { position:relative; font-size:0.8em; width:1200px; }
	#main_list td{ padding-top:20px; border:1px solid #c1c1c1; }
	#main_list a { color:black; text-decoration:none;}
	#main_list a:hover {}
	#main_list td:hover 
	{
	background-color:#eaeaea;
	}
	
</style>

</head>
<body>

<div id="wrapper">
	<!-- top -->
	<%@ include file="../include/inc_top.jsp" %>
	
	<!-- contents -->
	<div id="contents">
	<!-- Best -->
	<div id="product_best"><img src="../image/best_top2_best.gif" width="1198" alt="Weekly Best" /></div>
	<div id="main_list">
			<table width="1200">
			<%try
			{
				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				int clength = 0;
				String linkHead = "", linkTail = "";

				
				String src = "";

					sql ="select p_id, p_img, p_title, p_rprice, pc_title,p_best , p_stock,p_isview from product,product_category where product_category.pc_idx = product.pc_idx and  product.pc_idx = "+cate+"  and p_isview > 0  and p_isview < 4 order by p_best desc, p_isview limit 5";
					rs = stmt.executeQuery(sql);
					if(rs.next())
					{
						out.println("<tr><th colspan='5'><h1>"+ rs.getString("pc_title").toUpperCase() +"</h1></th></tr>");
						out.println("<tr>");
						do
						{
							pid = rs.getString("p_id");

							best = rs.getString("p_best");
							linkHead = "<a href='product_detail.jsp?pid="+pid+args+"&lined="+ lined +"'>";
							linkTail = "</a>";
							src = "../image/"+rs.getString("p_img");
							out.println("<td width='19%' align='center'>");
							out.println(linkHead +"<img src='"+ src +"' width='180' height='250' alt='상품이미지' /><br />");
							out.println(rs.getString("p_title")+  ((rs.getInt("p_stock") < 1) ? "<font color='red'>[품절]</font>":"") +"<br />");
							out.println(rs.getString("p_rprice")+ " 원" + linkTail);
							if(rs.getInt("p_isview") > 1) out.println("<br /><font color='red'>"+view[rs.getInt("p_isview")]+"상품</font>");
							if(best.equals("y")) out.println("<br /><span id=''><img src='../image/custom_105.gif' width='56' height='13' alt='best'/></span>");
							out.println("</td>");
						}while(rs.next());
					}
					else
					{
						out.println("<td><h1>인기 상품이 없습니다.</h1></td>");
					}
					rs.close();
					out.println("</tr>");
					out.println("</table>");
					%>
					<!-- Product List -->
					<div id="product_list">
					<img src="../image/best_top2_pro[1].gif" width="1200" alt="Product List" />
					<div id="align">
					<a href="product_list.jsp?lined=pa<%=args %>">낮은 가격순</a> | <a href="product_list.jsp?lined=pd<%=args %>">높은 가격순</a> | <a href="product_list.jsp?lined=rd<%=args %>">최신순</a> | <a href="product_list.jsp?lined=nd<%=args %>">이름순</a> 
					</div>
					<table width="1200">
					<%sql ="select p_id, p_img, p_title, p_rprice, pc_title, p_best, p_stock,p_isview from product,product_category where product_category.pc_idx = product.pc_idx and  product.pc_idx = "+cate+"  and p_isview > 0 and p_isview < 4 order by  p_isview, "+ order + " ";
					rs = stmt.executeQuery(sql);
					
					int count = 0;
					if(rs.next())
					{
						out.println("<tr>");
						do
						{
							pid = rs.getString("p_id");
							best = rs.getString("p_best");
							linkHead = "<a href='product_detail.jsp?pid="+pid+args+"&lined="+ lined +"'>";
							linkTail = "</a>";
							src = "../image/"+rs.getString("p_img");
							out.println("<td width='19%' align='center'>");
							out.println(linkHead +"<img src='"+ src +"' width='180' height='250' alt='상품이미지' /><br />");
							out.println(rs.getString("p_title") + ((rs.getInt("p_stock") < 1) ? "<font color='red'>[품절]</font>":"") +"<br />");
							out.println(rs.getString("p_rprice")+ " 원" + linkTail);
							if(rs.getInt("p_isview") > 1) out.println("<br /><font color='red'>"+view[rs.getInt("p_isview")]+"상품</font>");
							if(best.equals("y")) out.println("<br /><span id=''><img src='../image/custom_105.gif' width='56' height='13' alt='best'/></span>");
							out.println("</td>");
							count++;
							if(count % 5 == 0)
							{
								out.println("</tr><tr>");
							}
						}while(rs.next());
					}
					else
					{
						out.println("<td>상품이 없습니다.</td>");
					}
					rs.close();
					out.println("</tr>");
					out.println("</table>");%>
			
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