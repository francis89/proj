<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${empty sessionScope.id}">
		<c:set var="str">Francis 블로그</c:set>
	</c:when>
	
	<c:otherwise>
		<c:set var="str">안녕하세요 ${sessionScope.id} 님!!</c:set>
	</c:otherwise>
</c:choose>

<c:set var="title">Francis Spring</c:set>
	<c:if test="${not empty sessionScope.id && sessionScope.grade=='A'}">
		<c:set var="title">Admin Page</c:set>
	</c:if>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
} 
</style> 
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head> 
<body leftmargin="0" topmargin="0">
<DIV class="title">${title}</DIV>

<DIV class="content">
	<h1>${str }</h1>
	<img src="${pageContext.request.contextPath}/images/holly_Queen_mago.gif" width="50%">
	<br>
	<br>
<c:choose>
	<c:when test="${empty sessionScope.id}">
		<input type="button" value="Login" 
				onclick="location.href='${pageContext.request.contextPath}/member/login'">
	</c:when>
	
	<c:otherwise>
		<input type="button" value="Logout" 
				onclick="location.href='${pageContext.request.contextPath}/member/logout'">
	</c:otherwise>
</c:choose>

</DIV>
 

</body>
 
</html> 