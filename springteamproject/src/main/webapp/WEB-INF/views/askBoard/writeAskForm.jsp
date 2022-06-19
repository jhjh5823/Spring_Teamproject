<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>writeAskForm.jsp</title>
	
	<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<style type="text/css">
	h2 {
	text-align: center;
	}
	table {
	margin: auto;
	width: 60%;
	}
	table.cc {
	border: 1px solid black;
	}
	</style>
	
	<script type="text/javascript">
	function check() {
		if($('#ask_writer').val() == '') {
			alert("작성자명을 입력하세요.");
			$('#ask_writer').focus();
			return false;
		}
		if($('#ask_subject').val() == '') {
			alert("제목을 입력하세요.");
			$('#ask_subject').focus();
			return false;
		}
		if($('#ask_content').val() == '') {
			alert("내용을 입력하세요.");
			$('#ask_content').focus();
			return false;
		}
		return true;
	}
	</script>
</head>
<body>

<c:if test="${user_id == null}">
	<h2>로그인이 필요한 서비스입니다.</h2>
</c:if>

<c:if test="${user_id != null}">
	
	<h2>
		<c:if test="${user_id != 'admin'}">
			문의하기
		</c:if>
		<c:if test="${user_id == 'admin'}">
			답변하기
		</c:if>
	</h2>
 	
 	<table>
 		<tr>
 			<td align="right">
 				<a href="${ctxpath}/askBoard/askList.do">목록으로</a>
 			</td>
 		</tr>
 		<tr>
 			<td align="center">
 			<font size="2" color="gray">
 				• 내용을 입력하신 다음 "신청하기" 버튼을 눌러 주세요. <br>
 				• 한번 등록한 상담내용은 수정이 불가능하며 수정을 원하시는 경우 삭제 후 재등록하셔야 합니다.
 			</font>
 			</td>
 		</tr>
 	</table>
 	
 	<form name="writeAskForm" method="post" action="${ctxpath}/askBoard/writeAskPro.do" onsubmit="return check()">
 	
 	<input type="hidden" name="pageNum" value="${pageNum}">
    <input type="hidden" name="ask_num" value="${ask_num}">
    <input type="hidden" name="ask_ref" value="${ask_ref}">
    <input type="hidden" name="ask_restep" value="${ask_restep}">
    <input type="hidden" name="ask_relevel" value="${ask_relevel}">
    
		<table class="cc">
			<tr>
				<td>작성자</td>
				<c:if test="${user_id != 'admin'}">
					<td><input type="text" name="ask_writer" id="ask_writer" size="20" placeholder="작성자 아이디를 입력하세요."></td>
				</c:if>
				<c:if test="${user_id == 'admin'}">
					<td><input type="text" name="ask_writer" size="20" value="당근24" readonly></td>
				</c:if>
				
			</tr>
    		
			<tr>
				<c:if test="${user_id != 'admin'}">
					<td>제목</td>
					<td>
						<input type="text" name="ask_subject" id="ask_subject" size="50" placeholder="제목을 입력하세요.">
					</td>
				</c:if>
				<c:if test="${user_id == 'admin'}">
					<td>[답변]</td>
					<td><input type="text" name="ask_subject" size="50" value="안녕하세요. 고객님 문의에 대해 답변드립니다." readonly></td>
				</c:if>
			</tr>
    		
			<tr>
				<td>문의내용</td>
				<td>
					<textarea name="ask_content" id="ask_content" rows="10" cols="50" placeholder="내용을 입력하세요."></textarea>
				</td>
			</tr>
    		
			<tr>
				<c:if test="${user_id != 'admin'}">
					<td colspan="2" align="center">
						<input type="submit" value="신청">
						<input type="reset" value="취소">
					</td>
				</c:if>
				<c:if test="${user_id == 'admin'}">
					<td colspan="2" align="center">
						<input type="submit" value="등록">
						<input type="reset" value="취소">
					</td>
				</c:if>
			</tr>
    	</table>
	</form>
</c:if>
</body>
</html>