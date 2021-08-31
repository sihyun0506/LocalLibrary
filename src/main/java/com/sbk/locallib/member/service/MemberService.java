package com.sbk.locallib.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.member.dao.MemberDAO;
import com.sbk.locallib.member.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired	
	private MemberDAO dao;
	@Autowired
	private HttpSession session;
	
	public String login(MemberVO inputData) {
	
	
	
		String path = "";
		//사용자가 입력한 ID값으로 회원정보를 조회
		MemberVO searchData = dao.searchMember(inputData.getUser_id());
		//searchData는 2가지의 모습을 가질수 있다.
		
		//ID가 없을때
		if(searchData == null) {
			System.out.println("ID가 없는 상황");
			path = "redirect:/member/loginForm";
		} 
		//ID가 있을때
		else {
			//사용자가 입력한 비밀번호와 조회한 데이터의 비밀번호가 같은지?
			
			if(inputData.getPw().equals(searchData.getPw())) {
				//로그인 처리를 해주어야 하는 상황
				//세션스코프에 로그인 정보를 저장한다.
				//session.setAttribute("loginId", searchData.getUser_id());
				//session.setAttribute("loginNm", searchData.getName());
				//session.setAttribute("loginId", searchData.getUser_id());
				session.setAttribute("loginId", searchData.getUser_id());
				session.setAttribute("loginNm", searchData.getName());
				session.setAttribute("loginPw", searchData.getPw());
				session.setAttribute("loginPhone", searchData.getPhone());
				session.setAttribute("loginEmail", searchData.getEmail());
				session.setAttribute("postCode", searchData.getPostcode());//영근님 수정
				session.setAttribute("loginAddr1", searchData.getAddr1());
				session.setAttribute("loginAddr2", searchData.getAddr2());
				session.setAttribute("loginBirthday", searchData.getBirthday());
				session.setAttribute("loginGender", searchData.getGender());
				session.setAttribute("loginNickname", searchData.getNickname());
				System.out.println(searchData.getUser_id());
				System.out.println(searchData.getName());
				path = "redirect:/";
				System.out.println("로그인 완료");
				System.out.println(session);
				System.out.println(session.getAttribute(path));
			} else {
				//비밀번호가 틀린상황
				System.out.println("PW가 틀린 상황");
				path = "redirect:/member/loginForm";
				}
			}
			return path;
		}
	
	
		public String logout() {
		//세션스코프에 저장되어있는 로그인정보를 삭제한다.
				session.removeAttribute("loginId");
				session.removeAttribute("loginNm");
				session.removeAttribute("loginPw");
				session.removeAttribute("loginPhone");
				session.removeAttribute("loginEmail");
				session.removeAttribute("postCode");
				session.removeAttribute("loginAddr1");
				session.removeAttribute("loginAddr2");
				session.removeAttribute("loginBirthday");
				session.removeAttribute("loginGender");
				session.removeAttribute("loginNickname");
				return "redirect:/";
			}
	
	
	
	
	
			public String join(MemberVO member) {
				String path = "";
				int result = 0;
				
				result = dao.join(member);
				
				if(result > 0 ) {
					path = "redirect:/";
				}else {
					path = "redirect:/";
				}
				
				return path;
			}
			
			int cnt = 0;
			
			public int idCheck(String user_id) {
				return cnt = dao.idCheck(user_id);
			
			}
			
			public int emCheck(String email) {
				return cnt = dao.emailCheck(email);
			}
	
	public int phoneCheck(String phone) {
		return cnt = dao.phoneCheck(phone);
	}
	
}
