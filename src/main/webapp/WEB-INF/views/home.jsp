<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page isELIgnored="false" %>
<!--  %@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>-->
<!--  %@ page session="false" %> 세션 받아오지 않는 기능-->
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Local Lib</title>
   
    <script src="/resources/js/jquery-3.6.0.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
<!-- 책검색 -->
<script src="/resources/js/bookSearch.js"></script>
<!-- 회원가입 js  -->
<script src="/resources/js/join.js"></script>
<!-- 주소검색 시스템 구현  -->
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	  <script type="text/javascript"></script>
<!--  회원가입 css -->
	<link rel="stylesheet" type="text/css" href="resources/css/join.css"/>
</head>

<body>
	

  	  <header class="p-3 mb-3 border-bottom   ">
		
		    <div class="container">
		    <div class=" row-vw d-flex justify-content-between   ">
		    
		    
		     	<div onClick="location.href='/'" class="home">
			       <span class="logo fs-15 mx-auto fw-bold"><h3>Local Lib</h3></span>
			    </div>
		    
			    <div class="text-end">
			    
			   		
			    <c:choose>
						<c:when test="${empty sessionScope.loginId}">
						
							<a id="bootstraps_papa" data-bs-toggle="modal" href="#exampleModalToggle" role="button" class="btn btn-warning font-color-white ">Sign-up</a>
		        		   <!-- <button type="button" id="modal_open_btn" onClick="" class="btn btn-warning font-color-white ">Sign-up</button> -->
		          		  <!--  button type="button" onClick="" class="btn  btn-primary btn-warning font-color-white ">Sign-up</button>-->
		          		  <button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Sign-in</button>
		          		  <!--  button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Logout</button>-->
		          		</c:when>
						<c:otherwise>
						<button type="button" onClick="location.href='/member/myInfo'" class="btn  btn-primary btn-warning font-color-white ">My Info</button>
						  <button type="button" onClick="location.href='/member/logout'" class="btn btn-light text-dark me-2">Sign-out</button>
						<!--  a href="#" class="link-dark text-decoration-none dropdown-toggle  " id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
				           		<img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle ">
				         </a>
				           
				          <ul class="dropdown-menu text-small " aria-labelledby="dropdownUser1">
					            <li><a class="dropdown-item" href="#">MyPage</a></li>
					            <!--  li><a class="dropdown-item" href="#">Profile</a></li>
					            <li><hr class="dropdown-divider" href="#"></li>
					            <li><a class="dropdown-item" href="/member/logout">Sign out</a></li>
				          </ul> 
						-->
						
						
						</c:otherwise>
				</c:choose>
				  	
						 
			          	  
				     </div>   
	        	</div>
		          
		    </div>
		     
 	  </header>   


<!-- Modal1 -->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body">
        <h5 class="modal-title" id="exampleModalToggleLabel"></h5>
        <div>
        <form action="/member/join" method="post" id="formCheck" name="formCheck" onsubmit="return ckForm();">
			
			<!--<fieldset>  -->
			<!-- <div > -->
				<table class="left" style="margin:10px auto auto auto;">
					<tr>
						<h5 class=" logo fw-bold center">여러분과 함께하고 싶은 문화공동체 LocalLib</h5>
					</tr>
					<tr>
						<td colspan="2">
							ID<br>
							<input class="form-control" type="text" id="user_id" name="user_id" placeholder="ID는 8자 이내로 입력해 주세요" size="50" onkeyup="checkId()" oninput="this.value = this.value.replace(/[^a-z_0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="8"/>
							<div id="chkMsg1"></div>
						</td>
						<!-- <td>
							<button type="button" id="idCheckbtn" class="btn-primary btn-warning font-color-white" >ID 중복 체크</button>
						</td> -->
					</tr>
					<tr>
						<td>
							비밀번호<br>
							<input class="form-control" type="password" id="pw" name="pw" placeholder="비밀번호는 10자 이내로 입력해 주세요" size="50" maxlength="10">
						</td>
					</tr>
					<tr>
						<td>
							비밀번호 확인<br>
							<input class="form-control" type="password" id="pwCheck" placeholder="비밀번호 확인을 위해 한번 더 입력 해 주세요" size="50" maxlength="10">
						</td>
					</tr>
					<tr>
						<td>
							이름<br>
							<input class="form-control" type="text" id="name" name="name" placeholder="이름을 입력해 주세요" size="50" maxlength="20">
						</td>
					</tr>
					<tr>
						<td>휴대폰 번호<br><input class="form-control" type="text" id="phone" name="phone" placeholder="숫자만 입력해주세요" size="50"  onkeyup="checkPhone()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11" />
						<div id ="chkMsg3"></div>
						</td>
						
					</tr>
					<tr>
						<td colspan="2">
							주소<br>
							<div class="input-group mb-3">
  							<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" size="34" name="postcode" readonly>
							<button type="button" class="btn btn-warning btn-sm font-color-white" id="shpostcode">우편번호 검색</button>
							</div>
							</td>
					</tr>
					<tr>
						<td>
							<div class="input-group mb-3">
  							<input class="form-control" type="text" id="sample4_roadAddress" placeholder="도로명주소" size="23" name="addr1"readonly>
							<input class="form-control" type="text" id="sample4_jibunAddress" placeholder="지번주소" size="21"readonly>
							</div>							
							<span id="guide" style="color:#999;display:none"></span>
							<div class="input-group mb-3">
  							<input class="form-control" type="text" id="sample4_detailAddress" placeholder="상세주소" size="23" name="addr2" maxlength="50">
							<input class="form-control" type="text" id="sample4_extraAddress" placeholder="참고항목" size="21" name="addr2"readonly>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							E-Mail<br>
							<input class="form-control" type="text" id="email" name="email" placeholder="Email을 입력해 주세요" size="50" onkeyup = "checkEm()" maxlength="50"/><br>
							<span id ="chkMsg2"></span>
						</td>
						<!-- <td><button type="button" id="emailChkBtn" class="btn-primary btn-warning font-color-white" >E-mail 체크</button>
						</td> -->
					</tr>
					<tr>
						<td colspan="3" align="center">
							<button type="submit" class="btn btn-warning font-color-white" id="submitForm">가입 신청</button>
						</td>
					</tr>
				</table>
				<!-- </div> -->
			<!--</fieldset>  -->	
		</form>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 
