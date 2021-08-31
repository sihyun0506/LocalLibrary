package com.sbk.locallib.message.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.message.dao.MessageDAO;
import com.sbk.locallib.message.vo.MessageVO;

@Service
public class MessageService {

	@Autowired
	private MessageDAO dao;

	@Autowired
	private HttpSession session;

	public boolean newRentRequest(MessageVO message) {
		boolean chk = false;
		String loginId = (String) session.getAttribute("loginId");
		message.setSender_id(loginId);
		message.setRent_id(0);
		int cnt = dao.newRentRequest(message);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

	public ArrayList<MessageVO> messageList() {
		String loginId = (String) session.getAttribute("loginId");
		return dao.messageList(loginId);
	}

	public MessageVO showMessageInfo(int message_id) {
		return dao.showMessageInfo(message_id);
	}

	public boolean rentRequestReject(int message_id) {
		boolean chk = false;
		int cnt = dao.rentRequestReject(message_id);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

	public boolean updateMessageReceiveDate(int message_id) {
		boolean chk = false;
		int cnt = dao.updateMessageReceiveDate(message_id);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

	public boolean newMessage(MessageVO message) {
		boolean chk = false;
		int cnt = dao.newMessage(message);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

}
