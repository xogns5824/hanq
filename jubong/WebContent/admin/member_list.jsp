<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String cate = "", keyword = "" ,schkind="", skeyword ="", limit="",tmpPage= ""; 
int bsize = 10, ipp = 10 , cpage = 1 , endPage = 0 ,memberNum =0;
int totalCount = 0,startCount = 0 ;
String ml_idx = "", ml_id= "" ,ml_phone = "", ml_joindate = "" , ml_name ="" ;
String member = "0" , now="0" ;
int ml_point = 0,ml_situ = 0,count =0; 
String member_kind = "", term = "";

member_kind = request.getParameter("member_kind");
if(member_kind == null) member_kind = "0";
term = request.getParameter("term");
if(term == null) term = "0";
tmpPage = request.getParameter("cpage");
if(tmpPage == null || tmpPage.equals(""))
{
	cpage=1;
}
else
{
	cpage = Integer.valueOf(tmpPage);
}
schkind = request.getParameter("schkind");
if(schkind == null) schkind = "";
keyword = request.getParameter("keyword");
if(keyword == null) keyword = "";

limit = "limit "+ (cpage-1)*ipp + ", "+ ipp;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
.b_list , .member_out {
	margin:20px 5px;
	width:100px; 
	height:50px;
	color:#000; 
	background:#c1c1c1; 
	border:0;
}

