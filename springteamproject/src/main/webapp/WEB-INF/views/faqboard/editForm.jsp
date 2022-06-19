<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="..//module/jspheader.jsp" %>
<!DOCTYPE html>
<%--editForm.jsp--%>
<html>
<head>
<meta charset="UTF-8">
<title>editForm.jsp</title>
<style type="text/css">
table{
margin: auto;
width: 80%;
background-color: ivory;
}
</style>
</head>
<body>
<c:if test="${user_id==null}">
  <h2>로그인을 해야 글수정이 가능 합니다</h2>
</c:if>
<c:if test="${user_id!=null}">
  <h2>글수정 폼</h2>
  <form method="post" action="${ctxpath}/faqboard/editPro.do">
	<table border="1">
	  <tr>
	    <td>이름</td>
	    <td>
	    <input type="text" name="writer" id="writer" value="${faqDto.writer}">
	    <input type="hidden" name="num" value="${faqDto.num}">
	    </td>
	  </tr>
	  <tr>
	    <td>글제목</td>
	    <td><input type="text" name="subject" id="subject" value="${faqDto.subject}"></td>
	  </tr>
	  <tr>
	    <td>글내용</td>
	    <td>
	      <textarea name="content" id="content" rows="10" cols="50">${faqDto.content}</textarea>
	    </td>
	  </tr>
	  
	  <tr>
	    <td colspan="2" align="center">
	      <input type="submit" value="글수정">
	      <a href="${ctxpath}/faqboard/list.do?pageNum=${pageNum}">글목록</a>
	    </td>
	  </tr>
	</table>  
  </form>
</c:if>
</body>
</html>