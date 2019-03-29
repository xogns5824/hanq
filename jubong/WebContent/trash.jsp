<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String[] qtype = {"","상품문의","배송문의","환불/교환문의","결제문의","포인트문의","회원문의"};
String tmpQtype = "", qKeyword = "", rKeyword = "",schkind_qna ="", schkind_review = "", args="", rwhere = "", qwhere = "";
int pb_qtype = 0;
String pb_type = "",pb_title = "", pb_writer = "", pb_contents ="", pb_date = "";
int pb_idx = 0,pb_read = 0;
tmpQtype = request.getParameter("pb_qtype");
qKeyword = request.getParameter("qKeyword");
if(qKeyword == null) qKeyword ="";
rKeyword = request.getParameter("rKeyword");
if(rKeyword == null) rKeyword ="";
schkind_qna = request.getParameter("schkind_qna");
if(schkind_qna == null) schkind_qna ="";
schkind_review = request.getParameter("schkind_review");
if(schkind_review == null) schkind_review ="";

String tmpIpp = request.getParameter("ipp");
String tmprPage = request.getParameter("rpage");
String tmpqPage = request.getParameter("qpage");

int ipp = 10;
int rTotalPage = 1, qTotalPage =1;
if(tmpIpp != null)
{
	ipp = Integer.valueOf(tmpIpp);
}
int rpage = 1,qpage = 1, bsize = 10, rStartRow = 0, qStartRow = 0;
if(tmprPage == null || tmprPage.trim().equals(""))
{
	rpage = 1;
}
else
{
	rpage = Integer.valueOf(tmprPage);
}
if(tmpqPage == null || tmpqPage.trim().equals(""))
{
	qpage = 1;
}
else
{
	qpage = Integer.valueOf(tmpqPage);
}

rStartRow = (rpage-1) * ipp;
qStartRow = (qpage-1) * ipp;

String rPaging = "limit "+ rStartRow +" , "+ipp;
String qPaging = "limit "+ qStartRow +" , "+ipp;