#member_search {
width:600px; text-align:center; font-size:0.8em;
}
</style>
<script>
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
	if(confirm('[!!!!!!!!!!!!!!!!주의!!!!!!!!!!!!!!!]\n해당 회원 들을 정말 삭제 하시겠습니까? \n선택한 회원은 완전히 삭제 됩니다.'))
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
			obj.action = "member_proc.jsp?";
			obj.wtype.value="del";
	 		obj.submit();
		}
	}
}
function  isUpblack(){
	var obj = document.frm_list;
	var obj_a = document.getElementsByName("chk_sel");
	var chk = false;
		//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	if(confirm('[!!!!!!!!!!!!!!!!주의!!!!!!!!!!!!!!!]\n해당 회원 들을 정말 블랙리스트 전환 하시겠습니까? \n선택한 회원 블랙리스트로 전환됩니다.'))
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
			obj.action = "member_proc.jsp";
			obj.wtype.value="re";
	 		obj.submit();
		}
	}
}
</script>
</head>
<body>
<div id="wrapper">
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	<br /><br />
	<div id="contents">
	<!-- 회원 조회 시작-->
	<form action="" method="get" name="frm_search">
	<table width="1200"  cellpadding="5" cellspacing="0" border="1" align="center">
		
		<tr>
			<td>회원 종류</td>&nbsp;
			<td>
			전체회원 회원<input type="radio" name ="member_kind"  <%=(member.equals("0")) ? "checked='checked'" : "" %> value="0" />
			일반회원<input type="radio" name ="member_kind"  <%=(member.equals("1")) ? "checked='checked'" : "" %> value="1" />
			블랙 리스트 회원<input type="radio" name ="member_kind"  <%=(member.equals("2")) ? "checked='checked'" : "" %> value="2" />
			탈퇴회원<input type="radio" name ="member_kind"  <%=(member.equals("3")) ? "checked='checked'" : "" %> value="3" />
			</td>
		</tr>
		<tr>
			<td>기간</td>&nbsp;
			<td>
				전체<input type="radio" name ="term" <%=(now.equals("0")) ? "checked='checked'" : "" %> value="0" />
				오늘<input type="radio" name ="term" <%=(now.equals("1")) ? "checked='checked'" : "" %> value="1" />
				1주<input type="radio" name ="term" <%=(now.equals("2")) ? "checked='checked'" : "" %> value="2" />
				1개월<input type="radio" name ="term" <%=(now.equals("3")) ? "checked='checked'" : "" %> value="3" />
				3개월<input type="radio" name ="term" <%=(now.equals("4")) ? "checked='checked'" : "" %> value="4" />
			</td>
		</tr>						
	</table>
	<br /><br /><br />
	<!-- 회원 조회 종료-->
	<!--  검색 조건 시작 -->
	<table width="1200"  cellpadding="5" cellspacing="0" border="0" align="left">
		<td align="left">
			<select name="schkind">
				<option value="ml_name">이름</option>
				<option value="ml_id">아이디</option>
				
			</select>
			<input type="text" name="keyword" value="<%=keyword%>"/>
			<input type="submit" value="검색" />
		</td>
		</table>
	</form>
	<!-- 검색 부분  종료--><br /><br /><br />
	<!--  회원 리스트 보여주기 시작 -->
		<div id="member_list">
			
			<form action="" method="post" name="frm_list">
				<input type="hidden" name="wtype" value="del" />
				<table width="1200" id="tb_list" cellpadding="5" cellspacing="0" border="1">
				
				<tr>
					<th><input type="checkbox" name="chk_all" id="chk_all" value="" onchange="check_all();" /></th>
					<th>회원번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>연락처</th>
					<th>보유포인트</th>
					<th>가입일</th>
					<th>회원상태</th>
					</tr>
				<% 
				try{
					
					Class.forName(driver);
					
					conn = DriverManager.getConnection(url, "root", "root");
					stmt = conn.createStatement();
					
					where = "where 1=1 ";
					if (!member_kind.equals("0")) {
						where += " and ml_situ = " + member_kind;
					}
					
					 if (term.equals("1")) {
						where += " and dayofyear(ml_joindate) = dayofyear(now()) "; // 오늘
					}else if(term.equals("2")){
						where += " and ml_joindate > date_add(now(), interval - 1 week) "; // 1주 전
					}else if(term.equals("3")){
						where += " and ml_joindate > date_add(now(), interval - 1 month) ";// 1개월 전
					}else if(term.equals("4")){
						where += " and ml_joindate > date_add(now(), interval - 3 month) "; //3개울전
					}
					
					if(!keyword.equals("")){// 검색어가 들어가 있으면
						where += " and " + schkind + " = '" + keyword + "' ";
					}
					
					

					sql = "select count(*) as cnt from member_list "+where;
					
					rs = stmt.executeQuery(sql);
					if(rs.next())
					{
						totalCount = rs.getInt("cnt");
						endPage = ( (totalCount -1) / ipp ) +1;
						startCount = totalCount - ((cpage - 1)*ipp);
					}
					rs.close();
					sql ="";
					sql = "select * from member_list "+ where +" "+limit;
					String situ="";
			
					
					
					
					
					
					rs = stmt.executeQuery(sql);
					if(rs.next()){

						count = startCount;
					
						do{
							ml_idx = rs.getString("ml_idx");
							ml_id = rs.getString("ml_id");
							ml_name = rs.getString("ml_name");
							ml_phone = rs.getString("ml_phone");
							ml_point = rs.getInt("ml_point");
							ml_joindate = rs.getString("ml_joindate");
							ml_situ = rs.getInt("ml_situ");
							
							if(situ != null || !situ.equals("")){
								switch(ml_situ){
								case 0 : situ = "관리자";
								break;
								case 1 : situ = "일반회원";
								break;
								case 2 : situ = "블랙리스트";
								break;
								case 3 : situ = "탈퇴회원";
								break;
								}
							}

							
					%>
					
					<tr>
					<td><input type="checkbox" name="chk_sel" value="<%=ml_id%>"/></td>
					<td><%=count %></td>
					<td><%=ml_name%></td>
					<td><a href="member_form.jsp?ml_id=<%=ml_id%>"><%=ml_id%></a></td>
					<td><%=ml_phone%></td>
					<td><%=ml_point%></td>
					<td><%=ml_joindate%></td>
					<td><%=situ%></td>
					</tr>		
					<% 
					count--;
					
						}while(rs.next());
					
					}
					}catch(Exception e) {
						out.println("<h3>DB작업에 실패하였습니다.</h3>");
						e.printStackTrace();
					} finally {
						// 사용된 객체 닫기
						try {
							rs.close();
							conn.close();
						} catch(Exception e) {
							e.printStackTrace();
						}
					}
					%>
				
				</table>
		<!-- 페이징 시작 -->
			<div id = "num" class="brd">
			<%if(cpage != 1) 
			{%>
				<a href="member_list.jsp?cpage=1<%=args%>&ipp=<%=ipp%>">&lt;&lt;</a>
			<%}else{%>
			&lt;&lt;
			<%}
			
			if(cpage > 1) // 현재 페이지 번호가 1보다 크면(현재 페이지의 이전 페이지가 존재하면)
			{ %>
				<a href="member_list.jsp?cpage=<%=(cpage -1) + args %>&ipp=<%=ipp%>">&lt;</a>
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
					out.println("<a href='member_list.jsp?"+args+"&cpage="+i+"&ipp="+ipp+"'>"+i+"</a>");
				}
				else // 현재 페이지 번호 이면(링크를 생략하고 ,굵게 표현)
				{
					out.println("<b>["+i+"]</b>");	
				}
				
			}
			if(cpage < endPage) // 현재 페이지 번호가 마지막 페이지 번호 보다 작으면(현재 페이지의 다음 페이지가 존재하면)
			{ %>
				<a href="member_list.jsp?cpage=<%=(cpage + 1) + args %>&ipp=<%=ipp%>">&gt;</a>
			<%}
			else{%>
			&gt;
			<%}
			
			if(cpage != endPage){
			%>
			<a href="member_list.jsp?cpage=<%=endPage + args %>&ipp=<%=ipp%>">&gt;&gt;</a>
			<%}else{
				%>&gt;&gt;
			<%}%>
			
			
			</div>
			<!-- 페이징 끝 -->
			</form>
				<table width="1200" border="0">
					<td align="right"><input type="button" class="b_list" value="블랙리스트" onclick="isUpblack();"/>
					<input type="button" class="member_out" value="회원 탈퇴" onclick="isDel();"/>
					</td>
				</table>	
		</div>
		<!--  회원 리스트 보여주기 종료 -->
	</div>
</div>
</body>
</html>