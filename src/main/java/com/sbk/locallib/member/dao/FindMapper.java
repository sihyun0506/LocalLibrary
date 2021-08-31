package com.sbk.locallib.member.dao;

import com.sbk.locallib.member.vo.MemberVO;

public interface FindMapper {

	//이름 & 이메일 확인
	public MemberVO searchMember(MemberVO member);
	
	//이름 & 이메일 & 아이디 확인
	public MemberVO pw_searchMember(MemberVO member);
	
}
