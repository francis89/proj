<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,spring.model.memo.*"%>

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
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<div id ="w">
	<div class="title">메모 수정</div>

	<form name="frm" method="POST" action="./update" onsubmit="return input(this)">
		<input type="hidden" name="memono" value="${dto.memono }">
		<input type="hidden" name="col" value="${param.col}">
		<input type="hidden" name="word" value="${param.word }">
		<input type="hidden" name="nowPage" value="${param.nowPage }">
		<!-- submit하는걸 잠시멈추고 input()을 호출한다. -->
		<!-- input(this)는 자바스크립트의 this이다. HTML 페이지를 객체형태로 접근할 수 있는 것은 document이다. ( 이 페이지를 가르킴 ) -->
		<!-- 여기서 this는 form 객체 자신을 말한다. form 태그 자체를 객체로 받는다. -->
		<table class="table_width_40">
			<tr>
				<th class="table-bordered th">제목</th>
				<td class="table-bordered td">
					<input type="text" name="title" size="30" value="${dto.title }" />
				</td>
			</tr>
			<tr>
				<th class="table-bordered th">내용</th>
				<td class="table-bordered td">
					<textarea name="content" rows="10" cols="30">${dto.content }</textarea>
				</td>
			</tr>
		</table>
		<div class="bottom">
			<input type="submit" class="button" value="수정">
		</div>
	</form>
	</div>
</body>
</html>
