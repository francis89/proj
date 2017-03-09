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
function use(){
	opener.frm.id.value='${id}';
	window.close();
}
</script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
 
<DIV class="title">중복확인 처리</DIV>

<DIV class="content">
 입력된 ID : ${id }<br><br>
 <c:choose>
 	<c:when test="${flag }">
 		중복되어 사용불가
 	</c:when>
 	<c:otherwise>
 		<input type='button' value='사용' onclick='use()'>
 	</c:otherwise>
 </c:choose>
 
</DIV>
  
  <DIV class='bottom'>
    <input type='submit' value='다시시도' onclick="location.href='id_Form'">
    <input type='button' value='닫기' onclick="window.close()">
  </DIV>

 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 