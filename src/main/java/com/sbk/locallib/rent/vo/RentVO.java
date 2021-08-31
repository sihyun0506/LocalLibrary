package com.sbk.locallib.rent.vo;

import lombok.Data;

@Data
public class RentVO {
	
	private int rent_id;
	private String user_id;
	private int book_id;
	private String rent_date;
	
	private String return_date;
	private int extend_gb;
	private String extend_date;
	
	private int owner_rent_ck;
	private String owner_rent_ck_date;
	
	private int rent_ck;
	private String rent_ck_date;
	
	private int owner_return_ck;
	private String owner_return_ck_date;
	
	private int return_ck;
	private String return_ck_date;
	

}
