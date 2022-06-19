<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style type="text/css">
    table {
	margin: auto;
	width: 60%;
  }
  </style>
</head>
<body>
 <h2>글내용보기</h2>
  
  <table>
    <tr>
      <td align="right">
          <c:if test="${id!=null}">
          <a href="${ctxpath}/notice/editForm.do?id=${id}&pageNum=${pageNum}">글수정</a>&nbsp;
          <a href="${ctxpath}/notice/delete.do?id=${id}&pageNum=${pageNum}">글삭제</a>&nbsp;
          </c:if>
        <a href="${ctxpath}/notice/list.do?pageNum=${pageNum}">글목록</a>&nbsp;
      </td>
    </tr>
  </table>
  
  <table border="1">
    <tr>
      <td>글번호</td>
      <td>${noticeDto.noticeno}</td>
      <td>조회수</td>
      <td>${noticeDto.readcount}</td>
    </tr>
    
    <tr>
      <td>작성자</td>
      <td>${noticeDto.writer}</td>
      <td>작성일</td>
      <td>${noticeDto.regdate}</td>
    </tr>
    
    <tr>
      <td>글제목</td>
      <td colspan="3">
        ${noticeDto.subject}
      </td>
    </tr>
    
    <tr>
      <td>글내용</td>
      <td colspan="3">
        <pre>${noticeDto.content}</pre>
      </td>
    </tr>
  </table>
</body>
</html>