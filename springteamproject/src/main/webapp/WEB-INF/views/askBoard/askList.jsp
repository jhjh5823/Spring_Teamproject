<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>askList.jsp</title>
	
	<style type="text/css">
	.ask_list td {
	padding: 5px 0;
	text-align: center;
	border-bottom: 1px solid #e5e5e5;
	}
	.ask_list th {
	border-top: 1px solid #e5e5e5;
	border-bottom: 1px solid #e5e5e5;
	padding: 5px 0;
	text-align: center;
	background: #faf9fa;
	}
	</style>
	
	<style type="text/css">
	h2 {
	text-align: center;
	}
	table {
	margin: auto;
	width: 60%;
	}
	#button_style {
	border: 2px solid orange;
	background-color: white;
	color: orange;
	padding: 5px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	}
	</style>
</head>
<body>
	
	<h2>1:1문의</h2>

	<table>
		<tr>
			<td align="right">
			<c:if test="${user_id != 'admin'}">
				<input type="button" value="문의하기" id="button_style" onClick="location='${ctxpath}/askBoard/writeAskForm.do'">
			</c:if>
			</td>
		</tr>
	</table>

	<table class="ask_list">
  
	<tr>    
		<th>no</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th> 
	</tr>
  
	<c:forEach var="askBoardDto" items="${list}">
		<tr>
			<td width="10%" align="center">
				<c:out value="${number}"/>
				<c:set var="number" value="${number-1}"/>
			</td>
        	
			<td width="40%" align="center">
				<!-- 답글 들여쓰기 -->
				<c:if test="${askBoardDto.ask_relevel > 0}">
					ㄴ[답변] 
				</c:if>
              
				<!-- 글제목을 클릭하면 글 내용 보기로 가기 -->
				<a href="${ctxpath}/askBoard/askContent.do?ask_num=${askBoardDto.ask_num}&pageNum=${currentPage}">
					${askBoardDto.ask_subject}
				</a>
			</td>
			
			<td width="20%" align="center">${askBoardDto.ask_writer}</td>
			
			<td width="40%" align="center">${askBoardDto.ask_regdate}</td>     
		</tr>
    </c:forEach>
	</table>

	<%--블럭, 페이지 처리 --%>
	<table>
		<tr>
			<td align="center">
			<!-- 에러방지 -->
			<c:if test="${endPage > pageCount}">
			<c:set var="endPage" value="${pageCount}"/>
			</c:if>
          
			<!-- 이전블럭 -->
			<c:if test="${startPage > 10}">
			<a href="${ctxpath}/askBoard/askList.do?pageNum=${startPage-10}">[이전]</a>
			</c:if>
        
			<!-- 페이지 처리 -->
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${ctxpath}/askBoard/askList.do?pageNum=${i}">[${i}]</a>
			</c:forEach>
      	
			<!-- 다음블럭 -->
			<c:if test="${endPage < pageCount}">
			<a href="${ctxpath}/askBoard/askList.do?pageNum=${startPage+10}">[다음]</a>
			</c:if>
			</td>
		</tr>
	</table>
</body>
</html>