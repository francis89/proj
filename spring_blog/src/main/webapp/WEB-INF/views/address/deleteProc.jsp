<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
function alist() {
	var url = "list";
	url += "?col=${param.col}";
	url += "&word=${param.word}";
	url += "&nowPage=${param.nowPage}";
	location.href = url;
	}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
}
</style> 
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
	<div id="w">
		<div class="title"><h3>회원 삭제 확인</h3></div>
		<div class="content">
			<FORM name='frm' method='POST' action='./delete' onsubmit="return incheck(this)">
  			<input type='hidden' name='no' size='30' value='${param.no }'>
  			<input type='hidden' name='col' size='30' value='${param.col }'>
  			<input type='hidden' name='word' size='30' value='${param.word }'>
  			<input type='hidden' name='nowPage' size='30' value='${param.nowPage }'>
  			삭제하면 복구 할 수 없습니다 <br>
  			정말로 삭제하시겠습니까?<br>
  			
  
  			<DIV class='bottom'>
  		 		 <input type='submit' value='YES'>
   				 <input type='button' value='NO' onclick="alist()">
  			</DIV>
		</FORM>
		</div>
	</div>
</body>
</html>
