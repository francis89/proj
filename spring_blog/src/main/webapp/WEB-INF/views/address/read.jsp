<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	function acreate() {
		var url = "create"
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href = url;
	}
	function alist(){
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
		<div class="title"><h3>주소 조회</h3></div>
		<table>
			<tr>
				<th class="table-bordered th">이름</th>
				<td class="table-bordered td">${dto.name }</td>
			</tr>
			<tr>
				<th class="table-bordered th">전화번호</th>
				<td class="table-bordered td">${dto.phone }</td>
			</tr>
			<tr>
				<th class="table-bordered th">주소</th>
				<td class="table-bordered td">${dto.address1 }<br> ${dto.address2 }<br>
					우(${dto.zipcode })</td>
			</tr>
			<tr>
				<th class="table-bordered th">가입날짜</th>
				<td class="table-bordered td">${dto.wdate }</td>
			</tr>
		</table>
		<div class="bottom">
			<input type="button" class="button" value="글쓰기" onclick="acreate()">
			<input type="button" class="button" value="목록" onclick="alist()">
		</div>
	</div>
</body>
</html>
