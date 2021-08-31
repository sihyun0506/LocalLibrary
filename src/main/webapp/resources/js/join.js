/**
 * 
 */
 
 	
	//1. 필수정보를 입력했을 경우 True 
	var flag1 = false;
	var flag11 = false;
	var flag111 = false;
	//2.전회번호 중복 방지 플래그 
	var flag2 = true;
	//3.이메일 내용이 겹치지 않도록, 그리고 하나라도 2나 3중 false값이 존재할 경우 false 처리 되어 아이디 찾기 창으로 이동시킴.
	var flag3 = true;
	//4. ID 중복 방지 얼럿 용.
	var flag4 = false;
	
	function checkId(){
	    var id = $('#user_id').val();
	    $.ajax({
	        url:'/idDuplChk.do',
	        type:'post',
	        data:{user_id:id},
	        success:function(data){
	            if($.trim(data)==0){
	            	if(id == ""){
	            		$('#chkMsg1').html('<span style="color:red"><small>필수 정보 입니다.</small></span>');
	            		flag1 = false;
	            	}else{
	            		$('#chkMsg1').html('<span style="color:blue"><small>멋진 ID네요!</small></span>');
	            		flag4 = true;
	            		flag1 = true;
	            	}                
	            }else{
	                $('#chkMsg1').html('<span style="color:red"><small>사용하실 수 없는 ID 예요. 다시 입력해 주세요.</small></span>');
	                flag4 = false;
	            }
	        },
	        error:function(){
	                alert("에러입니다");
	        }
	    });
	};
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
	};
	function checkPhone(){
	    var pn = $('#phone').val();
	    $.ajax({
	        url:'/pnDuplChk.do',
	        type:'post',
	        data:{phone:pn},
	        success:function(data){
	            if($.trim(data)==0){
	            	if(pn == ""){
	            		$('#chkMsg3').html('<span style="color:red"><small>필수 정보 입니다.</small></span>');
	            		flag111 = false;
	            	}else{
	            		$('#chkMsg3').html('<span style="color:blue"><small>사용 하실 수 있는 전화번호예요.!</small></span>');
	            		flag2 = true; 
	            		flag111 = true;
	            	}
	            }else{
	                $('#chkMsg3').html('<span style="color:red"><small>이미 해당 전화번호로 가입된 계정이 있어요.</small></span>');
	                flag2 = false;
	            }
	        },
	        error:function(){
	                alert("에러입니다");
	        }
	    });
	};

	
	 function ckForm(){
	   	var user_id = $("#user_id").val();
	   	var pw = $("#pw").val();
	   	var pwCheck = $("#pwCheck").val();
	   	var phone = $("#phone").val();
	   	var email = $("#email").val();
	   	var postcode = $("#sample4_postcode").val();
	   	var name = $("#name").val()   
   		
		if(!flag2||!flag3){
			var result = confirm("해당 정보로 가입된 아이디가 있습니다. 찾으러 가시겠습니까?");
			if(!result){
				return false;
			}else{
				flag11 = true;
				flag111 = true;
				location.href="/member/findUserinfo";
				return false;	
			}
		}
	   	
		if(!flag1){
			alert("ID를 입력 해 주세요.");
			return false;
		} 
	
		if(!flag4){
			alert("ID를 정확히 입력해 주세요");
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
	   	
	   	 if(name == ""){
			alert("이름을 반드시 입력해 주세요");
			return false;
		} 
	   	
	   	
		if(!flag111){
			alert("사용하실 핸드폰 번호를 입력 해 주세요.");
			return false;
		} 
		
		 
	   	if(postcode == ""){
	   		alert("주소는 반드시 입력해 주세요");
	   		return false;
	   	}
	   		
		
		if(!flag11){
			alert("사용하실 이메일 주소를 입력 해 주세요.");
			return false;
		} 
		
		var ck = confirm("회원 가입 하시겠습니까?");
	   		
		if(!ck){
	   		return false;
	   	}else{
	   		alert("회원가입을 환영합니다.");
			return true;
		}
		
	}

	 
	 
$(function(){

		
		$("#shpostcode").on('click',
				
				 
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

			);	

});

