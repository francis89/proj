<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.img {
	width: 100%;
	height: 55%;
}

li#admin {
	float: right;
	padding-right: 30px;
}

body {
	background-color: black;
}
</style>
</head>
<body>
	<!-- 상단 메뉴 -->
	<div style="background-color: white;">
		<table style="width: 100%">
			<tr>
				<td><img class="img"
					src="${pageContext.request.contextPath }/images/marvel_1.jpg">
				</td>
			</tr>
		</table>
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#myNavbar">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="${pageContext.request.contextPath }/">Home</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<c:choose>
							<c:when test="${empty sessionScope.id }">
								<li><a
									href="${pageContext.request.contextPath }/member/agree">Create</a></li>
							</c:when>
							<c:when
								test="${not empty sessionScope.id && sessionScope.grade == 'H' }">
								<li class="dropdown"><a class="dropdown-toggle"
									data-toggle="dropdown" href="#"> MyInfo <span class="caret"></span></a>
									<ul class="dropdown-menu" role="menu">
										<li><a
											href="${pageContext.request.contextPath }/member/read">Info</a></li>
										<li><a
											href="${pageContext.request.contextPath }/member/update">Update</a></li>
										<li><a
											href="${pageContext.request.contextPath }/member/delete">ID_DEL</a></li>
									</ul>
								</li>

							</c:when>
						</c:choose>
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"> BOARD <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="${pageContext.request.contextPath }/bbs/list">BBS</a></li>
								<li><a href="${pageContext.request.contextPath }/imgbbs/list">ImgBBS</a></li>
								<li><a href="${pageContext.request.contextPath }/memo/list">MEMO</a></li>
							</ul></li>
				
					</ul>
					<ul class="nav navbar-nav navbar-right">
					<c:if
							test="${not empty sessionScope.id && sessionScope.grade=='A' }">
							<li class="dropdown"><a class="dropdown-toggle"
								data-toggle="dropdown" href="#"> Admin <span class="caret"></span></a>
								<ul class="dropdown-menu" role="menu">
									<li id="admin"><a
										href="${pageContext.request.contextPath }/admin/list">Member</a></li>
									<li><a
										href="${pageContext.request.contextPath }/team/list">Team</a></li>
									<li><a
										href="${pageContext.request.contextPath }/admin/cal/calendar">Calendar</a></li>
								</ul>
						</c:if>
					
					
					<c:choose>
						<c:when test="${not empty sessionScope.id}">
							<li><a href="${pageContext.request.contextPath }/member/logout">
								<span class="glyphicon glyphicon-log-in"></span> Logout
							</a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${pageContext.request.contextPath }/member/login"> <span
									class="glyphicon glyphicon-log-in"></span> Login
							</a></li>
						</c:otherwise>
					</c:choose>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<!-- 상단 메뉴 끝 -->



	<!-- 내용 시작 -->
	<div class="content" style="background-color: #8B8A8A;">