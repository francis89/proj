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
function incheck(f) {
	if(f.passwd.value==""){
		alert("패스워드를 입력하세요.");
		f.passwd.focus();
		return false;
	}
}
</script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">삭제</DIV>
 
<c:choose>
	<c:when test="${flag }">
		<div class="content">
			답변있는 글이므로 삭제를 할 수 없습니다.<br>
			<input type='button' value='목록으로' onclick='history.go(-2)'>
		</div>
	</c:when>
	<c:otherwise>
		<div class="content">
 
		<FORM name='frm' method='POST' action='./delete'onsubmit="return incheck(this)">
			<input type ="hidden" name="no" value="${dto.no }">
			<input type ="hidden" name="col" value="${param.col }" >
			<input type ="hidden" name="word" value="${param.word }" >
			<input type ="hidden" name="nowPage" value="${param.nowPage }" >
			<input type ='hidden' name='oldfile' value='${dto.filename }'>
  		<TABLE>
   			<TR>
      			<TH>패스워드</TH>
      			<TD><input type="password" name="passwd"></TD>
    		</TR>
  		</TABLE>
  
  		<DIV class='bottom'>
    		<input type='submit' value='삭제'>
    		<input type='button' value='뒤로가기' onclick="history.back()">
  		</DIV>
		</FORM>
		</div>
	</c:otherwise>
</c:choose>
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 