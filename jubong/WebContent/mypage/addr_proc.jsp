<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/inc_header.jsp" %>

<%

int count = 0; // 주소록을 수정할 때 주소록을 추가주소록으로 바꿀려고 할 때 기본주소록의 개수를 셀 변수 
String isBasic  ="",zip="",addr1="",addr2="",title="",name="",p1="",p2="",p3="",pNum="";
// isBasic : 수정,삽입 할 때 추가주소로 할것인지 기본주소로 할 것인지를 결정하는 변수
String tmp_idx = request.getParameter("ma_idx");
int ma_idx = 0;
String[] dIdx = {};
// 주소록을 삭제하려고할 때 삭제할 주소가 여러개일 경우가 있으므로 해당 ma_dix값을  배열로 담아둘 변수
String wtype = request.getParameter("wtype");
if(wtype.equals("up") && (tmp_idx == null || tmp_idx.equals(""))) // wtype이 up인데 ma_idx값이 없을경우 수정이 불가하므로 addr_list.jsp로 튕김
{
	out.println("<script>");
	out.println("location.replace('addr_list.jsp');");
	out.println("</script>");
}
else if(wtype.equals("up") && tmp_idx != null) // wtype이 up인 상태에서 ma_idx 값을 가지고있으면 값이 정상적으로 들어온 것이므로 ma_idx 정수로 변환하여 담는다.
{
	ma_idx = Integer.valueOf(tmp_idx);
}
if(!wtype.equals("del")) // wtype이 del인경우에는 ma_idx 값 말고는 받아올 값이 없으므로 del 이 아닌 경우에만 추가, 수정에 필요한 값들을 가져온다.
{
	title = request.getParameter("title");
	name = request.getParameter("name");
	p1 = request.getParameter("phone1");
	p2 = request.getParameter("phone2");
	p3 = request.getParameter("phone3");
	zip = request.getParameter("zip");
	addr1 = request.getParameter("address1");
	addr2 = request.getParameter("address2");
	pNum = p1 + "-" + p2 + "-" + p3; 
	isBasic = request.getParameter("isBasic");
	if(isBasic.equals("") || isBasic == null)
	{
		isBasic = "n";
	}
}
else
{
	dIdx =request.getParameterValues("dIdx");
}


for (int i = 0 ; i < dIdx.length ; i++)
{
	if(i > 0 && i < dIdx.length)
	{
		where += " or ";
	}
	where += "ma_idx ="+ dIdx[i];

}
if(userId == null || userId.equals(""))
{
	out.println("<script>");
	out.println("location.replace('../member/login_form.jsp');");
	out.println("</script>");
}
if (wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.replace('my_main.jsp')");
	out.println("</script>");
}

if(zip == null || zip.equals("") || addr1 == null || addr1.equals("") || addr2 == null || addr2.equals(""))
{
	out.println("<script>");
	out.println("history.back();");
	out.println("</script>");
}

String msg = "";
String link ="";

