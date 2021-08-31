package com.sbk.locallib.member.dao;

import com.sbk.locallib.member.vo.MemberVO;

public interface MemberMapper {

	public int join(MemberVO member);
	
	//public MemberVO idCheck(String user_id);
	//회원조회
	public MemberVO searchMember(String user_id);
	
	public int idCheck(String user_id);
	
	public int emailCheck(String email);
	
	public int phoneCheck(String phone);
	
}
