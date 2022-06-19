<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ include file="../module/jspheader.jsp"%> 
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

<h2>글수정</h2>
<form method="post" action="${ctxpath}/free/editPro.do"> 
    <table>
      <tr>
        <td>이름</td>
        <td><input type="text" name="user_id" value="${user_id}" readonly>
            <input type="hidden" name="free_no" value="${freeDto.free_no}">
        </td>
        
      </tr>
      <tr>
        <td>글제목</td>
        <td><input type="text" name="subject" id="subject" value="${freeDto.subject}"></td>
      </tr>
      <tr>
        <td>글내용</td>
        <td>
          <textarea name="content" id="content" rows="10" cols="50">${freeDto.content}</textarea>
        </td>
      </tr>      
      <tr>
        <td colspan="2" align="center">
        <input type="submit" value="글쓰기">
        <a href="${ctxpath}/free/list.do?pageNum=${pageNum}">글목록</a>
       
        </td>
      </tr>
    </table>
  </form>
</body>
</html>