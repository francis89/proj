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
<script type="text/javascript">
function blist(){
	var url = "list";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href=url;
}
</script> 
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">처리결과</DIV>
<DIV class="content">
<c:choose>
	<c:when test="${not pflag }">
		패스워드가 일치하지 않습니다.
	</c:when>
	<c:when test="${flag }">
		삭제 성공
	</c:when>
	<c:otherwise>
		삭제 실패
	</c:otherwise>
</c:choose>

</DIV>

<c:choose>
	<c:when test="${pflag==false }">
		<DIV class="bottom">
	 		 <input type='button' value='다시 시도' onclick="history.back();">       
     		 <input type='button' value='목록' onclick="blist()">
		</DIV>
	</c:when>
	<c:otherwise>
		<DIV class='bottom'>
     		<input type='button' value='등록' onclick="location.href='${pageContext.request.contextPath }/bbs/create.do'">       
      		<input type='button' value='목록' onclick="blist()">
    	</DIV>
	</c:otherwise>

</c:choose>
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 