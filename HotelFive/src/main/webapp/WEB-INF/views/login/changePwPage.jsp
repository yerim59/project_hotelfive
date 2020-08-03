<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="비밀번호 찾기" name="title"/>
</jsp:include>
	 

<script type="text/javascript">
   
   $(document).ready(function(){  // onload 이벤트
      $('#changePwBtn').click(function(){  // click 이벤트
         if ($('#mPw').val() == '') {
            alert('새로운 비밀번호를 입력하세요.');
            $('#mPw').focus();
            return false;
         }
         if ($('#mPw').val() != $('#mPw2').val()) {
            alert('비밀번호 입력을 확인하세요.');
            return false;
         }
         $.ajax({
            url: 'changePw',
            type: 'POST',
            dataType: 'json',
            data: 'mId=' + $('#mId').val() + '&mPw=' + $('#mPw').val(),
            success: function( data ) {
               if ( data.result == 'SUCCESS' ) {
                  alert('새로운 비밀번호로 변경되었습니다.');
                  location.href = 'main';
               } else {
                  alert('비밀번호가 변경되지 않았습니다.');
                  history.back();
               }
            },
            error: function() {
               alert('AJAX 통신이 실패했습니다.');
            }
         });
         
      });
   });
   
</script>

<div class="change-pw-box">
   <p id="bold">비밀번호 변경하기</p>
   <hr id="line"/>
   <p id="nobold">보안상 내용으로 새로운 비밀번호를 설정해 주시기 바랍니다.<p> 
   <form id="f" method="POST">
      <br/><p id="tableon">  새로운 비밀번호 설정하기</p>  
      <table>
         <tbody>
            <tr>
               <td>아이디</td>
               <td><input id="mId" type="text" name="mId" value="${param.mId }" readonly /></td>
            </tr>
            <tr>
               <td>새로운 비밀번호</td>
               <td><input id="mPw" type="password" name="mPw" autofocus /></td>
            </tr>
            <tr>
               <td>비밀번호 확인</td>
               <td><input id="mPw2" type="password" name="mPw2" /></td>
            </tr>
         </tbody>
      </table>
      <div class="btnbox">
         <input id="changePwBtn" type="button" value="비밀번호변경" />
      </div>
   </form>
</div>

<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>