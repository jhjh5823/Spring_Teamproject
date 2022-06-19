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
  background-color: ivory;
  }
  </style>



</head>
<body>

<h2>글수정</h2>
<form method="post" action="${ctxpath}/notice/editPro.do"> 
    <table>
      <tr>
        <td>이름</td>
        <td><input type="text" name="writer" value="${noticeDto.writer}">
            <input type="hidden" name="noticeno" value="${noticeDto.noticeno}">
        </td>
        
      </tr>
      <tr>
        <td>글제목</td>
        <td><input type="text" name="subject" id="subject" value="${noticeDto.subject}"></td>
      </tr>
      <tr>
        <td>글내용</td>
        <td>
          <textarea name="content" id="content" rows="10" cols="50">${noticeDto.content}</textarea>
        </td>
      </tr>      
      <tr>
        <td colspan="2" align="center">
        <input type="submit" value="글쓰기">
        <a href="${ctxpath}/notice/list.do?pageNum=${pageNum}">글목록</a>
       
        </td>
      </tr>
    </table>
  </form>
</body>
</html>