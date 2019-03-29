<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#card_tb { margin:30px; }
</style>
<script>
function cartGo() {
	var frm = opener.document.frm_order;
	frm.action="order_proc.jsp";
	frm.submit();
	self.close();
}
</script>
</head>
<body>
<form name="card_frm" action="order_proc.jsp" method="post">
<table id="card_tb" width="500" height="250">
<tr><th height="40" align="center">카드결제</th></tr>
<tr>
<td align="center" height="40">
<input type="text" name="card1" size="4" maxlength="4"> -
<input type="text" name="card2" size="4" maxlength="4"> -
<input type="text" name="card3" size="4" maxlength="4"> -
<input type="password" name="card4" size="4" maxlength="4">
</td>
</tr>
<tr><td height="40" align="center"><input type="submit" value="결제하기" onclick="cartGo();">&nbsp;&nbsp;&nbsp;<input type="button" value="결제 취소" onclick="self.close();" /></td></tr>
</table>
</form>
</body>
</html>