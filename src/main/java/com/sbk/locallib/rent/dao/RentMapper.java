package com.sbk.locallib.rent.dao;

import java.util.ArrayList;

import com.sbk.locallib.rent.vo.RentVO;

public interface RentMapper {

	int reservation(RentVO rent);

	int updateOwnerRentCk(RentVO rent);
	
	int updateRentCk(RentVO rent);
	
	int updateOwnerReturnCk(RentVO rent);
	
	int updateReturnCk(RentVO rent);
	
	RentVO checkRent(int rent_id);

	ArrayList<RentVO> getMyRentInfo(String loginId);


}
