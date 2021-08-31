package com.sbk.locallib.book.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbk.locallib.book.dao.BookDAO;
import com.sbk.locallib.book.vo.BookVO;

@Service
public class BookService {

	@Autowired
	private BookDAO dao;

	@Autowired
	private HttpSession session;

	public boolean bookInsert(BookVO book) {
		boolean chk = false;
		// kdc와 사용자 정보 반영 필요
//		book.setKdc(0);
//		session으로 부터 로그인한 사용자 정보 받아와 입력
		String loginId = (String) session.getAttribute("loginId");
		book.setOwner_id(loginId);
		int cnt = dao.bookInsert(book);

		if (cnt > 0) {
//			성공시 myInfo로
//			path = "redirect:/member/myInfo";
			chk = true;
		} else {
//			실패시 화면 그대로
//			path = "redirect:/book/bookAdd";
			chk = false;
		}
		return chk;
	}

	public ArrayList<BookVO> getMyBooks() {
//		session으로 부터 로그인한 사용자 정보 받아와 입력

		String loginId = (String) session.getAttribute("loginId");

		ArrayList<BookVO> list = dao.getMyBooks(loginId);
		return list;
	}

	public ArrayList<BookVO> bookSearchDB(String keyword) {
		return dao.bookSearchDB(keyword);
	}

	public ArrayList<BookVO> bookAdvSearchDB(BookVO book) {
		return dao.bookAdvSearchDB(book);
	}

	public boolean changeBookState3(int book_id) {
		boolean chk = false;
		int cnt = dao.changeBookState3(book_id);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}
	
	public boolean changeBookState2(int book_id) {
		boolean chk = false;
		int cnt = dao.changeBookState2(book_id);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}

	public boolean changeBookState1(int book_id) {
		boolean chk = false;
		int cnt = dao.changeBookState1(book_id);
		if (cnt > 0) {
			chk = true;
		} else {
			chk = false;
		}
		return chk;
	}
	
	public String getBookOwner(int book_id) {
		return dao.getBookOwner(book_id);
	}

	public BookVO getBookInfo(int book_id) {
		return dao.getBookInfo(book_id);
	}

}
