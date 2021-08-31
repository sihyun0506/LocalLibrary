<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findUserinfo</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />


<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">

//var dpcheck = false;

$(function(){
	
	//홈 - 모든 폼 숨기기
	$("#searchId").hide();
	$("#userPwCheck").hide();
	$("#searchPw").hide();
	
	//아이디찾기버튼 (클릭시 아이디찾기 폼 보여주고 비밀번호찾기 버튼 숨기기)
	
	$("#findUserId").on("click", function(){
		$("#searchId").show();
		$("#searchPw").hide();
		$("#pw_returnPw").empty();
		$("#pw_user_id").val("");
		$("#pw_name").val("");
		$("#pw_email1").val("");
		$("#pw_email2").val("");
		
		
		
		
	});
	
	//비밀번호찾기버튼 (클릭시 비밀번호찾기 폼 보여주고 아이디찾기 버튼 숨기기)
	$("#findUserPw").on("click", function(){
		$("#searchPw").show();
		$("#searchId").hide();
		$("#userPwCheck").hide();
		$("#returnId").empty();
		$("#returnPw").empty();
		$("#name").val("");
		$("#email1").val("");
		$("#email2").val("");
		
		
	});
	
	
	/*
	$(this).data('clicked', true);
	$(this).data('clicked', true);
	//$(".btn1").attr('class','btn btn-light');
	//$(".btn1").attr('class','btn btn-warning font-color-white');
		//$(".btn btn-light").attr('class','btn btn-warning font-color-white');
	if(("#findUserId").data("clicked")){
		$(".btn2").attr('class','btn btn-light');
	}
	if(("#findUserPw").data("clicked")){
		$(".btn1").attr('class','btn btn-light');
	}
	*/
	
	//아이디확인버튼 (클릭시 아이디 보여주고 비밀번호찾기버튼 보여주기)
	$("#userIdCheck").on("click", function(){
	
		var name = $("#name").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/userIdCheck",
			type : "post",
			data : {
				name : name,
				email : email
			},
			dataType : "json",
			success : function(data){
				
				if(data){
					var ck = confirm("아이디를 찾으시겠습니까?");
					if(ck){
						$("#userPwCheck").show();
						var context = '<p>'+"회원가입 시 사용한 아이디는 : "+data.user_id+" 입니다."+'</p>';
						
						$("#returnId").html(context);
					}
				}
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
				$("#name").val("");
				$("#email1").val("");
				$("#email2").val("");
			}
		});
	});
	
	//아이디찾기 - 비밀번호 찾기버튼(hide)
	$("#userPwCheck").on("click", function(){
	
		var name = $("#name").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/userPwCheck",
			type : "post",
			data : {
				name : name,
				email : email
			},
			dataType : "json",
			success : function(data){
				if(data){
					var ck = confirm("비밀번호를 찾으시겠습니까?");
					if(ck){
						var context = '<p>'+"회원가입 시 사용한 비밀번호는 : "+data.pw+" 입니다."+'</p>';
						$("#returnPw").html(context);
					}
				}
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
			}
		});
	});
	
	// 아이디찾기 - 재입력버튼 (클릭시 이름, 이메일, 어이디, 비밀번호 삭제)
	$("#reEnter").on("click", function(){
		$("#userPwCheck").hide();
		$("#returnId").empty();
		$("#returnPw").empty();
		$("#name").val("");
		$("#email1").val("");
		$("#email2").val("");
		$("#email").find("option:eq(0)").prop("selected", true);
		
	});
	
	
	/*----------------------------------------------------------------------*/
	
	
	
	//비밀번호찾기 - 비밀번호찾기버튼
	$("#pw_userPwCheck").on("click", function(){
	
		var user_id = $("#pw_user_id").val();
		var name = $("#pw_name").val();
		var email1 = $("#pw_email1").val();
		var email2 = $("#pw_email2").val();
		var email = email1 + "@" + email2;
		
		$.ajax({
			url : "/pw_userPwCheck",
			type : "post",
			data : {
				user_id : user_id,
				name : name,
				email : email
			},
			dataType : "json",
			
			success : function(data){
				if(data){
					var ck = confirm("비밀번호를 찾으시겠습니까?");
					if(ck){
						var context = '<p>'+"회원가입 시 사용한 비밀번호는 : "+data.pw+" 입니다."+'</p>';
						$("#pw_returnPw").html(context);
					}
				}
			},
			error : function(e){
				console.log(e);
				alert("입력된 정보가 없습니다. 다시 입력해 주세요");
			}
		});
	});
	
	//비밀번호찾기 - 재입력버튼
	$("#pw_reEnter").on("click", function(){
		$("#pw_returnPw").empty();
		$("#pw_user_id").val("");
		$("#pw_name").val("");
		$("#pw_email1").val("");
		$("#pw_email2").val("");
		$("#pw_email").find("option:eq(0)").prop("selected", true);
	});
});


