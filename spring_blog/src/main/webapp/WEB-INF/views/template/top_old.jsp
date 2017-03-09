<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">

 .img{
	width: 100%;
	height: 55%;
}
li#admin{
	float:right;
	padding-right: 30px;
}
</style>
</head>
<body>
<!-- 상단 메뉴 -->
<div style="background-color: white;">
<table style="width: 100%">
  <tr>
    <td>
        <img class="img" src="${pageContext.request.contextPath }/images/marvel_1.jpg" >
    </td>
  </tr>
  
  <tr>
    <td>
    <ul class="nav nav-pills" role="tablist">
     <li><a href="${pageContext.request.contextPath }/">홈</a></li> 
     <c:choose>
     	<c:when test="${empty sessionScope.id }">
     		<li><a href="${pageContext.request.contextPath }/member/agree">회원가입</a></li>
     		<li><a href="${pageContext.request.contextPath }/member/login">로그인</a></li>
     	</c:when>
		
		<c:when test="${not empty sessionScope.id && sessionScope.grade == 'H' }">
	     	<li><a href="${pageContext.request.contextPath }/member/read">나의정보</a></li>
     		<li><a href="${pageContext.request.contextPath }/member/update">회원수정</a></li>
     		<li><a href="${pageContext.request.contextPath }/member/logout">로그아웃</a></li>
     		<li><a href="${pageContext.request.contextPath }/member/delete">회원탈퇴</a></li>   
		</c:when>
     </c:choose>
     
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
      MEMO <span class="caret"></span></a>
      <ul class="dropdown-menu" role="menu">
	     <li><a href="${pageContext.request.contextPath }/memo/list">메모LIST</a></li>
	     <li><a href="${pageContext.request.contextPath }/memo/create">메모생성</a></li>
      </ul> 
    </li>
    
     <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
      ADDRESS <span class="caret"></span></a>
      <ul class="dropdown-menu" role="menu">
	     <li><a href="${pageContext.request.contextPath }/address/list">주소LIST</a></li>
	     <li><a href="${pageContext.request.contextPath }/address/create">주소등록</a></li>
      </ul> 
    </li>
    
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
      TEAM <span class="caret"></span></a>
      <ul class="dropdown-menu" role="menu">
	     <li><a href="${pageContext.request.contextPath }/team/list">팀LIST</a></li>
	     <li><a href="${pageContext.request.contextPath }/team/create">팀정보등록</a></li>

      </ul> 
    </li>
    
     <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
      BOARD <span class="caret"></span></a>
      <ul class="dropdown-menu" role="menu">
	     <li><a href="${pageContext.request.contextPath }/bbs/list">게시판</a></li>
	     <li><a href="${pageContext.request.contextPath }/bbs/create">게시글등록</a></li>

      </ul> 
    </li>
    
    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">
      IMAGE <span class="caret"></span></a>
      <ul class="dropdown-menu" role="menu">
	     <li><a href="${pageContext.request.contextPath }/imgbbs/list">이미지LIST</a></li>
	     <li><a href="${pageContext.request.contextPath }/imgbbs/create">이미지생성</a></li>

      </ul> 
    </li>
    <c:if test="${not empty sessionScope.id && sessionScope.grade=='A' }">
    	<li id="admin"><a href="${pageContext.request.contextPath }/member/logout">로그아웃</a></li>
     	<li id="admin"><a href="${pageContext.request.contextPath }/admin/list">회원목록</a></li>
    </c:if>
    </ul>
    </td> 
  </tr>
 
</table>
</div>
<!-- 상단 메뉴 끝 -->
 
 
 
<!-- 내용 시작 -->
<div style="width: 100%; padding-top: 10px;">