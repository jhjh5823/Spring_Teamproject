<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="..//module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${ctxpath}/item/editPro.do" name="itemEditForm" method="post" enctype="Multipart/form-data">
  <input type="hidden" name="item_no" value="${itemDto.item_no}">
  <table>
    <tr> 
      <td colspan="2" align="left">
                     📷<input type="file" name="imgFile" id="imgFile">
      </td>
    </tr>
    
    <tr>
      <td>제목</td>
      <td><input type="text" id="item_name" name="item_name" size="30" value="${itemDto.item_name}"></td>
    </tr>
    
    <tr>
      <td>판매자명</td>
      <td><input type="text" id="item_seller" name="item_seller" value="${user_id}" readonly></td>
    </tr>
    
    <tr>
      <td>가격</td>
      <td><input type="text" id="item_price" name="item_price" size="30" value="${itemDto.item_price}"></td>
    </tr>
    
    <tr>
      <td>판매 지역</td> 
      <td><input type="text" id="item_area" name="item_area" size="30" value="${itemDto.item_area}"></td> 
    </tr>
    
    <tr>
      <td>상품 설명</td>
      <td><textarea id="item_detail" name="item_detail" cols="50" rows="10" value="${itemDto.item_detail}"></textarea></td>
    </tr>
  
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="상품등록">
      </td>
    </tr>
  </table>
</form>
</body>
</html>