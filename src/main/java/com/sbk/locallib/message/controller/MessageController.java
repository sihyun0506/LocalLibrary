package com.sbk.locallib.message.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.book.controller.BookController;
import com.sbk.locallib.message.service.MessageService;
import com.sbk.locallib.message.vo.MessageVO;

@Controller
public class MessageController {

	@Autowired
	MessageService service;

	@Autowired
	BookController bc;

	// message로 이동(test용)
	@RequestMapping(value = "/member/myInfo", method = RequestMethod.GET)
	public String message(Model model) {
		ArrayList<MessageVO> list = service.messageList();
		model.addAttribute("message_list", list);
		return "member/myInfo";
	}

	// 대여요청 전송
	@ResponseBody
	@RequestMapping(value = "/newRentRequest", method = RequestMethod.POST)
	public boolean newRentRequest(@RequestBody MessageVO message) {
		System.out.println(message);
		return service.newRentRequest(message);
	}

	// 메시지 하나 상세 정보
	@ResponseBody
	@RequestMapping(value = "/showMessageInfo", method = RequestMethod.GET)
	public MessageVO showMessageInfo(int message_id) {
		return service.showMessageInfo(message_id);
	}

	// 대여요청 수락
	// 대여확인 요청(빌리는 사람)
	@ResponseBody
	@RequestMapping(value = "/newRentStartMessagetoTaker", method = RequestMethod.POST)
	public boolean newRentStartMessagetoTaker(@RequestBody MessageVO message) {
		System.out.println(message);
		return service.newMessage(message);
	}
	
	// 대여확인 요청(빌려주는 사람)
	@ResponseBody
	@RequestMapping(value = "/newRentStartMessagetoGiver", method = RequestMethod.POST)
	public boolean newRentStartMessagetoGiver(@RequestBody MessageVO message) {
		System.out.println(message);
		return service.newMessage(message);
	}

	// 대여요청 거부
	@ResponseBody
	@RequestMapping(value = "/rentRequestReject", method = RequestMethod.GET)
	public boolean rentRequestReject(int message_id) {
		return service.rentRequestReject(message_id);
	}

	// 수신일자 업데이트
	@ResponseBody
	@RequestMapping(value = "/updateMessageReceiveDate", method = RequestMethod.GET)
	public boolean updateMessageReceiveDate(int message_id) {
		return service.updateMessageReceiveDate(message_id);
	}
	
	// 빌림, 빌려줌 확인
	// 반납확인 요청(빌린 사람)
	@ResponseBody
	@RequestMapping(value = "/newRentEndMessagetoTaker", method = RequestMethod.POST)
	public boolean newRentEndMessagetoTaker(@RequestBody MessageVO message) {
		System.out.println(message);
		return service.newMessage(message);
	}
	
	// 반납확인 요청(빌려준 사람)
	@ResponseBody
	@RequestMapping(value = "/newRentEndMessagetoGiver", method = RequestMethod.POST)
	public boolean newRentEndMessagetoGiver(@RequestBody MessageVO message) {
		System.out.println(message);
		return service.newMessage(message);
	}

}
