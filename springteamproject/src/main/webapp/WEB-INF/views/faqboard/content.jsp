<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<%--content.jsp--%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function aa(){
	alert("로그인을 해야 글삭제가 가능 합니다");
	history.back();
}
</script>
<style type="text/css">
table{
margin: auto;
width: 80%;
}
</style>
</head>
<body>
  <h2>${faqDto.writer}님의 문의사항</h2>
  <table>
    <tr>
      <td align="right">
        <a href="${ctxpath}/faqboard/editForm.do?num=${num}&pageNum=${pageNum}">수정하기</a>&nbsp;
        
        
        <c:if test="${user_id==null}">
          <a href="javaScript:aa()">삭제하기
          </a>
         </c:if>
         
        <c:if test="${user_id!=null}">
        <a href="${ctxpath}/faqboard/delete.do?num=${num}&pageNum=${pageNum}">삭제하기</a>&nbsp;
        </c:if>
        <a href="${ctxpath}/faqboard/writeForm.do">문의하기</a>&nbsp;
        <a href="${ctxpath}/faqboard/writeForm.do?num=${num}&ref=${faqDto.ref}&re_step=${faqDto.re_step}&re_level=${faqDto.re_level}&pageNum=${pageNum}">답변작성</a>&nbsp;
        <a href="${ctxpath}/faqboard/list.do?pageNum=${pageNum}">목록으로</a>&nbsp;
      </td>
    </tr>
  </table>
  <table border="1">
    <tr>
      <td>글번호</td>
      <td>${faqDto.num}</td>
      <td>조회수</td>
      <td>${faqDto.readcount}</td>
    </tr>
    
    <tr>
      <td>작성자</td>
      <td>${faqDto.writer}</td>
      <td>작성일</td>
      <td><fmt:formatDate value="${faqDto.regdate}" type="time"/></td>
    </tr>
    
    <tr>
      <td>글제목</td>
      <td colspan="3">
        ${faqDto.subject}
      </td>
    </tr>
    
    <tr>
      <td>글내용</td>
      <td colspan="3">
        <pre>${faqDto.content}</pre>
      </td>
    </tr>
  </table>
</body>
</html>