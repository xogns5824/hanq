<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int ma_idx = -1 , count = 0;
String isbasic ="";
String zip ="";
String addr1 ="";
String addr2 ="";
String title="",name="",phone="";
int basic = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#wrapper { width:1200px; margin:0 auto;}
	#contents { text-align:center; }
	#my_top { width:1200px; height:152px;}
	.addr_btn { width:130px; height:25px; background-color:#e8e8ff; border:1px solid #c1c1c1;color:black; margin-bottom:3px;}
	#modify { background-color:#5a5a5a; color:#fff; width:60px; }
	#addrList { width:1200px;}
	#addrList th { border-top:3px solid black; border-bottom:3px solid black; }
	#addrList td { border-bottom:1px solid black; }
	#btn_box { width:1200px; }
	#left { float:left; }
	#right { float:right; }
</style>
<script>
/* 상단의 체크박스를 클릭했을 때 발생되는 javascript 메소드 
 	체크박스가 체크되어있으면  하단의 모든 체크박스를 클릭해준다. 체크되어 있지않으면 모든 체크박스를 해제한다.*/
function check_all() 
{	
	var obj = document.getElementsByName("dIdx_admin");
	var obj_a = document.getElementsByName("dIdx");
	var isChk = obj[0].checked;

	for (var i = 0;i < obj_a.length ;i++ )
	{
		obj_a[i].checked = isChk;
		//체크박스 obj의 i인덱스에 해당하는 체크 박스의 선택 여부
	}
}

function isdel(frm)
{
	var obj_a = document.getElementsByName("dIdx");
	var chk = false;
	if(confirm("정말 삭제하시겠습니까?"))
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
			return false;
		}
		else
		{
		return true;
		}
	}
	else
	{
		return false;
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
	
	<!-- contents -->
	<div id="contents">
		<h1>ADDRESS</h1>
		<div id="my_top">
		<%@ include file="../include/inc_mypage.jsp" %>
		<%@ include file="../include/inc_myinfo.jsp" %>
		</div>
		<br /><br /><br /><br />
		<div id="addrList">
			<form name="frm_addr" action="addr_proc.jsp" onsubmit="return isdel(this);">
				<input type="hidden" name="wtype" value="del" />
				<table width="1200" cellpadding="0" cellspacing="0">
					<tr>
						<th width="5%"><input type="checkbox" name="dIdx_admin" value="" onchange="check_all();"/></th>
						<th width="8%">NO.</th>
						<th width="10%">TITLE</th>
						<th width="10%">NAME</th>
						<th width="10%">PHONE</th>
						<th width="10%">ISBASIC</th>
						<th width="*">ADDRESS</th>
						<th width="10%">MODIFY</th>
					</tr>
					<%
						try{
						Class.forName(driver);
						conn = DriverManager.getConnection(url, "root", "root");
						stmt = conn.createStatement();
		
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
								<td>
								<%if(isbasic.equals("n")){ %>
								<input type="checkbox" name="dIdx" value="<%=ma_idx %>" />
								<%} %>
								</td>
								<td height="60"><%=count %></td>
								<td><%=title %></td>
								<td><%=name %></td>
								<td><%=phone %></td>
								<td>
								<%=isbasic %>
								</td>
								<td>{<%=zip %>} <%=addr1+ ", " + addr2%></td>
								<td><input type="button" value="수정" class="addr_btn" id="modify" onclick="location.href='addr_form.jsp?wtype=up&ma_idx=<%=ma_idx %>'" /></td>
								</tr>
								<%
							}while(rs.next());
						}
						else
						{
							out.println("<tr><td colspan='8'>주소가 존재하지 않습니다.</td></tr>");
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
				<div id="btn_box">
					<span id="left"><input type="submit" value="선택 주소록 삭제" class="addr_btn"/></span>
					<span id="right"><input type="button" value="배송지 등록" class="addr_btn" onclick="location.href='addr_form.jsp?wtype=in'" /></span>
				</div>
			</form>
	</div>
	<!-- banner -->
	
	<%@ include file="../include/inc_banner.jsp" %>
	
	<!-- footer -->
	
	<%@ include file="../include/inc_footer.jsp" %>
</div>
</body>
</html>