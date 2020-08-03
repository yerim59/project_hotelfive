<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="::::: 관리자모드 :::::" name="title"/>
</jsp:include>
 
<br>

<div class="adminMain-wrap">
	
	<div class="group-btn">
		<input class="adminMainBtn" type="button" value="회원관리하기" onclick="location.href='adminList'">
		<input class="adminMainBtn" type="button" value="객실예약현황" onclick="location.href='adminReservationList'">
	</div>
	
</div>




<%@ include file="/WEB-INF/views/template/footer.jsp" %>