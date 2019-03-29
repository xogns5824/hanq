<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="./include/inc_header.jsp" %>

<%
String keyword = request.getParameter("keyword");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<style>
body { margin: 0px; text-align:center; }
#main_list { position:relative; font-size:0.8em; width:1200px; }
#main_list td{ padding-top:20px; border:1px solid #c1c1c1;}
#main_list a { color:black; text-decoration:none;}
#main_list a:hover { color:#dddddd; }
#main_list td:hover 
{
	color:#dddddd;
	background-color:#ffffdf;
}
#wrapper { width:1200px; margin:0 auto;}
#contents { 
	position:relative; 
	width:1200px; 
	margin:0 auto; 
	margin-bottom:50px;
	 }
#top_box { 
	position:relative; 
	width:1200px; 
	margin:0 auto; 
	height:200px; 
	border: 1px solid #c1c1c1;
}
#btn_box { width:1190px; height:30px;  padding:5px;  }
.btn { background-color:white;  padding:5px 10px 5px 10px; width:80px; }
#btn_box #left { float:left;  }
#btn_box #right { float:right;  }
#logo { position:relative; text-align:center;}
#category { 
	position:absolute; 
	top:72%;
	width:1200px;
	border-top:1px solid #c1c1c1;
}
#category ul li:hover { background-color:#c1c1c1; color:#fff; }
#category ul li { 
	list-style:none; 
	display:inline;  
	padding:16px 20px 16px 20px;
	border-left:1px solid #c1c1c1;
	margin-left:-6px;

}
#category #solo { border-right:1px solid #c1c1c1; }
#category ul { text-align:center; padding-right:30px;}
a { text-decoration:none; color:#000; }  
#categoty a:hover { color:#fff; }

#tb_searchList th { border-top:3px solid black; border-bottom:3px solid black; }
#tb_searchList td { border-bottom:1px solid black; height:40px; }
#point_box {
	color:#c1c1c1; 
	background-color:#353535; 
	border-radius:20px; 
	width:50px; 
	height:20px; 
	font-size:0.8em; 
	position:absolute;
	top:40px;
	left:105px; 
}
.footer { 
	width:1200px; 
	margin:0 auto;
	padding-top:5px; 
	height:200px;
	margin-top:50px;
	text-align:center;
	padding-bottom:10px;
	border:1px solid #c1c1c1;
}
.footer_info{
	line-height:1.5em;
}
.footer #cp{
	font-size:1.2em;
	font-family:굴림;
	color:#626262;
}
.footer #customer, #address{
	font-family:굴림;
	color:#b3b3b3;
}
.footer #bank{
	font-size:1.0em;
	font-family:굴림;
	color:#626262;
}
.footer_bd {
	left:-10px;
	padding-right:15px;
}
.footer_bd ul li {
	list-style:none; 
	display:inline;
	font-size:1.2em;
	font-family:굴림;
	font-weight:bold;
	color:#b3b3b3;
	margin-right:20px;
}

#banner{
	position:fixed;
	top:0px;
	border:1px solid #626262;
	width:250px;
	height:100%;
	right:-252px;
	text-align:center;
	padding-top:50px;
	background-color:#fff;
}
#banner a{
	text-decoration:none;
	color:black;
}
#banner a:hover,#banner a:visited {
	color:black;
}

.btn_bd {
	position:relative;
	border:1px solid #626262;
	background-color:#c1c1c1;
	padding:5px;
	width: 120px;
	height:20px;
	text-align:center;
	left:25%;
}

.btn_bd:hover {
	cursor:pointer;
	background-color:#dfdfdf;

}

#banner_btn{
	position:fixed;
	
	height:100%;
	right:0px;
	top:45%;
}
#Frame
{
	position:relative;
	width:150px;
	height:150px;
	left:20%;
	overflow:hidden;
}
#image1,#image2,#image3 { float:left; }
#btn_box2
{
	position:relative;
	width:150px;
	height:18px;
	left:20%;
	top:50px;
}
#pic_box
{
	position:absolute;
	width:458px;
}

	/* banner */
	.banner {position: relative; width: 140px; height: 140px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; top:0px; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 140px; height: 140px; margin:0; padding:0;}

#keyword { font-size:1.5em; width:500px; height:60px; border:1px solid #c1c1c1; }
#btn_search { background-color:#5a5a5a; color:#fff; width:140px; height:60px; border:1px solid black; font-size:1.5em; }

