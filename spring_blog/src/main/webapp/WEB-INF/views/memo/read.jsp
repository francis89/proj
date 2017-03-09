<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.mrcreate {
	font-size: 20px;
	font-weight: bold;
	text-align: left;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 35%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/
}

.mrlist {
	line-height: 1.2em;
	font-size: 15px;
	font-weight: bold;
	text-align: left;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	color: #000000; /* 글자 색깔 */
	width: 35%; /* 화면의 30% */
	padding: 10px; /* 위 오른쪽 아래 왼쪽: 시간 방향 적용 */
	/* padding: 50px 10px;  50px: 위 아래, 10px: 좌우 */
	/* padding-top: 30px;  상단만 간격을 30px 지정   */
	margin: 20px auto; /* 가운데 정렬 기능, 20px: 위 아래, auto: 오른쪽 왼쪽*/
}

hr {
	text-align: center;
	border-style: solid; /* 실선 */
	border-width: 1px; /* 선 두께 */
	border-color: #AAAAAA; /* 선 색깔 */
	width: 45%; /* 화면의 30% */
}
</style>
<script type="text/javascript">
	function mcreate() {
		var url = "create";
		location.href = url;
	}

	function mupdate(memono) {
		var url = "update";
		url += "?memono=" + memono;
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href = url;
	}

	function mdelete(memono) {
		if (confirm("정말 삭제할꺼야?")) {
			var url = "delete";
			url += "?memono=" + memono;
			url += "&col=${param.col}";
			url += "&word=${param.word}";
			url += "&nowPage=${param.nowPage}";
			location.href = url;
		}
	}

	function mlist() {
		var url = "list";
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		url += "&nowPage=${param.nowPage}";
		location.href = url;
	}
	function rcheck(tarea) {
		if ('${sessionScope.id}' == "") {
			if (confirm("로그인후 댓글를 쓰세요")) {
				var url = "../member/login";
				url = url + "?no=${dto.memono}";
				url = url + "&type=memono";
				url = url + "&nowPage=${param.nowPage}";
				url = url + "&nPage=${nPage}";
				url = url + "&col=${param.col}";
				url = url + "&word=${param.word}";
				url = url + "&bflag=../memo/read";
				location.href = url;
			} else {
				tarea.blur();
			}
		}
	}

	function input(f) {
		if ('${sessionScope.id}' == "") {
			if (confirm("로그인후 댓글를 쓰세요")) {
				var url = "../member/login";
				url = url + "?no=${dto.memono}";
				url = url + "&type=memono";
				url = url + "&nowPage=${param.nowPage}";
				url = url + "&nPage=${nPage}";
				url = url + "&col=${param.col}";
				url = url + "&word=${param.word}";
				url = url + "&bflag=../memo/read";
				location.href = url;
				return false;
			} else {

				return false;
			}
		} else if (f.content.value == "") {
			alert("댓글 내용을 입력하세요.");
			f.content.focus();
			return false;
		}
	}
	function mrupdate(rnum, rcontent) {
		var f = document.rform;
		f.content.value = rcontent;
		f.rnum.value = rnum;
		f.rsubmit.value = "수정";
		f.action = "./mrupdate"
	}
	function mrdelete(rnum) {
		if (confirm("정말삭제 하겠습니까?")) {
			var url = "./mrdelete";
			url = url + "?rnum=" + rnum;
			url = url + "&memono=${dto.memono}";
			url = url + "&nowPage=${param.nowPage}";
			url = url + "&nPage=${nPage}";
			url = url + "&col=${param.col}";
			url = url + "&word=${param.word}";
			location.href = url;
		}
	}
</script>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 24px;
}
</style>
<link href="${pageContext.request.contextPath }/css/style.css"
	rel="Stylesheet" type="text/css">
</head>
<body>
	<div id="w">
		<div class="title">
			<h3>메모 조회</h3>
		</div>
		<table>
			<tr>
				<th class="table-bordered th">제목</th>
				<td class="table-bordered td">${dto.title }</td>
			</tr>
			<tr>
				<th class="table-bordered th">내용</th>
				<td class="table-bordered td">${dto.content }</td>
			</tr>
			<tr>
				<th class="table-bordered th">조회수</th>
				<td class="table-bordered td">${dto.viewcnt }</td>
			</tr>
			<tr>
				<th class="table-bordered th">등록일</th>
				<td class="table-bordered td">${dto.wdate }</td>
			</tr>
		</table>
		<div class="bottom">
			<input type="button" value="등록" class="button" onclick="mcreate()">
			<input type="button" value="수정" class="button"
				onclick="mupdate('${dto.memono}')"> <input type="button"
				value="삭제" class="button" onclick="mdelete('${dto.memono}')">
			<input type="button" value="목록" class="button" onclick="mlist()">
		</div>
	</div>

	<hr>
	<c:forEach var="mrdto" items="${mrlist}">
		<div class="mrlist">
			${mrdto.id}<br />
			<p>${mrdto.content}</p>
			${mrdto.regdate} 
			<c:if test="${sessionScope.id==mrdto.id }">
			<span style="float: right;"> 
			<a href="javascript:mrupdate('${mrdto.rnum}','${mrdto.content }')">수정</a>
			|
			<a href="javascript:mrdelete('${mrdto.rnum}')">삭제</a>
			</span>
			</c:if>
		</div>
	</c:forEach>
	<div class="mrcreate">
		<form name="rform" action="./mrcreate" method="post"
			onsubmit="return input(this)">
			<textarea rows="3" cols="28" name="content" onclick="rcheck(this)"></textarea>
			<input type="submit" name="rsubmit" value="등록"> 
			<input
				type="hidden" name="memono" value="${dto.memono}"> 
			<input
				type="hidden" name="nowPage" value="${param.nowPage}"> 
			<input 
				type="hidden" name="id" value="${sessionScope.id}"> 
			<input
				type="hidden" name="nPage" value="${param.nPage}"> 
			<input
				type="hidden" name="col" value="${param.col}"> 
			<input
				type="hidden" name="word" value="${param.word}"> 
			<input
				type="hidden" name="rnum" value="0">


		</form>
	</div>
	<div class="bottom">${paging}</div>

</body>
</html>

