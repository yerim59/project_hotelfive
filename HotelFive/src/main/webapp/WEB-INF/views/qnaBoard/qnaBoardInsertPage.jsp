<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
   <jsp:param value="QNA게시판" name="title"/>
</jsp:include>
<style type="text/css">
   .notice_backimg {
		width: 100%; 
		height: 750px; 
		background-size: cover;
		background-image: url("resources/assets/background_img/backimg.jpg"); 
		text-align: center; 
		color: white; 
		padding-top: 300px;
	}
</style>
<script type="text/javascript">
   function fn_inputCheck1(f){
      if(f.qTitle.value == ''){
         alert('제목을 입력하세요');
         f.qTitle.focus();
         return;
      }
      if(f.qContent.value == ''){
         alert('내용을 입력하세요');
         f.qContent.focus();
         return;
      }
      if(f.qPw.value == ''){
         alert('비밀번호를 입력하세요');
         f.qPw.focus();
         return;
      }
      f.action = 'qnaBoardInsert1';
      f.submit();
   }
   
   function fn_inputCheck2(f){
      if(f.qTitle.value == ''){
         alert('제목을 입력하세요');
         f.qTitle.focus();
         return;
      }
      if(f.qContent.value == ''){
         alert('내용을 입력하세요');
         f.qContent.focus();
         return;
      }
      if(f.qPw.value == ''){
         alert('비밀번호를 입력하세요');
         f.qPw.focus();
         return;
      }
      f.action = 'qnaBoardInsert2';
      f.submit();
   }
   
   $(function() {
      
      $('#content').on('keyup', function (e){
          var content = $(this).val();
          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
          $('#counter').html(content.length + '/200');
      });
      $('#content').keyup();
      
      $('#content').on('keyup', function(){
      if($(this).val().length > 200){
         $(this).val($(this).val().substring(0, 200));
      }
      });
   });
</script>

<div class="notice_backimg">
	<h3 id="hotelfive">Hotel Five</h3>
	<h1 id="pagetitle">Community</h1>
	<p id="explain">호텔파이브의 각종 이벤트 및 소식</p>
</div>

<div class="qnaBoard-insertBox">
	<img id="writing_name" alt="writing_name" src="resources/assets/name_img/writing_name1.png"/><br/> 
   <form method="POST">
      <div class="insertBox">
         <table class="title-table">
            <tbody>
               <tr>
                  <th>NAME</th>
                  <td> 
                     <c:if test="${loginDTO ne null }">
                        <input type="text" name="mId" value="${loginDTO.mId }" readonly/>                     
                     </c:if>
                     <c:if test="${loginDTO eq null }">
                        <input type="text" name="nmName" maxlength="10"/>
                     </c:if>
                  </td>
                  <th>PASS</th>
                  <td>
                     <input type="password" name="qPw" maxlength="10"/>
                     <span id="pass-caption">자동 잠금 처리</span>
                  </td>
               </tr>
               <tr>
                  <th>TITLE</th>
                  <td colspan="3">
                     <input type="text" name="qTitle" maxlength="30"/>
                  </td>
               </tr>
            </tbody>
         </table>
         <table class="content-table"> 
            <tbody>
               <tr>
                  <th>CONTENT</th>
                  <td>
                     <div class="limited_text_wrap">
                        <textarea id="content" name="qContent" placeholder="질문사항을 200자 이내로 기재해 주세요."></textarea>
                        <span id="counter">###</span>
                     </div>
                  </td>
               </tr>
            </tbody>
            <tfoot>
               <tr>
                  <td class="none" colspan="2">
                     <input class="qnaBtn" type="button" value="CANCEL" onclick="history.go(-1)"/>
                     <c:if test="${loginDTO ne null }">
                        <input class="qnaBtn" type="button" value="SAVE" onclick="fn_inputCheck1(this.form)"/>                     
                     </c:if>
                     <c:if test="${loginDTO eq null }">
                        <input class="qnaBtn" type="button" value="SAVE" onclick="fn_inputCheck2(this.form)"/>
                     </c:if>
                  </td>
               </tr>
            </tfoot>
         </table>
      </div>
   </form>
</div>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp" %>