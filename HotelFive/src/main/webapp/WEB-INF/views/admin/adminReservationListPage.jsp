<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
   <jsp:param value="전체예약현황" name="title"/>
</jsp:include>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script><!-- alert 꾸미기 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript">
   // 예약 승인하기
   function fn_ReservationOk(f){
	  if( confirm('예약을 승인하시겠습니까?') ){
		  alert('예약이 승인되었습니다');
		  f.action = 'ReservationOk';
          f.submit();
	  }
   }
   
   // 예약 취소하기
   function fn_ReservationCancel(f){
	  if( confirm('정말로 고객의 예약을 취소하시겠습니까?') ){
			  alert('예약이 취소되었습니다');
			  f.action = 'ReservationCancel';
              f.submit();
		}
   }
   
   // 승인된 예약 취소하여 삭제하기
   function fn_ReservationDelete(f){
	   if( confirm('승인이 확정된 예약을 취소하시겠습니까?') ){
			  alert('승인 확정된 예약이 취소되었습니다.');
			  f.action = 'ReservationDelete';
              f.submit();
		}
     
   }
   // 예약 현황 검색하기
   function fn_queryAdminReservationList(f){
      
      if(f.query.value == ''){
         alert('검색할 입력은 필수입니다');
         //swal("검색할 입력은 필수입니다","", 'error');
         f.query.focus();
         return;
      }
      if(f.column.value == 'EMPTY' && f.query.value != ''){
    	  alert('검색할 카테고리를 지정해주세요');
         //swal("검색할 카테고리를 지정해주세요","", 'error');
         f.column.focus();
         return;
      } 
      f.action = 'queryAdminReservationPage';
      f.submit();
   }  
</script>

<div class="container"> <!-- 전체 예약 현황-->

   <h1 class="text-center">전체 예약 현황</h1><br>
   <div class="text-center">전체 ${totalReservation} 개</div>
   
   <form class="text-right">
      <input class="Btn btnTotalList" type="button" value="전체 예약현황 보기" onclick="location.href='adminReservationList'" />
   </form>

      <br><br>
      <table class="table table-hover">
         <thead>
            <tr>
               <td>예약번호</td>
               <td>이름</td>
               <td>객실이름</td>
               <td>체크인</td>
               <td>체크아웃</td>
               <td>인원수</td>
               <td>예약현황</td>
               <td>예약취소</td>
            </tr>
         </thead>
         <tbody class="search row">
            <c:if test="${empty reservationList }">
               <tr>
                  <td colspan="8">현재 예약이 없습니다.</td>
               </tr>
            </c:if>
            <c:if test="${not empty reservationList }">
                  <c:forEach var="rDTO" items="${reservationList }">
               <form method="POST">
                     <tr>
                        <c:if test="${rDTO.rApproval eq 0}"> <!-- 최초 : 승인대기, 예약취소 -->
                           <td>${rDTO.rNo }</td>               
                           <td>${rDTO.mName }</td>
                           <td>${rDTO.gName }</td>
                           <td>${rDTO.rCheckIn }</td>
                           <td>${rDTO.rCheckOut }</td>
                           <td>${rDTO.rPeople }</td>
                           <td>
                              <input type="hidden" name="rNo" value="${rDTO.rNo }">
                              <input class="Btns confirmBtn" type="button" value="승인대기" onclick="fn_ReservationOk(this.form)">
                           </td>
                           <td>
                              <input class="Btns cancelBtn" type="button" value="예약취소" onclick="fn_ReservationCancel(this.form)">
                           </td>
                        </c:if>
                  
                        <c:if test="${rDTO.rApproval eq 1}"> <!-- 승인을 하였으면 -->
                           <td>${rDTO.rNo }</td>            
                           <td>${rDTO.mName }</td>
                           <td>${rDTO.gName }</td>
                           <td>${rDTO.rCheckIn }</td>
                           <td>${rDTO.rCheckOut }</td>
                           <td>${rDTO.rPeople }</td>
                           <td>
                              <input type="button" value="승인완료" disabled>
                           </td>
                           <td>
                              <input class="confirmBtn" type="hidden" name="rNo" value="${rDTO.rNo }">
                              <input class="cancelBtn" type="button" value="승인취소" onclick="fn_ReservationDelete(this.form)">
                           </td>
                        </c:if>
                        <%-- 예약을 취소하였으면 예약 내역이 삭제가 된다 .--%>  
                     </tr>
               </form>
               </c:forEach>
               
            </c:if>
         </tbody>
      </table>
      
      <div class="text-center">
         <c:if test="${page ne null}">
            <span>${pageView }</span>
            <span>${pageVie2 }</span>
            <br><br>
            <form class="text-center">
            <%-- 검색 --%>
               <select name="column">
                  <option value="EMPTY">::검색 선택::</option>
                 <!--  <option value="MID">아이디</option> -->
                  <option value="MNAME">이름</option>
                  <option value="GNAME">객실이름</option>
               </select>
               <input class="queryInput" type="text" name="query" placeholder="검색어를 입력해주세요" size="25" />
               <input class="queryBtn" type="button" value="검색" onclick="fn_queryAdminReservationList(this.form)" />
            </form>
         </c:if>
      </div>
</div>

<br><br><br><br>



<%@ include file="/WEB-INF/views/template/footer.jsp" %>