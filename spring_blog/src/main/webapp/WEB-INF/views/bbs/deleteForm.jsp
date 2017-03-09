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
function incheck(f){
	if(f.passwd.value==""){
		alert("패스워드를 입력하세요");
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
 
<DIV class='content'> 
<c:choose>
	<c:when test="${flag }">
		답변 있는 글이므로 삭제 할 수 없습니다.<br>
		<input type='button' value='목록으로' onclick='history.go(-2)'>
	</c:when>
	<c:otherwise>
		<FORM name='frm' method='POST' action='./delete' onsubmit="return incheck(this)">
  			<input type='hidden' name='bbsno' size='30' value='${param.bbsno }'>
  			<input type='hidden' name='col' size='30' value='${param.col }'>
  			<input type='hidden' name='word' size='30' value='${param.word }'>
  			<input type='hidden' name='nowPage' size='30' value='${param.nowPage }'>
  			<input type='hidden' name='oldfile' size='30' value='${param.oldfile }'>
  			삭제하면 복구 할 수 없습니다 <br><br>
  			<TABLE>
    			<TR>
		 	     <TH>패스워드</TH>
      			  <TD>
      				<input type='password' name='passwd' size='40' value=''>
      			  </TD>
    			</TR>		
  			</TABLE>
  
  			<DIV class='bottom'>
  		 		 <input type='submit' value='삭제'>
   				 <input type='button' value='취소' onclick="history.back();">
  			</DIV>
		</FORM>
	
	</c:otherwise>

</c:choose>

</DIV>

 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 