args += "&qKeyword="+qKeyword;	
args += "&rKeyword="+rKeyword;
args += "&schkind_qna="+schkind_qna;
args += "&schkind_review="+schkind_review;
if(tmpQtype == null || tmpQtype.equals(""))
{
	pb_qtype = 0;
}
else
{
	pb_qtype = Integer.valueOf(tmpQtype);
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
	#myBoardList { width:1200px;}
	#myBoardList th { border-top:3px solid black; border-bottom:3px solid black; }
	#myBoardList td { border-bottom:1px solid black; }
	#type { float:left; margin-bottom:3px; }
	#qna, #review { position:relative; }
	#schreview, #schqna { width:1200px; text-align:left; }
</style>
<script>
function chnType(val,args)
{
	location.replace("myboard_list.jsp?pb_qtype="+val+args);	
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
		<h1>MY BOARD</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<div id="myBoardList">
			<div id="qna">
			<h2>Q&A</h2>
			<form name="frm_category">
					<select name="pb_qtype" id="type" onchange="chnType(this.value,'<%=args%>');">
						<option value="0" <%=(pb_qtype == 0) ? "selected='selected'" : "" %> >분류</option>
						<option value="1" <%=(pb_qtype == 1) ? "selected='selected'" : "" %>>상품문의</option>
						<option value="2" <%=(pb_qtype == 2) ? "selected='selected'" : "" %>>배송문의</option>
						<option value="3" <%=(pb_qtype == 3) ? "selected='selected'" : "" %>>환불/교환 문의</option>
						<option value="4" <%=(pb_qtype == 4) ? "selected='selected'" : "" %>>결제문의</option>
						<option value="5" <%=(pb_qtype == 5) ? "selected='selected'" : "" %>>포인트 문의</option>
						<option value="6" <%=(pb_qtype == 6) ? "selected='selected'" : "" %>>회원문의</option>
					</select>
				</form>
				<table width="1200" class ="tb_myBoardList" cellpadding="0" cellspacing="0">
				<tr>
					<th width="10%">NO</th>
					<th width="8%">CATEGORY</th>
					<th width="*">SUBJECT</th>
					<th width="10%">WRITER</th>
					<th width="10%">DATE</th>
					<th width="10%">HIT</th>
				</tr>
				<%
				try
				{
					int rCount = 0, qCount = 0;
					Class.forName(driver);
					conn = DriverManager.getConnection(url, "root", "root");
					stmt = conn.createStatement();
					
					if(pb_qtype > 0) 
					{
						qwhere = " and pb_qtype = "+ pb_qtype;
					}
					
					if(schkind_qna != null && qKeyword != null &&!schkind_qna.trim().equals("") && !qKeyword.trim().equals(""))
					{
						qwhere += " and "+schkind_qna+ " like '%"+ qKeyword+"%' ";
					}
					else 
					{ 	
						schkind_qna ="";
						qKeyword ="";
					}

					rs = stmt.executeQuery("select count(*) as cnt from product_board where pb_type = 'q' "+ qwhere);
					if(rs.next())
					{
						qTotalPage = ((rs.getInt("cnt")-1 )/ ipp) +1; 
						out.println(qTotalPage);
						qCount = rs.getInt("cnt");
					}
					rs.close();
					
					sql = "select pb_idx, pb_type,pb_qtype,pb_title, pb_writer, pb_contents, pb_read,pb_date from product_board where pb_type = 'q' and ml_id = '"+userId+"' "+ qwhere +" order by pb_idx desc "+ qPaging;
					rs =stmt.executeQuery(sql);
					qCount = qCount - qStartRow;
					if(rs.next())
					{
	
		
						do
						{
							pb_idx = rs.getInt("pb_idx");
							pb_type = rs.getString("pb_type");
							pb_qtype = rs.getInt("pb_qtype");
							pb_title = rs.getString("pb_title");
							pb_writer = rs.getString("pb_writer");
							pb_contents  = rs.getString("pb_contents");
							pb_read = rs.getInt("pb_read");
							pb_date = rs.getString("pb_date").substring(0,11);
						%>
						<tr>
						<td height="40" ><%=qCount %></td>
						<td><%=qtype[pb_qtype] %></td>
						<td align="left"><a href="../board/board_view.jsp?pb_idx=<%=pb_idx%>"><%=(pb_title.length() > 25)? pb_title.substring(0,25)+"..." : pb_title  %></a></td>
						<td><%=pb_writer %></td>
						<td><%=pb_date %></td>
						<td><%=pb_read %></td>
						
					</tr>
					
					<%

						qCount--;
						}while(rs.next());
						
					}
					else
					{
						out.println("<tr><td colspan='6'>등록한 게시물이 없습니다.</td></tr>");
					}
	
					rs.close();
					%>
					</table>

					<div id="schqna">
						<form action ="" name="frm_schqna" >
						<input type="hidden" name="rKeyword" value="<%=rKeyword%>"/>
						<input type="hidden" name="schkind_review" value="<%=schkind_review%>"/>
						<input type="hidden" name="pb_qtype" value="<%=pb_qtype%>"/>
						<input type="hidden" name="qpage" value="<%=qpage%>"/>
						<input type="hidden" name="rpage" value="<%=rpage%>"/>
						<select name="schkind_qna">
							<option value="pb_title">제목</option>
						</select>
						<input type="text" name="qKeyword" value="<%=qKeyword %>" />
						<input type="submit" value="검색" />
						</form>
					</div>
					<div id = "num" class="brd">
<%if(qpage != 1) 
{%>
	<a href="free_list.jsp?cpage=1<%=args %>&ipp=<%=ipp%>">&lt;&lt;</a>
<%}else{%>
&lt;&lt;
<%}

if(qpage > 1) // 현재 페이지 번호가 1보다 크면(현재 페이지의 이전 페이지가 존재하면)
{ %>
	<a href="free_list.jsp?cpage=<%=(qpage -1) + args %>&ipp=<%=ipp%>">&lt;</a>
<%}
else{%>
&lt;
<%}
int spage = (qpage-1) / bsize * bsize +1;
// 각 블록의 시작 페이지 번호 
for (int i = spage ;i < spage+bsize && i <= spage+rTotalPage ; i++) // 시작 페이지 번호 부터 블록의 크기만큼 또는 마지막 페이지까지 루프를 돔
{
	if(i != (qpage)) // 현재 페이지 번호가 아니면 
	{
		out.println("<a href='free_list.jsp?"+args+"&qpage="+i+"&ipp="+ipp+"'>"+i+"</a>");
	}
	else // 현재 페이지 번호 이면(링크를 생략하고 ,굵게 표현)
	{
		out.println("<b>["+i+"]</b>");
	}
	
}
if(qpage < rTotalPage) // 현재 페이지 번호가 마지막 페이지 번호 보다 작으면(현재 페이지의 다음 페이지가 존재하면)
{ %>
	<a href="free_list.jsp?cpage=<%=(qpage + 1) + args %>&ipp=<%=ipp%>">&gt;</a>
<%}
else{%>
&gt;
<%}

if(qpage != rTotalPage){
%>
<a href="free_list.jsp?cpage=<%=rTotalPage + args %>&ipp=<%=ipp%>">&gt;&gt;</a>
<%}else{
	%>&gt;&gt;
<%}%>
</div>
					</div>
					<br/>
					<div id="review">
					<h2>REVIEW</h2>
					<table width="1200" class ="tb_myBoardList" cellpadding="0" cellspacing="0">
					<tr>
						<th width="10%">NO</th>
						<th width="8%">CATEGORY</th>
						<th width="*">SUBJECT</th>
						<th width="10%">WRITER</th>
						<th width="10%">DATE</th>
						<th width="10%">HIT</th>
					</tr>
					<%
						rCount = 0;
						
						if(!schkind_review.equals("") && !rKeyword.equals(""))
						{
							rwhere = " and "+schkind_review+ " like '%"+ rKeyword +"%' ";
						}
						else 
						{ 	
							rwhere = "";
							schkind_review ="";
							rKeyword ="";
						}
					
						sql = "select pb_idx, pb_type,pb_qtype,pb_title, pb_writer, pb_contents, pb_read,pb_date from product_board where pb_type = 'r' and ml_id = '"+userId+"' "+ rwhere +" order by pb_idx desc";
						rs =stmt.executeQuery(sql);
	
						if(rs.next())
						{
	
			
							do
							{
								rCount ++;
								pb_idx = rs.getInt("pb_idx");
								pb_type = rs.getString("pb_type");
								pb_qtype = rs.getInt("pb_qtype");
								pb_title = rs.getString("pb_title");
								pb_writer = rs.getString("pb_writer");
								pb_contents  = rs.getString("pb_contents");
								pb_read = rs.getInt("pb_read");
								pb_date = rs.getString("pb_date").substring(0,11);
							%>
							<tr>
							<td height="40" ><%=rCount %></td>
							<td><%=pb_qtype %></td>
							<td align="left"><a href="../board/board_view.jsp?pb_idx=<%=pb_idx%>"><%=pb_title%></a></td>
							<td><%=pb_writer %></td>
							<td><%=pb_date %></td>
							<td><%=pb_read %></td>
							
						</tr>
					<%
				
						}while(rs.next());
						
					}
					else
					{
						out.println("<tr><td colspan='6'>등록한 게시물이 없습니다.</td></tr>");
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
			
				<div id="schreview">
				<form action ="" name="frm_schrivew">
				<input type="hidden" name="qKeyword" value="<%=qKeyword%>"/>
				<input type="hidden" name="schkind_qna" value="<%=schkind_qna%>"/>
				<input type="hidden" name="pb_qtype" value="<%=pb_qtype%>"/>
				<select name="schkind_review">
					<option value="pb_title">제목</option>
				</select>
				<input type="text" name="rKeyword" value="<%=rKeyword %>" />
				<input type="submit" value="검색" />
				</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>