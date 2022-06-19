<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberDeleteForm.jsp</title>
<script>
function check(){
	if(document.delForm.pw.value==''){
		alert("암호를 입력하세요");
		document.delForm.pw.focus();
		return false;
	}
	if(document.delForm.pw.value != '${memberDto.pw}'){
		alert("암호가 틀립니다");
		document.delForm.pw.value=''; //암호삭제
		document.delForm.pw.focus();
		return false;
	}
	   if (!confirm("정말 탈퇴하시겠습니까?")) {
	       history.back();
	    } else {
	    	alert("회원탈퇴 되었습니다.");
	       document.delForm.submit();
	    }
	
}
</script>

<style>
.wrap {
  font-family: "Noto Sans KR", sans-serif;
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #FFEDCB;
  margin-bottom: 30px;
  margin-top: 30px;
}

.login {
  width: 35%;
  height: 200px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.4), -4px -4px 4px rgba(0, 0, 0, 0.1);
}

.form-style-2{
	max-width: 600px;
	padding: 10px 12px 10px 10px;
	font: 13px Arial, Helvetica, sans-serif;
}
.form-style-2-heading{
	font-weight: bold;
	font-style: italic;
	border-bottom: 2px solid #ddd;
	margin-bottom: 20px;
	font-size: 18px;
	padding-bottom: 5px;
}
.form-style-2 label{
	display: block;
	margin: 0px 0px 15px 0px;
}
.form-style-2 label > span{
	width: 50px;
	font-weight: bold;
	float: left;
	padding-top: 8px;
	padding-right: 5px;
}
.form-style-2 span.required{
	color:red;
}

.form-style-2 input.input-field{
	width: 70%;	
} 

.form-style-2 input.input-field {
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	border: 1px solid #C2C2C2;
	box-shadow: 1px 1px 4px #EBEBEB;
	-moz-box-shadow: 1px 1px 4px #EBEBEB;
	-webkit-box-shadow: 1px 1px 4px #EBEBEB;
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	padding: 7px;
	outline: none;
}

.form-style-2 .input-field:focus {
	border: 1px solid #0C0;
}

.form-style-2 input[type=button]{
	border: none;
	padding: 8px 10px 8px 10px;
	background: #FF8500;
	color: #fff;
	box-shadow: 1px 1px 4px #DADADA;
	-moz-box-shadow: 1px 1px 4px #DADADA;
	-webkit-box-shadow: 1px 1px 4px #DADADA;
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	font-size: 12px;
	display: inline-block;
}
.form-style-2 input[type=button]:hover{
	background: #EA7B00;
	color: #fff;
}

</style>
</head>
<body>
	<div class="wrap">
   <div class="login">
	<div class="form-style-2">

	<div class="form-style-2-heading">회원탈퇴</div>
	
	 <form name="delForm" method="post" action="${ctxpath}/member/memberDeletePro.do">
	 
		<label>
			<span>암호<span class="required">*</span> </span>			
			 <input type="password" class="input-field" name="pw" id="pw" size="20">
        	 <input type="hidden" name="id" value="${memberDto.id}">
		</label>	
	
      
     
        <label style="text-align: center;">
          <input type="button" value="탈퇴" onclick="check()">&nbsp;&nbsp;&nbsp;
          <input type="button" value="취소" onClick="javascript:history.back();">
      	</label>
       
  </form>
  </div>
  </div>
  </div>
</body>
</html>