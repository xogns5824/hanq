<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    

String p_id = "",p_title="",p_best ="n", p_img ="", p_contact ="";
ArrayList<int[][]> optionList = new ArrayList<int[][]>();
ArrayList<String> po_color = new ArrayList<String>();
String[] arrSize = {"250","255","260","265","270","275","280"};
int[][] option = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};
int pc_idx = 0, p_price = 0, p_rprice = 0, p_point = 0 , p_isview = 0, p_delivery = 0,po_stock=1, po_size = 0, o_count = 1,blCnt = 0,reCnt = 0,yeCnt = 0, whCnt = 0,brCnt = 0, cnt = 0;
String wtype="";
wtype = request.getParameter("wtype");
if(wtype == null || wtype.equals(""))
{
	out.println("<script>");
	out.println("location.href='product_list.jsp';");
	out.println("</script>");
}
else if(wtype.equals("up"))
{
	p_id = request.getParameter("p_id");
	if(p_id == null || p_id.equals(""))
	{
		out.println("<script>");
		out.println("location.href='product_list.jsp';");
		out.println("</script>");
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#wrapper { width:1200px; margin:0 auto; }
#contents { width:1200px; text-align:center; font-size:0.8em; }
#contents h2 { float:left; }
#top 
{ 
	position:relative;
	width:1200px; 
	padding-left:20px; 
	text-align:center;
	border:1px solid #c1c1c1;
}
#tb_productEnroll .first
{
	border-top:1px solid #000;
}
#tb_productEnroll td, #tb_productEnroll th
{
	border-bottom:1px solid #000;
	
}

#tb_productEnroll th
{
}

#tb_productEnroll .enroll_controll,#tb_productEnroll .enroll_input 
{
	width:250px;
	border:1px solid black;
}

.enroll_input
{
	background:#FFECB4;
}

#p_contact
{
	overflow:auto;
	resize:none;
}

#product_option th, #product_option td
{
	height:30px;
	border-bottom:1px solid #c1c1c1;
	border-top:1px solid #c1c1c1;
	
}
#product_option th
{
	background:#c1c1c1;
}

#product_option #add_option
{
	background : #353535;
	color:#BDBDBD;
	border-radius:5px;
	border:1px solid black;
	height:25px;
}
#btn_area
{
	width:1200px;
	height:500px;
}
#btn_area #left
{
	float:left;
}
#center .btn_center
{
	margin-top:50px;
	height:50px;
	width:150px;	
	font-size:1.7em;
	font-weight:bold;
	
}

.btn_center#ok
{
	color:#000;
	background:#fff;
	border:1px solid #c1c1c1;
}

.btn_center#cancel
{
	color:#fff;
	background:#000;
	border:1px solid #c1c1c1;
}

</style>
<script src="../js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function() {
	var o_count = document.frm_product.o_count.value;
	var html = "";
	
	/* 이미지 미리보기 */
	$("#pImg").change( function() {
		var output = document.getElementById('image');
		var image = document.getElementById('pImg');
		if( $("#pImg").val() != "" )
		{
			var ext = $('#pImg').val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				return;
			}
			readURL(image);
		}
		else
		{
			output.src = "../image/none.a";
		}
	});
	
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
	              $('#image').attr('src', e.target.result);
            }

          reader.readAsDataURL(input.files[0]);
        }
    }	
});

function clickBox(obj)
{
	if(obj.value == 0)
	{
		obj.value = "";
	}
}

function blurBox(obj)
{
	if(obj.value=="")
	{
		obj.value= "0";
	}
}

function inputChk(frm)
{
	var p_title = frm.p_title.value.trim();
	var pc_idx = frm_pc_idx.value;
	var p_rprice = frm.price.value;
	if(p_title == "")
	{
		alert("상품명을 입력해주세요.");
		frm.p_title.focus();
		return false;
	}
	else if(pc_idx == 0)
	{
		alert("상품 카테고리를 선택해주세요.");
		return false;
	}
	else if(p_rprice == "")
	{
		alert("판매가를 입력해주세요.");
		frm_p_rprice.focus();
		return false;
	}
	else
	{
		return false;
	}
}

