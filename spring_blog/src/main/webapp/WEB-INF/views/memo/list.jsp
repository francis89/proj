<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/ELFunctions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	function read(memono) {
		var url = "read";
		url += "?memono=" + memono;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";

		location.href = url; // url 이동하라
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
	<section id="list" name="contact"></section>
	<div id="w">
		<div class="title">메모 목록</div>
		<div class="search">
			<form method="post" action="./list">
				<select name="col">
					<!-- 검색할 컬럼 -->
					<option value="title"
						<c:if test="${col=='title' }">
							selected='selected'
						</c:if>>제목</option>
						<option value="content"
						<c:if test="${col=='content' }">
							selected='selected'
						</c:if>>내용</option>
					<option value="total">전체출력</option>
				</select> <input type="text" name="word" value="${word}" />
				<!-- 검색어 -->
				<input type="submit" class="button_mini" value="검색" />
			</form>
		</div>

		<table>
			<tr>
				<th class="table-bordered th">번호</th>
				<th class="table-bordered th">제목</th>
				<th class="table-bordered th">날짜</th>
				<th class="table-bordered th">조회수</th>
			</tr>
			<c:choose>
				<c:when test="${fn:length(list)==0 }">
					<tr>
						<td colspan="4">등록된 메모가 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td class="table-bordered td">${dto.memono}</td>
							<td class="table-bordered td">
								 <c:set var="rcount" value="${util:rcount(dto.memono,irdao) }"/>
									<a href="javascript:read('${dto.memono}')"> ${dto.title }</a>
								<c:if test="${rcount>0 }">
            						<span style="color:blue;">(${rcount})</span>
          						</c:if>
							</td>
							<td class="table-bordered td">${dto.wdate }</td>
							<td class="table-bordered td">${dto.viewcnt }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		<div class='bottom'>
			<input type="button" value="등록" class="button"
				onclick="location.href='./create'">
			${paging}
		</div>
	</div>
</body>
</html>