//아이디찾기 - 이베일 셀렉트
function auto_select_email(){
	var email2 = document.getElementById("email2");
	var email_selected = document.getElementById("email");
	
	var index = email_selected.options.selectedIndex;
	email2.value = email_selected.options[index].value;
}
//비밀번호찾기 - 이메일 셀렉트
function pw_auto_select_email(){
	var pw_email2 = document.getElementById("pw_email2");
	var pw_email_selected = document.getElementById("pw_email");
	
	var index = pw_email_selected.options.selectedIndex;
	pw_email2.value = pw_email_selected.options[index].value;
}

/*
function formCheck1(){
	
	var name = $("#name").val();
	var email1 = $("#email1").val();
	var email2 = $("#email2").val();

	//이름
	if(name==""){
		alert("이름을 입력해 주세요");
		return false;
	}
	
	//이메일
	if(email1==""){
		alert("이메일 아이디를 입력해주세요");
		return false;
	}
	//이메일 주소 확인
	if(email2==""){
		alert("이메일 주소를 입력해 주세요");
		return false;
	}
	return true;

}
*/

</script>
<style type="text/css">
.form-signin {
    width: 100%;
    max-width: 550px;
    padding: 15px;
    margin: auto;
}
</style>
</head>
<body>


<div class="form-signin">
	<h2 class="center logo fw=bold">회원정보 찾기</h2>
	
	<div class="center">
		<input type="button" id="findUserId" value="아이디 찾기" class ="btn btn-warning font-color-white btn1" >
		<input type="button" id="findUserPw" value="비밀번호 찾기" class ="btn btn-warning font-color-white btn2"><br><br> <!-- name="btnbutton" clicked autocomplete="off" for="btn-check-outlined" -->
	</div>	
	<!-- 아이디 찾기 -->
	<div id="searchId" >
		<label>이름</label><br>
		<input type="text" id="name" placeholder="Name"><br>
		
		<label>이메일</label><br>
		<input type="text" id="email1" placeholder="Email Id">@
		<input type="text" id="email2" placeholder="Email Address">
		
		<select id="email" onchange="auto_select_email();">
		    <option value="" selected="selected">선택하세요</option>
		    <option value="">직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select><br><br>
		<input type="button" id="userIdCheck" id="numSubmit" value="아이디확인" class ="btn btn-warning font-color-white "><br><br>
		
		<div id="returnId"></div>
		<div id="returnPw"></div>
		
		<input type="reset" id="reEnter" value="재입력" class ="btn btn-warning font-color-white ">
		<input type="button" id="userPwCheck" value="비밀번호 찾기" class ="btn btn-warning font-color-white ">
	</div>
	
	<!-- <p>-------------------------------------------------<p><br><br> -->
	
<!-- 비밀번호 찾기 -->
	<div id="searchPw">
		<label>아이디</label><br>
		<input type="text" id="pw_user_id" placeholder="ID"><br>
		
		<label>이름</label><br>
		<input type="text" id="pw_name" placeholder="Name"><br>
		
		<label>이메일</label><br>
		<input type="text" id="pw_email1" placeholder="Email Id">@
		<input type="text" id="pw_email2" placeholder="Email Address">
		
		<select id="pw_email" onchange="pw_auto_select_email();">
		    <option value>선택하세요</option>
		    <option value>직접입력</option>
		    <option value="naver.com">naver.com</option>
		    <option value="daum.net">daum.net</option>
		    <option value="gmail.com">gmail.com</option> 
		</select><br><br>
		
		<div id="pw_returnPw"></div>
		
		<input type="button" id="pw_userPwCheck" value="비밀번호 찾기" class="btn btn-warning font-color-white "><br><br>
		<input type="reset" id="pw_reEnter" value="재입력" class="btn btn-warning font-color-white ">
	</div>
</div>	

</body>
</html>