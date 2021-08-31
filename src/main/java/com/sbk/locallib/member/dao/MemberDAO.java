package com.sbk.locallib.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.member.vo.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession session ;
	
	
	public MemberVO searchMember(String user_id) {
		MemberVO member = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.searchMember(user_id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public int join(MemberVO member) {
		int cnt = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			cnt = mapper.join(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public int idCheck(String user_id) {
		int member = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.idCheck(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public int emailCheck(String email) {
		int member = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.emailCheck(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public int phoneCheck(String phone) {
		int member = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.phoneCheck(phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
}
