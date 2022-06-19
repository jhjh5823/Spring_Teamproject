<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle:wght@300&family=Noto+Sans+KR&display=swap');

	html, body{
		margin: 0;
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 18px;
	}
	
	.navbar a {
		text-decoration: none;
		color: white;
	}
	.navbar{
		display: flex;
		justify-content: space-between;
		align-items: center;
		background-color: #263343;
		padding: 8px 12px;
	}
	
	.navbar__logo{
	 	font-size: 32px;
	 	color: white;
	 	font-family: 'Jua', sans-serif;
	}
	
	.navbar__logo i{
		color: orange;
	}
	
	.navbar__menu{
		display: flex;
		list-style: none;
		padding-left:0;
	}
	
	.navbar__menu li{
	 	padding: 8px 12px;
	}
	
	.navbar__menu li:hover{
		background-color: #d49466;
		border-radius: 4px;
	}
	
	.navbar__icons{
		list-style: none;
		color: white;
		display: flex;
		padding-left: 0;
	}
	
	.navbar__icons li{
		padding: 8px 12px;
	}
	
	.navbar__toogleBtn{
		display: none;
		position: absolute;
		right: 32px;
		font-size: 24px;
		color:#d49466;
	}
	@media screen and (max-width: 768px){
		.navbar {
			flex-direction: column;
			align-items: flex-start;
			padding: 8px 24px;
		}
		
		.navbar__menu{
			display:none;
			flex-direction: column;
			align-items: center;
			width: 100%;
		}
		
		.navbar__menu li{
		 width: 100%;
		 text-align: center;
		}
		
		.navbar__icons{
		display:none;
		justify-content: center;
		width: 100%;
		}
		
		.navbar__toogleBtn{
		display: block;
		}
	}
	

</style>