<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="QNA게시판" name="title" />
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
	function fn_inputCheck(f) {
		if (f.qTitle.value == '') {
			alert('제목을 입력하세요');
			f.qTitle.focus();
			return;
		}
		if (f.qContent.value == '') {
			alert('내용을 입력하세요');
			f.qContent.focus();
			return;
		}
		if (f.qPw.value == '') {
			alert('비밀번호를 입력하세요');
			f.qPw.focus();
			return;
		}
		var qPw = '${qDTO.qPw}';
		if (f.qPw.value != qPw) {
			alert('비밀번호가 다릅니다.');
		} else {
			f.action = 'qnaBoardUpdate';
			f.submit();
		}
	}

	$(function() {

		$('#content').on('keyup', function(e) {
			var content = $(this).val();
			$(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
			$('#counter').html(content.length + '/200');
		});
		$('#content').keyup();

		$('#content').on('keyup', function() {
			if ($(this).val().length > 200) {
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
<div class="qnaBoardUpdateBox">
	<img id="notice_name" alt="notice_name"
		src="resources/assets/name_img/update_name.png" /><br />
	<form method="POST">
		<div class="viewBox">
			<table class="title-table">
				<tbody>
					<tr>
						<th>작성자</th>
						<td><c:if test="${qDTO.nmName ne null }">
                        ${qDTO.nmName }
                     </c:if> <c:if test="${qDTO.nmName eq null }">
                        ${qDTO.mId }
                     </c:if></td>
						<th>비밀번호</th>
						<td><input type="text" name="qPw" /> <span id="pass-caption">비밀번호
								입력</span></td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3"><input type="text" name="qTitle"
							value="${qDTO.qTitle }" /></td>
					</tr>
				</tbody>
			</table>
			<br />
			<table class="content-table">
				<tbody>
					<tr>
						<th>CONTENT</th>
						<td colspan="2">
							<div class="limited_text_wrap">
								<textarea id="content" name="qContent"
									placeholder="질문사항을 200자 이내로 기재해 주세요.">${qDTO.qContent }</textarea>
								<span id="counter">###</span>
							</div>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td class="none" colspan="2"><input type="button"
							value="CANCEL" onclick="history.go(-1)" /> <input type="button"
							value="SAVE" onclick="fn_inputCheck(this.form)" /> <input
							type="hidden" name="mId" value="${qDTO.mId }" /> <input
							type="hidden" name="qNo" value="${qDTO.qNo }" /></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
</div>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp"%>