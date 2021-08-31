package com.sbk.locallib.member.dao;

import com.sbk.locallib.member.vo.MemberVO;

public interface UpdateMapper {

	//회원수정
	public int updateUser(MemberVO member);
}
