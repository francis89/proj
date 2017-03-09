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
  font-size: 24px; 
}
</style> 
<script type="text/javascript">
function tlist(){
	var url = "list.do";
	url += "?col=${param.col }";
    url += "&word=${param.word }";
    url += "&nowPage=${param.nowPage }";
	location.href=url;
}
</script> 
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<div class="content">
<c:choose>
	<c:when test="${flag }">
		정보를 삭제했습니다
	</c:when>
	<c:otherwise>
		정보를 삭제못했습니다
	</c:otherwise>
</c:choose>

<br>
</div>
<div class="bottom">
<input type='button' value='목록' onclick="tlist()">
</div>
</body> 
</html> 
