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
  
  <h2>자유게시판(전제글:${count})</h2>
  <table>
    <tr>
      <td align="right">
      <c:if test="${user_id!=null}">
        <a href="${ctxpath}/free/writeForm.do">글쓰기</a>
        </c:if>
      </td>
    </tr>
  </table>
  
  <form name="searchForm" method="post" action="${ctxpath}/free/list.do?pageNum=${currentPage}">
    <table >
      <tr>
        <td align="center">
          <select name="keyField">
            <option value="user_id">작성자</option>
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
      <th>날짜</th>
      <th>조회수</th>
    </tr>
    
    <c:forEach var="freeDto" items="${list}">
      <tr>
        <td>${freeDto.free_no}</td>
        
        <td>${freeDto.user_id}</td>
        <td>
        <a href="${ctxpath}/free/content.do?free_no=${freeDto.free_no}&pageNum=${currentPage}">
             ${freeDto.subject}
             <c:if test="${freeDto.img!=null}">
        	 <img src="../../resources/img/품절.jpg">
         	 </c:if>
           </a>
        </td>
        <td>${freeDto.regdate}</td>
        <td>${freeDto.readcount}</td>
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
          <a href="${ctxpath}/free/list.do?pageNum=${startPage-10}">[이전블럭]</a>
        </c:if>
        
        <!-- 페이지처리 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="${ctxpath}/free/list.do?pageNum=${i}">[${i}]</a>
        </c:forEach>
        
        <!-- 다음블럭처리 -->
        <c:if test="${endPage<pageCount}">
          <a href="${ctxpath}/free/list.do?pageNum=${startPage+10}">[다음블럭]</a>
        </c:if>
      </td>
    </tr>
  </table>
  </body>
</html>