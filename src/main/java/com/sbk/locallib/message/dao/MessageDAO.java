package com.sbk.locallib.message.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.message.vo.MessageVO;

@Repository
public class MessageDAO {
	
	@Autowired
	private SqlSession session;

	public int newRentRequest(MessageVO message) {
		int cnt = 0;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			cnt = mapper.newRentRequest(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public ArrayList<MessageVO> messageList(String loginId) {
		ArrayList<MessageVO> list = null;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			list = mapper.messageList(loginId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public MessageVO showMessageInfo(int message_id) {
		MessageVO message = null;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			message = mapper.showMessageInfo(message_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return message;
	}

	public int rentRequestReject(int message_id) {
		int cnt = 0;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			cnt = mapper.rentRequestReject(message_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public int updateMessageReceiveDate(int message_id) {
		int cnt = 0;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			cnt = mapper.updateMessageReceiveDate(message_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	public int newMessage(MessageVO message) {
		int cnt = 0;
		try {
			MessageMapper mapper = session.getMapper(MessageMapper.class);
			cnt = mapper.newRentRequest(message);	// 새 메시지
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	
}
