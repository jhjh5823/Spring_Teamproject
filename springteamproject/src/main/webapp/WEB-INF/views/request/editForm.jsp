<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>editForm.jsp</title>

 <style>
  	.layout{
  	width : 90%;
  	margin : auto;
  	margin-bottom: 20px;
  	}
  	.layout p{
  	 margin-right: 10px;
  	 font-size: 15px;
  	 color:rightgray;
  	 display: inline-block;
  	 text-align: center;
  	}
  	
  	.layout input{
  	box-sizing: border-box;
  	border: solid 1px lightgray;
  	margin-top: 15px;
  	margin-bottom: 20px;
    display: inline-block;
  	font-size: 17px;
  	width: 20%;
  	height: 25px;
  	right: 15px;
  	}
  	
 
  	.layout textarea {
	width: 100%;
	height: 300px;
	border: solid 1px lightgray;
	padding:20px;
	font-size: 15px;
	}
  </style>
</head>

<body>
<c:if test="${user_id==null}">
  <h2>로그인 후 글 수정 가능합니다.</h2>
</c:if>
<%-- 
<c:if test="${user_id!=null}">
  <script>
	alert('본인이 작성한 글만 수정가능합니다');
	history.back();
  </script>
</c:if>
--%>

<c:if test="${user_id!=null}">
  <h2>글 수정 </h2>
    <form method="post" action="${ctxpath}/request/editPro.do">
  	    <div id="main">
          <div class="layout">
 
         <p>분류</p>&nbsp;
       	  <select class="form-select" name="category" id="category" aria-label="Default select example">
  		  	
  		  	<option selected value="">카테고리 선택</option>           
            <option value="디지털기기">디지털기기</option>
            <option value="생활가전">생활가전</option>
            <option value="생활/가공식품">생활/가공식품</option>
            <option value="가구/인테리어">가구/인테리어</option>
            <option value="스포츠/레저">스포츠/레저</option>
            <option value="의류">의류</option>
            <option value="기타">기타</option>    
          </select>           
        
        <br>                   
              
       
        <p>제목</p>&nbsp;
        <input type="text" name="subject" id="subject" value="${requestDto.subject}">
                
      	<br><p>작성자</p>
        <input type="text" name="writer" id="writer" value="${requestDto.writer}" readonly>
        <input type="hidden" name="num" value="${requestDto.num}">     
                         
       	<br><p>글내용</p>
        <textarea name="content" id="content" rows="10" cols="50">${requestDto.content}</textarea>
 </div></div>

<div id="support">
  <table align="center">           
       <tr>
         <td colspan="2" align="center">
              <input  class="btn" type="submit" value="글수정">
                           
          <input type="button" class="btn" value="리스트" onClick="location.href='${ctxpath}/request/requestList.do?pageNum=${pageNum}'">
         </td>
       </tr>
 </table>
</div>

  </form>
 </c:if>
</body>
</html>