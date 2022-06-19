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
      		<c:if test="${user_id!=null}">
           <a href="${ctxpath}/free/editForm.do?free_no=${free_no}&pageNum=${pageNum}">글수정</a>&nbsp;
          <a href="${ctxpath}/free/delete.do?free_no=${free_no}&pageNum=${pageNum}">글삭제</a>&nbsp;
          </c:if>
        <a href="${ctxpath}/free/list.do?pageNum=${pageNum}">글목록</a>&nbsp;
      </td>
    </tr>
  </table>
  
  <table border="1">
    <tr>
      <td>글번호</td>
      <td>${freeDto.free_no}</td>
      <td>조회수</td>
      <td>${freeDto.readcount}</td>
    </tr>
    
    <tr>
      <td>작성자</td>
      <td>${freeDto.user_id}</td>
      <td>작성일</td>
      <td>${freeDto.regdate}</td>
    </tr>
    
    <tr>
      <td>글제목</td>
      <td colspan="3">
        ${freeDto.subject}
      </td>
    </tr>
    
    <tr>
      <td>글내용</td>
      <td colspan="3">
        <pre>${freeDto.content}</pre>
      </td>
    </tr>
  </table>
  
  <table border="1">
    <tr>
		   
      <td colspan="2"> 
       <c:forEach items="${reply}" var="reply">
	
        <div>
       
          <p>${reply.reply_writer} / ${reply.reply_regDate}
          <c:if test="${user_id==reply.reply_writer || user_id=='admin'}">
          <a href="${ctxpath}/free/replyDelete.do?reply_rno=${reply.reply_rno}&free_no=${free_no}&pageNum=${pageNum}">글 삭제하기</a>
          </c:if>
          </p>
          <p>${reply.reply_content}&nbsp;</p>
        </div>
        
</c:forEach>

<div>
<c:if test="${user_id!=null}">
  <form method="post" action="${ctxpath}/free/replyWritePro.do">
  <p>
    <label>댓글 작성자</label>&nbsp;<input type="text" id="reply_writer" name="reply_writer" value="${user_id}" readonly>
  </p>
  <p>
    <textarea id="reply_content" name="reply_content" rows="3" cols="50"></textarea>
  	<input type="hidden" name="free_no" id="free_no" value="${freeDto.free_no}">
    <input type="submit" value="댓글 작성">
  </p>
  </form>
   </c:if>
</div>
    </tr>
  </table>
  
    <!-- 
    <li>
        <div>
            <p>첫번째 댓글 작성자</p>
            <p>첫번째 댓글</p>
        </div>
    </li>
    <li>
        <div>
            <p>두번째 댓글 작성자</p>
            <p>두번째 댓글</p>
        </div>
    </li>
    <li>
        <div>
            <p>세번째 댓글 작성자</p>
            <p>세번째 댓글</p>
        </div>
    </li>
    -->
    
</body>
</html>