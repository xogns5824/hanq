<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
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
	border:1px solid black;
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
	.banner {position: relative; width: 140px; height: 140px; top: 20px;  margin:0 auto; padding:0; overflow: hidden; border:1px solid black;}
	.banner ul {position: absolute; top:0px; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 140px; height: 140px; margin:0; padding:0;}

</style>
<script src="../js/jquery-3.3.1.js"></script>
<script>
$(document).ready(function() {
	var scrollHeight =  $(document).height() - $(window).height();
	
		
$("#top").click(function () {
    $('html, body').stop().animate( { scrollTop : '0' },200 ); 
 });
 $("#bot").click(function () {
    $('html, body').stop().animate( { scrollTop : scrollHeight },200 ); 
 });
 var obj = document.getElementById("open");
 var pointer = "left";
 var left = "<img src='../image/right_open1.jpg' id='open' alt='배너열기'/><br/>";
 var right = "<img src='../image/right_close1.jpg' id='open' alt='배너열기'/><br/>";
 
 $("#open").click(function() {
    if (pointer == "left")
    {
    	obj.src = "../image/right_close1.jpg";
       $("#banner").animate({right:"0px"},300);
       $("#banner_btn").animate({right:"252px"},300);
       pointer ="right";
    }
    else if (pointer == "right")
    {
		
    	obj.src = "../image/right_open1.jpg";

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
		$("#next").click(function () {
			
			$banner.css("width", $bannerWidth * $bannerLength + "px");
			$banner.css("height", $bannerHeight + "px");
			//alert(bannerHeight);
			//배너의 좌측 위치를 옮겨 준다.
			$banner.animate({left: - $bannerWidth + "px"}, 500, function() { //숫자는 롤링 진행되는 시간이다.
				//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
				$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
				//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
				$(this).find("li:first").remove();
				//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
				$(this).css("left", 0);
				//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
			});
		});

		
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
			$banner.animate({left: - $bannerWidth + "px"}, 500, function() { //숫자는 롤링 진행되는 시간이다.
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
<div id="banner">
	<h3>검색창</h3>
	<form action="../search.jsp" method="get">
	<input type="text" name="keyword" id="keyword" placeholder="검색어는 두글자 이상" />
	<a href="#"><input type="image" src="../image/btn_zoom_header.gif" align="absmiddle" alt="검색"/></a>
	</form>
	<br />
	<br />
	<br />
	<a href="../board/notice_list.jsp"><div class="btn_bd">NOTICE</div></a>
	<br />
	<a href="../board/qna_list.jsp"><div class="btn_bd">Q & A</div></a>
	<br />
	<a href="../board/review_list.jsp"><div class="btn_bd">REVIEW</div></a>
	<br />
	<div id="banner_btn">
	<img src="../image/right_top1.jpg" id="top" alt="맨위로"/><br/>
	<span id="banner_open">
	<img src="../image/right_open1.jpg" id="open" alt="배너열기"/><br/>
	</span>
	<img src="../image/right_bot1.jpg" id="bot" alt="맨아래로"/>
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
		 			<li><a href="../product/product_detail.jsp?pid=<%=ck[i].getValue()%>">

				<%
		 		}
		 		if(ck[i].getName().indexOf("p_img") != -1)
		 		{
		 			%>
		 			<img src="../image/<%=ck[i].getValue() %>" width="140" height="140" alt="상품이미지" /></a></li>
		 			<%
		 		}

		 	}
		 }
		
		 %>
			
	

			</ul>
		</div>
		<br />
		<div id="btn_box2">
		
			<span id="prev"><img src="../image/wing_arrow_prev.jpg"  width="48" height="17" /></span><span id="next"><img src="../image/wing_arrow_next.jpg" id="next" width="48" height="17" /></span>
		</div>
	</div>
</div>


</body>
</html>