package com.sbk.locallib.rent.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.rent.service.RentService;
import com.sbk.locallib.rent.vo.RentVO;

@Controller
public class RentController {

	@Autowired
	RentService service;

	// 예약(대여테이블에 추가 후 성공 시 대여번호 반환)
	@ResponseBody
	@RequestMapping(value = "/reservation", method = RequestMethod.POST)
	public int reservation(@RequestBody RentVO rent) {
		return service.reservation(rent);
	}

	// 책주인 일때 rent 업데이트 후 대여 완료인지 체크하여 true 반환
	@ResponseBody
	@RequestMapping(value = "/newRentStartGive", method = RequestMethod.POST)
	public boolean newRentStartGive(@RequestBody RentVO rent) {
		return service.newRentStartGive(rent);
	}

	// 책주인 아닐때 rent 업데이트
	@ResponseBody
	@RequestMapping(value = "/newRentStartTake", method = RequestMethod.POST)
	public boolean newRentStartTake(@RequestBody RentVO rent) {
		return service.newRentStartTake(rent);
	}

	// 책주인 일때 return 업데이트
	@ResponseBody
	@RequestMapping(value = "/newRentEndTake", method = RequestMethod.POST)
	public boolean newRentEndTake(@RequestBody RentVO rent) {
		return service.newRentEndTake(rent);
	}

	// 책주인 아닐때 return 업데이트
	@ResponseBody
	@RequestMapping(value = "/newRentEndGive", method = RequestMethod.POST)
	public boolean newRentEndGive(@RequestBody RentVO rent) {
		return service.newRentEndGive(rent);
	}
	
	// 내가 대여중인 도서 출력
	@ResponseBody
	@RequestMapping(value = "/getMyRentInfo", method = RequestMethod.GET)
	public ArrayList<RentVO> getMyRentInfo(){
		return service.getMyRentInfo();
	}
	
	
}
