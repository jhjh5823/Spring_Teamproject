<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctxpath" value="<%=request.getContextPath()%>"/> 

<style>
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');


.login-header{
background-color: white;
text-align: right;
padding: 10px;
}

.login-header a{
text-decoration: none;
color: black;
}

.login-header a:hover {
  border-bottom: 1px solid black;
}

  }
  th{
  padding: 3px;
  }
  td{
  padding: 3px;
  }
  
  h2{
  display: block;
  font-size: 1.3rem;
  color: #546173;
  margin-bottom: 0.4em;
  font-weight: normal;
 }


#tr-subject{
padding: 30px;
background-color: #DF9F1F;
color: white;
font-weight: bold;
font-size: 17px;
height: 17px;
}




.td-subject{
padding: 10px;
background-color: #DF9F1F;
color: white;
font-weight: bold;
font-size: 15px;
border: 1px solid white;
width: 250px;
}

.td-subject2{
border-bottom: 2px solid #DF9F1F;
font-size: 14px;
font-weight: bold;
padding: 15px;
height: 40px;
width: 15%;
}

.td-content{
height: 300px;
font-size: 17px;
padding: 30px;
align-items: flex-start; 
border: 1px;
width: 100%;
}

.td-date{
border-bottom: 2px solid #DF9F1F;
font-size:12px;
color:gray;
text-align:right;
padding: 20px;
}

#main{
border: 2px solid #EBE3DB;
padding: 10px;
margin: auto;
margin-top: 40px;
width: 70%;
text-decoration: none;
}
h2{
text-align: center;
color: #546173;
}

#support{
padding: 10px;
margin: auto;
width: 70%;
align-items: right;
}

#support a{
text-align: center;
text-decoration: none;
}

	.btn{
	background-color: white;
	 font-size: 15px;
	 padding: 7px 15px;
	 color: #DF9F1F;
	 border:2px solid #DF9F1F;
	 border-radius: 30px;
	 text-transform: uppercase;
	 letter-spacing: 3px;
	 font-family: 'Jua', sans-serif;
	 transition: all 0.4s;
	}
	
	.btn:focus{
		outline: none;
	}
	
	.btn:hover {
		background-color: #DF9F1F;
		color:white;
	}

</style>
