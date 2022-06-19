<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>content.jsp</title>


<script>
 function aa(){
	 alert("로그인 후 이용할 수 있습니다")
	 history.back();
 }
</script>

</head>
<body>

 <h2>요청게시판</h2>

  
<div id="main">
	
   <table align="center">
   
    <tr>
      <th class="td-subject">${requestDto.num}</th>
      <th colspan="2" class="td-subject">${requestDto.subject}</th> 
    </tr>  
    
    <tr> 
      <td class="td-subject2">작성자 : ${requestDto.writer}</td>
      
      <td class="td-date">DATE : ${requestDto.wdate}<br>
      READ : ${requestDto.readcount}</td>
      
   </tr>
    
  <tr>
    <td colspan="3" class="td-content">
    ${requestDto.content}
    </td>
  </tr>   
  </table>
  </div>
     
  <div id="support" align="right">
    <table>  
     <tr>    
     <td>     
        

        <c:if test="${user_id==null}">
          <a href="javaScript:aa()"><button type="button" class="btn">글수정</button></a>&nbsp;
          <a href="javaScript:aa()"><button type="button" class="btn">글삭제</button></a>&nbsp;
          <a href="javaScript:aa()"><button type="button" class="btn">답 글</button></a>&nbsp;      
        </c:if>
      
        <c:if test="${user_id!=null}">
          <a href="${ctxpath}/request/editForm.do?num=${num}&pageNum=${pageNum}"><button type="button" class="btn">글수정</button></a>&nbsp;
          <a href="${ctxpath}/request/delete.do?num=${num}&pageNum=${pageNum}"><button type="button" class="btn">글삭제</button></a>&nbsp;
          <a href="${ctxpath}/request/writeForm.do?num=${num}&ref=${requestDto.ref}&re_step=${requestDto.re_step}&re_level=${requestDto.re_level}"><button type="button" class="btn btn-outline-warning btn-sm">답 글</button></a>&nbsp;
        </c:if>
        
        <a href="${ctxpath}/request/requestList.do?pageNum=${pageNum}"><button type="button" class="btn btn-outline-warning btn-sm">목 록</button></a>&nbsp;    	
        </td>     
    </tr>
    
    </table>     
  </div>

</body>
</html>