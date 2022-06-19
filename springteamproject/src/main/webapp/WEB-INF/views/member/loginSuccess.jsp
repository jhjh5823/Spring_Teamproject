<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>loginSuccess.jsp</title>
  
</head>
<body>
<!-- loginSuccess.jsp -->
<%--EL,JSTL --%>

<c:set var="user_id" value="${memberDto.id}" scope="session"/>
<meta http-equiv="Refresh" content="0;url=${ctxpath}">

</body>
</html>