<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm.jsp</title>

	<style type="text/css">

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
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.4), -4px -4px 4px rgba(0, 0, 0, 0.1);
}

.form-style-2{
	max-width: 500px;
	padding: 20px 12px 10px 20px;
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
	width: 100px;
	font-weight: bold;
	float: left;
	padding-top: 8px;
	padding-right: 5px;
}
.form-style-2 span.required{
	color:red;
}
.form-style-2 .tel-number-field{
	width: 60px;
	text-align: center;
}
.form-style-2 input.input-field{
	width: 35%;	
} 

.form-style-2 .select-field{
	width: 25%;	
}

.form-style-2 .addr-field{
	width: 15%;
}
.form-style-2 .addr-field2{
	width: 60%;
}

.form-style-2 input.input-field, 
.form-style-2 .tel-number-field, 
.form-style-2 .textarea-field, 
.form-style-2 .addr-field,
.form-style-2 .addr-field2,
 .form-style-2 .select-field{
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
.form-style-2 .input-field:focus, 
.form-style-2 .tel-number-field:focus, 
.form-style-2 .textarea-field:focus,  
.form-style-2 .select-field:focus{
	border: 1px solid #0C0;
}
.form-style-2 .textarea-field{
	height:100px;
	width: 55%;
}
.form-style-2 input[type=submit],
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
.form-style-2 input[type=submit]:hover,
.form-style-2 input[type=button]:hover{
	background: #EA7B00;
	color: #fff;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%--daum API사용--%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
	function openDaumPostcode() {

		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById('addr').value = data.address;
			}

		}).open();
	}//openDaumPostcode()---
</script>
<script>

function deleteUser() {
    document.deleteForm.action="${ctxpath}/member/memberDeleteForm.do";
     document.deleteForm.submit();
}

function check(){
	if($('#pw').val()==''){
        alert("암호를 입력하세요");
        $('#pw').focus();
        return false;
     }
	
	if($('#pw2').val()==''){
        alert("암호 확인을 입력하세요");
        $('#pw2').focus();
        return false;
     }
     
     if($('#pw2').val()!=$('#pw').val()){
        alert("암호 확인이 일치하지 않습니다");
        $('#pw2').val('');
        $('#pw').val('').focus();
        return false;
     }
     
     //$('#email').val($('#email1').val()+$('#email2').val());
     email=$('#email1').val()+$('#email2').val();
	 $('#email').val(email);
     //$('#tel').val($('#tel1').val()+$('#tel2').val()+$('#tel3').val());
     tel=$('#tel1').val()+$('#tel2').val()+$('#tel3').val();
	 $('#tel').val(tel);
	 
	 alert("수정이 완료되었습니다.")
     document.updateForm.submit();
}
</script>
</head>
<body>
 <div class="wrap">
   <div class="login">
	<div class="form-style-2">

	<div class="form-style-2-heading">내정보수정</div>
	
	 <form name="updateForm" method="post" action="${ctxpath}/member/memberUpdatePro.do">
	 
		<label>
			<span>이름 <span class="required">*</span></span>			
			 <input type="text" class="input-field" name="name" id="name" value="${memberDto.name}">
       		 <input type="hidden" name="id" value="${memberDto.id}">
		</label>
		
		<label>
		<span>암호 <span class="required">*</span></span>		
			<input type="password" class="input-field" name="pw" id="pw" size="20">
		</label>
		
		<label>
		<span>암호확인 <span class="required">*</span></span>		
			<input type="password" class="input-field" name="pw2" id="pw2" size="20" >
		</label>			
		
		<label ><span>E-mail</span>						
			 <input class="select-field" type="text" name="email1" id="email1" value="${email1}" size="10">@
         		 <select class="select-field" name="email2" id="email2">
         		 	 <option value="${email2}">${email3}</option>
          			 <option value="@naver.com">naver.com</option>
           			 <option value="@nate.com">nate.com</option>
           			 <option value="@daum.net">daum.net</option>
           			 <option value="@google.com">google.com</option>           			
          		</select>
          		 <input type="hidden" name="email" id="email">
		</label>
		
		<label>
		<span>Tel.</span>
			<input type="text" class="tel-number-field" name="tel1" id="tel1" value="${tel1}" maxlength="4" />&nbsp;-&nbsp;
			<input type="text" class="tel-number-field" name="tel2" id="tel2" value="${tel2}" maxlength="4"  />&nbsp;-&nbsp;
			<input type="text" class="tel-number-field" name="tel3" id="tel3" value="${tel3}" maxlength="10"  />
			<input type="hidden" name="tel" id="tel">
		</label>
		
		<label>
		<span>우편번호 <span class="required">*</span></span>		
			<input type="text" class="addr-field" name="zipcode" id="zipcode" value="${memberDto.zipcode}" size="7" readOnly="readonly">
         	<input type="button" value="주소찾기" onClick="openDaumPostcode()">
		</label>
		
		<label>
		<span>주소 <span class="required">*</span></span>		
			<input type="text" class="addr-field2" name="addr" id="addr" value="${memberDto.addr}" size="50" readOnly="readonly">
		</label>
		
		<label>
		<span>상세주소 <span class="required">*</span></span>		
			<input type="text" class="addr-field2" name="addr2" id="addr2" value="${memberDto.addr2}" size="20">
		</label>
		
		
		
		<label style="text-align: center;">
			<br>
			<input type="button" value="내정보수정" onClick="check()">&nbsp;&nbsp;&nbsp;
          	<input type="button" value="탈퇴하기" onClick="javascript:deleteUser()">
		</label>
</form>
<form name="deleteForm" method="post">
  <input type="hidden" name="id" id="id" value="${user_id}">
</form>
</div>
</div>
</div>  
</body>
</html>