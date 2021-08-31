package com.sbk.locallib.book.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sbk.locallib.book.vo.BookVO;

@Repository
public class BookDAO {

	@Autowired
	private SqlSession session;

	public int bookInsert(BookVO book) {
		int cnt = 0;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			cnt = mapper.bookInsert(book);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public ArrayList<BookVO> getMyBooks(String userId) {
		ArrayList<BookVO> list = null;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			list = mapper.getMyBooks(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<BookVO> bookSearchDB(String keyword) {
		ArrayList<BookVO> list = null;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			list = mapper.bookSearchDB(keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<BookVO> bookAdvSearchDB(BookVO book) {
		ArrayList<BookVO> list = null;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			list = mapper.bookAdvSearchDB(book);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;

	}

	public int changeBookState3(int book_id) {
		int cnt = 0;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			cnt = mapper.changeBookState3(book_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public int changeBookState2(int book_id) {
		int cnt = 0;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			cnt = mapper.changeBookState2(book_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public int changeBookState1(int book_id) {
		int cnt = 0;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			cnt = mapper.changeBookState1(book_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public String getBookOwner(int book_id) {
		String owner_id = "";
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			owner_id = mapper.getBookOwner(book_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return owner_id;
	}

	public BookVO getBookInfo(int book_id) {
		BookVO book = null;
		try {
			BookMapper mapper = session.getMapper(BookMapper.class);
			book = mapper.getBookInfo(book_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return book;
	}

}
