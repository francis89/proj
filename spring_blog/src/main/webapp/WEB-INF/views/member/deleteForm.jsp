<%@ page contentType="text/html; charset=UTF-8" %> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">회원 탈퇴</DIV>
 
<FORM name='frm' method='POST' action='./delete'>
<input type="hidden" name="id" value="${id }">
<input type="hidden" name="oldfile" value="${oldfile }">

	<DIV class="content">
		탈퇴를 하시면 더이상 CONTENT를 제공받을수 없습니다<br>
		그래도 탈퇴를 원하시면 아래 탈퇴버튼을 클릭하세요
	</DIV>

  <DIV class='bottom'>
    <input type='submit' value='탈퇴'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 