package com.sbk.locallib.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.member.vo.MemberVO;

@Repository
public class UpdateDAO {

	@Autowired
	private SqlSession session;
	
	//회원수정
	public int updateUser(MemberVO member) {
		int cnt = 0;
		try {
			UpdateMapper mapper = session.getMapper(UpdateMapper.class);
			cnt = mapper.updateUser(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
}
