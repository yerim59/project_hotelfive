<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, java.text.*"  %>

<style>
	
</style>
<script>
	
	var today = 1;

	function fn_reservationCancle(f){
		
		if(confirm('예약을 취소하시겠습니까?')){
			f.action="reservationCancle";
			f.submit();
		}
	}
	
	
</script>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />
	<div >
		<h4>${nmName } 님 예약내역</h4>
		<form>
			<c:if test="${empty list }">
				예약한 방이 없습니다.
			</c:if>
			<c:if test="${not empty list }">
					<c:forEach var="rDTO" items="${list }">
						<input type="hidden" name="rNo" value="${rDTO.rNo }"/> 
						<input type="hidden" name="nmId" value="${rDTO.nmId }"/> 
						No.${rDTO.rNo }<br/>
						객실 : ${rDTO.gName}<br/>
						${rDTO.rCheckIn } ~ ${rDTO.rCheckOut }<br/>
							<c:if test="${rDTO.rApproval eq 0 }">
								예약대기 <input type="button" value="예약취소" onclick="fn_reservationCancle(this.form)">
							</c:if>
							<c:if test="${rDTO.rApproval eq 1 }">
								예약승인
							</c:if>
						
							<hr/>
					</c:forEach>
			</c:if>
		</form>
		
	</div>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>