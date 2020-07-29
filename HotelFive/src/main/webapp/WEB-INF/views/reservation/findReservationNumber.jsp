<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />

<div>
	<form action="selectNonMemberReservationPage" method="POST">
		<h1>비회원 예약정보 확인</h1>
		<label>성함</label>
		<input type="text" name="nmName" /><br/>
		<label>전화번호</label>
		<input type="text" name="nmPhone" /><br/>
		<input type="submit" value="조회하기"/>
	</form>
</div>

<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>