+<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8");
    String root = request.getContextPath();
    boolean flag = (Boolean) request.getAttribute("flag");
%> 
 
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
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
 
<DIV class="title">에러확인</DIV>
 
<div class="content">
비밀번호 에러
</div>
<DIV class='bottom'>
  <input type='button' value='다시시도' onclick="history.back()">
</DIV>


</body>
</html> 