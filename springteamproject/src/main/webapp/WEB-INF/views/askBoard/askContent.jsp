<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>askContent.jsp</title>
	
	<style type="text/css">
	.ask_content td {
	padding: 5px 0;
	border-bottom: 1px solid #e5e5e5;
	}
	h2 {
	text-align: center;
	}
	table {
	padding-top: 20;
	margin: auto;
	width: 50%;
	}
	#button_style {
	border: 2px solid orange;
	background-color: white;
	color: orange;
	padding: 5px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	}
	</style>
</head>
<body>
<c:if test="${user_id == null}">
	<h2>로그인이 필요한 서비스입니다.</h2>
</c:if>

<c:if test="${user_id != null}">	
	<table>
		<tr>
			<td align="right">
				<input type="button" value="삭제" id="button_style" onClick="location='${ctxpath}/askBoard/askDelete.do?id=${id}&pageNum=${pageNum}'">&nbsp;
				<input type="button" value="목록으로" id="button_style" onClick="location='${ctxpath}/askBoard/askList.do?pageNum=${pageNum}'">
				<c:if test="${user_id == 'admin'}">
					<input type="button" value="답변하기" id="button_style" onClick="'${ctxpath}/askBoard/writeAskForm.do?ask_num=${askBoardDto.ask_num}&ask_ref=${askBoardDto.ask_ref}&ask_restep=${askBoardDto.ask_restep}&ask_relevel=${askBoardDto.ask_relevel}&pageNum=${pageNum}'">
				</c:if>
			</td>
		</tr>
	</table>
	
	<table class="ask_content">
		<tr>
			<td colspan="2"><font color="orange" size="4"><b>${askBoardDto.ask_subject}</b></font></td>
		</tr>
		
		<tr></tr><tr></tr><tr></tr>
    
		<tr>
			<td><font color="gray" size="2">작성자</font></td>
			<td><font color="gray" size="2">${askBoardDto.ask_writer}</font></td>
		</tr>
		
		<tr>
			<td><font color="gray" size="2">작성일</font></td>
			<td><font color="gray" size="2">${askBoardDto.ask_regdate}</font></td>
		</tr>
    
    	<tr></tr><tr></tr><tr></tr>
    
		<tr>
			<td colspan="2">
				<pre>${askBoardDto.ask_content}</pre>
			</td>
		</tr>
	</table>
</c:if>
	
</body>
</html>