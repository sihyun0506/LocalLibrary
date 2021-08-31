package com.sbk.locallib.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sbk.locallib.member.service.UpdateService;
import com.sbk.locallib.member.vo.MemberVO;
@Controller
public class UpdateController {

	@Autowired
	private UpdateService service;
	//회원수정폼 이동
	@RequestMapping(value="/member/updateinfo" , method = RequestMethod.GET)
	public String updateinfo() {
		return "member/updateinfo";
	}
	//회원수정
	@RequestMapping(value="/member/update" , method = RequestMethod.POST)
	public String update(MemberVO member) {
		return service.updateUser(member);
	}
	
}
