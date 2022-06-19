<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../module/jspheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<style type="text/css">
.faq-sub-title {
	font-size: 1.3rem;
	font-weight: normal;
	color: #868e96;
	line-height: 1.46;
	letter-spacing: -0.5px;
	margin-bottom: 0.8rem;
}

.faq .faq-link {
	background-color: #fff;
	width: 100%;
	display: block;
	padding: 1.6rem 0;
	text-decoration: none;
	color: #212529;
}

.faq-title-text {
	width: calc(100% - 1.8rem - 1rem);
	font-size: 1rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	vertical-align: middle;
}

.faq-title {
	width: calc(100% - 1.8rem - 1rem);
	font-size: 1rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	vertical-align: middle;
}

.faq {
	width: 90%; font-size : 1.5rem;
	line-height: 1.47;
	letter-spacing: -0.5px;
	display: inline-block;
	vertical-align: middle;
	font-size: 1.5rem;
	border-bottom: 1px solid #e9ecef;
}

#faqs-more-question {
  margin-top: 2.4rem;
  text-align: center;
  font-size: 1rem;
  line-height: 1.47;
  letter-spacing: -0.5px;
}


.faqs-more-question-link {
  color: #2694ab;
  margin-top: 0.8rem;
  display: block;
  text-decoration: none;
}

#faqs-list {
  list-style-type: none;
  font-size: 1.5rem;
  padding: 1.6rem 0;
  display: block;
  color: #212529;
  text-decoration: none;

}
</style>
</head>
<body>
	<h3 class="faq-sub-title">사용자들이 자주 묻는 질문을 확인해보세요.</h3>
	<ul id="faqs-list">
		<li class="faq"><a class="faq-link"
			href="${ctxpath}/faqboard/faqGuideline.do">
				<div class="faq-title">
					<div class="faq-title-text">Q. 커뮤니티 가이드라인</div>
				</div>
		</a></li>
		<li class="faq"><a class="faq-link"
			href="${ctxpath}/faqboard/faqoperationpolicy.do">
				<div class="faq-title">
					<div class="faq-title-text">Q. 중고거래 운영정책</div>
				</div>
		</a></li>

		<li class="faq"><a class="faq-link"
			href="${ctxpath}/faqboard/faqmanner.do">
				<div class="faq-title">
					<div class="faq-title-text">Q. 마켓에서 지켜야 할 매너</div>
				</div>
		</a></li>

		<li class="faq"><a class="faq-link"
			href="${ctxpath}/faqboard/faqprohibition.do">
				<div class="faq-title">
					<div class="faq-title-text">Q. 판매 금지 물품</div>
				</div>
		</a></li>
	</ul>
	
	<div id="faqs-more-question">
    <p>그래도 해결이 안 되시나요?</p>
    <a class="faqs-more-question-link" href="${ctxpath}/faqboard/writeForm.do">
      <b class="faqs-more-text">고객센터에 문의하기</b>
</a>  </div>
</body>
</html>