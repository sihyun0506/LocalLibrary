package com.sbk.locallib.message.vo;

import lombok.Data;

@Data
public class MessageVO {

	private int message_id;		//메시지 번호 pk
	private String sender_id;		//보낸이	참조키
	private String receiver_id;		//받는이	참조키
	private String context;		//내용	not null
	private int type;			//메시지 타입(일반 1 or 버튼 포함 2)	number(1)
	private String isbn;			//책 대여 요청일 시 isbn 포함하여 전송
	private String send_date;	//보낸날짜	date
	private String receive_date;	//받은날짜	date
	private int book_id;
	private int rent_id;
}
