<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	if (title == null || title.isEmpty()) {
		title = "Welcome to the KoreaHotel";
	}
	pageContext.setAttribute("title", title);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title }</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Inconsolata">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="resources/style/header.css">
<link rel="stylesheet" href="resources/style/hotelInfo.css">
<link rel="stylesheet" href="resources/style/guestroom.css">
<link rel="stylesheet" href="resources/style/reservation.css">
<link rel="stylesheet" href="resources/style/admin.css">
<link rel="stylesheet" href="resources/style/board.css">
<link rel="stylesheet" href="resources/style/login.css">
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	var filename;

	function fn_loginPage() {
		//$('.test_1').css("display","block");
		$('.test_1').addClass('open');

		$.ajax({
			url : 'getImage',
			type : 'POST',
			dataType : 'JSON',
			success : function(data) {
				filename = data.filename;
				$('#getchaImg').attr("src", "resources/storage/" + filename);
			},
			error : function() {
				alert('AJAX 통신이 실패했습니다1.');
			}
		});
	}
	function fn_resetCaptcharImg() {
		$.ajax({
			url : 'getImage',
			type : 'POST',
			dataType : 'JSON',
			success : function(data) {
				filename = data.filename;
				$('#getchaImg').attr("src", "resources/storage/" + filename);
			},
			error : function() {
				alert('AJAX 통신이 실패했습니다1.');
			}
		});
		$('#input_key').val('');
		$('#input_key').focus();
	}

	function fn_loginPageClose() {
		$('.test_1').removeClass('open');
		//$('.test_1').css("display","none");
	}

	$(document).ready(function() {

		// 아이디 기억하기
		var savedID = getCookie("savedID");
		$('#login_mId').val(savedID);

		// savedID 가 있으면, 체크박스를 체크 상태로 유지
		if ($('#login_mId').val() != '') {
			$('#saveIDCheck').attr('checked', true);
		}

		// 체크박스의 상태가 변하면,
		$('#saveIDCheck').change(function() {
			// 체크되어 있다
			if ($('#saveIDCheck').is(':checked')) {
				setCookie("savedID", $('#login_mId').val(), 7); // 7일간 쿠키에 보관
			}
			// 체크해제되어 있다.
			else {
				deleteCookie("savedID");
			}
		});

		// 아이디를 입력할 때
		$('#login_mId').keyup(function() {
			// 체크되어 있다
			if ($('#saveIDCheck').is(':checked')) {
				setCookie("savedID", $('#login_mId').val(), 7); // 7일간 쿠키에 보관
			}
		});
	});

	function fn_logout() {
		location.href = 'logout';
	}

	function fn_login(f) {
		$.ajax({
			url : 'loginCheck',
			type : 'POST',
			dataType : 'JSON',
			data : 'input_key=' + $('#input_key').val(),
			success : function(data) {
				if (data.result == true) {
					$.ajax({
						url : 'login',
						type : 'POST',
						dataType : 'JSON',
						data : 'mId=' + $('#login_mId').val() + '&mPw='
								+ $('#login_mPw').val(),
						success : function(data) {
							if (data.result != 'YES') {
								if (data.result == 'DELETED') {
									alert('탈퇴한 회원입니다.');
								} else {
									alert('로그인 실패 아이디와 비밀번호를 확인하세요.');
								}
								$('#login_mPw').val('');
								$('#input_key').val('');
								$('#login_mPw').focus();
								fn_resetCaptcharImg();
							} else {
								location.reload();
							}
						},
						error : function() {
							alert('AJAX 통신이 실패했습니다.2');
						}
					});
				} else {
					alert('그림의 인증번호와 입력하신 인증번호가 다릅니다.');
					$('#input_key').val('');
					$('#input_key').focus();
					fn_resetCaptcharImg();
				}
			},
			error : function() {
				alert('AJAX 통신이 실패했습니다.2');
			}
		});
	}

	// 1. 쿠키 만들기
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 2. 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}

	// 3. 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + "=";
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = "";
		if (start != -1) {
			start += cookieName.length;
			var end = cookieData.indexOf(";", start);
			if (end == -1) {
				end = cookieData.length;
			}
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>
<style>
.pop-up-close {
	border: none;
	position: absolute;
	top: -20.5px;
	right: -20px;
	width: 40px;
	height: 41px;
	text-indent: -9999px;
	background-color: transparent;
	background-image: url(resources/x-button.png);
	background-repeat: no-repeat;
	background-size: 100%;
	background-position: center;
}
</style>
</head>
<body>
	<div class="header-wrap">
		<div class="center-tab">
			<a href="hotelInfo">AboutUs</a> <a href="roomListPage">RoomInfo</a>
			<a href="reservation">Reservation</a> <a href="main"><img
				id="logo" alt="logo" src="resources/logo/logogo.jpg" /></a>
			<div class="dropdown">
				<a>Board▼</a>
				<div class="dropdown-content">
					<a href="noticeBoardListPage">Notice</a> <a href="qnaBoardList">QNA</a>
					<a href="ReviewBoardListPage">Review</a>
				</div>
			</div>
			<c:if test="${loginDTO eq null }">
				<a href="registerPage">REGISTER</a>
			</c:if>
			<c:if test="${loginDTO.mRight eq 1}">
				<a href="adminMain">Member Management</a>
			</c:if>
			<c:if test="${loginDTO ne null and loginDTO.mRight ne 1}">
				<a href="goMyPage">MyPage</a>
			</c:if>
			<c:if test="${loginDTO eq null }">
				<a id="loginout" href="javascript:void(0);" style="float: right;"
					onclick="fn_loginPage()"><i class="fas fa-sign-in-alt fa-2x"></i><br />LOGIN</a>
			</c:if>
			<c:if test="${loginDTO ne null }">
				<a id="loginout" href="javascript:void(0);" style="float: right;"
					onclick="fn_logout()"><i class="fas fa-sign-out-alt fa-2x"></i><br />LOGOUT</a>
			</c:if>
		</div>


	</div>
	<div class="main-footer">
		<div class="main-wrap">

			<div class="test_1">

				<div class="test_2">
					<div id="login" class="login-box">
						<form method="POST">
							<h1>LOGIN</h1>
							<br /> <input class="login-text" id="login_mId" type="text"
								name="login_mId" placeholder="아이디" autofocus /><br /> <input
								class="login-text" id="login_mPw" type="password"
								name="login_mPw" placeholder="비밀번호" /><br /> <input
								id="saveIDCheck" type="checkbox" name="saveIDCheck" value="true"
								checked />아이디 기억하기 <img id="getchaImg" src=""
								style="width: 360px; height: 120px;" /> <input id="input_key"
								type="text" name="input_key" style="margin-top: 5px;" /> <a
								href="javascript:void(0);" onclick="fn_resetCaptcharImg()"><i
								class="fas fa-redo-alt"></i></a> <br />
							<input id="loginButton" type="button" value="로그인"
								onclick="fn_login(this.form)" /> <br />
							<input id="registerButton" type="button" value="회원가입"
								onclick="location.href='registerPage'" /> <br />
							<div class="find">
								<a href="findIdPage">아이디 찾기</a>&nbsp;|&nbsp; <a
									href="findPwPage">비밀번호 찾기</a><br />
							</div>
							<a href="findReservationNumber">비회원 예약확인</a><br />
						</form>
					</div>
					<button class="pop-up-close" onclick="fn_loginPageClose()"></button>
				</div>
			</div>