<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="style.jsp"%> 
<%@ include file="../module/jspheader.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="device-width, initial-scale=1.0">
  
    <title>Header</title> 
 
  <!-- Place your kit's code here -->
  <script src="https://kit.fontawesome.com/75ed03f504.js" crossorigin="anonymous"></script>
  
  <script type="text/javascript">
	function updateUser() {
	//내정보 수정
		document.modifyForm.action="${ctxpath}/member/memberUpdateForm.do";
		document.modifyForm.submit();
}
  </script>
        
</head>
     
 
<body>
  <div class="login-header">
  	<c:if test="${user_id==null}">
      <a href="${ctxpath}/member/loginForm.do">로그인</a>&nbsp;
      <a href="${ctxpath}/member/insertForm.do">회원가입</a>
    </c:if>
    
    <c:if test="${user_id!=null}">
      <a href="javaScript:updateUser()">마이페이지</a>&nbsp;
      <a href="${ctxpath}/member/logOut.do">로그아웃</a>&nbsp;  
    </c:if>
  </div>
	<nav class="navbar">
		<div class="navbar__logo">
			<i class="fa-solid fa-carrot"></i>		
			<a href="${ctxpath}/board/list.do">당근24</a>
		</div>
		
		<ul class="navbar__menu">
			 <li><a href="${ctxpath}/notice/list.do">공지사항</a></li>
   			 <li><a href="${ctxpath}/item/itemList.do">상품목록</a></li>
   			 <li><a href="${ctxpath}/request/requestList.do">요청게시판</a></li>
   			 <li><a href="${ctxpath}/free/list.do">자유게시판</a></li>
   			 <li><a href="${ctxpath}/askBoard/askList.do">1:1문의</a></li>
   			 <li> <a href="${ctxpath}/faqboard/faqHome.do">FAQ</a></li>
		</ul>
		
		<ul class="navbar__icons">
			<li><a href="https://www.youtube.com/watch?v=PYLw3HdHyAM"><i class="fab fa-twitter"></i></a></li>
			<li><i class="fab fa-facebook-f"></i></li>	
		</ul>
		
		<a href="#" class="navbar__toogleBtn">
			<i class="fa-solid fa-bars"></i>
		</a>
	</nav>
<form name="modifyForm" method="post">
  <input type="hidden" name="user_id" id="user_id" value="${user_id}"> 
</form>
  
</body>
</html>
