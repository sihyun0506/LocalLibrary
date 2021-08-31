/**
 * 
 */
 
 	var show = -1;
	
	$(function(){
		//상세검색창 숨기기
		$("#searchAdvBookDBForm").hide();
		
		//직접 등록 리프레쉬
		$("#refresh").on("click",function(){
			$("#book_name_d").val("");
			$("#author_d").val("");
			$("#publisher_d").val("");
			$("#isbn_d").val("");
		});
		
		// 도서 직접 제출 시 유효성 검사 & isbn 체크
		$("#submit_form").on("click",function(){			
			var book_name = $("#book_name_d").val();
			var author = $("#author_d").val();
			var publisher = $("#publisher_d").val();
			var isbn = $("#isbn_d").val();
			location.href='/book/bookListDbAdv?book_name='+book_name
					+'&author='+author+'&publisher='+publisher+'&isbn='+isbn;
		});
		
		$("#btn_adv_search").on("click",function(){
			$("#searchAdvBookDBForm").show();
		});
		
		//알림 클릭시 메시지 창 표시
		$("#btn_adv_search").on("click",function(){
			show = show * -1;
			if(show==1){
				$("#searchAdvBookDBForm").show();
			}else{
				$("#searchAdvBookDBForm").hide();
			}
		});

	});
	
    function searchBookDB(){
    	var keyword = document.getElementById("keyword").value;
    	location.href='/book/bookListDb?keyword=' + keyword;
    }
	