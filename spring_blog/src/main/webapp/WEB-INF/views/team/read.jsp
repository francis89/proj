<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,spring.model.*" %> 
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
img{
	width:250px;
	height:200px;
}
</style> 
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
	function create(){
	var url = "${pageContext.request.contextPath }/team/create";
	location.href=url;
}
function tlist(){
	var url = "${pageContext.request.contextPath }/team/list";
	url += "?col=${col}";
	url += "&word=${word}";
	url += "&nowPage=${nowPage}";
	location.href=url;
}

function down(){
	var url = "${pageContext.request.contextPath }/download";
	url += "?dir=/team/storage";
	url += "&filename=+${dto.filename}";
	
	location.href = url;
	
}
</script> 

</head> 
<body> 
<div class="title">조회</div>
<table>
<tr>
	<td colspan="2" id="ftd">
	<img src='${pageContext.request.contextPath }/team/storage/${dto.filename}' style="width: 500px; height: 450px;">
	</td>
</tr>
<tr>
	<th>이름</th>
	<td>${dto.name }</td>
</tr>
<tr>
	<th>성별</th>
	<td>${dto.gender }</td>
</tr>
<tr>
	<th>전화번호</th>
	<td>${dto.phone }</td>
</tr>
<tr>
	<th>주소</th>
	<td>
	${dto.address1 } <br>
	${dto.address2 } <br>
	우편번호 (${dto.zipcode })
	</td>
</tr>
<tr>
	<th>보유기술</th>
	<td>${dto.skillstr }</td>
</tr>
<tr>
	<th>취미</th>
	<td>${dto.hobby }</td>
</tr>
<tr>
</table>
<div class="bottom">
<input type="button" value="생성" 	onclick="create()">
<input type="button" value="목록" 	onclick="tlist()">
<input type='button' value='다운로드' 
  	 onclick="location.href='${pageContext.request.contextPath }/download?dir=/team/storage&filename=${dto.filename }'">
</div>
</body> 
</html> 


