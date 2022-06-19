<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>modify.jsp</title>
  <script type="text/javascript">
  function updateUser() {
      //내정보수정
      document.updateForm.action="${ctxpath}/member/memberUpdateForm.do";
      document.updateForm.submit();
}
  function deleteUser() {
     document.deleteForm.action="${ctxpath}/member/memberDeleteForm.do";
      document.deleteForm.submit();
}
  </script>
</head>
<body>
<a href="javaScript:updateUser()">내정보수정</a>&nbsp;
<a href="javaScript:deleteUser()">회원탈퇴</a>&nbsp;


<form name="updateForm" method="post">
  <input type="hidden" name="user_id" id="user_id" value="${user_id}">
</form>

<form name="deleteForm" method="post">
  <input type="hidden" name="user_id" id="user_id" value="${user_id}">
</form>
</body>
</html>