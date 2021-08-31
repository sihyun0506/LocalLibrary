<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책검색결과</title>
	<script src="/resources/js/jquery-3.6.0.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />

	
	<!-- 주소검색 시스템 구현  -->
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	  <script type="text/javascript"></script>

	    <!-- 회원가입 js  -->
<script src="/resources/js/join.js"></script>
<!-- 책검색 -->
	<script src="/resources/js/bookSearch.js"></script>
	<!--  회원가입 css -->
	<link rel="stylesheet" type="text/css" href="resources/css/join.css"/>
	<script type="text/javascript">
	
	var isbn_a = "";
	var receiver_id_a = "";
	var book_id_a = "";
	
	$(function(){
		$("#bootstraps_papa").hide();
				
		//1.대여요청(책 검색 후 상세 정보 화면의 '대여 버튼'과 연결)
		$("#new_rent_request").on("click",function(){
			//책주인이 본인일 시
			console.log($("#login_id").val());
			console.log(receiver_id_a);
			
			if($("#login_id").val()==receiver_id_a)
				alert("본인의 도서는 대여 불가합니다.");
			//책 주인에게 메시지 전송
			else{
				var context = "대여요청!<br><br>" + $("#login_id").val() + "님으로부터 아래 책에 대한 대여요청이 왔습니다. 수락하시겠습니까?";
				$.ajax({
					url : '/newRentRequest',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						receiver_id : receiver_id_a,
						context : context, 
						type : '2',
						isbn : isbn_a,
						book_id : book_id_a
					}),
					dataType : "json",
					success : function(data){
						console.log(data);
						if(data == true){
							$("#my_modal_close").trigger("click");
							alert("대여 신청 완료!");
						}else{
							alert("대여 신청 실패...");						
						}
					},
					error : function(e){
						console.log(e);	
					}
				//메시지 post 형식으로 전송
				//발신자 : 책의 id로 검색한 상대 id 전송
				//내용 : '~님 ~로부터 대여 요청이 왔습니다. 수락하시겠습니까?'
				//타입 : 2(버튼 포함)
				//isbn : 현재 책
				//받아오는거는 메시지 전송 성공여부 반환			
				});
			}
		});
	});
	
	function search_book_info(keyword, owner_id, book_id){
		isbn_a = keyword;
		receiver_id_a = owner_id;	
		book_id_a = book_id;
		
		$.ajax({
			url : '/naverBookSearch',
			type : 'get',
			//한글로 보내주기 위해선 필요
			contentType : "application/json; charset=utf-8",
			data : {
				keyword : keyword
			},
			dataType : "json",
			async : false,
			success : function(data){
				console.log(data);

				var context = '';
				if(data.items[0]!=null){
					var isbn_long = data.items[0].isbn.split(" ");
					
					book_name_temp = data.items[0].title;
					author_temp = data.items[0].author;
					publisher_temp = data.items[0].publisher;
					var isbn_splited = isbn_long[1].split("");
					isbn_temp = "";
					for(var i=3;i<16;i++){
						isbn_temp += isbn_splited[i];
					}
				
					context = '<table>'
					context += '<tr><td rowspan="4"><img src='+data.items[0].image+'></td>';
					context += '<td>'+data.items[0].title+'</td></tr>';
					context += '<tr><td>'+data.items[0].author+'</td></tr>';	
					context += '<tr><td>'+isbn_long[1]+'</td></tr>';
					context += '<tr><td>'+data.items[0].publisher+'</td></tr></table>';
				$("#modal_header").show();
				$("#modal_foot").show();	
				$("#book_show").show();	
				$("#book_show").html(context);
				$("#changhun").hide();
				$("#bootstraps_papa").get(0).click();
				}
			},
			error : function(e){
				console.log(e);	
			}
		});
	}
	
	function changhun(){
		$("#modal_header").hide();
		$("#modal_foot").hide();
		$("#book_show").hide();	
		$("#changhun").show();
		$("#bootstraps_papa").get(0).click();
	}
	
	</script>

