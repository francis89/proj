<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="/ELFunctions" %>
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
function read(no){
	var url ="${pageContext.request.contextPath}/imgbbs/read";
	url += "?no="+no;
	url += "&col=${col}";
	url += "&word=${word}";
	url += "&nowPage=${nowPage}";
	location.href = url;
}
function down(filename){
	  var url = "${pageContext.request.contextPath}/download";
	  url += "?dir=/imgbbs/storage";
	  url += "&filename="+filename;
	  
	  location.href = url;
	  
	}
</script> 
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">이미지 게시판</DIV>
<DIV class="search">
<FORM name='frm' method='POST' action='./list'>
<SELECT name="col">
	<option value="name" <c:if test="${col=='name'}">selected='selected'</c:if>>성명</option> 
	<option value="title" <c:if test="${col=='title'}">selected='selected'</c:if>>제목</option>
	<option value="content" <c:if test="${col=='content'}">selected='selected'</c:if>>내용</option>
	<option value="total">전체출력</option>
</SELECT>
<input type="text" name="word" value='${word }'>
<input type="submit" value="검색">
<input type="button" value="등록" onclick="location.href='./create'"> 
</FORM>
 </DIV>
 <TABLE style="width: 80%;">
    <TR>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>글쓴이</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>이미지</TH>
    </TR>
    <c:choose>
    	<c:when test="${fn:length(list)==0 }">
    		<tr>
    			<td colspan= "8">등록된 글이 없습니다.</td>
    		</tr>
    	</c:when>
    	<c:otherwise>
    		<c:forEach items="${list}" var="dto">
    			 <tr>
      				<td>${dto.no }</td>
      			 	<td>
      			 	<c:forEach begin="1" end="${dto.indent }">
      			 		&nbsp;&nbsp;
      			 	</c:forEach>
      			 	<c:if test="${dto.indent > 0 }">
      			 		<img src="${pageContext.request.contextPath }/images/reply.JPG" style=" width:10px; height:10px;">
      			 	</c:if>
      			 	 <a href="javascript:read('${dto.no }')">
  						${dto.title}
					 </a>
  					<c:if test="${util:newImg(fn:substring(dto.wdate, 0, 10))}">
  						<img src="${pageContext.request.contextPath }/images/new.gif">
  					</c:if>
				    </td>
    				<td>${dto.name }</td>
    				<td>${dto.viewcnt}</td>
    				<td>${dto.wdate}</td>   
    				<td>
    				<c:choose>
    					<c:when test="${empty dto.filename }">
    						이미지 없음
    					</c:when>
    					<c:otherwise>
    						<a href="javascript:down('${dto.filename }')">
      						<img src="${pageContext.request.contextPath }/imgbbs/storage/${dto.filename}" style="width: 200px; height: 150px;"> 
      						</a>
    					</c:otherwise>
    				</c:choose>
			    	</td>
			    </tr>  
    		</c:forEach>
    	</c:otherwise>
    </c:choose>
</TABLE>

<DIV class='bottom'>
   ${paging }
</DIV>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 