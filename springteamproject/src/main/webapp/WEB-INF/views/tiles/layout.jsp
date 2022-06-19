<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp"%> 

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>layout.jsp</title>
<style>
header {
  position: fixed;
  top: 0; left: 0;
  height: 100px;
  width: 100%; 
}

section {
  padding-top: 150px;  
  display:flex;
  flex-direction: column;
  height: 100%;
}

footer {
  bottom: 0; left: 0;
  
  background-color: #DEB887;
  padding-top: 30px;
  padding-bottom: 50px;
  font-size: 20px;
  text-align: center;
  color: #F5F5F5;
  font-size: 15px;

}

.contents{
padding-left: 50px;
padding-right: 50px;
flex:1;
}
</style>

</head>
<body>
 
<section>    
      <header>
        <tiles:insertAttribute name="header"/>
      </header>
   
    
    
      <div class="contents">
        <tiles:insertAttribute name="content"/>
      </div>
    
    
  
   <footer>
        <tiles:insertAttribute name="footer"/>
    </footer>
   
 </section>
</body>
</html>