#goAdmin
{
	position:absolute;
	left:20px;
	top:50px;
	z-index:10;
	
}
#goAdmin a
{
	color:#fff;
}
#goAdmin a:hover
{
	color:red;
}
</style>
<script src="./js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function() {

	move();
   window.onblur = stop;
   
   window.onfocus = move;
   var int1;
      // setInterval() 함수로 구현할 타이머를 담을 변수
      // 잠시 멈추게 하기 위한 clearInterval()함수에서 사용하기 위한 변수
   function move()
   {
      int1 = setInterval(function() {movePoint();}, 1000);
      
      // setInterval() 함수를 변수에 담으면 변수에는 해당 타이머가 담김
   }

   function movePoint()
   {
         $("#point_box").animate({top:"-=3px"},500);
         $("#point_box").animate({top:"+=3px"},500);
   }   
   function stop()
   {
      window.clearInterval(int1);
   }
      
	var scrollHeight =  $(document).height() - $(window).height();
	
	
	$("#top").click(function () {
	    $('html, body').stop().animate( { scrollTop : '0' },200 ); 
	 });
	 $("#bot").click(function () {
	    $('html, body').stop().animate( { scrollTop : scrollHeight },200 ); 
	 });
	 var obj = document.getElementById("open");
	 var pointer = "left";
	 var left = "<img src='./image/right_open1.jpg' id='open' alt='배너열기'/><br/>";
	 var right = "<img src='./image/right_close1.jpg' id='open' alt='배너열기'/><br/>";
	 
	 $("#open").click(function() {
	    if (pointer == "left")
	    {
	    	obj.src = "./image/right_close1.jpg";
	       $("#banner").animate({right:"0px"},300);
	       $("#banner_btn").animate({right:"252px"},300);
	       pointer ="right";
	    }
	    else if (pointer == "right")
	    {
			
	    	obj.src = "./image/right_open1.jpg";

	       $("#banner").animate({right:"-252px"},300);
		   $("#banner_btn").animate({right:"0px"},300);
	       pointer ="left";
	    }
	 });
	 

		$(document).ready(function() {
			//사용할 배너
			var $banner = $(".banner").find("ul");

			var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
			var $bannerHeight = $banner.children().outerHeight(); // 높이
			var $bannerLength = $banner.children().length;//배너 이미지의 갯수
			var rollingId;

			//정해진 초마다 함수 실행
			rollingId = setInterval(function() { rollingStart(); }, 1500);//다음 이미지로 롤링 애니메이션 할 시간차

			//마우스 오버시 롤링을 멈춘다.
			banner.mouseover(function(){
				//중지
				clearInterval(rollingId);
				$(this).css("cursor", "pointer");
			});
			//마우스 아웃되면 다시 시작
			banner.mouseout(function(){
				rollingId = setInterval(function() { rollingStart(); }, 1500);
				$(this).css("cursor", "default");
			});
			
			function rollingStart() {
				$banner.css("width", $bannerWidth * $bannerLength + "px");
				$banner.css("height", $bannerHeight + "px");
				//alert(bannerHeight);
				//배너의 좌측 위치를 옮겨 준다.
				$banner.animate({left: - $bannerWidth + "px"}, 300, function() { //숫자는 롤링 진행되는 시간이다.
					//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
					$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
					//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
					$(this).find("li:first").remove();
					//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
					$(this).css("left", 0);
					//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
				});
			}
		}); 

	 
});
</script>
</head>
<body>
<div id="wrapper">
	<!-- top -->
	<div id="top_box">
		<%if(isAdmin) %> <span id="goAdmin"><a href="./admin/main.jsp">관리자 페이지로이동</a></span>
		<div id="btn_box">
			<span id="left">
			
			<%
			if (userId == null) 
			{%>	
			<input type="button" value="login" class="btn" onclick="location.href='./member/login_form.jsp';">
			<%
			}
			else if(userId != null)
			{
			%> 
			<input type="button" value="logout" class="btn" onclick="location.href='./member/logout.jsp';">
			<%
			}
			%>
				<input type="button" value="join" class="btn" onclick="location.href='./member/join_agree.jsp';">
			</span>
			<div id="point_box">
				+2000P
			</div>
		<%if (userId != null){ %>
		<span id="right">
			<input type="button" value="mypage" class="btn" onclick="location.href = 'mypage/my_main.jsp'">
			<input type="button" value="cart" class="btn">
		</span>
		<% } %>
		</div>
		<div id="logo"><a href="/jubong/index.jsp"><img src="./image/logo.png" width="200" height="90" alt="로고이미지" ></a></div>
		<div id="category">
			<ul>
				<a href="./product/product_list.jsp?cate=1"><li>&nbsp;LOAFER&nbsp;</li></a>
				<a href="./product/product_list.jsp?cate=2"><li>&nbsp;&nbsp;&nbsp;SUIT&nbsp;&nbsp;&nbsp;</li></a>
				<a href="./product/product_list.jsp?cate=3"><li>&nbsp;WALKER&nbsp;</li></a>
				<a href="./product/product_list.jsp?cate=4"><li>RUNNING</li></a>
				<a href="./product/product_list.jsp?cate=5"><li>SNEAKERS</li></a>
				<a href="./product/product_list.jsp?cate=6"><li id="solo">&nbsp;SANDLE&nbsp;</li></a>
			</ul>
		</div>
	</div>
	
	<!-- contents -->
	
	<div id="contents">
		<h1>통합 검색</h1>
		<form name="frm_search" id="frm_search" action="search.jsp" method="get">
		<input type="text" id="keyword" name="keyword" value="<%=keyword %>" /> <input type="submit" id="btn_search" value="검색" />
		</form>
		<%
	
		try
		{
			sql = "select p_id, pc_title, p_img, p_title, p_rprice from product,product_category where product.pc_idx = product_category.pc_idx and ( p_title like '%"+keyword+"%' or pc_title like '%"+ keyword +"%' )";
			int count=  0;
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "root", "root");
			stmt = conn.createStatement();
		%>
		<h3>상품 검색</h3>
			<table width="1200"id ="tb_searchList" cellpadding="0" cellspacing="0">
		<tr>
		<th width="5%">NO.</th>
		<th width="10%">카테고리</th>
		<th width="10%">상품 이미지</th>
		<th width="*">상품명</th>
		<th width="10%">가격</th>
		</tr>
		<%
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				do
				{
					count++;
					out.println("<tr>");
					out.println("<td>"+ count +"</td>");
					out.println("<td>"+ rs.getString("pc_title") +"</td>");
					out.println("<td><a href='./product/product_detail.jsp?pid="+ rs.getString("p_id") +"' ><img src='./image/"+ rs.getString("p_img") +"' width='100' height='140' alt ='상품이미지'/></a></td>");
					out.println("<td><a href='./product/product_detail.jsp?pid="+ rs.getString("p_id") +"' >"+ rs.getString("p_title") +"</a></td>");
					out.println("<td>"+ rs.getInt("p_rprice") +"</td>");
					out.println("</tr>");
						
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>");
			}
			rs.close();
		%>
		</table>
		<h3>게시판 검색</h3>
			<%
			sql = "select pb_idx, pb_type, pb_title, pb_writer, pb_date, pb_read from product_board where  pb_title like '%"+keyword+"%' or pb_writer like '%"+ keyword +"%' order by pb_date desc";
			count=  0;
			
		%>
		<table width="1200"id ="tb_searchList" cellpadding="0" cellspacing="0">
		<tr>
		<th width="5%">NO.</th>
		<th width="10%">게시판 분류</th>
		<th width="*">제목</th>
		<th width="10%">작성자</th>
		<th width="10%">작성날짜</th>
		<th width="10%">조회수</th>
		</tr>
		<%
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				do
				{
					count++;
					out.println("<tr>");
					out.println("<td>"+ count +"</td>");
					out.println("<td>"+ ((rs.getString("pb_type").equals("q")) ? "Q&A" : "REVIEW") +"</td>");
					out.println("<td><a href='./board/board_view.jsp?pb_idx="+ rs.getString("pb_idx") +"' >"+ rs.getString("pb_title") +"</a></td>");
					out.println("<td>"+ rs.getString("pb_writer") +"</td>");
					out.println("<td>"+ rs.getString("pb_date").substring(0,10) +"</td>");
					out.println("<td>"+ rs.getInt("pb_read") +"</td>");
					out.println("</tr>");
						
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='6'>검색 결과가 없습니다.</td></tr>");
			}
			rs.close();
			%>
			</table>
		<h3>공지사항 검색</h3>
			<%
	

			sql = "select n_idx, n_title, n_contents, n_date,n_writer from notice where  n_title like '%"+keyword+"%' or n_contents like '%"+ keyword +"%' or n_writer like '%"+ keyword +"%' order by n_date desc";
			count=  0;
			
		%>
		<table width="1200"id ="tb_searchList" cellpadding="0" cellspacing="0">
		<tr>
		<th width="5%">NO.</th>
		<th width="10%">제목</th>
		<th width="*">내용</th>
		<th width="10%">작성날짜</th>
		<th width="10%">작성자</th>
		</tr>
		<%
			rs = stmt.executeQuery(sql);
			if(rs.next())
			{
				do
				{
					count++;
					out.println("<tr>");
					out.println("<td>"+ count +"</td>");
					out.println("<td>"+ rs.getString("n_title") +"</td>");
					out.println("<td><a href='./board/notice_view.jsp?idx="+ rs.getString("n_idx") +"' >"+ rs.getString("n_contents") +"</a></td>");
					out.println("<td>"+ rs.getString("n_writer") +"</td>");
					out.println("<td>"+ rs.getString("n_date").substring(0,10) +"</td>");
					out.println("</tr>");
						
				}while(rs.next());
			}
			else
			{
				out.println("<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>");
			}
			rs.close();
		%>
		</table>
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
	
	<!-- banner -->
	<div id="banner">
		<h3>검색창</h3>
		<form action="./search.jsp" method="get">
		<input type="text" name="keyword"  placeholder="검색어는 두글자 이상" />
		<a href="#"><input type="image" src="./image/btn_zoom_header.gif" align="absmiddle" alt="검색"/></a>
		</form>
		<br />
		<br />
		<br /><a href="./board/notice_list.jsp"><div class="btn_bd">NOTICE</div></a>
		<br />
		<a href="./board/qna_list.jsp"><div class="btn_bd">Q & A</div></a>
		<br />
		<a href="./board/review_list.jsp"><div class="btn_bd">REVIEW</div></a>
		<br />
		<div id="banner_btn">
		<img src="./image/right_top1.jpg" id="top" alt="맨위로"/><br/>
		<span id="banner_open">
		<img src="./image/right_open1.jpg" id="open" alt="배너열기"/><br/>
		</span>
		<img src="./image/right_bot1.jpg" id="bot" alt="맨아래로"/>
		</div>
		<br/><br/><br/>
		<div id="recent">
			<h2>최근 본 상품</h2>
			
		<div class="banner">
			<ul>
		<%
		
		Cookie[] ck = request.getCookies();
		
		if(ck != null)
		{

			sql="";
			for(int i = 0 ; i < ck.length ; i ++)
		 	{
		 		if(ck[i].getName().indexOf("p_id") != -1)
		 		{
		 		%>
		 			<li><a href="./product/product_detail.jsp?pid=<%=ck[i].getValue()%>">

				<%
		 		}
		 		if(ck[i].getName().indexOf("p_img") != -1)
		 		{
		 			%>
		 			<img src="./image/<%=ck[i].getValue() %>" width="140" height="140" alt="상품이미지" /></a></li>
		 			<%
		 		}

		 	}
		 }
		 %>
			
	

			</ul>
		</div>
			<br />
			<div id="btn_box2">
				<span id="prev"><img src="./image/wing_arrow_prev.jpg"  width="48" height="17" /></span><span id="next"><img src="./image/wing_arrow_next.jpg" id="next" width="48" height="17" /></span>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<div class="footer">
		<div class="footer_bd">
			<ul>
				<li>notice</li>
				<li>Q&A</li>
				<li>review</li>
			</ul>
		</div>
		<span id="cp" class="footer_info">070-4814-2905<br/></span>
		<span id="customer" class="footer_info">MON - FRI AM 11:00 - PM 05:00 <br />BREAK PM 12:00 - PM 01:00 (SAT.SUN.HOLIDAY CLOSE)</span>
		<span id="bank" class="footer_info"><br />KB 123456-01-123456<br />주봉샵<br /></span>
		<span id="address" class="footer_info">서울시 강남구 테헤란로 123-4567</span>
	</div>
</div>
</body>
</html>