package com.sbk.locallib.message.dao;

import java.util.ArrayList;

import com.sbk.locallib.message.vo.MessageVO;

public interface MessageMapper {

	int newRentRequest(MessageVO message);

	ArrayList<MessageVO> messageList(String loginId);

	MessageVO showMessageInfo(int message_id);

	int rentRequestReject(int message_id);

	int updateMessageReceiveDate(int message_id);	

}
