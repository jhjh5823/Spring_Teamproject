<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.code{
    color: #191919;  
    display: block;  
    font-family: sans-serif; 
    font-size: 18px;  
    margin: 8px;  
    padding: 4px;
}
.code_div {
	font-size: 1rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	vertical-align: middle;
}
.link_div {
	font-size: 0.8rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	width: 10%;
}
.reply {
	width: 70%; font-size : 1.5rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	vertical-align: middle;
	font-size: 1.5rem;
	border-bottom: 1px solid #e9ecef;
}

.reply-link {
	background-color: #fff;
	display: block;
	text-decoration: none;
	color: orange;
}
</style>
</head>
<body>
<table align="center">
  <tr>
    <td colspan="2" align="center">
      <img src="${ctxpath}/resources/itemimgs/${itemDto.item_image}" width="500" height="500">
    </td>
  </tr>
</table>
<br>
<table align="center" width="40%">
  <tr>
    <td>
           π <b>${itemDto.item_seller}</b><br>
       &nbsp;${itemDto.item_area}
    </td>
  </tr>
</table>
<br>
<table align="center" width="40%"> 
  <tr>
    <td>
      <b>${itemDto.item_name}</b>
    </td>
  </tr>
  <tr>
    <td>
          π°  ${itemDto.item_price}μ
    </td>
  </tr>
</table>
<br>
<table align="center" width="40%">
  <tr>
    <td>
      <pre class="code">${itemDto.item_detail}</pre>
    </td>
  </tr>
</table>
<br><br>
<div class="link_div" align="right">
<c:if test="${user_id==itemDto.item_seller || user_id=='admin'}">
  <a class="reply-link" href="${ctxpath}/item/delete.do?num=${item_no}">κΈ μ­μ νκΈ°</a>&nbsp;
  <a class="reply-link" href="${ctxpath}/item/itemEditForm.do?num=${item_no}">κΈ μμ νκΈ°</a>&nbsp;
</c:if>
</div>
<div>
<table align="right" width="30%">
  <tr>
    <td>
           κ²μμΌ: <fmt:formatDate value="${itemDto.item_regdate}" type="time"/>
    </td>
  </tr>
</table>
</div>
<!-- λκΈ μμ -->
<ul>
    <c:forEach items="${reply}" var="reply">
	  <li class="reply">
        <div class="code_div">
          <p>π€   ${reply.reply_writer}
          &nbsp;π <fmt:formatDate value="${reply.reply_regDate}" type="time"/></p>
          <p>${reply.reply_content}</p>
          <c:if test="${reply.reply_writer==user_id || user_id=='admin'}">
          <a class="reply-link" href="${ctxpath}/item/replyDelete.do?num=${reply.item_no}">λκΈ μ­μ </a>&nbsp;
          </c:if>
        </div>
      </li>    
</c:forEach>
</ul>

<c:if test="${user_id!=null}">
<div>
  <form method="post" action="${ctxpath}/item/writePro.do">
  <p>
    <label>λκΈ μμ±μ</label>&nbsp;<input type="text" id="reply_writer" name="reply_writer" value="${user_id}" readonly>
  </p>
  <p>
    <textarea id="reply_content" name="reply_content" rows="5" cols="50"></textarea>
  </p>
  <p>
  	<input type="hidden" name="item_no" id="item_no" value="${itemDto.item_no}">
    <input type="submit" value="λκΈ μμ±">
  </p>
  </form>
</div>
</c:if>
<!-- λκΈ λ -->

</body>
</html>