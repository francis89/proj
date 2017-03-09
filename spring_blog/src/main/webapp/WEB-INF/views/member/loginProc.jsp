<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">로그인 처리</DIV>
 
<DIV class="content">
<c:choose>
	<c:when test="${flag }">
		로그인이 되었습니다.
	</c:when>
	<c:otherwise>
		id와 passwd가 일치하지 않습니다.
	</c:otherwise>
</c:choose>

</DIV>

  
<DIV class='bottom'>
    <input type='button' value='홈' onclick="location.href='../index.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='회원가입' onclick="location.href='./agree.do'">
</DIV>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 