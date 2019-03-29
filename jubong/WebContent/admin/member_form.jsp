<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
String ml_id= "" , ml_pwd = "" ,ml_name = "" , ml_phone = "" , ml_birth="", ml_email = "",ml_email1 = "" , ml_email2 = "";
String ml_phone1 = "", ml_phone2 ="", ml_phone3="",pointadd="" ,ml_point ="";
int  ml_situ = 0 ;
String ml_joindate = "";
int cyear = 0 , cmonth = 0, cday = 0 ;
int ma_idx = -1 , count = 0;
String isbasic ="";
String zip ="";
String addr1 ="";
String addr2 ="";
String title="",name="",phone="";
int basic = 0;



String userId = request.getParameter("ml_id");
String mpDate="",o_id ="",mpContent="",mpState="";

String[] strSitu = {"포인트상태","적립","사용"};
String situ = request.getParameter("situ");

if(situ == null || situ.equals(""))
{
	situ = "n";
}
if(pointadd == null || pointadd.equals(""))
{
	pointadd = "y";
}

int point = 0;
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
		padding-left:20px; 
		text-align:center;
		border:1px solid #c1c1c1;
	}

	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center; }
	#my_top { width:1200px; height:152px;}
	.addr_btn { width:130px; height:25px; background-color:#e8e8ff; border:1px solid #c1c1c1;color:black; margin-bottom:3px;}
	#modify { background-color:#5a5a5a; color:#fff; width:60px; }
	#addrList ,#memberList{ width:1200px;}
	#addrList th { border-top:3px solid black; border-bottom:3px solid black; }
	#addrList td { border-bottom:1px solid black; }
	#btn_box { width:1200px; }
	#left { float:left; }
	#right { float:right; }




	#wrapper { width:1200px; margin:0 auto;}
	#contents { margin-bottom:50px;text-align:center; }
	#my_top { width:1200px; height:152px;}
	#pointList { width:1200px; margin-bottom:20px;}
	#tb_pointList th ,#pointList_Add th{ border-top:3px solid black; border-bottom:3px solid black; }
	#tb_pointList td ,#pointList_Add td{ border-bottom:1px solid black; }
	
	#situ { float:left; margin-bottom:3px; }
	.b_list , .member_out {
	margin:20px 5px;
	width:100px; 
	height:50px;
	color:#000; 
	background:#c1c1c1; 
	border:0;
}
	
	
</style>
<script>
	function  update(){
		var obj = document.memberList;
		
				obj.action = "member_proc.jsp";
				obj.wtype.value="update";
		 		obj.submit();
	
	}

	function chnSitu(val)
	{	
		var obj = document.frm_situ;


		obj.action = "member_form.jsp";
 		obj.submit();
	}
	function select(obj)
	{
		obj_t = document.getElementById("email2");
		
		obj_t.value = obj.value;
		
		if(obj.value != "")
		{
			obj_t.disabled = true;
		}
		else if(obj.value == "")
		{
			obj_t.disabled = false;
		}
		
		
	}
</script>
</head>
<body>
<div id="wrapper">
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	<div id="contents">
	

			<%
			try
			{

				Class.forName(driver);
				conn = DriverManager.getConnection(url, "root", "root");
				stmt = conn.createStatement();
				
				sql = "select * from member_list where ml_id = '"+ userId +"' ";
				rs = stmt.executeQuery(sql);
				
				if(rs.next()){
					ml_name = rs.getString("ml_name"); 
					ml_id = rs.getString("ml_id"); 
					ml_pwd = rs.getString("ml_pwd");
					ml_point = rs.getString("ml_point");
					ml_phone = rs.getString("ml_phone"); 
					ml_phone1 = ml_phone.substring(0,3);
					ml_phone2 = ml_phone.substring(4,ml_phone.lastIndexOf("-"));
					ml_phone3 = ml_phone.substring(ml_phone.lastIndexOf("-")+1,ml_phone.length());
					ml_email = rs.getString("ml_email"); 
					ml_email1 =  ml_email.substring(0,ml_email.lastIndexOf("@"));
					ml_email2 = ml_email.substring(ml_email.lastIndexOf("@")+1 ,ml_email.length());
					ml_joindate = rs.getString("ml_joindate");
					cyear = Integer.valueOf(rs.getString("ml_birth").substring(0,4));  // 올해의 년도
					cmonth = Integer.valueOf(rs.getString("ml_birth").substring(5,7)); // 현재 월
					cday = Integer.valueOf(rs.getString("ml_birth").substring(8,10));  // 현재 일
					
					ml_situ = rs.getInt("ml_situ");
					
				}else
				{
					out.println("<tr><td colspan='8'>회원이 존재하지 않습니다.</td></tr>");
				}
				%>
			<h1>회원정보</h1>
	
			<br /><br /><br /><br />
			<div id="memberList">
			<form action="member_proc.jsp" name ="memberList"/>
				<input type="hidden" name="wtype" value="" />
				<input type="hidden" name="ml_id" value="<%=ml_id %>" />
				<table width="700" cellpadding="5" cellspacing="0" border="1" align="center">
					<tr>
						<td width="30%">이름</td><td><input type="text" value="<%=ml_name %>" name="name"/></td>
					</tr>
					<tr>
						<td>보유 포인트</td><td><%=ml_point %></td>
					</tr>
					<tr>
						<td width="">아이디</td><td><%=ml_id %></td>
					</tr>
					<tr>
						<td width="">비밀번호</td><td><input type="password" value="<%=ml_pwd %>"  name="pwd"/></td>
					</tr>
					<tr >
						<td >전화번호</td>
						<td >
							<select  name ="p1">
								<option value="010" <%=ml_phone1.equals("010") ? "selected='selected'":"" %>>010</option>
								<option value="011" <%=ml_phone1.equals("011") ? "selected='selected'":"" %>>011</option>
								<option value="016" <%=ml_phone1.equals("016") ? "selected='selected'":"" %>>016</option>
								<option value="019" <%=ml_phone1.equals("019") ? "selected='selected'":"" %>>019</option>
							</select> -
							<input type="text" size="5" maxlength="4" name ="p2" value="<%=ml_phone2 %>"/> -
							<input type="text" size="5" maxlength="4" name ="p3" value="<%=ml_phone3 %>"/>
						</td>
					</tr>
					<tr >
						<td >생년월일</td>
						<td >
						 <!-- 1930 ~ 올해 -->
						 <select name="b1" >
						 
						<%
						String slt = ""; // 선택상태 여부
						
						for (int i = 1930 ; i <= cyear ; i++) {
						 slt = (i == cyear) ? " selected='selected'" : "";
						 out.println("<option value='" + i + "' " + slt + " >" + i + "</option>");
						}
						%>
						 </select>년
						 <select  name="b2" id="b2">
						<%
						String str = "";
						for (int i = 1 ; i <= 12 ; i++) {
						 str = (i < 10) ? "0" + i : i + "";
						 slt = (i == cmonth) ? " selected='selected'" : "";
						 out.println("<option value='" + i + "' " + slt + " >" + str + "</option>");
						}
						%>
						 </select>월
						 <select  name="b3" id="b3">
						<%
						str = "";
						for (int i = 1 ; i <= 31 ; i++) {
						 str = (i < 10) ? "0" + i : i + "";
						 slt = (i == cday) ? " selected='selected'" : "";
						 out.println("<option value='" + i + "' " + slt + " >" + str + "</option>");
						}
						%>
						 </select>일
						</td>
					</tr>

					<tr >
					<th >이메일</th>
						<td >
							<input type="text" size="20" name ="email1" value="<%=ml_email1 %>"/> @
							<input type="text" size="20" name="email2" value="<%=ml_email2 %>"/>
							<select name="mail" id="mail" onchange="select(this);" >
								<option value="">직접입력</option>
								<option value="naver.com">네 이 버</option>
								<option value="nate.com">다음</option>
								<option value="gmail.com">구글</option>
							</select>&nbsp;&nbsp;
							
						</td>
					</tr>
						<tr>
							<td width="">가입일</td><td><%=ml_joindate%></td>
						</tr>
					<tr >
						<td>회원상태</td>
						<td >
							<input type="radio" name="situ"  value="0" <%=ml_situ == 0 ? "checked='checked'": "" %>/>관리자
							<input type="radio" name="situ"  value="1" <%=ml_situ == 1  ? "checked='checked'": "" %>/>일반회원
							<input type="radio" name="situ"  value="2" <%=ml_situ == 2 ? "checked='checked'": "" %>/>블랙리스트
							<input type="radio" name="situ"  value="3" <%=ml_situ == 3  ? "checked='checked'": "" %>/>탈퇴회원
						</td>
					</tr>
				</table>
			</form>
			</div>
			<h1>ADDRESS</h1>
	
			<br /><br /><br /><br />
			<div id="addrList">
			
				<table width="1200" cellpadding="0" cellspacing="0">
					<tr>
						<th width="8%">NO.</th>
						<th width="10%">TITLE</th>
						<th width="10%">NAME</th>
						<th width="10%">PHONE</th>
						<th width="10%">ISBASIC</th>
						<th width="*">ADDRESS</th>
						
					</tr>
				<%
				sql = "select ma_idx,ma_title,ma_phone,ma_name,ma_isbasic,ma_zip,ma_addr1,ma_addr2 from member_addr where ml_id = '"+ userId +"' order by ma_isbasic desc";
				// 화면에 주소록 리스트 뿌려줄 sql문
				rs = stmt.executeQuery(sql);
				if(rs.next())
				{
					do{		
						ma_idx = rs.getInt("ma_idx");
						title = rs.getString("ma_title");
						name = rs.getString("ma_name");
						phone = rs.getString("ma_phone");
						isbasic =rs.getString("ma_isbasic");
				 		zip = rs.getString("ma_zip");
						addr1 = rs.getString("ma_addr1");
						addr2 = rs.getString("ma_addr2");
						if(isbasic.equals("y"))
						{
							basic = 1;
						}
						else if(isbasic.equals("n"))
						{
							basic = 0;
						}
						count++;
						%>
						<tr>
					
						<td height="60"><%=count %></td>
						<td><%=title %></td>
						<td><%=name %></td>
						<td><%=phone %></td>
						<td>
						<%=isbasic %>
						</td>
						<td>{<%=zip %>} <%=addr1+ ", " + addr2%></td>
						
						</tr>
			</div>
						<%
					}while(rs.next());
				}
				else
				{
					out.println("<tr><td colspan='8'>주소가 존재하지 않습니다.</td></tr>");
				}
			
				
				%>
				</table>
				<h1>MY POINT</h1>

			<br /><br /><br /><br />
			<div id="pointList" >
			<form action="member_proc.jsp" >
			<input type="hidden" name="wtype" value="point" />
			<input type="hidden" name="ml_id" value="<%=userId%>" />
				<table width="1200" cellpadding="5" cellspacing="0" id ="pointList_Add">
					<tr><th>적립날짜</th><th>POINT</th><th>상세내용</th><th>포인트 상태</th><th></th></tr>
					<tr><td>현재시간</td><td><input type="text" name ="point" /></td><td><input type="text" name ="content" /></td>
					<br />
					<td>
						<select name="state" id="state" >
							<option value="u" <%=(pointadd.equals("u")) ? "selected='selected'" : ""%>>사용</option>
							<option value="y" <%=(pointadd.equals("y")) ? "selected='selected'" : ""%>>적립</option>
						</select>
					</td>
					<td><input type="submit" value="추가" /></td>
					</tr>
				</table>
			</form>
			<br /><br />
			<form name="frm_situ">
			<input type="hidden" name="ml_id" value="<%=userId%>" />
				<select name="situ" id="situ" onchange="chnSitu(this.value);">
					<option value="n" <%=(situ.equals("n")) ? "selected='selected'" : ""%>>포인트상태</option>
					<option value="u" <%=(situ.equals("u")) ? "selected='selected'" : ""%>>사용</option>
					<option value="y" <%=(situ.equals("y")) ? "selected='selected'" : ""%>>적립</option>
				</select>
			</form>
			<table width="1200"id ="tb_pointList" cellpadding="0" cellspacing="0">
			<tr>
				<th width="10%"class="first_column">적립날짜</th>
				<th width="8%">POINT</th>
				
				<th width="*">상세내용</th>
				<th width="10%" class="last_column">포인트 상태</th>
			</tr>
			
				<% 
				if(situ.equals("n")) 
				{
					sql = "select mp_date, mp_point, o_id, mp_content, mp_state from member_point where ml_id = '"+userId+"' order by mp_date desc";
				}
				else
				{
					sql = "select mp_date, mp_point, o_id, mp_content, mp_state from member_point where ml_id = '"+userId+"' and mp_state ='"+ situ +"' order by mp_date desc";
				}

				rs =stmt.executeQuery(sql);

				if(rs.next())
				{

	
					do
					{			
						mpDate = rs.getString("mp_date");
						mpDate = mpDate.substring(0,mpDate.indexOf(" "));
						point = rs.getInt("mp_point");
						o_id = rs.getString("o_id");
						mpContent = rs.getString("mp_content");
						mpState = rs.getString("mp_state");
					%>
					<tr>
					<td height="80" class="first_column"><%=mpDate %></td>
					<td><%=point %></td>
					<td><%=mpContent %>(주봉샵)</td>
					<td class="last_column"><%=mpState%></td>
					
				</tr>
						
				</div>
	
	
				<%
			
					}while(rs.next());
					
				}
				else
				{
					out.println("<tr><td colspan='5'>포인트 사용/적립 내역이 없습니다.</td></tr>");
				}
				rs.close();
				out.println("</table>");
				
			}
		catch(Exception e)
		{
			e.printStackTrace();
			out.println("<script>");
			out.println("location.href='member_list.jsp'");
			out.println("</script>");
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
				out.println("<script>");
				out.println("location.href='member_list.jsp'");
				out.println("</script>");
			}
		}
		%>
		<table width="1200" border="1">
			<td align="right"><input type="button" class="b_list" value="수정(OK)" onclick="update();"/>
			<input type="button" class="member_out" value="취소" onclick="location.href='member_list.jsp'"/>
			</td>
		</table>	
	</div>
	</div>
</div>
</body>
</html>