</head>
<body>


 <header class=" p-3 mb-3 border-bottom   ">
		    
		     <div class="container">
		     <div class=" row-vw d-flex justify-content-between   ">
		    	
			       <div onClick="location.href='/'" class="home">
			       			<span class="logo fs-15 mx-auto fw-bold"><h3>Local Lib</h3></span>
			       </div>
			       
			       <div class=" m-l-10">
				        <form action="" method="GET" class="col-12 col-lg-auto mb-3 mb-lg-0  ">
		        			<div class="search-bar   rounded-pill input-group  m-r-20">
				  				<input type="text" id="keyword" class="form-control place-holder-align-c" placeholder="어떤 도서를 찾으시나요:)" aria-label="Recipient's username" aria-describedby="button-addon2">
	  							<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="searchBookDB();">검색</button>
	  				
		  					</div>
		        
		 				 </form>
				    </div>
			       
			  		<div class="text-end  ">
			   		
							    <c:choose>
										<c:when test="${empty sessionScope.loginId}">
						        		   <button type="button" id="modal_open_btn" onClick="changhun();" class="btn  btn-primary btn-warning font-color-white ">Sign-up</button>
						          		  <!--  button type="button" onClick="" class="btn  btn-primary btn-warning font-color-white ">Sign-up</button>-->
						          		  <button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Sign-in</button>
						          		  <!--  button type="button" onClick="location.href='/member/loginForm'" class="btn btn-light text-dark me-2">Logout</button>-->
						          		</c:when>
										<c:otherwise>
										<button type="button" onClick="location.href='/member/myInfo'" class="btn  btn-primary btn-warning font-color-white ">My Info</button>
										  <button type="button" onClick="location.href='/member/logout'" class="btn btn-light text-dark me-2">Sign-out</button>
										
										
										</c:otherwise>
								</c:choose>
				  	
						 
			          	  
				     </div> 
	        	
		          </div>
		    </div>
 	  </header>  



<!-- DB책 검색 결과 -->
<div class="container">
<!--  h3 class="center">도서목록</h3>-->
	<table  class="table  table-hover table-bordered">
		<tr  class="table-warning center">
			<!-- <th>책ID</th> -->
			<th>대여가능한 책이름</th>
			<th>저자 </th>
			<th>출판사</th>
			<th>isbn</th>
			<!-- <th>kdc </th>
			<th>등록날짜</th>
			<th>등록자</th>
			<th>state_gb</th> -->
	</tr>
	<c:forEach var="data" items="${list}">		
 		<tr onClick="search_book_info(${data.isbn}, '${data.owner_id}', '${data.book_id}')" class="center">
 			<%-- <td> ${data.book_id}</td>  --%>
			<td> ${data.book_name} </td> 
			<td> ${data.author} </td> 
			<td> ${data.publisher}</td> 
			<td> ${data.isbn} </td>  
			<%-- <td> ${data.kdc} </td> 
			<td> ${data.indate} </td> 
			<td> ${data.owner_id} </td> 
			<td> ${data.state_gb}</td> --%>
		</tr>
	</c:forEach>	
	</table>
</div>	
	<input type="hidden" id="login_id" value='${sessionScope.loginId}'/>
	
	<a id="bootstraps_papa" data-bs-toggle="modal" href="#exampleModalToggle" role="button"></a>
		


<!-- Modal1 -->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" id="modal_header">
        <h5 class="modal-title" id="exampleModalToggleLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="my_modal_close"></button>
      </div>
      
      <div class="modal-body">
		<div id="book_show"></div>   
		<div id="changhun">
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
      
      <div class="modal-footer" id="modal_foot">
      
      	<div id="button_for_insert">
  		<button id="new_rent_request" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">대여 신청</button>
      	</div>
      </div>
    </div>
  </div>
</div>


</body>
</html>