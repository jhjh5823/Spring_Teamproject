<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<style type="text/css">
table{
margin: auto;
width: 80%;
}
</style>
</head>
<body>
  <c:if test="${count==0}">
    문의사항이 없습니다 
  </c:if>
  
  <c:if test="${count>0}">
  <h2>문의목록(전체):${count}</h2>
  <table>
    <tr>
      <td align="right">
        <a href="${ctxpath}/faqboard/writeForm.do">작성하러 가기</a>
      </td>
    </tr>
  </table>
  
  
  <form name="searchForm" method="post" action="${ctxpath}/faqboard/list.do?pageNum=${currentPage}">
    <table>
      <tr>
        <td align="right">
        <select name="keyField">
          <option value="writer">작성자</option>
          <option value="subject">제목</option>
          <option value="content">내용</option>
        </select>
        <input type="text" name="keyWord">
        <input type="submit" value="검색">
        </td>
      </tr>
    </table>
  </form>
 
    <table border="1">
      <tr bgcolor="#ffB4B4">
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>IP</th>
      </tr>
      
      <c:forEach var="dto" items="${list}">
        <tr>
          <td>
            <c:out value="${number}"/>
            <c:set var="number" value="${number-1}"/>
          </td>
          
          <%-- 글제목 --%>
          <td>
          <c:if test="${dto.cs_open=='2'}">
            <c:choose>
              <c:when test="${user_id==dto.writer || user_id=='admin'}">
                <%-- 답글 들여쓰기 --%>
                <c:if test="${dto.re_level>0}">
                <img src="${ctxpath}/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
                <img src="${ctxpath}/resources/imgs/re.gif">
                </c:if>
                <%-- 원글 --%>
                <c:if test="${dto.re_level==0}">
                <img src="${ctxpath}/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
                </c:if>
            
                <%-- 제목을 클릭하면 글내용 보기로 가기 --%>
                <a href="${ctxpath}/faqboard/content.do?num=${dto.num}&pageNum=${currentPage}">
                ${dto.subject}
                </a>
                </c:when>
                <c:otherwise>
                  <c:if test="${dto.re_level>0}">
                  <img src="${ctxpath}/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
                  <img src="${ctxpath}/resources/imgs/re.gif">
                  </c:if>
                                          비밀글입니다 
                </c:otherwise>
            </c:choose>
          </c:if>
          <c:if test="${dto.cs_open=='1'}">
                <%-- 답글 들여쓰기 --%>
                <c:if test="${dto.re_level>0}">
                <img src="${ctxpath}/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
                <img src="${ctxpath}/resources/imgs/re.gif">
                </c:if>
                <%-- 원글 --%>
                <c:if test="${dto.re_level==0}">
                <img src="${ctxpath}/resources/imgs/level.gif" width="${5*dto.re_level}" height="16">
                </c:if>
            
                <%-- 제목을 클릭하면 글내용 보기로 가기 --%>
                <a href="${ctxpath}/faqboard/content.do?num=${dto.num}&pageNum=${currentPage}">
                ${dto.subject}
                </a>
          </c:if>
          </td>
          <td>${dto.writer}</td>
          <td><fmt:formatDate value="${dto.regdate}" type="time"/></td>
          <td>${dto.ip}</td>
        </tr>
      </c:forEach>
    </table>
  </c:if>
  <%--블럭,페이지 처리--%>
  <table>
    <tr>
      <td align="center">
      
        <%-- 에러방지 --%>
        <c:if test="${endPage>pageCount}">
          <c:set var="endPage" value="${pageCount}"/>
        </c:if>
        
        <%-- 이전 블럭 --%>
        <c:if test="${startPage>10}">
          <a href="${ctxpath}/faqboard/list.do?pageNum=${startPage-10}">[이전블럭]</a>
        </c:if>
        
        <%--페이지처리 --%>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="${ctxpath}/faqboard/list.do?pageNum=${i}">[${i}]</a>
        </c:forEach>
        
        <%--다음블럭 처리 --%>
        <c:if test="${endPage<pageCount}">
          <a href="${ctxpath}/faqboard/list.do?pageNum=${startPage+10}">[다음블럭]</a>
        </c:if>
      </td>
    </tr>
  </table>
  
</body>
</html>