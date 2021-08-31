package com.sbk.locallib.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.member.service.MemberService;
import com.sbk.locallib.member.service.FindService;
import com.sbk.locallib.member.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberService service;
		
	@RequestMapping(value="/member/joinForm" , method = RequestMethod.GET)
	public String joinForm() {
		return "member/joinForm";
		
	}
		
	@RequestMapping(value="/member/loginForm" , method = RequestMethod.GET)
	public String loginForm() {
		return "member/loginForm";
	}
	
	//MyPage로 이동
	@RequestMapping(value="/member/myPage" , method = RequestMethod.GET)
	public String myPage() {
		return "member/myPage";
	}
	
//	//MyInfo로 이동
//	@RequestMapping(value="/member/myInfo" , method = RequestMethod.GET)
//	public String myInfo() {
//		return "member/myInfo";
//	}
	
	
	@RequestMapping(value="/member/findUserinfo" , method = RequestMethod.GET)
	public String findUserinfo() {
		return "member/findUserinfo";
	}
	
	
	
	
	@RequestMapping(value="/member/login" , method = RequestMethod.POST)
	public String login(MemberVO member) {
		return service.login(member);
				
	}
	
	@RequestMapping(value="/member/logout" , method = RequestMethod.GET)
	public String logout() {
		return service.logout();
				
	}
	
	@RequestMapping(value="/member/join", method = RequestMethod.POST)
	public String join(MemberVO member) {
		return service.join(member);
		
	}
	
	@RequestMapping(value = "/idDuplChk.do" , method = RequestMethod.POST)
	public @ResponseBody String idDuplChk(@ModelAttribute("vo") MemberVO vo , Model model) throws Exception{
	    //int result = service.idCheck(vo.getUser_id());
		int result = service.idCheck(vo.getUser_id());
	    return String.valueOf(result);
	}
	
	@RequestMapping(value = "/emDuplChk.do" , method = RequestMethod.POST)
	public @ResponseBody String emCheck(@ModelAttribute("vo") MemberVO vo , Model model) throws Exception{
	    int result = service.emCheck(vo.getEmail());
	    return String.valueOf(result);
	}
	
	@RequestMapping(value = "/pnDuplChk.do" , method = RequestMethod.POST)
	public @ResponseBody String pnCheck(@ModelAttribute("vo") MemberVO vo , Model model) throws Exception{
	    int result = service.phoneCheck(vo.getPhone());
	    return String.valueOf(result);
	}
}