var n1 = "", n2 = "", n3 = "", n4 = "";
function chkNum(obj,val)
{
	var Number = val.value;
	
	if (isNaN(Number))
	{
		if(obj == 1)
		{
			val.value=n1;
		}
		else if(obj == 2)
		{
			val.value=n2;
		}
		else if(obj == 3)
		{
			val.value=n3;
		}
		else if(obj == 4)
		{
			val.value=n4;
		}
		val.focus();
	}
	if(obj == 1)
	{
		n1 = val.value;
	}
	else if(obj == 2)
	{
		n2 = val.value;
	}
	else if(obj == 3)
	{
		n3 = val.value;
	}
	else if(obj == 4)
	{
		n4 = val.value;
	}
}
</script>
</head>
<body>
<div id="wrapper">
	<div id="top"><%@ include file="inc_top.jsp" %></div>
	<div id="contents">
	<form action="product_proc.jsp" method="post" name="frm_product"  onsubmit="return dasd(this.form);" enctype="multipart/form-data" >
	<!-- 
	상품 등록 폼 영역 기능
	1. wtype 이 in 일경우에는 컨트롤 들이 모두 비어있고, up일 경우 해당하는 상품의 값으로 채워짐.
	2. 시중가,판매가,적립금,배송비 등은 숫자만 입력가능
	3. 찾아보기에서는 이미지 파일만 선택할 수 있음
	4. 이미지에는 찾아보기를 이용하여 선택한 사진 파일이 뜸.
	5. 상품명,상품 상세 설명을 입력하지 않으면 '상품명, 상품 설명은 필수 입력 사항입니다.' 문구가 출력된다.
	 -->
	
	<%
	try
	{				
		Class.forName(driver);
		conn = DriverManager.getConnection(url, "root", "root");
		stmt = conn.createStatement();
		sql = "select p_title, pc_idx, p_point, p_isview, p_img, p_contact, p_price, p_rprice, p_delivery , p_best , ";
		sql += "(select sum(if(po_color = 'black', 1, 0)) from product_option where p_id ='"+ p_id +"' )as blCnt, ";
		sql += "(select sum(if(po_color = 'red', 1, 0)) from product_option where p_id ='"+ p_id +"' )as reCnt, ";
		sql += "(select sum(if(po_color = 'yellow', 1, 0)) from product_option where p_id ='"+ p_id +"' )as yeCnt, ";
		sql += "(select sum(if(po_color = 'white', 1, 0)) from product_option where p_id ='"+ p_id +"' )as whCnt, ";
		sql += "(select sum(if(po_color = 'brown', 1, 0)) from product_option where p_id ='"+ p_id +"' )as brCnt, ";
		sql += "(select count(distinct(po_color)) from product_option where p_id = '"+ p_id +"') as cnt "; 
		sql += "from product where p_id = '"+ p_id +"'";
	 	System.out.println("sql = "+sql);
	 	if(wtype.equals("up"))
	 	{
		 	rs = stmt.executeQuery(sql);
		 	if(rs.next())
		 	{
		 		p_title = rs.getString("p_title");
		 		pc_idx = rs.getInt("pc_idx");
		 		p_point = rs.getInt("p_point");
		 		p_isview = rs.getInt("p_isview");
		 		p_img = rs.getString("p_img");
		 		p_contact = rs.getString("p_contact");
		 		p_price = rs.getInt("p_price");
		 		p_rprice = rs.getInt("p_rprice");
		 		p_delivery = rs.getInt("p_delivery");
		 		blCnt = rs.getInt("blCnt");
		 		reCnt = rs.getInt("reCnt");
		 		yeCnt = rs.getInt("yeCnt");
		 		whCnt = rs.getInt("whCnt");
		 		brCnt = rs.getInt("brCnt");
				o_count = rs.getInt("cnt");
				p_best = rs.getString("p_best");
		 	}
		 	rs.close();
		 	int count = 0;
		 	sql ="select po_color from product_option where p_id = '"+p_id+"' group by po_color";
		 	rs = stmt.executeQuery(sql);
		 	
		 	if(rs.next())
		 	{
		 		do
		 		{
		 			po_color.add(rs.getString("po_color"));
		 			count++;
		 		}while(rs.next());
		 	}
		 	rs.close();
		 	for(int i = 0 ; i < o_count ; i++)
		 	{
			 	for(int a = 0 ; a < 2 ; a++)
			 	{
			 		for(int b = 0 ; b < 7; b++)
			 		{
			 			option[a][b] = 0;
			 		}
			 	}
			 	sql = "select po_size, po_stock "; 
			 	sql += "from product_option where p_id = '"+ p_id +"' and po_color = '"+ po_color.get(i) +"' group by po_size,po_color ";
			 	rs = stmt.executeQuery(sql);
			 	if(rs.next())
			 	{
			 		do
			 		{
			 			for(int k = 0; k < 7 ; k++)
			 			{
			 				System.out.println(arrSize[k] + ","+ rs.getString("po_size"));
			 				if(arrSize[k].equals(rs.getString("po_size")))
			 				{
			 					option[0][k] = 1;
								option[1][k] = rs.getInt("po_stock");
			 				}
			 			}
			 			
			 		}while(rs.next());
				 
			 	}
			 	optionList.add(i, new int[][]{{option[0][0],option[0][1],option[0][2],option[0][3],option[0][4],option[0][5],option[0][6]},{option[1][0],option[1][1],option[1][2],option[1][3],option[1][4],option[1][5],option[1][6]}});
			 	rs.close();
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
				rs.close();
				stmt.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	%>
	<!-- 수정폼에서 이미지 파일을 선택하지 않으면 원래의 이미지파일을 넘겨 주기 위함 -->
	<input type="hidden" name="upImg" value="<%=p_img %>" />
	<input type="hidden" name="up_title" value="<%=p_title %>" />
	<input type="hidden" name="up_rprice" value="<%=p_rprice %>" />
	<input type="hidden" name="up_pcidx" value="<%=pc_idx %>" />	
	<input type="hidden" name="wtype" value="<%=wtype %>" />
	<input type="hidden" name="p_id" value="<%=p_id %>" />
	<input type="hidden" name="o_count" id="o_count" value="<%=o_count %>" />
	<!-- 상품 등록 폼 영역 시작 -->
	<div id="product">
	<h2><%=(wtype != null && wtype.equals("in")) ? "상품 등록" : "상품 수정" %></h2>
	<table width="1200" id="tb_productEnroll" cellpadding="5" cellspacing="0">
	<tr>
	<th width="20%" class="first">상품명</th><td align="left" width="*" class="first"><input type="text" class="enroll_input" name="p_title" value="<%=p_title%>" /></td>
	</tr>
	<tr>
		<th width="20%">카테고리</th>
		<td align="left" width="*">
			<select name="pc_idx" class="enroll_controll">
				<option value="0">카테고리 선택</option>
				<option value="1" <%=(pc_idx == 1) ? "selected='selected'" : "" %>>로퍼</option>
				<option value="2" <%=(pc_idx == 2) ? "selected='selected'" : "" %>>구두</option>
				<option value="3" <%=(pc_idx == 3) ? "selected='selected'" : "" %>>워커</option>
				<option value="4" <%=(pc_idx == 4) ? "selected='selected'" : "" %>>운동화</option>
				<option value="5" <%=(pc_idx == 5) ? "selected='selected'" : "" %>>스니커즈</option>
				<option value="6" <%=(pc_idx == 6) ? "selected='selected'" : "" %>>샌들</option>
			</select>
		</td>
	</tr>
	<tr>
		<th width="20%">시중가</th><td align="left" width="*"><input type="text" class="enroll_input" name="p_price" id="p_price" value="<%=p_price%>" onclick="clickBox(this);" onblur="blurBox(this);" onkeyup="chkNum(1,this);"/> 원</td>
	</tr>
	<tr>
		<th width="20%">판매가</th><td align="left" width="*"><input type="text" class="enroll_input" name="p_rprice" id="p_rprice" value="<%=p_rprice%>" onclick="clickBox(this);" onblur="blurBox(this);" onkeyup="chkNum(2,this);"/> 원</td>
	</tr>
	<tr>
		<th width="20%">적립금</th><td align="left" width="*"><input type="text" class="enroll_input" name="p_point" id="p_point" value="<%=p_point%>" onclick="clickBox(this);" onblur="blurBox(this);" onkeyup="chkNum(3,this);"/> point</td>
	</tr>
	<tr>
		<th width="20%">게시여부</th>
		<td align="left" width="*">
		<select name="p_isview" class="enroll_controll">
			<option value="0" <%=(p_isview == 0) ? "selected='selected'" : "" %>>미게시</option>
			<option value="1" <%=(p_isview == 1) ? "selected='selected'" : "" %>>판매</option>
			<option value="2" <%=(p_isview == 2) ? "selected='selected'" : "" %>>품절</option>
			<option value="3" <%=(p_isview == 3) ? "selected='selected'" : "" %>>재입고중</option>
			<option value="4" <%=(p_isview == 4) ? "selected='selected'" : "" %>>판매종료</option>
		</select>
		</td>	
	</tr>
	<tr>
		<th width="20%">Best 여부</th>
		<td align="left" width="*">
		<input type="radio" id="y" name="p_best" value="y" <%=(p_best.equals("y")) ? "checked='checked'" : "" %> /><label for="y">인기 상품</label>
		<input type="radio" id="n" name="p_best" value="n" <%=(p_best.equals("n")) ? "checked='checked'" : "" %> /><label for="n">기본 상품</label>
		</td>
	</tr>
	<tr>
		<th width="20%">배송비</th><td align="left" width="*"><input type="text" class="enroll_input" name="p_delivery" id="p_delivery" value="<%=p_delivery%>" onclick="clickBox(this);" onblur="blurBox(this);" onkeyup="chkNum(4,this);"/></td>
	</tr>
	<tr>
		<th width="20%">이미지</th>
		<td align="left" width="*">
			<%
			if(p_img == null || p_img.equals("")) p_img ="none.gif";
			%>
			<img src="../image/<%=p_img %>" id="image" width="200" height="250"alt="상품 이미지" /><br/>
			<input type="file" name="pImg" id="pImg" value="<%=p_img%>" accept=".gif, .jpg, .png" />
			
		</td>
	</tr>
	<tr>
		<th width="20%">상품상세설명</th>
		<td align="left" width="*">
		<textarea name="p_contact" id="p_contact" cols="132" rows="20" placeholder="상품 설명을 입력해주세요."><%=p_contact %></textarea>
		</td>
	</tr>
	</table>
	</div>
	<!-- 상품 등록 폼 영역 종료 -->
	<br />
	<br />
	
	<!-- 
	상품  옵션 영역 기능
	1. wtype이 up일 경우 해당 상품의 옵션들을 불러와 화면에 뿌려줌.(이때 po_idx를 가지고 있어야 함)
	2. 상단의 체크박스를 누를경우 모든 체크박스가 체크 되어야 함.
	3. 선택 삭제를 누를경우 체크박스에 체크가 되어있는 것이 하나라도 있으면 해당 옵션을 삭제함.(아직 DB에서 삭제하는 것은 아님), 하나도 체크가 되어있지 않은 경우에는 '삭제할 항목을 체크해주세요.' 라는문구를 출력해줌.
	4. 색상은 중복 생성이 불가능. 색상이 중복 선택되었을 경우 '색상은 중복 생성이 불가능 합니다.' 라는 문구를 출력한 후 색상의 옵션을 Default 값으로 되돌림
	5. 색상은 드래그 해서 여러개를 선택 하거나 ctrl+마우스 왼쪽 클릭을 이용해 여러개 클릭이 가능
	6. 옵션 추가 버튼을 클릭하면 바로 아래쪽에 옵션을 입력할 수 있는 칸이 출력됨
	6. 모든 값을 입력한 후 ok 버튼을 클릭했을 경우 입력한 상품의 값과 옵션의 값들이 product_proc.jsp 로 넘아감
	7. 사이즈마다 재고량을 설정해 줄 수 있어야 함.
	8. 재고량은 기본적으로 보이지 않고, 체크박스에 해당하는 값이 체크되어 있는 경우  재고량을 입력할 수 있는 칸이 생성된다.
	9. 체크박스와 재고량은 체크된 값 만을 전송한다.
	 -->
	<!-- 상품 옵션 등록 폼 영역 시작 -->
	<div id="product_option">
	<h2>옵션</h2>
	<table width="1200" border="0" cellpadding="0" cellspacing="0" id="tb_area">
	<tr><th>No.</th><th>색상</th><th>사이즈</th><th>재고량</th><th><input type="button" name="add_option" id="add_option" value="옵션 추가"/></th></tr>
	<tbody>
	<%
	
	if(o_count > 0 && wtype.equals("up"))
	{
		System.out.println(o_count);
		for(int i = 0 ; i < o_count ; i++)
		{
		%>
		<tr>
			<td width="5%"><%=i+1 %></td>
	
			<td width="20%">
				<select name="po_color<%=i+1 %>" class="color" id="po_color<%=i+1%>">
					<option value="">---색상 선택---</option>
					<option value="black" <%=po_color.get(i).equals("black") ? "selected='selected'" : "" %>>black</option>
					<option value="red" <%=po_color.get(i).equals("red") ? "selected='selected'" : "" %>>red</option>
					<option value="yellow" <%=po_color.get(i).equals("yellow") ? "selected='selected'" : "" %>>yellow</option>
					<option value="white" <%=po_color.get(i).equals("white") ? "selected='selected'" : "" %>>white</option>
					<option value="brown" <%=po_color.get(i).equals("brown") ? "selected='selected'" : "" %>>brown</option>
				</select>
			</td>
			<td width="*">
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>1" value="250" <%=optionList.get(i)[0][0] == 1 ? "checked='checked'" : "" %> /><label for="po_size<%=i+1 %>1">[250]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>2" value="255" <%=optionList.get(i)[0][1] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>2">[255]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>3" value="260" <%=optionList.get(i)[0][2] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>3">[260]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>4" value="265" <%=optionList.get(i)[0][3] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>4">[265]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>5" value="270" <%=optionList.get(i)[0][4] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>5">[270]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>6" value="275" <%=optionList.get(i)[0][5] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>6">[275]</label>
				<input type="checkbox" name="po_size<%=i+1 %>" id="po_size<%=i+1 %>7" value="280" <%=optionList.get(i)[0][6] == 1 ? "checked='checked'" : "" %>/><label for="po_size<%=i+1 %>7">[280]</label>
			</td>
			<td width="10%">
			[250] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>1" value="<%=optionList.get(i)[1][0] %>" maxlength="5" size="5" /><br />
			[255] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>2" value="<%=optionList.get(i)[1][1] %>" maxlength="5" size="5" /><br />
			[260] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>3" value="<%=optionList.get(i)[1][2] %>" maxlength="5" size="5" /><br />
			[265] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>4" value="<%=optionList.get(i)[1][3] %>" maxlength="5" size="5" /><br />
			[270] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>5" value="<%=optionList.get(i)[1][4] %>" maxlength="5" size="5" /><br />
			[275] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>6" value="<%=optionList.get(i)[1][5] %>" maxlength="5" size="5" /><br />
			[280] : <input type="text" name="po_stock<%=i+1 %>" id="po_stock<%=i+1 %>7" value="<%=optionList.get(i)[1][6] %>" maxlength="5" size="5" /><br />
			</td>
			<td width="10%"><input type="checkbox" name="chk_sel" id="chk_sel" value="1"/></td>
		</tr>
		<%
		}
	}
	else
	{
		o_count = 1;
	%>
		<tr>
		<td width="5%"><%=o_count %></td>

		<td width="20%">
			<select name="po_color1" class="color" id="po_color1">
				<option value="">---색상 선택---</option>
				<option value="black" selected="selected">black</option>
				<option value="red" >red</option>
				<option value="yellow">yellow</option>
				<option value="white">white</option>
				<option value="brown">brown</option>
			</select>
		</td>
		<td width="*">
			<input type="checkbox" name="po_size1" id="po_size11" value="250" checked="checked"/><label for="po_size11">[250]</label>
			<input type="checkbox" name="po_size1" id="po_size12" value="255" checked="checked"/><label for="po_size12">[255]</label>
			<input type="checkbox" name="po_size1" id="po_size13" value="260" checked="checked"/><label for="po_size13">[260]</label>
			<input type="checkbox" name="po_size1" id="po_size14" value="265" checked="checked"/><label for="po_size14">[265]</label>
			<input type="checkbox" name="po_size1" id="po_size15" value="270" checked="checked"/><label for="po_size15">[270]</label>
			<input type="checkbox" name="po_size1" id="po_size16" value="275" checked="checked"/><label for="po_size16">[275]</label>
			<input type="checkbox" name="po_size1" id="po_size17" value="280" checked="checked" /><label for="po_size17">[280]</label>
		</td>
		<td width="10%">
		[250] : <input type="text" name="po_stock1" id="po_stock11" maxlength="5" size="5" value="30" /><br />
		[255] : <input type="text" name="po_stock1" id="po_stock12" maxlength="5" size="5" value="30" /><br />
		[260] : <input type="text" name="po_stock1" id="po_stock13" maxlength="5" size="5" value="30" /><br />
		[265] : <input type="text" name="po_stock1" id="po_stock14" maxlength="5" size="5" value="30" /><br />
		[270] : <input type="text" name="po_stock1" id="po_stock15" maxlength="5" size="5" value="30" /><br />
		[275] : <input type="text" name="po_stock1" id="po_stock16" maxlength="5" size="5" value="30" /><br />
		[280] : <input type="text" name="po_stock1" id="po_stock17" maxlength="5" size="5" value="30" /><br />
		</td>
		<td width="10%"><input type="checkbox" name="chk_sel" id="chk_sel" value="1"/></td>
	</tr>
	<%
	}

	
	%>
	</tbody>
	</table>
	
	</div>
	<!-- 상품 옵션 등록 폼 영역 종료 -->
	<!-- 상품 등록 버튼 영역 시작 -->
	<div id="btn_area">
	<span id="left">
	<input type="button" name="chk_del" id="chk_del" value="선택 삭제" onclick="chkDel(this.form);" />
	</span>
	<span id="center">
	<input type="submit" class="btn_center" id="ok" value="OK" />
	<input type="button" class="btn_center" id="cancel" value="CANCEL" onclick="location.href='product_list.jsp';" />
	</span>
	</div>
	<!-- 상품 등록 버튼 영역 종료 -->
	
	</form>
	</div>
</div>
<script>
/* 옵션 추가 */
 o_count = <%=o_count%> ;
$("#add_option").click(function () {
	o_count++;
	if(o_count < 6)
	{
		html = "";
		html += "<tr><td>"+o_count+"</td><td>&nbsp;";
		html += "<select name='po_color"+ o_count +"' class='color' id='po_color"+ o_count +"'><option value=''>---색상 선택---</option>&nbsp;";
		html += "<option value='black'>black</option>&nbsp;";
		html += "<option value='red'>red</option>&nbsp;";
		html += "<option value='yellow'>yellow</option>&nbsp;";
		html += "<option value='white'>white</option>&nbsp;";
		html += "<option value='brown'>brown</option>&nbsp;";
		html += "</select>&nbsp;";
		html += "</td>&nbsp;";
		html += "<td>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"1' value='250' /><label for='po_size"+ o_count +"1'>[250]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"2' value='255' /><label for='po_size"+ o_count +"2'>[255]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"3' value='260' /><label for='po_size"+ o_count +"3'>[260]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"4' value='265' /><label for='po_size"+ o_count +"4'>[265]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"5' value='270' /><label for='po_size"+ o_count +"5'>[270]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"6' value='275' /><label for='po_size"+ o_count +"6'>[275]</label>&nbsp;";
		html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"7' value='280' /><label for='po_size"+ o_count +"7'>[280]</label>&nbsp;";
		html += "</td>&nbsp;";
		html += "<td>";
		html += "[250] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"1' value='0' maxlength='5' size='5' /><br />";
		html += "[255] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"2' value='0' maxlength='5' size='5' /><br />";
		html += "[260] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"3' value='0' maxlength='5' size='5' /><br />";
		html += "[265] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"4' value='0' maxlength='5' size='5' /><br />";
		html += "[270] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"5' value='0' maxlength='5' size='5' /><br />";
		html += "[275] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"6' value='0' maxlength='5' size='5' /><br />";
		html += "[280] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"7' value='0' maxlength='5' size='5' /><br /></td>&nbsp;";
		html += "<td><input type='checkbox' name='chk_sel' id='chk_sel' value='"+ o_count +"'/></td>&nbsp;";
		html += "</tr>&nbsp;";
		$("#tb_area > tbody:last").append(html);
		
		document.frm_product.o_count.value = o_count;
	}
	else
	{
		alert('옵션 추가는 5개 까지만 가능합니다.');
	}
});

/*
옵션 삭제
- 삭제하지 않을 옵션의 값을 저장
- 모든 옵션제거
- 삭제 하지 않을 옵션을 다시 출력
(product_proc.jsp로 값을 보낼 때 name값이 혼동 되지 않도록 다시 재정렬 하여 보냄)
*/
function chkDel(frm)
{
	var obj = frm.chk_sel;	
	var count = 0;
	var customerId = new Array();
	var colorValue = new Array();
	var sizeValue = new Array();
	var stockValue = new Array();
	for(var i = 0 ; i < obj.length ; i++)
	{
		sizeValue[i] = new Array(0,0,0,0,0,0,0);
		colorValue[i] = new Array(0,0,0,0,0);
		stockValue[i] = new Array(0,0,0,0,0,0,0);
		if(!obj[i].checked)
		{
			var sel = document.getElementById('po_color'+(i+1));
			colorValue[count] = sel.options[sel.selectedIndex].value;
			for(var j = 0 ; j < 7 ; j++)
			{
				if(document.getElementsByName('po_size'+(i+1))[j].checked)
				sizeValue[count][j] = 1;
				stockValue[count][j] = $('#po_stock'+(((i+1)*10)+(j+1))).val();
			}
			count++;
		}
	}
	
	if(count != 0)
	{
		$("#tb_area > tbody:last").children().remove();
		o_count = 0;
		for(var i = 0 ; i < count ; i++)
		{
			o_count++;
			html = "";
			html += "<tr><td width='5%'>"+o_count+"</td><td>&nbsp;";
			html += "<select name='po_color"+ o_count +"' class='color' id='po_color"+ o_count +"'><option value=''>---색상 선택---</option>&nbsp;";
			html += "<option value='black' "+ (colorValue[i] == 'black' ? "selected='selected'" : "") +" >black</option>&nbsp;";
			html += "<option value='red' "+ (colorValue[i] == 'red' ? "selected='selected'" : "") +" >red</option>&nbsp;";
			html += "<option value='yellow' "+ (colorValue[i] == 'yellow' ? "selected='selected'" : "") +" >yellow</option>&nbsp;";
			html += "<option value='white' "+ (colorValue[i] == 'white' ? "selected='selected'" : "") +" >while</option>&nbsp;";
			html += "<option value='brown' "+ (colorValue[i] == 'brown' ? "selected='selected'" : "") +" >brown</option>&nbsp;";
			html += "</select>&nbsp;";
			html += "</td>&nbsp;";
			html += "<td>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"1' value='250' "+ ((sizeValue[i][0] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"1'>[250]</label>";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"2' value='255' "+ ((sizeValue[i][1] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"2'>[255]</label>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"3' value='260' "+ ((sizeValue[i][2] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"3'>[260]</label>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"4' value='265' "+ ((sizeValue[i][3] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"4'>[265]</label>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"5' value='270' "+ ((sizeValue[i][4] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"5'>[270]</label>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"6' value='275' "+ ((sizeValue[i][5] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"6'>[275]</label>&nbsp;";
			html += "<input type='checkbox' name='po_size"+ o_count +"' id='po_size"+ o_count +"7' value='280' "+ ((sizeValue[i][6] == 1) ? "checked='checked'" : "") +" /><label for='po_size"+ o_count +"7'>[280]</label>&nbsp;";
			html += "</td>&nbsp;";
			html += "<td>";
			html += "[250] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"1' value='"+ stockValue[i][0] +"' maxlength='5' size='5' /><br />";
			html += "[255] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"2' value='"+ stockValue[i][1] +"' maxlength='5' size='5' /><br />";
			html += "[260] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"3' value='"+ stockValue[i][2] +"' maxlength='5' size='5' /><br />";
			html += "[265] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"4' value='"+ stockValue[i][3] +"' maxlength='5' size='5' /><br />";
			html += "[270] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"5' value='"+ stockValue[i][4] +"' maxlength='5' size='5' /><br />";
			html += "[275] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"6' value='"+ stockValue[i][5] +"' maxlength='5' size='5' /><br />";
			html += "[280] : <input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"7' value='"+ stockValue[i][6] +"' maxlength='5' size='5' /><br /></td>&nbsp;";
			//html += "<input type='text' name='po_stock"+ o_count +"' id='po_stock"+ o_count +"' value='"+ stockValue[i] +"' maxlength='5' size='5' /></td>&nbsp;";
			html += "<td><input type='checkbox' name='chk_sel' id='chk_sel' value='"+ o_count +"'/></td>&nbsp;";
			html += "</tr>&nbsp;";
			$("#tb_area > tbody:last").append(html);	
			document.frm_product.o_count.value = o_count;
		}
	}
}

</script>
</body>
</html>
