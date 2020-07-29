<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp" />



<style type="text/css">
	.find-pw-box {
      border: 2px solid lightgray;
      margin: 30px auto;
      width: 500px;
      padding: 20px 0 30px 70px;
   }
   .findPw-text {border: none; padding:10px; border-bottom: 2px solid lightgray;width: 350px;}
   .findPw-text:focus {outline: none; border-bottom: 2px solid gray;}
   #findPwBtn {border: none; width: 100px; padding: 10px 0; margin-top:10px;background: #E3EAF3; border-radius: 20px;}
   
</style>

<script type="text/javascript">
	var authKey = "";
	
	$(document).ready(function(){  // onload 이벤트
		$('#findPwBtn').click(function(){  // click 이벤트
			if ($('#mId').val() == '') {
				alert('아이디를 입력하세요.');
				$('#mId').focus();
				return false;
			}
			if ($('#mEmail').val() == '') {
				alert('이메일을 입력하세요.');
				$('#mEmail').focus();
				return false;
			}
			$.ajax({
				url: 'findPw',
				type: 'POST',
				dataType: 'json',
				data: 'mId=' + $('#mId').val() + '&mEmail=' + $('#mEmail').val(),
				success: function( data ) {
					if ( data.result != 'NO' ) {
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
						alert('제출하신 회원 정보가 없습니다.');
						
					}
				},
				error: function() {
					alert('AJAX 통신이 실패했습니다.');
				}
			});
			
		});
	
		$('#realFindPwBtn').click(function(){

			if ($('#authKey').val() == authKey && authKey != "") {
				alert('인증되었습니다.');
				location.href = 'changePwPage?mId=' + $('#mId').val();
				}else if(mId == ""){
				alert('이메일인증을 진행하세요.');
			}
			else {
				alert('인증번호를 확인하세요.');
			}
			
		});
	
	
	});
	
</script>
<div class="find-pw-box">
   <form method="POST">
      <h2 style="color: #CAC2D1;">본인 확인</h2>
      <input class="findpw-text" id="mId" type="text" name="mId" placeholder="아이디" autofocus /><br/>
      <input class="findpw-text" id="mEmail" type="text" name="mEmail" placeholder="E-mail" style="width:250px;"/>
      <input id="findPwBtn" type="button" value="인증번호 받기" /><br/><br/>
      <input id="authKey" type="text" name="authKey" placeholder='인증번호 입력'/>

      <input id="realFindPwBtn" type="button" value="비밀번호 찾기" />
      <br/><br/>
   </form>
</div>




<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>