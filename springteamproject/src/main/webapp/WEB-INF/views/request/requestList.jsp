<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp"%> 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script>
 function aa(){
	 alert("로그인 후 이용할 수 있습니다")
	 return false;
 }
</script>
<style>

a{text-decoration: none;
color: black;
}
a:hover{
text-decoration: underline;
}

</style>
</head>
<body>

  <c:if test="${count==0}">
  게시판에 저장된 글이 없습니다
  </c:if>
  
   <c:if test="${count>0}">
   
  <h2>요청게시판</h2>
   <div id="support" align="right"> 
  <form name="searchForm" method="post" action="${ctxpath}/request/requestList.do?pageNum=${currentPage}">
  
    <table>
      <tr>
        <td>
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
  </div>
 <div id="main"> 
  <table width="100%">
  
    <tr id="tr-subject">    
      <th>no.</th>
      <th>글제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>   
    </tr>
  

    <c:forEach var="dto" items="${list}">
      <tr>
        <td width="10%" align="center">
          <c:out value="${number}"/>
          <c:set var="number" value="${number-1}"/>
        </td>
        
        
        <td width="50%">
        <!-- 답글들여쓰기 -->
		<c:if test="${dto.re_level>0}">
		 <span style="font-weight:bold;">
		 	<font color=blue>[팝니다]</font>
		 </span>
		</c:if>
              
        <!-- 글제목을 클릭하면 글 내용 보기로 가기 -->
        <a href="${ctxpath}/request/content.do?num=${dto.num}&pageNum=${currentPage}">
        ${dto.subject}
        </a>     
                
        <td width="15%" align="center">${dto.writer}</td>
        <td width="15%" align="center">
        <fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.wdate}"/></td>     
        <td width="10%" align="center">${dto.readcount}</td>
        
      </tr>
    </c:forEach>
  </table>
  </div>
  </c:if>
 
<div id="support" align="right">  
   <table>
    <tr>
      <td>
      
      <c:if test="${user_id==null}">
        <a href="javaScript:aa()"><button class="btn">글쓰기</button></a>
      </c:if>
           
      <c:if test="${user_id!=null}">
         <a href="${ctxpath}/request/writeForm.do"><button class="btn">글쓰기</button></a>
      </c:if>
      </td>
    </tr>
  </table>
</div>
  
  
   <%--블럭, 페이지 처리 --%>
<div id="support" align="center">   
  <table>
    <tr>
      <td>
        <!-- 에러방지 -->
          <c:if test="${endPage>pageCount}">
            <c:set var="endPage" value="${pageCount}"/>
          </c:if>
          
        <!-- 이전블럭 -->
        <c:if test="${startPage>10}">
          <a href="${ctxpath}/request/requestList.do?pageNum=${startPage-10}">>[이전블럭]</a>
        </c:if>
        
        <!-- 페이지 처리 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
      		<a href="${ctxpath}/request/requestList.do?pageNum=${i}">[${i}]</a>
      	</c:forEach>
      	
      	<!-- 다음블럭 -->
      	<c:if test="${endPage<pageCount}">
      	  <a href="${ctxpath}/request/requestList.do?pageNum=${startPage+10}">[다음블럭]</a>
      	</c:if>
      </td>
    </tr>
  </table>
 </div>
</body>
</html>