package com.sbk.locallib.book.vo;

import lombok.Data;

@Data
public class BookVO {

	private int book_id;
	private String book_name;	
	private String author;
	private String publisher;
	private String isbn;
	private int kdc;
	private String indate;
	private String owner_id;
	private int state_gb;
}
