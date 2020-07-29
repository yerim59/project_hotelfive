<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />

<script type="text/javascript">
   
   var authKey = "";
   var mId = "";
   // AJAX 를 통해 아이디를 찾는다.
   $(document).ready(function(){
      $('#findIdBtn').click(function(){
         $.ajax({
            url: 'findId',
            type: 'POST',
            dataType: 'json',
            data: 'mName=' + $('#mName').val() + '&mEmail=' + $('#mEmail').val(),
            success: function(data) {
               if ( data.result != "NO" ) {
                  
                     mId = data.result;
                  
                  $.ajax({
                     url : 'emailAuth',
                     type : 'POST',
                     dataType : 'json',
                     data : 'mEmail=' + $('#mEmail').val(),
                     success : function(data) {
                           alert('인증번호를 발송했습니다.');
                           authKey = data.authKey;
                     },
                     error : function() {
                        alert('AJAX 통신이 실패했습니다.');
                     }
                  });
               } else {
                  alert('일치하는 이메일 정보가 없습니다. 다시 작성해 주세요.');
               }
            },
            error: function() {
               alert('AJAX 통신이 실패했습니다.');
            }
         });
      });
         
      $('#realFindIdBtn').click(function(){

         if ($('#authKey').val() == authKey && authKey != "") {
            alert('인증되었습니다.');
               $('#findIdResult').text(mId);
         }else if(mId == ""){
            alert('이메일인증을 진행하세요.');
         }
         else {
            alert('인증번호를 확인하세요.');
         }
         
      });
   
   
   });
   
</script>

<style type="text/css">
   .find-id-box {
      border: 2px solid lightgray;
      margin: 30px auto;
      width: 500px;
      padding: 20px 0 30px 70px;
   }
   .findId-text {border: none; padding:10px; border-bottom: 2px solid lightgray;width: 350px;}
   .findId-text:focus {outline: none; border-bottom: 2px solid gray;}
   #findIdBtn {border: none; width: 100px; padding: 10px 0; margin-top:10px;background: #E3EAF3; border-radius: 20px;}
   
</style>

<div class="find-id-box">
   <form method="POST">
      <h2 style="color: #CAC2D1;">본인 확인</h2>
      <input class="findId-text" id="mName" type="text" name="mName" placeholder="이름" autofocus /><br/>
      <input class="findId-text" id="mEmail" type="text" name="mEmail" placeholder="E-mail" style="width:250px;"/>
      <input id="findIdBtn" type="button" value="인증번호 받기" /><br/><br/>
      <input id="authKey" type="text" name="authKey" placeholder='인증번호 입력'/>

      <input id="realFindIdBtn" type="button" value="아이디 찾기" />
      <div id="findIdResult"></div>  <!-- AJAX 처리 결과가 나타나는 위치이다. -->                  
      <br/><br/>
   </form>
</div>






<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>