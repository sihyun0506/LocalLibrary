package com.sbk.locallib.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.member.dao.FindDAO;
import com.sbk.locallib.member.vo.MemberVO;

@Service
public class FindService {

	@Autowired
	private FindDAO dao;
	@Autowired
	private HttpSession session;
	
	//이름 & 이메일 확인
	public MemberVO userCheck(MemberVO member) {
		MemberVO user = null;
		user = dao.searchMember(member);
		
		if(user == null) {
			System.out.println("회원정보가 없음");
			
		}
		return user;
	}
	
	//이름 & 이메일 & 아이디 확인
	public MemberVO pw_userCheck(MemberVO member) {
		MemberVO user = null;
		user = dao.pw_searchMember(member);
		
		if(user == null) {
			System.out.println("회원정보가 없음");
			
		}
		return user;
	}
	

	
	
}
