<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>    
    <%--itemList.jsp --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h2{
text-align: center;
}

table{
margin: auto;
min-width: 50%;
max-width: 80%;
}

.fixed-search-input{
display:block;
width:100%;
border:5px solid cyan;
padding:0;
margin:0;
font-size:18px;
color:#212529;
background-color:transparent}

.fixed-search-submit{
display:block;
width:5%;
border:2px solid cyan;
padding:0;
margin:0;
font-size:15px;
color:#212529;
background-color:transparent}
a{
text-decoration: none;
}
</style>

</head>
<body>
 <h2>중고거래 매물 [등록된 총 상품수:${list.size()}]</h2>
 <div><br></div>
 <a href="${ctxpath}/item/itemWriteForm.do">판매글 작성하기</a>
 <div><br></div>
  <table>
    <tr>
      <td align="right" colspan="4">
        <form name="searchForm" method="get" action="${ctxpath}/item/itemList.do">
          <input type="search" name="search" id="search" class="fixed-search-input" placeholder=" 동네 이름, 물품명 등을 검색해보세요!">
          <input type="submit" class="fixed-search-submit" value="🔎">
        </form>
      </td>
    </tr>
    <tr>
      <c:set var="cnt" value="-1"/>
      
      <c:forEach var="itemDto" items="${list}">
        
        <c:set var="cnt" value="${cnt+1}"/>
        <c:if test="${cnt%4==0}">
          </tr>
          <tr>
        </c:if>
        
         <td>
         <table>
          <tr>
            <td colspan="2" align="left">
              <a href="${ctxpath}/item/itemDetail.do?num=${itemDto.item_no}">
              <img src="${ctxpath}/resources/itemimgs/${itemDto.item_image}" width="200" height="200">
              </a>
            </td>
          </tr>
          
          <tr>
            <td colspan="2">
              ${itemDto.item_name}
            </td>
          </tr>
          
          <tr>
            <td>가격 :</td>
            <td>${itemDto.item_price}원</td>
          </tr>
          
          <tr>
            <td>등록일 :</td>
            <td><fmt:formatDate value="${itemDto.item_regdate}" type="time"/></td>
          </tr>
          
        </table>
      </td>
      
    </c:forEach>
    
    </tr>
  </table>
</body>
</html>