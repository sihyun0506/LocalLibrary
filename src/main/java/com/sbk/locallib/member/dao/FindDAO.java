package com.sbk.locallib.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.member.vo.MemberVO;

@Repository
public class FindDAO {
	@Autowired
	private SqlSession session;
	
	//이름 & 이메일 확인
	public MemberVO searchMember(MemberVO member) {
		MemberVO user = null;
		
		try {
			FindMapper mapper = session.getMapper(FindMapper.class);
			user = mapper.searchMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	//이름 & 이메일 & 아이디 확인
	public MemberVO pw_searchMember(MemberVO member) {
		MemberVO user = null;
		
		try {
			FindMapper mapper = session.getMapper(FindMapper.class);
			user = mapper.pw_searchMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
}
