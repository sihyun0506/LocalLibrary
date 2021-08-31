package com.sbk.locallib.rent.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.rent.dao.RentDAO;
import com.sbk.locallib.rent.vo.RentVO;

@Service
public class RentService {

	@Autowired
	RentDAO dao;
	
	@Autowired
	private HttpSession session;
	
	public int reservation(RentVO rent) {
		return dao.reservation(rent);
	}

	public boolean newRentStartGive(RentVO rent) {
		//업데이트
		int updateResult = dao.updateOwnerRentCk(rent);
		if(updateResult>0)
			System.out.println("owner_rent_ck 업데이트성공");
		
		//조회
		boolean chk = false;
		RentVO newRent = dao.checkRent(rent.getRent_id());
		if(newRent.getOwner_rent_ck() == 1 && newRent.getRent_ck() == 1)
			chk = true;
		return chk;
	}

	public boolean newRentStartTake(RentVO rent) {
		//업데이트
		int updateResult = dao.updateRentCk(rent);
		if(updateResult>0)
			System.out.println("rent_ck 업데이트성공");
		
		//조회
		boolean chk = false;
		RentVO newRent = dao.checkRent(rent.getRent_id());
		if(newRent.getOwner_rent_ck() == 1 && newRent.getRent_ck() == 1)
			chk = true;
		return chk;
	}

	public boolean newRentEndTake(RentVO rent) {
		//업데이트
		int updateResult = dao.updateOwnerReturnCk(rent);
		if(updateResult>0)
			System.out.println("owner_return_ck 업데이트성공");
		
		//조회
		boolean chk = false;
		RentVO newRent = dao.checkRent(rent.getRent_id());
		if(newRent.getOwner_return_ck() == 1 && newRent.getReturn_ck() == 1)
			chk = true;
		return chk;
	}
	
	public boolean newRentEndGive(RentVO rent) {
		//업데이트
		int updateResult = dao.updateReturnCk(rent);
		if(updateResult>0)
			System.out.println("return_ck 업데이트성공");
		
		//조회
		boolean chk = false;
		RentVO newRent = dao.checkRent(rent.getRent_id());
		if(newRent.getOwner_return_ck() == 1 && newRent.getReturn_ck() == 1)
			chk = true;
		return chk;
	}

	public ArrayList<RentVO> getMyRentInfo() {
		String loginId = (String) session.getAttribute("loginId");
		return dao.getMyRentInfo(loginId);
	}
	
}
