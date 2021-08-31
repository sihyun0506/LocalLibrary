package com.sbk.locallib.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.member.dao.UpdateDAO;
import com.sbk.locallib.member.vo.MemberVO;

@Service
public class UpdateService {

	@Autowired
	private UpdateDAO dao;
	@Autowired
	private HttpSession session;
	
	//회원수정
	public String updateUser(MemberVO member) {
		String path = "";
		
		String loginid = (String) session.getAttribute("loginId");
		member.setUser_id(loginid);
		
		int cnt = dao.updateUser(member);
		
		if(cnt > 0) {
			System.out.println("수정성공");
			path = "redirect:/member/myInfo";
		}else {
			System.out.println("수정실패");
			path = "redirect:/member/updateinfo";
		}
		return path;
	}
}
