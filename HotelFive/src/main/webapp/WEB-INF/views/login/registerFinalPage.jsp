<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

<div id="page-box-3" class="page-box-3">
	<h3>MEMBERSHIP</h3>
   	<img alt="step3" src="resources/assets/register_img/step3.jpg"><br/><br><br/>
   	<img alt="logo" src="resources/logo/register.jpg">
   	<p>${mName }님의 회원가입이 성공적으로 이루어졌습니다.</p>
   	<p>고객님의 편안한 휴식을 제공하는 Hotel Five에서 좋은 추억을 쌓아가세요.</p>
   	<input type="button" value="홈으로 가기" onclick="location.href='main'"/>
</div>

<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>