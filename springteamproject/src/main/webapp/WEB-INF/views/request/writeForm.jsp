<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>writeForm.jsp</title>
  
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
  	right: 20px;
  	}
  	
 
  	.layout textarea {
	width: 100%;
	height: 300px;
	border: solid 1px lightgray;
	padding:20px;
	font-size: 15px;
	}
  </style>

  <script type="text/javascript">
  
  function check(ff){
	  
	  if(ff.category.value==''){
		  alert("카테고리를 선택하세요");
		  ff.category.focus();
		  return false;
		  
	  }
	  
	  if(ff.subject.value==''){
		  alert("글제목을 입력 하세요");
		  ff.subject.focus();
		  return false;
	  }
	  
	  if(ff.writer.value==''){
		  alert("작성자를 입력 하세요");
		  ff.writer.focus();
		  return false;
	  }
	  	  
	  if(ff.content.value==''){
		  alert("글내용을 입력 하세요");
		  ff.content.focus();
		  return false;
		  
	  }
	    
	  return true;
  }
  </script>
</head>
<body>


 <c:if test="${num==0 }">
  <h2>요청게시판 글쓰기</h2>
 </c:if>
          
 <c:if test="${num!=0}">
    <h2>답글쓰기</h2>
 </c:if>

 <form name="writeForm" method="post" action="${ctxpath}/request/writePro.do" onSubmit="return check(this)">
   
   <input type="hidden" name="pageNum" value="${pageNum}">
   <input type="hidden" name="num" value="${num}">
   <input type="hidden" name="ref" value="${ref}">
   <input type="hidden" name="re_step" value="${re_step}">
   <input type="hidden" name="re_level" value="${re_level}">
 
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
        <!-- 원글 -->
        <c:if test="${num==0 }">
        <p>제목</p>&nbsp;
        <input type="text" name="subject" id="subject">
        </c:if>
        
        <!-- 답글 -->
        <c:if test="${num!=0}">    
        <p>제목</p>&nbsp;&nbsp;&nbsp; 
        <span style="color:blue;">[팝니다]</span><input type="text" name="subject" id="subject" value="${dto.subject}">          
        </c:if>       
                      
      	<br><p>작성자</p>
        <input type="text" name="writer" id="writer" value="${user_id}" readonly>
               
                         
       	<br><p>글내용</p>
        <textarea name="content" id="content" rows="10" cols="50"></textarea>
        
   </div> 
</div>  

<div id="support">
<table align="center">           
       <tr>
         <td colspan="2" align="center">
          <c:if test="${num==0 }">
           <input class="btn" type="submit" value="글쓰기">
          </c:if>
          
          <c:if test="${num!=0}">
            <input  class="btn" type="submit" value="답글쓰기">
          </c:if>
          
          <button class="btn" type="reset">다시쓰기</button>
          <input type="button" class="btn" value="리스트" onClick="location.href='requestList.do'">
         </td>
       </tr>
 </table>
 </div>
</form>
 
</body>
</html>