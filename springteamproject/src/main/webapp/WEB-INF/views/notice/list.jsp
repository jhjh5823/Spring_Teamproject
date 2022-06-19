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
	background-color: ivory;
}

</style>
</head>
<body>
  <h2>글목록(전제글:${count})</h2>
  <table>
    <tr>
      <td align="right">
      <c:if test="${id!=null}">
        <a href="${ctxpath}/notice/writeForm.do">글쓰기</a>
        </c:if>
      </td>
    </tr>
  </table>
  
  <form name="searchForm" method="post" action="${ctxpath}/notice/list.do?pageNum=${currentPage}">
    <table >
      <tr>
        <td align="center">
          <select name="keyField">
            <option value="writer">작성자</option>
            <option value="subject">글제목</option>
            <option value="content">글내용</option>
          </select>
          
          <input type="text" name="keyWord">
          <input type="submit" value="검색">
        </td>
      </tr>
    </table>
  </form>
 
   <table border="1">
    <tr>
      <th>글번호</th>
      <th>작성자</th>
      <th>글제목</th>
      <th>글내용</th>
      <th>날짜</th>
      <th>조회수</th>
      <th>비고</th>
    </tr>
    
    <c:forEach var="noticeDto" items="${list}">
      <tr>
        <td>${noticeDto.noticeno}</td>
        <td>${noticeDto.writer}</td>
        <td>
        <a href="${ctxpath}/notice/content.do?noticeno=${noticeDto.noticeno}&pageNum=${currentPage}">
             ${noticeDto.subject}
           </a>
        </td>
        <td>${noticeDto.content}</td>
        <td>${noticeDto.regdate}</td>
        <td>${noticeDto.readcount}</td>
        <td>
      	<c:if test="${noticeDto.emer==1}">
      	긴급
      	</c:if>
      	<c:if test="${noticeDto.emer==0}">
      	</c:if>
      	</td>
      </tr>
    </c:forEach>
  </table>
  
   <!-- 블럭 페이지처리 -->
  <table>
    <tr>
      <td align="center">
        <!-- 에러방지 -->
        <c:if test="${endPage>pageCount}">
          <c:set var="endPage" value="${pageCount}"/>
        </c:if>
        
        <!-- 이전블럭 -->
        <c:if test="${startPage>10}">
          <a href="${ctxpath}/notice/list.do?pageNum=${startPage-10}">[이전블럭]</a>
        </c:if>
        
        <!-- 페이지처리 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="${ctxpath}/notice/list.do?pageNum=${i}">[${i}]</a>
        </c:forEach>
        
        <!-- 다음블럭처리 -->
        <c:if test="${endPage<pageCount}">
          <a href="${ctxpath}/notice/list.do?pageNum=${startPage+10}">[다음블럭]</a>
        </c:if>
      </td>
    </tr>
  </table>
  </body>
</html>