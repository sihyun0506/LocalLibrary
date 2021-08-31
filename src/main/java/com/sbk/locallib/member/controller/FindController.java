package com.sbk.locallib.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.member.service.FindService;
import com.sbk.locallib.member.vo.MemberVO;

@Controller
public class FindController {

	@Autowired
	private FindService service;
	
	
	//이름 & 이메일 확인
	@ResponseBody
	@RequestMapping(value = "userIdCheck", method = RequestMethod.POST)
	public MemberVO userIdCheck(MemberVO member) {
		return service.userCheck(member);
	}
	
	@ResponseBody
	@RequestMapping(value = "userPwCheck", method = RequestMethod.POST)
	public MemberVO userPwCheck(MemberVO member) {
		return service.userCheck(member);
	}
	
	//이름 & 이메일 & 아이디 확인
	@ResponseBody
	@RequestMapping(value = "pw_userPwCheck", method = RequestMethod.POST)
	public MemberVO pw_userPwCheck(MemberVO member) {
		return service.pw_userCheck(member);
	}
		
	
}
