<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메시지, 대여, 반납 테스트 페이지</title>
	<script src="/resources/js/jquery-3.6.0.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNCOe7tC1doHpGoWe/6oMVemdAVTMs2xqW4mwXrXsW0L84Iytr2wi5v2QjrP/xp" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-cn7l7gDp0eyniUwwAZgrzD06kc/tftFf19TOAs2zVinnD/C7E91j9yyk5//jjpt/" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />
	<script type="text/javascript">
	//요청 모두 비동기 방식으로 처리하여 반영
	var show_message_list = -1;
	
	var message_id_n = "";
	var sender_id_n = "";
	var receiver_id_n = "";
	var context_n = "";
	var type_n = "";
	var isbn_n = "";
	var send_date_n = "";
	var receive_date_n = "";
	var book_id_n = "";
	var rent_id_n = "";
	
	var book_img = "";
	var book_name = "";
	var book_author = "";
	var book_publisher = "";
	
	$(function(){		

		$("#bootstraps_papa").hide();
		
/* 		//메시지 창 숨기기
		$("#message_list").hide();
		
		//알림 클릭시 메시지 창 표시
		$("#new_notice").on("click",function(){
			show_message_list = show_message_list * -1;
			if(show_message_list==1){
				$("#message_list").show();
			}else{
				$("#message_list").hide();
			}
		}); */
	
		//요청이나 새 메시지가 있으면 카운트하여 알림에 표시
		//항상 실행되어야 함
		$("#new_notice").val("알림")
		//사용자id로 메시지 수신자 검색해서 메시지와 메시지 갯수 반환
		
		//2.대여요청 수락
		$("#new_rent_request_accept").on("click",function(){
			//수락시
			//메시지 수신(수신일자 업데이트)
			$.ajax({
				url : '/updateMessageReceiveDate',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					message_id : message_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(data);
					if(data==true)
						console.log("수신일 업데이트");
					else
						alert("오류 : 메시지 수신일 업데이트 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//도서 테이블 book state 3 으로(예약)
			$.ajax({
				url : '/changeBookState3',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					book_id : book_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(book_id_n);
					console.log('state:'+data);
					if(data==true)
						alert("수락되었습니다.");
					else
						alert("오류 : 수락 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});

			//대여 테이블에 추가하고 대여번호 반환
			$.ajax({
				url : '/reservation',
				type : 'post',
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify({
					user_id : sender_id_n,
					book_id : book_id_n
				}),
				dataType : "json",
				async : false,
				success : function(data){
					console.log("대여번호"+data);
					rent_id_n = data;
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//빌리는 쪽이 받는 메시지
			context_n = "예약완료!<br><br>"+receiver_id_n+"님으로 부터 직접 아래 책을 수령 후 확인 버튼을 눌러주세요.";
			$.ajax({
					url : '/newRentStartMessagetoTaker',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						sender_id : receiver_id_n,
						receiver_id : sender_id_n,
						context : context_n, 
						type : '3',
						isbn : isbn_n,
						book_id : book_id_n,
						rent_id : rent_id_n
					}),
					dataType : "json",
					async : false,
					success : function(data){
						//alert(rent_id_n);
						console.log(data);
						if(data == true){
							console.log("빌리는 쪽에게 메시지 전송"+data);
						}else{
							console.log("빌리는 쪽에게 메시지 전송"+data);
						}
					},
					error : function(e){
						console.log(e);	
					}		
				});
			
			//빌려주는 쪽이 받는 메시지
			context_n = "예약확정!<br><br>"+sender_id_n+"님께 직접 아래 책을 전달 후 확인 버튼을 눌러주세요.";
			$.ajax({
					url : '/newRentStartMessagetoGiver',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						sender_id : sender_id_n,
						receiver_id : receiver_id_n,
						context : context_n, 
						type : '3',
						isbn : isbn_n,
						book_id : book_id_n,
						rent_id : rent_id_n
					}),
					dataType : "json",
					async : false,
					success : function(data){
						//alert(rent_id_n);
						console.log(data);
						if(data == true){
							console.log("빌려주는 쪽에게 메시지 전송"+data);
						}else{
							console.log("빌려주는 쪽에게 메시지 전송"+data);
						}
					},
					error : function(e){
						console.log(e);	
					}		
				});
			
			//창 닫기
			$("#my_modal_close").trigger("click");
			location.reload();
		});	
		
		//2.대여요청 거부
		$("#new_rent_request_reject").on("click",function(){
			//거절시
			//메시지 삭제
			$.ajax({
				url : '/rentRequestReject',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					message_id : message_id_n
				},
				dataType : "json",
				success : function(data){
					console.log(data);
					if(data==true)
						alert("거절되었습니다.");
					else
						alert("오류 : 거절 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			//창 닫기
			$("#my_modal_close").trigger("click");
			location.reload();
		});	
	
		
		//2-c. 예약 취소
		$("#new_rent_cancel").on("click",function(){
			//메시지 수신(수신일자 업데이트)
			$.ajax({
				url : '/updateMessageReceiveDate',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					message_id : message_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(data);
					if(data==true)
						console.log("수신일 업데이트");
					else
						alert("오류 : 메시지 수신일 업데이트 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			//도서 상태 1로 변경
			$.ajax({
				url : '/changeBookState1',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					book_id : book_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(book_id_n);
					console.log('state:'+data);
					if(data==true)
						alert("대여 예약이 취소되었습니다.");
					else
						alert("오류 : 예약 취소 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			//창 닫기
			$("#my_modal_close").trigger("click");
			location.reload();	
			
		});
		
		
		//3.빌려준거 확인
		$("#new_rent_start").on("click",function(){
			
			//메시지 수신(수신일자 업데이트)
			$.ajax({
				url : '/updateMessageReceiveDate',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					message_id : message_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(data);
					if(data==true)
						console.log("수신일 업데이트");
					else
						alert("오류 : 메시지 수신일 업데이트 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//책 주인 확인
			var book_owner_check = false;			
			$.ajax({
				url : '/getBookOwner',
				type : 'get',
				contentType : 'application/json; charset=utf-8',
				data : {
					book_id : book_id_n
				},
				dataType : "text",
				async : false,
				success : function(data){
					alert(data);
					alert($("#login_id").val());
					if(data == $("#login_id").val())
						book_owner_check = true;
					else
						book_owner_check = false;
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//서비스에서 둘다 체크했는지 확인하고 둘다 체크했으면 true 반환
			var both_chk = false;
			if(book_owner_check){
				//책주인 일때 rent업데이트
				$.ajax({
					url : '/newRentStartGive',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						rent_id : rent_id_n,
						owner_rent_ck : '1'
					}),
					dataType : "json",
					async : false,
					success : function(data){
						both_chk = data;
					},
					error : function(e){
						console.log(e);	
					}
				});
			}else{
				//책주인 아닐때 rent 업데이트
				$.ajax({
					url : '/newRentStartTake',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						rent_id : rent_id_n,
						rent_ck : '1'
					}),
					dataType : "json",
					async : false,
					success : function(data){
						both_chk = data;
					},
					error : function(e){
						console.log(e);	
					}
				});
			}
			
			//둘다 체크 되면
			if(both_chk){
				//도서 상태 2로 변경
				$.ajax({
					url : '/changeBookState2',
					type : 'get',
					contentType : "application/json; charset=utf-8",
					data : {
						book_id : book_id_n
					},
					dataType : "json",
					async : false,
					success : function(data){
						console.log(book_id_n);
						console.log('state:'+data);
						if(data==true)
							alert("대여 완료!");
						else
							alert("오류 : 대여 실패")
					},
					error : function(e){
						console.log(e);	
					}
				});
				
				//서로에게 반납 예정 메시지 전송
				if(book_owner_check==false){
					//빌리는 쪽이 받는 메시지
					context_n = "수령완료!<br><br>"+sender_id_n+"님에게 아래 책을 반납 후 확인 버튼을 눌러주세요.";
					$.ajax({
						url : '/newRentEndMessagetoTaker',
						type : 'post',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							sender_id : sender_id_n,
							receiver_id : receiver_id_n,
							context : context_n, 
							type : '4',
							isbn : isbn_n,
							book_id : book_id_n,
							rent_id : rent_id_n
						}),
						dataType : "json",
						async : false,
						success : function(data){
							//alert(rent_id_n);
							console.log(data);
							if(data == true){
								console.log("빌린 쪽에게 메시지 전송"+data);
							}else{
								console.log("빌린 쪽에게 메시지 전송"+data);
							}
						},
						error : function(e){
							console.log(e);	
						}		
					});
					//빌려주는 쪽이 받는 메시지
					context_n = "전달완료!<br><br>"+receiver_id_n+"님으로부터 아래 책을 반납받고 확인 버튼을 눌러주세요.";
					$.ajax({
						url : '/newRentEndMessagetoGiver',
						type : 'post',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							sender_id : receiver_id_n,
							receiver_id : sender_id_n,
							context : context_n, 
							type : '4',
							isbn : isbn_n,
							book_id : book_id_n,
							rent_id : rent_id_n
						}),
						dataType : "json",
						async : false,
						success : function(data){
							//alert(rent_id_n);
							console.log(data);
							if(data == true){
								console.log("빌려준 쪽에게 메시지 전송"+data);
							}else{
								console.log("빌려준 쪽에게 메시지 전송"+data);
							}
						},
						error : function(e){
							console.log(e);	
						}		
					});
				}else{
					//빌리는 쪽이 받는 메시지
					context_n = "수령완료!<br><br>"+receiver_id_n+"님에게 아래 책을 반납 후 확인 버튼을 눌러주세요.";
					$.ajax({
						url : '/newRentEndMessagetoTaker',
						type : 'post',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							sender_id : receiver_id_n,
							receiver_id : sender_id_n,
							context : context_n, 
							type : '4',
							isbn : isbn_n,
							book_id : book_id_n,
							rent_id : rent_id_n
						}),
						dataType : "json",
						async : false,
						success : function(data){
							//alert(rent_id_n);
							console.log(data);
							if(data == true){
								console.log("빌린 쪽에게 메시지 전송"+data);
							}else{
								console.log("빌린 쪽에게 메시지 전송"+data);
							}
						},
						error : function(e){
							console.log(e);	
						}		
					});
					//빌려주는 쪽이 받는 메시지
					context_n = "전달완료!<br><br>"+sender_id_n+"님으로부터 아래 책을 반납받고 확인 버튼을 눌러주세요.";
					$.ajax({
						url : '/newRentEndMessagetoGiver',
						type : 'post',
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify({
							sender_id : sender_id_n,
							receiver_id : receiver_id_n,
							context : context_n, 
							type : '4',
							isbn : isbn_n,
							book_id : book_id_n,
							rent_id : rent_id_n
						}),
						dataType : "json",
						async : false,
						success : function(data){
							//alert(rent_id_n);
							console.log(data);
							if(data == true){
								console.log("빌려준 쪽에게 메시지 전송"+data);
							}else{
								console.log("빌려준 쪽에게 메시지 전송"+data);
							}
						},
						error : function(e){
							console.log(e);	
						}		
					});
				}
				
			}
			//창 닫기
			$("#my_modal_close").trigger("click");
			location.reload();				
		});

		
		
		//4.반납받은거 확인
		$("#new_rent_end").on("click",function(){
			//메시지 수신(수신일자 업데이트)
			$.ajax({
				url : '/updateMessageReceiveDate',
				type : 'get',
				contentType : "application/json; charset=utf-8",
				data : {
					message_id : message_id_n
				},
				dataType : "json",
				async : false,
				success : function(data){
					console.log(data);
					if(data==true)
						console.log("수신일 업데이트");
					else
						alert("오류 : 메시지 수신일 업데이트 실패")
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//책 주인 확인
			var book_owner_check = false;			
			$.ajax({
				url : '/getBookOwner',
				type : 'get',
				contentType : 'application/json; charset=utf-8',
				data : {
					book_id : book_id_n
				},
				dataType : "text",
				async : false,
				success : function(data){
					alert(data);
					alert($("#login_id").val());
					if(data == $("#login_id").val())
						book_owner_check = true;
					else
						book_owner_check = false;
				},
				error : function(e){
					console.log(e);	
				}
			});
			
			//서비스에서 둘다 체크했는지 확인하고 둘다 체크했으면 true 반환
			var both_chk = false;
			if(book_owner_check){
				//책주인 일때 return업데이트
				$.ajax({
					url : '/newRentEndTake',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						rent_id : rent_id_n,
						owner_return_ck : '1'
					}),
					dataType : "json",
					async : false,
					success : function(data){
						both_chk = data;
					},
					error : function(e){
						console.log(e);	
					}
				});
			}else{
				//책주인 아닐때 return 업데이트
				$.ajax({
					url : '/newRentEndGive',
					type : 'post',
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						rent_id : rent_id_n,
						return_ck : '1'
					}),
					dataType : "json",
					async : false,
					success : function(data){
						both_chk = data;
					},
					error : function(e){
						console.log(e);	
					}
				});
			}
			
			//둘다 체크 되면
			if(both_chk){
				//도서 상태 1로 변경
				$.ajax({
					url : '/changeBookState1',
					type : 'get',
					contentType : "application/json; charset=utf-8",
					data : {
						book_id : book_id_n
					},
					dataType : "json",
					async : false,
					success : function(data){
						console.log(book_id_n);
						console.log('state:'+data);
						if(data==true)
							alert("반납 완료!");
						else
							alert("오류 : 반납 실패")
					},
					error : function(e){
						console.log(e);	
					}
				});
			}
			//창 닫기
			$("#my_modal_close").trigger("click");
			location.reload();	
		});
		
	});
	
	function show_message_info(message_id){
		$.ajax({
			url : '/showMessageInfo',
			type : 'get',
			contentType : "application/json; charset=utf-8",
			data : {
				message_id : message_id
			},
			dataType : "json",
			async : false,
			success : function(data){
				console.log(data);
				message_id_n = data.message_id;
				sender_id_n = data.sender_id;
				receiver_id_n = data.receiver_id;
				context_n = data.context;
				type_n = data.type;
				isbn_n = data.isbn;
				send_date_n = data.send_date;
				receive_date_n = data.receive_date;
				book_id_n = data.book_id;
				rent_id_n = data.rent_id;
			},
			error : function(e){
				console.log(e);	
			}
		});
		
		$.ajax({
			url : '/naverBookSearch',
			type : 'get',
			contentType : "application/json; charset=utf-8",
			data : {
				keyword : isbn_n
			},
			dataType : "json",
			async : false,
			success : function(data){
				console.log(data);
				book_img = data.items[0].image;
				book_name = data.items[0].title;
				book_author = data.items[0].author;
				book_publisher = data.items[0].publisher;
			},
			error : function(e){
				console.log(e);	
			}
		});
		
		context = '<table>';
		context += '<tr><td colspan="2">'+context_n+'</td></tr>';
		context += '<tr><td rowspan="4"><img src='+book_img+'></td>';
		context += '<td>'+book_name+'</td></tr>';
		context += '<tr><td>'+book_author+'</td></tr>';	
		context += '<tr><td>'+isbn_n+'</td></tr>';
		context += '<tr><td>'+book_publisher+'</td></tr></table>';
		if(type_n==1){
			$("#type_1").show();
			$("#type_2").hide();
			$("#type_3").hide();
			$("#type_4").hide();
		}else if(type_n==2){
			$("#type_1").hide();
			$("#type_2").show();
			$("#type_3").hide();
			$("#type_4").hide();
		}else if(type_n==3){
			$("#type_1").hide();
			$("#type_2").hide();
			$("#type_3").show();
			$("#type_4").hide();			
		}else if(type_n==4){
			$("#type_1").hide();
			$("#type_2").hide();
			$("#type_3").hide();
			$("#type_4").show();
		}
		$("#message_info").html(context);
		$("#bootstraps_papa").get(0).click();
	}
	</script>
</head>
<body>
<!-- 여기에 들어오면 항상 처리할 것에 대한 알림을 띄움 -->
<div>
	<h3>여기에 새 대여 반납 정보에 대한 알림수 표시, 클릭 시 알림 확인 가능(나중에)</h3>
	<input type="button" id="new_notice">
</div>
<div id="message_list">
	<h1>여기는 메시지 창</h1>
	여기서 받은 메시지를 확인
	<table>
	<c:forEach var="ml" items="${message_list}">		
 		<tr onClick="show_message_info(${ml.message_id})">
			<td> ${ml.sender_id} </td> 
			<td> ${ml.send_date} </td> 
		</tr>
		<tr onClick="show_message_info(${ml.message_id})">	
			<td colspan="2"> ${ml.context}</td>
		</tr>
	</c:forEach>
	</table>	
</div>



<!-- <h3>빌려주는 사람이 할 일</h3>
<div>
	<h4>2.대여요청 수락하고 메시지 보내기(수락시 bookstate 3)</h4>
	<input type="button" id="new_rent_requset_accept" value="수락">
	<input type="button" id="new_rent_requset_reject" value="거절">
</div>
<div>
	<h4>3-g.빌려준거 확인하기(양쪽다 대여 확인시 bookstate 2)</h4>
	<input type="button" id="new_rent_start_give" value="확인">
</div>
<div>
	<h4>4-t.반납받은거 확인하기(양쪽다 반납 확인시 bookstate 1)</h4>
	<input type="button" id="new_rent_end_take" value="확인">
</div>
<div>
	<h4>2-c1.예약 취소(입력과 동시에 bookstate 1)</h4>
	<input type="button" id="new_rent_cancel1" value="확인">
</div>

<h3>빌리는 사람이 할 일</h3>
<div>
	<h4>1.대여요청 보내기</h4>
	<input type="button" id="new_rent_request" value="대여 신청">	
</div>
<div>
	<h4>3-t.빌린거 확인하기(양쪽다 대여 확인시 bookstate 2)</h4>
	<input type="button" id="new_rent_start_take" value="확인">
</div>
<div>
	<h4>4-g.반납한거 확인하기(양쪽다 반납 확인시 bookstate 1)</h4>
	<input type="button" id="new_rent_end_give" value="확인">
</div>
<div>
	<h4>2-c2.예약 취소(입력과 동시에 bookstate 1)</h4>
	<input type="button" id="new_rent_cancel2" value="확인">
</div> -->

	<input type="hidden" id="login_id" value='${sessionScope.loginId}'/>


<!-- Modal1 -->
<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="my_modal_close"></button>
      </div>
      
      <div class="modal-body">
		<div id="message_info"></div>        
      </div>
      
      <div class="modal-footer">
      
      	<div id="button_for_insert">
      		<div id="type_2">
				<button id="new_rent_request_accept" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">수락</button>
  				<button id="new_rent_request_reject" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">거절</button>
      		</div>
      		<div id="type_3">
  				<button id="new_rent_start" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">대여 확인</button>
  				<button id="new_rent_cancel" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">예약 취소</button>
      		</div>
      		<div id="type_4">
  				<button id="new_rent_end" type="button" class ="btn btn-warning btn-sm font-color-white mx-auto">반납 확인</button>
      		</div>
      		<div id="type_1">
      		</div>
      	</div>
      </div>
    </div>
  </div>
</div>

	<a id="bootstraps_papa" data-bs-toggle="modal" href="#exampleModalToggle" role="button"></a>

</body>
</html>