<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 동적인 페이지 포함 -->
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="QNA게시판" name="title" />
</jsp:include>
<script type="text/javascript">
	var qPw = '${qDTO.qPw}';

	function fn_update(f) {
		f.action = 'qnaBoardUpdatePage';
		f.submit();
	}

	function fn_delete(f) {
		var qPwCheck = prompt('비밀번호를 입력해주세요');
		if (qPwCheck == qPw) {
			if (confirm('삭제하시겠습니까?')) {
				f.action = 'qnaBoardDelete';
				f.submit();
			}
		} else {
			alert('비밀번호가 틀렸습니다.');
		}
	}

	function fn_replyInsert(f) {
		if (f.reContent.value == '') {
			alert('답변을 입력해주세요');
		} else {
			f.action = 'qnaBoardReplyInsert';
			f.submit();
		}
	}

	function fn_replyDelete(f) {
		if (confirm('답변을 삭제하시겠습니까?')) {
			f.action = 'qnaBoardReplyDelete';
			f.submit();
		}
	}

	function fn_replyUpdate(f) {

		var reNo = f.reNo.value;
		var reContent = document.querySelector('#reContent' + reNo);
		var reContentUpdateBox = document.querySelector('#reContentUpdateBox'
				+ reNo);
		var updateBtn = document.querySelector('#updateBtn' + reNo);
		var deleteBtn = document.querySelector('#deleteBtn' + reNo);
		var saveBtn = document.querySelector('#saveBtn' + reNo);
		var cancelBtn = document.querySelector('#cancelBtn' + reNo);

		if (updateBtn.value == '수정') {
			update();
		}

		function update() {
			reContent.style.display = 'none';
			reContentUpdateBox.style.display = 'inline';
			reContentUpdateBox.style.width = '100%';
			reContentUpdateBox.style.height = '100%';
			updateBtn.style.display = 'none';
			deleteBtn.style.display = 'none';
			saveBtn.style.display = 'inline';
			cancelBtn.style.display = 'inline';
		}

	}

	function fn_replyCancel(f) {

		var reNo = f.reNo.value;
		var reContent = document.querySelector('#reContent' + reNo);
		var reContentUpdateBox = document.querySelector('#reContentUpdateBox'
				+ reNo);
		var updateBtn = document.querySelector('#updateBtn' + reNo);
		var deleteBtn = document.querySelector('#deleteBtn' + reNo);
		var saveBtn = document.querySelector('#saveBtn' + reNo);
		var cancelBtn = document.querySelector('#cancelBtn' + reNo);

		if (cancelBtn.value == '취소') {
			cancel();
		}

		function cancel() {
			reContent.style.display = 'inline';
			reContentUpdateBox.style.display = 'none';
			updateBtn.style.display = 'inline';
			deleteBtn.style.display = 'inline';
			saveBtn.style.display = 'none';
			cancelBtn.style.display = 'none';
		}

	}

	function fn_replySave(f) {
		var updateReContent = f.updateReContent.value;
		if (updateReContent == '') {
			alert('내용을 입력해주세요');
		} else {
			f.action = 'qnaBoardReplyUpdate';
			f.submit();
		}
	}

	$(function() {
		$('#reContentInsertBox').keyup(function(e) {
			var content = $(this).val();
			$(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
			$('#counter1').html(content.length + '/100');
		});
		$('#reContentInsertBox').keyup();

		$('#reContentInsertBox').on('keyup', function() {
			if ($(this).val().length > 100) {
				$(this).val($(this).val().substring(0, 100));
			}
		});
	});
</script>
<style type="text/css">
.qna_backimg {
	width: 100%;
	height: 750px;
	background-size: cover;
	background-image: url("resources/assets/background_img/backimg.jpg");
	text-align: center;
	color: white;
	padding-top: 300px;
}
</style>
<div class="qna_backimg">
	<h3 id="hotelfive">Hotel Five</h3>
	<h1 id="pagetitle">Community</h1>
	<p id="explain">호텔파이브에 대한 관련 질문</p>
</div>
<div class="qnaBoard-viewBox">
	<img id="notice_name" alt="qna_name"
		src="resources/assets/name_img/qna_name.png" /><br />
	<form method="POST">
		<div class="viewBox">
			<table class="title-table">
				<tbody>
					<tr>
						<th>NAME</th>
						<td><c:if test="${qDTO.nmName ne null }">
                        ${qDTO.nmName }
                     </c:if> <c:if test="${qDTO.nmName eq null }">
                        ${qDTO.mId }
                     </c:if></td>
						<th>NOTICEDATE</th>
						<td>${qDTO.qNoticedate }</td>
					</tr>
					<tr>
						<th>TITLE</th>
						<td colspan="3">${qDTO.qTitle }</td>
					</tr>
				</tbody>
			</table>
			<br />
			<table class="content-table">
				<tbody>
					<tr>
						<th>CONTENT</th>
						<td>${qDTO.qContent }</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2"><input class="qnaBtn" type="button"
							value="LIST" style="display: inline-block;"
							onclick="location.href='qnaBoardList'" /> <input class="qnaBtn"
							type="button" value="DELETE" style="display: inline-block;"
							onclick="fn_delete(this.form)" /> <input class="qnaBtn"
							type="button" value="UPDATE" style="display: inline-block;"
							onclick="fn_update(this.form)" /> <input type="hidden" name="qNo"
							value="${qDTO.qNo }" /> <input type="hidden" name="qPw"
							value="${qDTO.qPw }" /> <input type="hidden" name="mId"
							value="${qDTO.mId }" /> <input type="hidden" name="qTitle"
							value="${qDTO.qTitle }" /> <input type="hidden" name="qContent"
							value="${qDTO.qContent }" /> <input type="hidden" name="page"
							value="${page }" /></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
</div>
<br />
<div class="qnaBoardReply-insertBox">
	<img id="notice_name" alt="qna_name"
		src="resources/assets/name_img/answer_name.png" /><br />
	<c:if test="${loginDTO ne null }">
		<c:if test="${loginDTO.mId eq 'admin' }">
			<div class="reply-insertBox">
				<form method="POST">
					<table class="reply-insertTable">
						<tr>
							<th>admin</th>
							<td>
								<div class="limited_text_wrap1">
									<textarea id="reContentInsertBox" name="reContent"
										placeholder="답변을 100자 이내로 기재해 주세요."></textarea>
									<span id="counter1">###</span>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="등록"
								onclick="fn_replyInsert(this.form)" /> <input type="hidden"
								name="mId" value="${loginDTO.mId }" /> <input type="hidden"
								name="qNo" value="${qDTO.qNo }" /> <input type="hidden"
								name="page" value="${page }" /></td>
						</tr>
					</table>
				</form>
			</div>
		</c:if>
	</c:if>
</div>
<div class="qnaBoardReply-viewBox">
	<table class="reply-viewTable">
		<tbody>
			<c:if test="${empty reList }">
				<tr>
					<th colspan="4">아직 답변이 등록되지 않았습니다</th>
				</tr>
			</c:if>
			<c:if test="${not empty reList }">
				<c:forEach var="reDTO" items="${reList }">
					<form method="POST">
						<tr>
							<td><span id="mId">${reDTO.mId }</span></td>
							<td><span id="reContent${reDTO.reNo }">${reDTO.reContent }</span>
								<textarea id="reContentUpdateBox${reDTO.reNo }"
									name="updateReContent" style="display: none;">${reDTO.reContent }</textarea>
							</td>
							<c:if test="${loginDTO ne null }">
								<c:if test="${loginDTO.mId eq 'admin' }">
									<th><input id="updateBtn${reDTO.reNo }" type="button"
										value="수정" onclick="fn_replyUpdate(this.form)" /> <input
										id="saveBtn${reDTO.reNo }" style="display: none" type="button"
										value="저장" onclick="fn_replySave(this.form)" /> <input
										type="hidden" name="reNo" value="${reDTO.reNo }" /> <input
										type="hidden" name="qNo" value="${qDTO.qNo }" /> <input
										type="hidden" name="page" value="${page }" /></th>
									<th><input id="deleteBtn${reDTO.reNo }" type="button"
										value="삭제" onclick="fn_replyDelete(this.form)" /> <input
										id="cancelBtn${reDTO.reNo }" style="display: none"
										type="button" value="취소" onclick="fn_replyCancel(this.form)" />
									</th>
								</c:if>
							</c:if>
						</tr>
					</form>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<!-- 정적인 페이지 포함 -->
<%@ include file="/WEB-INF/views/template/footer.jsp"%>