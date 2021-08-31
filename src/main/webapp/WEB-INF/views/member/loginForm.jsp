<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
<script type="text/javascript">
function formCheck(){
	var user_id = document.getElementById("user_id").value;
	var pw = document.getElementById("pw").value;
	
	if(user_id == ""){
		alert("아이디를 입력해주세요");
		return false;
	}
	
	if(pw == ""){
		alert("비밀번호를 입력해주세요");
		return false;
	}
	return true;
}
</script>

</head>
<body>



<div class="modal modal-signin position-static d-block bg-secondary py-5" tabindex="-1" role="dialog" id="modalSignin">
  <div class="modal-dialog" role="document">
    <div class="modal-content rounded-5 shadow">
      <div class="  p-5 pb-4 border-bottom-0 ">
      
        <!--  h5 class="modal-title">Modal title</h5> --> 
        <!-- 모달로 변경시 취소 버튼
         button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>-->
        
        <h2 class=" fw-bold mb-0 text-center text-warning h1">Local Lib </h2>
        
        
      </div>

      <div class="modal-body p-5 pt-0">
      
        <form action="/member/login" method="post" onsubmit="return formCheck();">
          <div class="form-floating mb-3">
            <input type="text" class="form-control rounded-4" id="user_id" name="user_id" placeholder="name@example.com">
            <label for="floatingInput">Id</label>
          </div>
          <div class="form-floating mb-3">
            <input type="password" class="form-control rounded-4" id="pw" name="pw" placeholder="Password">
            <label for="floatingPassword">Password</label>
          </div>
          <div class="text-center">
          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary btn-warning font-color-white " type="submit">로그인</button>
          <small class="text-muted "> <a href="/member/findUserinfo" > 아이디  /  비밀번호 찾기 </a></small>
          <hr class="my-4">
          </div>
          
          
          
          <!--  h2 class="fs-5 fw-bold mb-3">Or use a third-party</h2>
          <button class="w-100 py-2 mb-2 btn btn-outline-dark rounded-4" type="submit">
            <svg class="bi me-1" width="16" height="16"><use xlink:href="#twitter"></use></svg>
            Sign up with Twitter
          </button>
          <button class="w-100 py-2 mb-2 btn btn-outline-primary rounded-4" type="submit">
            <svg class="bi me-1" width="16" height="16"><use xlink:href="#facebook"></use></svg>
            Sign up with Facebook
          </button>
          <button class="w-100 py-2 mb-2 btn btn-outline-secondary rounded-4" type="submit">
            <svg class="bi me-1" width="16" height="16"><use xlink:href="#github"></use></svg>
            Sign up with GitHub
          </button>
          -->
        </form>
      </div>
    </div>
  </div>
</div>

</html>