<div id="modal">
   
<div class="modal_content">
<h5 class=" logo fw-bold center">여러분과 함께하고 싶은 문화공동체</h5>

<form action="/member/join" method="post" id="formCheck" name="formCheck" onsubmit="return ckForm();">
			
			<fieldset> 
			<div >
				<table class="left" style="margin:10px auto auto auto;">
					<tr>
						<td colspan="2">
							ID<br>
							<input type="text" id="user_id" name="user_id" placeholder="ID는 8자 이내로 입력해 주세요" size="30" onkeyup="checkId()" oninput="this.value = this.value.replace(/[^a-z_0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="8"/><br>
							<span id="chkMsg1"></span>
						</td>
						<td>
							<button type="button" id="idCheckbtn" class="btn-primary btn-warning font-color-white" >ID 중복 체크</button>
						</td>
					</tr>
					<tr>
						<td>
							비밀번호<br>
							<input type="password" id="pw" name="pw" placeholder="비밀번호는 10자 이내로 입력해 주세요" size="50" maxlength="10">
						</td>
					</tr>
					<tr>
						<td>
							비밀번호 확인<br>
							<input type="password" id="pwCheck" placeholder="비밀번호 확인을 위해 한번 더 입력 해 주세요" size="50" maxlength="10">
						</td>
					</tr>
					<tr>
						<td>
							이름<br>
							<input type="text" id="name" name="name" placeholder="이름을 입력해 주세요" size="50" maxlength="20">
						</td>
					</tr>
					<tr>
						<td>휴대폰 번호<br><input type="text" id="phone" name="phone" placeholder="숫자만 입력해주세요" size="50"  onkeyup="checkPhone()" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11" /><br>
						<span id ="chkMsg3"></span>
						</td>
						
					</tr>
					<tr>
						<td>
							주소<br>
							<input type="text" id="sample4_postcode" placeholder="우편번호" size="30" name="postcode" readonly></td>
							<td><button type="button" class="btn-primary btn-warning font-color-white" id="shpostcode">우편번호 찾기</button><br></td>
						</tr><tr>
						<td><input type="text" id="sample4_roadAddress" placeholder="도로명주소" size="23" name="addr1"readonly>
							<input type="text" id="sample4_jibunAddress" placeholder="지번주소" size="21"readonly><br>
							<span id="guide" style="color:#999;display:none"></span>
							<input type="text" id="sample4_detailAddress" placeholder="상세주소" size="23" name="addr2" maxlength="50">
							<input type="text" id="sample4_extraAddress" placeholder="참고항목" size="21" name="addr2"readonly>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							E-Mail<br>
							<input type="text" id="email" name="email" placeholder="Email을 입력해 주세요" size="30" onkeyup = "checkEm()"   maxlength="50"/><br>
							<span id ="chkMsg2"></span>
						</td>
						<td><button type="button" id="emailChkBtn" class="btn-primary btn-warning font-color-white" >E-mail 체크</button>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<button type="submit" class="btn-primary btn-warning font-color-white " id="submitForm">가입 신청</button>
						</td>
					</tr>
				</table>
				</div>
			</fieldset> 	
		</form>
    </div>
    <div class="modal_layer" id = "modal_close_btn" onclick="reset" style="cursor:hand"></div>
</div> -->
	  <h1 class="center logo fw-bold">
	        Local Lib
	  </h1>

	  <form action="" method="GET">
	        <div class="search-bar mx-auto mt-5 rounded-pill input-group mb-3">
	  				<input type="text" id="keyword" class="form-control place-holder-align-c" placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  				<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="searchBookDB();">검색</button>
	  				<button class="btn btn-outline-secondary" type="button" id="btn_adv_search" >상세검색</button>
	  		</div>
	            
	  </form>
		<!-- 상세검색창 -->
        <div id="searchAdvBookDBForm" class="search-bar mx-auto mt-2 rounded-pill input-group mb-3">
			<table class="mx-auto">
				<tr>
					<td><input type="text" name="book_name" id="book_name_d" class="form-control " placeholder="제목"></td>
				</tr>
				<tr>
					<td><input type="text" name="author" id="author_d" class="form-control " placeholder="글쓴이"></td>
				</tr>
				<tr>
					<td><input type="text" name="publisher" id="publisher_d" class="form-control " placeholder="출판사"></td>
				</tr>
				<tr>
					<td><input type="text" name="isbn" id="isbn_d" class="form-control " placeholder="ISBN" maxlength="13" oninput="this.value = this.value.replace(/[^0-9]/g, '');" ></td>
				</tr>
				<tr>
					<td>
					<div class="row-vw d-flex">
					<button id="refresh" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">
						다시입력
					</button>
					<button id="submit_form" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">		
			
						&nbsp;&nbsp;검&nbsp;&nbsp;색&nbsp;&nbsp;
					</button>
					</div>
					</td> 
				</tr>
			</table>
		</div>
	

	
</body>
</html>
