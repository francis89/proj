<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="elfnc" uri="/ELFunctions" %>

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
function incheck(f){ //f는 그냥 변수 그냥 다른걸로 써도됨
  if(f.name.value==""){
    alert("이름을 입력하세요");
    f.name.focus();
    return false;
  }
  if(f.title.value==""){
    alert("제목을 입력하세요");
    f.title.focus();
    return false;
  }
  if(f.content.value==""){
    alert("내용을 입력하세요");
    f.content.focus();
    return false;
    }
  if(f.passwd.value==""){
    alert("패스워드를 입력하세요");
    f.passwd.focus();
    return false;
  }
  
}


</script>
<link href="${pageContext.request.contextPath }/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./update'
	  enctype="multipart/form-data" 
	  onsubmit="return incheck(this)">
 
  <input name="no" value="${dto.no }" type="hidden">
  <input name="col" value="${param.col }" type="hidden">
  <input name="word" value="${param.word }" type="hidden">
  <input name="nowPage" value="${param.nowPage }" type="hidden">
  <input name="oldfile" value="${dto.filename }" type="hidden">
  <TABLE style="width: 45%;">
     <TR>
      <TD colspan="2">
      <img style="width:300px;height:200px;" src="${pageContext.request.contextPath }/imgbbs/storage/${dto.filename }">
      </TD>
      <td></td>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="name" size="40" value="${dto.name }"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="40" value="${dto.title }"></TD>
    </TR>
    <TR>
      <TH>사진파일</TH>
      <TD><input type="file" name="fileMF" size="40">${dto.filename}</TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD>
      <textarea rows="10" cols="40" name="content">${dto.content }</textarea>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 