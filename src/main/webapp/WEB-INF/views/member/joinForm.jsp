<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
<script src="/resources/js/jquery-3.6.0.js" type="text/javascript"></script>
<script type="text/javascript">
var flag = false;
var emailflag = false;

$(function(){
	
	$("#idCheckbtn").on("click",function(){
	
		var user_id = $("#user_id").val();
		
		if(user_id == ""){
			alert("중복 검사를 위해서 사용하실 ID를 입력해 주세요.");
			return false;
		}else{
			$.ajax({
				url : "/idCheck",
				type : "post",
				data : {
					user_id : user_id
				},
				dataType : "json",
				success : function(data){
					if(data){
						var ck = confirm("사용 가능한 아이디 입니다. 사용하시겠습니까?");
						if(ck){
							$("#user_id").prop("readonly", true);
							flag = true;
						}else{
							$("#user_id").val("").focus();
						}
					}else{
						alert("사용중인 ID 입니다.");
						$("#user_id").val("").focus();
					}
				},
				error : function(e){
					console.log(e);
				}
			});
		}
	
	});
	
		$("#emailChkBtn").on("click",function(){
		
		var email = $("#email").val();
		
		if(email == ""){
			alert("비밀번호 재확인을 위한 Email 주소를 입력해 주세요.");
			return false;
		}else{
			$.ajax({
				url : "/emailCheck",
				type : "post",
				data : {
					email : email
				},
				dataType : "json",
				success : function(data){
					if(data){
						var ck = confirm("사용 가능한 Email 입니다. 등록 하시겠습니까?");
						if(ck){
							$("#email").prop("readonly", true);
							emailflag = true;
						}else{
							$("#email").val("").focus();
						}
					}else{
						alert("이미 사용중인 메일 주소 입니다");
						$("#email").val("").focus();
					}
				},
				error : function(e){
					console.log(e);
				}
			});
		}
	
	});

});

function ckForm(){
	var user_id = $("#user_id").val();
	var pw = $("#pw").val();
	var pwCheck = $("#pwCheck").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
	var postcode = $("#sample4_postcode").val();
	

	
	if(user_id == ""){
		alert("ID는 반드시 입력해 주세요");
		return false;
	}
	if(!flag){
		alert("ID 중복체크를 해주세요");
		return false;
	}
	if(pw == ""){
		alert("비밀번호는 반드시 입력해 주세요");
		return false;
	}
	if(pw != pwCheck ){
		alert("동일한 비밀번호를 입력하세요.");
		return false;
	}
	if(phone == ""){
		alert("핸드폰 번호는 반드시 입력해 주세요");
		return false;
	}
	if(postcode == ""){
		alert("주소는 반드시 입력해 주세요");
		return false;
	}
		
	if(email == ""){
		alert("E-Mail은 반드시 입력해 주세요");
		return false;
	}
	if(!emailflag){
		alert("Email 중복 검사를 해주세요");
		return false;
	}
	
	var ck = confirm("회원 가입 하시겠습니까?");
		if(ck){
			alert("회원가입을 환영합니다.");
			return true;
		}
		return false;
}



</script>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<style>
h1 {
	/*text-align: center;*/

	font-size: 90px;
}

table {
	text-align: center;
	margin: 20px;
}

th {
	padding: 10px;
	text-align: center;
}

td {
	padding: 10px;
}

.logo {
	color : #fbbc05;
}

.sign-up{
	background-color : #fbbc05;
}

.search-bar{
	width : 500px;
}




.border {
	border: 1px solid black;
}

.bold {
	font-weight: bold;	
}
.left {
	text-align: left;
}
.center {
	text-align: center;
}
.title {
	background-color: #cccccc;
}

.fl {
	float : left;
}

.fr {
	float : right;
}

.font-color-black{
	color : black;
}
.font-color-white{
	color : white;
}
</style>
</head>
<body>
<h1 class=" logo fw-bold">Welcome to<br> Local Lib!</h1>

<form action="/member/join" method="post" id="formCheck" name="formCheck" onsubmit="return ckForm();">
			
			<fieldset>
			<div>
				<table class="left">
					<tr>
						<td>
							ID<br>
							<input type="text" id="user_id" name="user_id" placeholder="ID는 8자 이내로 입력해 주세요" size="50">
							<button type="button" id="idCheckbtn" class="btn-primary btn-warning font-color-white" >ID 중복 체크</button>
						</td>
					</tr>
					
					<tr>
						<td>
							비밀번호<br>
							<input type="password" id="pw" name="pw" placeholder="비밀번호는 10자 이내로 입력해 주세요" size="50">
						</td>
					</tr>
				
					<tr>
						<td>
							비밀번호 확인<br>
							<input type="password" id="pwCheck" placeholder="비밀번호 확인을 위해 한번 더 입력 해 주세요" size="50">
						</td>
					</tr>
				
					<tr>
						<td>휴대폰 번호<br><input type="text" id="phone" name="phone" placeholder="숫자만 입력해주세요" size="50"></td>
					</tr>
				
					<tr>
						<td>
							주소<br>
							<input type="text" id="sample4_postcode" placeholder="우편번호" size="50" name="postcode" readonly>
							<button type="button" onclick="sample4_execDaumPostcode()" class="btn-primary btn-warning font-color-white" >우편번호 찾기</button><br>
							<input type="text" id="sample4_roadAddress" placeholder="도로명주소" size="23" name="addr1"readonly>
							<input type="text" id="sample4_jibunAddress" placeholder="지번주소" size="21"readonly><br>
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="sample4_detailAddress" placeholder="상세주소" size="23" name="addr2">
							<input type="text" id="sample4_extraAddress" placeholder="참고항목" size="21" name="addr2"readonly>
						</td>
					</tr>
				
					<tr>
						<td>
							E-Mail<br>
							<input type="text" id="email" name="email" placeholder="Email을 입력해 주세요" size="50">
							<button type="button" id="emailChkBtn" class="btn-primary btn-warning font-color-white" >E-mail 체크</button>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<button type="submit" class="btn-primary btn-warning font-color-white center" >가입 신청</button>
						</th>
					</tr>
				</table>
				</div>
			</fieldset>	
		</form>
		
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</body>
</html>