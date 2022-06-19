<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>loginForm.jsp</title>
  <style>
  * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
 
}

a {
  text-decoration: none;
  color: black;
}

li {
  list-style: none;
}

.wrap {
  font-family: "Noto Sans KR", sans-serif;
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #FFEDCB;
  margin-bottom: 30px;
}

.login {
  width: 30%;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.4), -5px -5px 5px rgba(0, 0, 0, 0.1);
}

.login_sns {
  padding: 20px;
  display: flex;
}

.login_sns li {
  padding: 0px 15px;
}

.login_sns a {
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px;
  border-radius: 50px;
  background: white;
  font-size: 20px;
  box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4), -3px -3px 5px rgba(0, 0, 0, 0.1);
}

.login_id {
  margin-top: 20px;
  width: 80%;
}

.login_id input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_pw {
  margin-top: 20px;
  width: 80%;
}

.login_pw input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_etc {
  padding: 10px;
  width: 80%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.submit {
  margin-top: 50px;
  width: 80%;
}
.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}
  </style>
  <script type="text/javascript">
  function check(){
     ff=eval("document.myForm");
     if(ff.id.value==""){
        alert("ID를 입력하세요");
        ff.id.focus();
        return false;
     }
     
     if(ff.pw.value==''){
        alert("암호를 입력하세요");
        ff.pw.focus();
        return false;
     }
     return true;
  }
  
  </script>

</head>
<body>
<form name="myForm" method="post" action="${ctxpath}/member/loginPro.do" onSubmit="return check()">
   <div class="wrap">
        <div class="login">
            <h2>로그인</h2>
			<h5><font color="#DF9F1F">${msg}</font></h5>
            <div class="login_sns">
              <li><a href=""><i class="fab fa-instagram"></i></a></li>
              <li><a href=""><i class="fab fa-facebook-f"></i></a></li>
              <li><a href=""><i class="fab fa-twitter"></i></a></li>
            </div>
            <div class="login_id">
                <h4>ID</h4>
                <input type="text" name="id" id="id" placeholder="ID">
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="pw" id="pw" placeholder="Password">
            </div>
            <div class="login_etc">
                <div class="checkbox">
                <input type="checkbox" name="" id=""> ID저장
             
             </div>
                <div class="forgot_pw">
                <a href="${ctxpath}/member/insertForm.do">회원가입</a>
            </div>
            
            </div>
            <div class="submit">
                <input type="submit" value="submit">
            </div>      
        </div>
    </div>
  </form>  
</body>

</html>
