<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<title>Lady bug</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/ex/resources/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">

<link rel="stylesheet" href="/ex/resources/chatcss/styles.css" />

<style>
	.chatbootstart1 { visibility: hidden; }
	.chatbootstart2 { visibility: hidden; }
	.mg-bt10 { margin-bottom: 10px; }
</style>

</head>
<body>
	<div id="change">
		<div id="togglechat"
			style="background-color: #f4f5f7; box-shadow: 0 30px 60px rgba(50, 50, 93, 0.25); width: 304px; height: 504px; overflow-y: auto;">

			<div class="header-wrapper" style="position: absolute;">
				<header class="header" style="margin-bottom: 0px;">
					<div class="header__header-column">
						<div class="header__back-btn" onclick="buttonback_click()">
							<i class="fas fa-arrow-left"></i>
						</div>
					</div>
					<div class="header__header-column">
						<h1 class="header__title">Lady bug</h1>
					</div>
					<div class="header__header-column">
						<span class="header__icon"> <i class="fas fa-cog"></i>
						</span>
					</div>
				</header>
			</div>
			<main class="chat-screen">
				<ul id="chatList" class="chat__messages" style="padding-left: 5px;">
					<li class="chat__timestamp">&nbsp;</li>
					<span class="chat__timestamp">Monday, December 30, 2019</span>


					<li class="incoming-message message chatbootstart1"><img
						src="/ex/resources/chatcss/hello.png"
						class="m-avatar message__avatar" />
						<div class="message__content">
							<span class="message__bubble" style="word-break: break-all;">${BootContent.sb}</span>
							<span class="message__author">lady</span>
						</div>
				   </li>


				   <div id="innerhtml">
				   <li class="incoming-message message chatbootstart2"><img
						src="/ex/resources/chatcss/hello.png"
						class="m-avatar message__avatar" />
						<div class="message__content">
							<span class="message__bubble" style="word-break: break-all;">
							<c:forEach var="i" begin="0" end="${BootContent.butNum - 1}"> 
								<c:set var="fname1" value="q${i}" />
								<c:set var="fname2" value="a${i}" />
								<button id="a${i}" type="button" class="btn btn-secondary mg-bt10 buttonlock" onclick="submitboot('${BootContent[fname2]}','${BootContent[fname1]}');">${BootContent[fname1]}</button>
							</c:forEach>
							</span>
							<span class="message__author">lady</span>
						</div>	
				   </li>
				  </div>


				</ul>
			</main>
			<div class="chat__write--container chat_input"
				style="position: absolute;">
				<input id="chatContent" type="text" class="chat__write"
					placeholder="Send message" class="chat__write-input"
					style="margin-bottom: 90px; position: fixed; width: 310px; top: 780px;"
					onkeydown="return enter()" />
			</div>
		</div>


		<script type="text/javascript">

		webSocket.onerror = function(message) {
			
			$('#chatList').append('<li class="incoming-message message">' + 
	  				'<div class="message__content">' +
	  				'<span class="message__bubble">' +
	  				'error...' +
	  				'</span>' +
	  				'</div>' +
	  				'<div class="media-body">' +
	  				' </li>');
		};
		
		webSocket.onmessage = function(message) {
			
			var onmessagedata = message.data;
			
			if(onmessagedata === "AdminConnect입니다." ) {
				sessionStorage.removeItem("adminconnect");
				sessionStorage.setItem("adminconnect", "connect");
				$(".checkone").replaceWith();
				return;
				
			} else if (onmessagedata === "Adminlogout입니다.") {
				sessionStorage.removeItem("adminconnect");
				sessionStorage.setItem("adminconnect", "notConnect");
				return;
			}
	  		
			$('#chatList').append('<li class="incoming-message message">' + 
					'<img src="/ex/resources/chatcss/hello.png" class="m-avatar message__avatar" />'+
	  				'<div class="message__content">' +
	  				'<span class="message__bubble" style="word-break:break-all;">' +
	  				onmessagedata +
	  				'</span>' +
	  				'<span class="message__author">lady</span>'+
	  				'</div>' +
	  				'<div class="media-body">' +
	  				' </li>');
			$('#togglechat').scrollTop($('#togglechat')[0].scrollHeight);

		};
		
		function sendMessage() {
			
			let message = document.getElementById("chatContent");
			
			$('#chatList').append('<li class="sent-message message">' +
					'<span id="checkdb" class="spinner-border text-muted spinner-border-sm" style="margin-top: 20px;"></span>'+
	  				'<div class="message__content">' +
	  				'<span class="message__bubble" style="word-break:break-all;">' +
	  				message.value +
	  				'</span>' +
	  				'</div>' +
	  				'<div class="media-body">' +
	  				' </li>');
			$('#togglechat').scrollTop($('#togglechat')[0].scrollHeight);
			
			
			var fromID = '${userID}';
	  		var toID = 'admin';
			var chatContent = message.value;
			var chatRoomNum =${consultNum} +1;
			
			
			message.value = "";
			
				var changetext = '<span class="text-warning checkone" style="margin-top: 20px;">1</span>';
				$.ajax({
					type : "POST",
					url : "chatSubmit",
					data : {
						fromID : encodeURIComponent(fromID),
						toID : encodeURIComponent(toID),
						chatContent : encodeURIComponent(chatContent),
						chatRoomNum : chatRoomNum
					}
				}).done(function() {
					setTimeout(function() {
						
						$("#checkdb").replaceWith(changetext);
						
						if  ( "connect" === sessionStorage.getItem("adminconnect")) {
							$(".checkone").replaceWith(); 
						}
					
						webSocket.send(chatContent);

					}, 500);
				});
			}


			function enter() {

				if (event.keyCode === 13) {
					sendMessage();
					return false;
				}
				return true;
			}

			$(document).ready(function() {
				
				$('.chatbootstart1')
				  .delay(700)
				  .queue(function (next) { 
				    $(this).css('visibility', 'visible'); 
				    next(); 
				  });
				
				$('.chatbootstart2')
				  .delay(1400)
				  .queue(function (next) { 
				    $(this).css('visibility', 'visible'); 
				    next(); 
				  });
			});
		</script>
		<script>
	function submitboot(i,q){
		
		var onmessagedata = i;
		var sendmessagedata = q;
		var fromID = 'admin';
  		var toID = '${userID}';
  		var chatRoomNum =${consultNum} +1;
		
  		sessionStorage.removeItem("sendmessagedata");
  		sessionStorage.setItem("sendmessagedata", sendmessagedata);
  		
		$.ajax({
			type : "POST",
			url : "chatBootSubmit",
			data : {
				fromID : encodeURIComponent(toID),
				toID : encodeURIComponent(fromID),
				chatContent : encodeURIComponent(sendmessagedata),
				chatRoomNum : chatRoomNum
			}
		}).done(function() {
			$('#chatList').append('<li class="sent-message message">' +
	  				'<div class="message__content">' +
	  				'<span class="message__bubble" style="word-break:break-all;">' +
	  				q +
	  				'</span>' +
	  				'</div>' +
	  				' </li>');
			$.ajax({
				type : "POST",
				url : "chatBootSubmit",
				data : {
					fromID : encodeURIComponent(fromID),
					toID : encodeURIComponent(toID),
					chatContent : encodeURIComponent(onmessagedata),
					chatRoomNum : chatRoomNum

				}
			}).done(function() {
				$('#chatList').append('<li class="incoming-message message">' + 
						'<img src="/ex/resources/chatcss/hello.png" class="m-avatar message__avatar" />'+
		  				'<div class="message__content">' +
		  				'<span class="message__bubble" style="word-break:break-all;">' +
		  				i +
		  				'</span>' +
		  				'<span class="message__author">lady</span>'+
		  				'</div>' +
		  				'</li>' +
		  				'<li class="incoming-message message">' + 
						'<img src="/ex/resources/chatcss/hello.png" class="m-avatar message__avatar" />'+
		  				'<div class="message__content">' +
		  				'<span class="message__bubble" style="word-break:break-all;">' +
		  				'<button type="button" class="btn btn-secondary buttonlock" onclick="replayboot()">메뉴</button><button type="button" class="btn btn-secondary buttonlock" onclick="adminchat()">상담원연결</button>'+
		  				'</span>' +
		  				'<span class="message__author">lady</span>'+
		  				'</div>' +
		  				' </li>'		
				);
				$('#togglechat').scrollTop($('#togglechat')[0].scrollHeight);
			});
		});
	}
	
	function replayboot(){
		var el = $("#innerhtml").html();
		$('#chatList').append(el);
		$('#togglechat').scrollTop($('#togglechat')[0].scrollHeight);
	}
	
	function adminchat(){
		
		let messageconnect = "ClientConnect입니다.";
		webSocket.send(messageconnect);
		
		$(".buttonlock").removeAttr("onclick");
		var fromID = '${userID}';
  		var chatRoomNum = ${consultNum} +1;
  		var chatRoomSubject = sessionStorage.getItem("sendmessagedata");

		$.ajax({
			type : "POST",
			url : "chatRoomSetting",
			data : {
				fromID : encodeURIComponent(fromID),
				chatRoomNum : chatRoomNum,
				chatRoomSubject : encodeURIComponent(chatRoomSubject),
				admincall : 1
			}
		}).done(function() {
			sessionStorage.removeItem("sendmessagedata");
			webSocket.send("AdminCallPlease입니다.");
		});
	}
	
	
	function buttonback_click() {
		
		let clientconnectout = "ClientLogout입니다.";			
		webSocket.send(clientconnectout);
		
		var fromID = '${userID}';
  		var chatRoomNum = ${consultNum} +1;
  		var chatRoomSubject = sessionStorage.getItem("sendmessagedata");
		
  		if (!chatRoomSubject) {
			
  			$.ajax({
		  	    url: "chatindex",
		  	  	cache: false
		   }).done(function (fragment) {
		         $("#change").replaceWith(fragment);
		    });
			
		} else {
			$.ajax({
				type : "POST",
				url : "chatRoomSetting",
				data : {
					fromID : encodeURIComponent(fromID),
					chatRoomNum : chatRoomNum,
					chatRoomSubject : encodeURIComponent(chatRoomSubject)
				}
			}).done(function() {
				
				sessionStorage.removeItem("sendmessagedata");
				
				$.ajax({
			  	    url: "chatindex",
			  	  	cache: false
			   }).done(function (fragment) {
			         $("#change").replaceWith(fragment);
			    });
				
			});
		}
	}
	
</script>

	</div>
</body>
</html>