<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,spring.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 24px;
}
</style>
<link href="${pageContext.request.contextPath }/css/style.css"
	rel="Stylesheet" type="text/css">
<script type="text/javascript">
	function input(f) {

		if (f.phone.value == "") {
			alert("전화번호를 입력하시오");
			f.phone.focus();
			return false;
		}
		if (f.zipcode.value == "") {
			alert("우편번호를 입력하시오");
			f.zipcode.focus();
			return false;
		}
		if (f.address1.value == "") {
			alert("주소를 입력하시오");
			f.address1.focus();
			return false;
		}
		if (f.address2.value == "") {
			alert("상세주소를 입력하시오");
			f.address2.focus();
			return false;
		}
		var cnt = 0;
		for (var i = 0; i < f.skill.length; i++) {
			if (f.skill[i].checked) {
				cnt += 1;

			}
		}
		if (cnt == 0) {
			alert("보유기술을 체크하시오");
			f.skill[0].focus();
			return false;
		}
		if (f.hobby.selectedIndex == 0) {
			alert("취미를 선택하시오");
			f.hobby.focus();
			return false;
		}

	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('sample6_address').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('sample6_address2').focus();
					}
				}).open();
	}
</script>
</head>
<body>
	<div class="title">
		<h1>팀 정보 수정</h1>
	</div>
	<br>
	<br>
	<br>
	<form name='frm' action="update" method="POST"
		enctype="multipart/form-data" onsubmit="return input(this)">
		<input type='hidden' name='no' value='${param.no }'> 
		<input type='hidden' name='col' size='30' value='${param.col }'> 
		<input type='hidden' name='word' size='30' value='${param.word }'> 
		<input type='hidden' name='nowPage' size='30' value='${param.nowPage }'>
		<input type='hidden' name='oldfile' size='30' value='${dto.filename }'>
		<table>
			<tr>
				<th colspan="2" style="text-align: center;"><img
					src='${pageContext.request.contextPath }/team/storage/${dto.filename}'
					style='width: 500px; height: 450px;'></th>
			</tr>
			<tr>
				<td>이름</td>
				<td>${dto.name }</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>${dto.gender }</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone" value="${dto.phone }">
				</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input type="text" name="zipcode" size="7" maxlength="5"
					id="sample6_postcode" placeholder="우편번호" value="${dto.zipcode }">
					<input type="button" onclick="sample6_execDaumPostcode()"
					value="우편번호 검색"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address1" size="45"
					value="${dto.address1 }" id="sample6_address" placeholder="주소">
				</td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="address2" value="${dto.address2 }"
					size="45" id="sample6_address2" placeholder="상세주소"></td>
			</tr>
			<tr>
				<td>보유기술</td>
				<td><label for="s1"><input id="s1" type="checkbox"
						name="skill" value="Java"
						<c:if test="${fn:indexOf(skill,'java')!= -1 }">checked</c:if>>
						Java </label> <label for="s2"><input id="s2" type="checkbox"
						name="skill" value="Jsp"
						<c:if test="${fn:indexOf(skill,'Jsp')!= -1 }">checked</c:if>>
						Jsp </label> <label for="s3"><input id="s3" type="checkbox"
						name="skill" value="MVC"
						<c:if test="${fn:indexOf(skill,'MVC')!= -1 }">checked</c:if>>
						MVC </label> <label for="s4"><input id="s4" type="checkbox"
						name="skill" value="Spring"
						<c:if test="${fn:indexOf(skill,'Spring')!= -1 }">checked</c:if>>
						Spring </label> <label for="s5"><input id="s5" type="checkbox"
						name="skill" value="jQuery"
						<c:if test="${fn:indexOf(skill,'jQuery')!= -1 }">checked</c:if>>
						jQuery </label></td>
			</tr>
			<tr>
				<td>취미</td>
				<td><select name="hobby">
						<option>취미를 선택하세요</option>
						<option value="기술서적읽기">기술서적읽기</option>
						<option value="영화보기">영화보기</option>
						<option value="게임하기">게임하기</option>
						<option value="축구">축구</option>
						<option value="농구">농구</option>
						<option value="야구">야구</option>
				</select> <script type="text/javascript">
					document.frm.hobby.value = '${dto.hobby}';
				</script></td>
			</tr>
			<TR>
      			<TH>사진수정</TH>
      			<TD><input type="file" name="fileMF" accept=".gif, .jpg, .png, .GIF, .JPG, .PNG"></TD>
    		</TR>
			
			<tr>
				<td colspan="2"><input type="submit" value="수정"> <input
					type="reset" value="다시입력"></td>
			</tr>


		</table>
	</form>
</body>
</html>
