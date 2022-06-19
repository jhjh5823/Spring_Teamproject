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
	 
	  if(ff.subject.value==''){
		  alert("글제목을 입력 하세요");
		  ff.subject.focus();
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
 
  <h2>게시판 글쓰기</h2>
 
 <table>
   <tr>
     <td align="right">
       <a href="${ctxpath}/free/list.do">리스트</a>
     </td>
   </tr>
 </table>
 
 <form name="freeForm" method="post" action="${ctxpath}/free/writePro.do" onSubmit="return check(this)" encType="multipart/form-data">
   <table border="1" >
   
       <tr>
        <td>User_id</td>
        <td>
        <input type="text" name="user_id" id="user_id" value="${user_id}" readonly>
        <input type="hidden" name="ip" id="ip" value="<%=request.getRemoteAddr()%>">
        </td>
       </tr>
       
       <tr>
        <td>글제목</td>
        <td><input type="text" name="subject" id="subject">    
        </td>
       </tr>
       <tr>
        <td>글내용</td>
        <td>
        <textarea name="content" id="content" rows="10" cols="50"></textarea>
        </td>
        <tr>
 		<td>파일첨부</td>
        <td><input type="file" name="imgFile" id="imgFile"></td>
      </tr>
       <tr>
         <td colspan="2" align="center">
  
           <input type="submit" value="글쓰기">
         </td>
       </tr>
   </table>
 </form>

</body>
</html>