<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file ="../include/inc_header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body { margin: 0px; }
#top_box { 
	position:relative; 
	width:1200px; 
	margin:0 auto; 
	height:200px; 
	border: 1px solid #c1c1c1;
}
#btn_box { width:1190px; height:30px;  padding:5px;  }
.btn { background-color:white; padding:5px 10px 5px 10px; width:80px;}
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
<script src="../js/jquery-3.3.1.js"></script>
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
<div id="top_box">
		<%if(isAdmin) %> <span id="goAdmin"><a href="../admin/main.jsp">관리자 페이지로이동</a></span>
		<div id="btn_box">
			<span id="left">
			<%
			if (userId == null) 
			{%>	
			<input type="button" value="login" class="btn" onclick="location.href='../member/login_form.jsp';">
			<%
			}
			else if(userId != null)
			{
			%> 
			<input type="button" value="logout" class="btn" onclick="location.href='../member/logout.jsp';">
			<%
			}
			%>
				<%if(userId == null) {%><input type="button" value="join" class="btn" onclick="location.href='../member/join_agree.jsp';"><%} %>
			</span>
				<%
				if(userId == null)
				{%>
				<div id="point_box">
				+2000P
			</div>
			<% }

		if (userId != null){ %>
		<span id="right">
			<input type="button" value="mypage" class="btn" onclick="location.href = '../mypage/my_main.jsp'">
			<input type="button" value="cart" class="btn" onclick="location.href= '../order/cart_list.jsp';">
		</span>
		<%} %>
		</div>
		<div id="logo"><a href="/jubong/index.jsp"><img src="../image/logo.png" width="200" height="90" alt="로고이미지" ></a></div>
		<div id="category">
			<ul>
				<a href="../product/product_list.jsp?cate=1"><li>&nbsp;LOAFER&nbsp;</li></a>
				<a href="../product/product_list.jsp?cate=2"><li>&nbsp;&nbsp;&nbsp;SUIT&nbsp;&nbsp;&nbsp;</li></a>
				<a href="../product/product_list.jsp?cate=3"><li>&nbsp;WALKER&nbsp;</li></a>
				<a href="../product/product_list.jsp?cate=4"><li>RUNNING</li></a>
				<a href="../product/product_list.jsp?cate=5"><li>SNEAKERS</li></a>
				<a href="../product/product_list.jsp?cate=6"><li id="solo">&nbsp;SANDLE&nbsp;</li></a>
			</ul>
		</div>
	</div>
</body>
</html>