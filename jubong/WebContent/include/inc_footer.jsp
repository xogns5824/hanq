<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body { margin:0px; }
.footer { 
	 
	width:1200px; 
	border:1px solid #c1c1c1;
	margin:0 auto;
	padding-top:5px; 
	height:200px;
	margin-top:50px;
	text-align:center;
	padding-bottom:10px; 
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
</style>
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
      
   
});
</script>
</head>
<body>
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
</body>
</html>