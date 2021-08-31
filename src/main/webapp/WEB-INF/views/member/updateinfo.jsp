<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateinfo</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
	<link rel="stylesheet" type="text/css" href="/resources/css/find.css" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
	<!-- 회원가입 js  -->
<script src="/resources/js/join.js"></script>
<script type="text/javascript">
/*
function checkEm(){
    var em = $('#email').val();
    $.ajax({
        url:'/emDuplChk.do',
        type:'post',
        data:{email:em},
        success:function(data){
            if($.trim(data)==0){
            	if(em == ""){
            		$('#chkMsg2').html('<span style="color:red"><small>필수 정보 입니다.</small></span>');
            		flag11 = false;
            	}else{
            		$('#chkMsg2').html('<span style="color:blue"><small>사용 하실 수 있는 Email이예요.!</small></span>');
            		flag3 = true; 
            		flag11 = true;
            	}
            }else{
                $('#chkMsg2').html('<span style="color:red"><small>이미 해당 이메일로 가입된 계정이 있어요.</small></span>');
                flag3 = false;
               
            }
        },
        error:function(){
                alert("에러입니다");
        }
    });
*/
var flag = false;
var emailflag = false;


function formCheck(){
	var pw = $("#pw").val();
	var pwCheck = $("#pwCheck").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
	var postcode = $("#sample4_postcode").val();
	
	if(pw == ""){
		alert("비밀번호를 입력해 주세요");
		return false;
	}
	if(pwCheck == ""){
		alert("비밀번호 확인을 입력해 주세요");
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
	
		
	if(email == ""){
		alert("E-Mail은 반드시 입력해 주세요");
		return false;
	}
	
	if(postcode == ""){
		alert("주소는 반드시 입력해 주세요");
		return false;
	}
	
	var ck = confirm("회원 정보를 수정하시겠습니까?");
		if(ck){
			alert("회원정보 수정이 완료되었습니다.");
			return true;
		}
		return false;
}


</script>
</head>
<body>
<div class="form-update">
	<h2 class="center logo fw=bold">내 정보 수정</h2>
	<!--  
	<h2 class="center">${loginId} 님의 정보입니다.</h2>
	<p class="center">회원정보는 개인정보방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.</p>
	-->
	<form action="/member/update" method="post" onsubmit="return formCheck();">
		<table class="table table-bordered">
			<tr >
				<td>
					<label>아이디</label>
				</td>
				<td>
					<p id="user_id" name="user_id"> ${loginId} </p>
					<span style="color:red"><small>※아이디는 수정할 수 없습니다.</small></span>
				</td>
			</tr>
			
			<tr>
				<td>
					<label>이름</label>
				</td>
				<td>
					<p id="name" name="name"> ${loginNm} </p>
					<span style="color:red"><small>※이름은 수정할 수 없습니다.</small></span>
				</td>
			</tr>
			 		 
			<tr>
				<td>
					<label>비밀번호</label>
				</td>
				<td>
					<input type="password"  id="pw" name="pw">
				</td>
			</tr>
			<tr >
				<td>
					<label>비밀번호 확인</label>
				</td>
				<td>
					<input type="password" id="pwCheck">
				</td>
			</tr>
			<tr>
				<td>
					<label>전화번호</label>
				</td>
				<td>
					<input type="text" placeholder=" ${loginPhone}" id="phone" name="phone">
				</td>
			</tr>
			<tr>
				<td>
					<label>이메일</label>
				</td>
				<td>
					<input type="text" placeholder=" ${loginEmail}" id="email" name="email" onkeyup = "checkEm()"><br>
					<span id ="chkMsg2"></span>
				</td>
			</tr>
			<tr>
				<td>
					<label>주소</label>
				</td>
				<td>
					주소<br>
					<input type="text" id="sample4_postcode"  size="50" name="postcode" readonly placeholder=" ${postCode}">
					<button type="button" onclick="sample4_execDaumPostcode()" class="btn-primary btn-warning font-color-white" >우편번호 찾기</button><br>
					<input type="text" id="sample4_roadAddress"  size="23" name="addr1"readonly placeholder=" ${loginAddr1}">
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소" size="21"readonly><br>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_detailAddress" size="23" name="addr2" placeholder=" ${loginAddr2}">
					<input type="text" id="sample4_extraAddress" placeholder="참고항목" size="21" name="addr2"readonly>
				</td>
			</tr>
			<tr>
				<td>
					<label>닉네임</label>
				</td>
				<td>
					<input type="text" value="${loginNickname }" id="nickname" name="nickname" ><br>
				</td>
			</tr>
			<tr>
				<td>
					<label>생년월일</label>
				</td>
				<td>
					<input type="date" placeholder=" " id="birthday" name="birthday" ><br>
				</td>
			</tr>
			<tr>
				<td>
					<label>성별</label>
				</td>
				
				<td>
					<!-- <input type="text" placeholder=" " id="gender" name="gender" ><br> -->
					<select name="gender" id="gender">
						<option selected="selected" value="3">선택안함</option>
						<option value="1">남자</option>
						<option value="2">여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2">
					<input type="submit" value="수정하기" class="btn btn-warning font-color-white center">
				</td>
			</tr>
		</table>
	</form>
</div>
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