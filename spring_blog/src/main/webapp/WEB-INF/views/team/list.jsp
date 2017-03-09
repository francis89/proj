<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	function read(no){
  		//alert(no);
  		var url = "read";
  		url += "?no="+no;
  		url += "&col=${col}";
  		url += "&word=${word}";
  		url += "&nowPage=${nowPage}";
  
 		 location.href=url;
	}

	function update(no){
			var url = "update";
			url += "?no="+no;
			url += "&col=${col}";
	  		url += "&word=${word}";
	  		url += "&nowPage=${nowPage}";
			location.href=url;
	}
	function del(no,oldfile){
			
		if(confirm("정말 삭제할꺼야?")){

			var url = "delete";
			url += "?no="+no;
			url += "&col=${col}";
	  		url += "&word=${word}";
	  		url += "&nowPage=${nowPage}";
    		url += "&oldfile="+oldfile;
			location.href=url;
	}
}
</script> 
</head> 
<body> 
<div class="title">팀정보</div>

 <DIV class="search"> 
  <FORM name="frm" method='post' action="./list"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='name'  <c:if test="${col=='name'}"> selected='selected' </c:if>>성     명</OPTION> 
    <OPTION value='phone' <c:if test="${col=='phone'}"> selected='selected' </c:if>>전화 번호</OPTION> 
    <OPTION value='skill' <c:if test="${col=='skill'}"> selected='selected' </c:if>>보유 기술</OPTION> 
    <OPTION value='total'>전체출력</OPTION> 
  </SELECT> 
  <input type='text' name='word' value='${word }'> <!-- 검색어 -->
  <input type='submit' value='검색'> 
  <input type='button' value='등록' onclick="location.href='./create'"> 
  </FORM> 
</DIV> 

<table>
<tr>
<th>번호</th>
<th>이름</th>
<th>전화번호</th>
<th>보유 기술</th>
<th>사진</th>
<th>수정/삭제</th>
</tr>
<c:choose>
	<c:when test="${fn:length(list)==0 }">

	<tr>
  		<td colspan='5'>등록된 메모가 없습니다.</td>
	</tr>
	
	</c:when>

	<c:otherwise>
		<c:forEach items="${list}" var="dto">
			<tr>
     		 <td>${dto.no }</td>
      		 <td><a href="javascript:read('${dto.no }')">${dto.name }</a></td>
      		 <td>${dto.phone }</td>
      	 	 <td>${dto.skillstr }</td>
       	  	 <td><img src='${pageContext.request.contextPath }/team/storage/${dto.filename }'></td>
      		 <td>
      			<a href="javascript:update('${dto.no }')">수정</a>
      			/
      			<a href="javascript:del('${dto.no }','${dto.filename }')">
        		삭제
			    </a>
		     </td>
    		</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>

</table>
<DIV class='bottom'>
    ${paging }
	<input type="button" value="등록" onclick="location.href='${pageContext.request.contextPath }/team/create'">
  </DIV>
</body> 
</html> 



