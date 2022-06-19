<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${user_id==null}">
  <h2>로그인을 해야 글쓰기가 가능합니다</h2>
  
</c:if>
<c:if test="${user_id!=null}">
<form action="${ctxpath}/item/itemWritePro.do" name="itemWriteForm" method="post" enctype="Multipart/form-data">
  <input type="hidden" name="num" value="${num}">
  <table>
    <tr> 
      <td colspan="2" align="left">
                     📷<input type="file" name="imgFile" id="imgFile">
      </td>
    </tr>
    
    <tr>
      <td>제목</td>
      <td><input type="text" id="item_name" name="item_name" size="30" placeholder="제목"></td>
    </tr>
    
    <tr>
      <td>판매자명</td>
      <td><input type="text" id="item_seller" name="item_seller" value="${user_id}" readonly></td>
    </tr>
    
    <tr>
      <td>가격</td>
      <td><input type="text" id="item_price" name="item_price" size="30" placeholder="💰 가격"></td>
    </tr>
    
    <tr>
      <td>판매 지역</td> 
      <td><input type="text" id="item_area" name="item_area" size="30" placeholder="판매지역"></td> 
    </tr>
    
    <tr>
      <td>상품 설명</td>
      <td><textarea id="item_detail" name="item_detail" cols="50" rows="10" placeholder="게시글의 내용을 작성해주세요.                      가품 및 판매금지품목은 게시가 제한될 수 있어요."></textarea></td>
    </tr>
  
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="상품등록">
      </td>
    </tr>
  </table>
</form>
</c:if>
</body>
</html>