<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>writeForm.jsp</title>
  <style type="text/css">
  
  h2{
  text-align: center;
  }
  
  table{
  margin: auto;
  width: 60%;
  }
  </style>
  
  <script type="text/javascript">
  
  function check(ff){
	  if(ff.writer.value==''){
		  alert("이름을 입력 하세요");
		  ff.writer.focus();
		  return false;
	  }
	  
	  if(ff.subject.value==''){
		  alert("글제목을 입력 하세요");
		  ff.subject.focus();
		  return false;
	  }
	  
	  if(ff.emer.value==''){
		  alert("글종류를 입력 하세요");
		  ff.content.focus();
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
       <a href="${ctxpath}/notice/list.do">리스트</a>
     </td>
   </tr>
 </table>
 
 <form name="noticeForm" method="post" action="${ctxpath}/notice/writePro.do" onSubmit="return check(this)">
   <table border="1">
       <tr>
        <td>이름</td>
        <td><input type="text" name="writer" id="writer"></td>
       </tr>
       
       <tr>
        <td>글제목</td>
        <td><input type="text" name="subject" id="subject">
            <input type="checkbox" name="emer" id="emer" value="1">긴급
        	<input type="checkbox" name="emer" id="emer" value="0">일반    
        </td>
       </tr>
       <tr>
        <td>글내용</td>
        <td>
        <textarea name="content" id="content" rows="10" cols="50"></textarea>
        </td>
       </tr>
       <tr>
         <td colspan="2" align="center">
  
           <input type="submit" value="글쓰기">
          <input type="reset" value="다시쓰기">
         </td>
       </tr>
   </table>
 </form>
 
</body>
</html>