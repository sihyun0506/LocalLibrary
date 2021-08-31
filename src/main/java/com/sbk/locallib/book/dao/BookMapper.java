package com.sbk.locallib.book.dao;

import java.util.ArrayList;

import com.sbk.locallib.book.vo.BookVO;

public interface BookMapper {
	
	public int bookInsert(BookVO book);

	public ArrayList<BookVO> getMyBooks(String userId);
	
	public ArrayList<BookVO> bookSearchDB(String keyword);
	
	public ArrayList<BookVO> bookAdvSearchDB(BookVO book);

	public int changeBookState3(int book_id);

	public int changeBookState2(int book_id);
	
	public int changeBookState1(int book_id);
	
	public String getBookOwner(int book_id);

	public BookVO getBookInfo(int book_id);

}