try
{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "root");
	stmt = conn.createStatement();
	/* 주소록 추가 */
	/* 
		isBasic이 y인 경우
		1. 먼저 모든 ma_isbasic의 값을 n으로 변경한다.(ma_isbasic이 중복되는 것을 방지하기 위함)
		2. 그 후 입력받은 값들을 가지고 insert문을 실행 (ma_isbasic은 y로 함)
		
		isBasic이 n인 경우
		1. 입력받은 값들을 가지고 insert문 실행(ma_isbasicc은 n으로함)(isBasic은 y가 중복될 일이 없기 때문에 일을 두번하지 않아도됨)
	*/
	if(wtype.equals("in"))
	{
		
		if(isBasic.equals("y"))
		{
			sql = "update member_addr set ma_isbasic = 'n' where ma_isbasic = 'y' and ml_id='"+ userId +"'";
		}
		else if(isBasic.equals("") || isBasic.equals("n"))
		{
			sql = "insert into member_addr (ml_id,ma_title,ma_name,ma_phone,ma_zip,ma_addr1,ma_addr2) values ('"+ userId +"','"+ title +"','"+ name +"','"+ pNum +"','"+ zip +"','"+ addr1 +"','"+ addr2 +"')";
		}
	}
	/* 주소록 수정 */
	/*
		isBasic이 y인 경우
		1. 먼저 모든 ma_isbasic의 값을 n으로 변경한다.
		2. 일력받은 값들을 가지고 update문을 실행 (ma_isbasic은 y로 함)
		
		isBasic이 n인 경우
		1. 입력받은 값들으 가지고 update문을 실행 (ma_isbasic은 n으로 함)
		2. isBasic이 y인 레코드가 있는지 검사
		3. 있으면 addr_list.jsp로 이동
		3-2. 없으면 해당 ma_idx를 제외하고 한 레코드를 가져와 ma_isbasic을 y로 변경 (자신을 제외한 아무 레코드나 가져와서 기본 주소로 한다는 말임)
	*/
	else if(wtype.equals("up"))
	{
		if(isBasic.equals("y"))
		{
			sql = "update member_addr set ma_isbasic = 'n' where ma_isbasic = 'y' and ml_id = '"+ userId +"'";
		}		
		else if(isBasic.equals("") || isBasic.equals("n"))
		{
			sql = "update member_addr set ma_title = '"+ title +"', ma_name ='"+ name +"', ma_phone = '"+ pNum +"', ma_zip ='"+ zip +"', ma_addr1 = '"+ addr1 +"', ma_addr2 = '"+ addr2 +"' , ma_isbasic = 'n' where ma_idx ="+ma_idx;
		}
	}
	/* 주소록 삭제 */
	/* 체크한 모든 주소록을 가지고 삭제를 실행 */
	else if(wtype.equals("del"))
	{
		sql = "delete from member_addr where "+where;
	}
	/* 추가주소로 변경 (사용 x)*/
	else if(wtype.equals("bs"))
	{
		sql = "update member_addr set ma_isbasic = 'n' where ma_isbasic = 'y'";
	}
	result = stmt.executeUpdate(sql);
	if(result != 0)
	{
		if(wtype.equals("in"))
		{
			if(isBasic.equals("y"))
			{
				sql = "insert into member_addr (ml_id,ma_title,ma_name,ma_phone,ma_zip,ma_addr1,ma_addr2,ma_isbasic) values ('"+ userId +"','"+ title +"','"+ name +"','"+ pNum +"','"+ zip +"','"+ addr1 +"','"+ addr2 +"','y')";
				result = stmt.executeUpdate(sql);
				if(result != 0)
				{
					out.println("<script>");
					out.println("location.replace('addr_list.jsp');");
					out.println("</script>");
				}
			}
			else if(isBasic.equals("") || isBasic.equals("n"))
			{
				out.println("<script>");
				out.println("location.replace('addr_list.jsp');");
				out.println("</script>");
			}
		}
		else if(wtype.equals("up"))
		{
			if(isBasic.equals("y"))
			{
				sql = "update member_addr set ma_title = '"+ title +"', ma_name ='"+ name +"', ma_phone = '"+ pNum +"', ma_zip ='"+ zip +"', ma_addr1 = '"+ addr1 +"', ma_addr2 = '"+ addr2 +"', ma_isbasic='y' where ma_idx ="+ma_idx;
				result = stmt.executeUpdate(sql);
				if(result != 0)
				{
					out.println("<script>");
					out.println("location.replace('addr_list.jsp');");
					out.println("</script>");
				}
			}
			else if(isBasic.equals("") || isBasic.equals("n"))
			{

				rs = stmt.executeQuery("select count(ma_idx) as cnt from member_addr where ma_isbasic = 'y' and ml_id = '"+ userId +"'");
				if(rs.next())
				{                   
					count = rs.getInt("cnt");
				}
				rs.close();
				if(count < 1)
				{
					sql = "update member_addr set ma_isbasic = 'y' where ml_id = '"+ userId +"' and ma_isbasic = 'n' and ma_idx != "+ ma_idx + " limit 1";
					result = stmt.executeUpdate(sql);
					if(result != 0)
					{
						out.println("<script>");
						out.println("location.replace('addr_list.jsp');");
						out.println("</script>");
					}
					else
					{	
						sql = "update member_addr set ma_isbasic = 'y' where ma_idx = "+ ma_idx;
						result = stmt.executeUpdate(sql);
						out.println("<script>");
						out.println("location.replace('addr_list.jsp');");
						out.println("</script>");
						
					}
				}					
				else
				{	
					out.println("<script>");
					out.println("location.replace('addr_list.jsp');");
					out.println("</script>");
					
				}
			}
		}
		else if(wtype.equals("del"))
		{
			out.println("<script>"); 
			out.println("location.replace('addr_list.jsp');");
			out.println("</script>");
		}
		
	}
	else
	{		
		
		if(wtype.equals("in"))
		{
			sql = "insert into member_addr (ml_id,ma_title,ma_name,ma_phone,ma_zip,ma_addr1,ma_addr2,ma_isbasic) values ('"+ userId +"','"+ title +"','"+ name +"','"+ pNum +"','"+ zip +"','"+ addr1 +"','"+ addr2 +"','y')";
			result = stmt.executeUpdate(sql);
			if(result != 0)
			{
				out.println("<script>");
				out.println("location.replace('addr_list.jsp');");
				out.println("</script>");
			}
		}
		else if(wtype.equals("up"))
		{
			if(isBasic.equals("y"))
			{
				sql = "update member_addr set ma_title = '"+ title +"', ma_name ='"+ name +"', ma_phone = '"+ pNum +"', ma_zip ='"+ zip +"', ma_addr1 = '"+ addr1 +"', ma_addr2 = '"+ addr2 +"', ma_isbasic='y' where ma_idx ="+ma_idx;
				result = stmt.executeUpdate(sql);
				if(result != 0)
				{
					out.println("<script>");
					out.println("location.replace('addr_list.jsp');");
					out.println("</script>");
				}
			}
		}

		
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
		stmt.close();
		conn.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
%>