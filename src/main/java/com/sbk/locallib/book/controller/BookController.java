package com.sbk.locallib.book.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbk.locallib.book.service.BookService;
import com.sbk.locallib.book.vo.BookVO;

@Controller
public class BookController {

	@Autowired
	private BookService service;

//	//bookAdd로 이동
//	@RequestMapping(value="/book/bookAdd" , method = RequestMethod.GET)
//	public String myInfo() {
//		return "book/bookAdd";
//	}

	// insert my book
	@ResponseBody
	@RequestMapping(value = "/bookInsert", method = RequestMethod.GET)
	public boolean bookInsert(BookVO book) {
		return service.bookInsert(book);
	}

	// get my books form db
	@ResponseBody
	@RequestMapping(value = "/getMyBooks", method = RequestMethod.GET)
	public ArrayList<BookVO> getMyBooks() {
		return service.getMyBooks();
	}

	// DB책검색
	@RequestMapping(value = "/book/bookListDb", method = RequestMethod.GET)
	public String bookSearchDB(String keyword, Model model) {
		ArrayList<BookVO> list = service.bookSearchDB(keyword);
		model.addAttribute("list", list);
		return "book/bookListDb";
	}

	// DB책상세검색
	@RequestMapping(value = "/book/bookListDbAdv", method = RequestMethod.GET)
	public String bookAdvSearchDB(BookVO book, Model model) {
		ArrayList<BookVO> list = service.bookAdvSearchDB(book);
		model.addAttribute("list", list);
		return "book/bookListDb";
	}

	// state3으로 변경(예약)
	@ResponseBody
	@RequestMapping(value = "/changeBookState3", method = RequestMethod.GET)
	public boolean changeBookState3(int book_id) {
		return service.changeBookState3(book_id);
	}

	// state2으로 변경(대여)
	@ResponseBody
	@RequestMapping(value = "/changeBookState2", method = RequestMethod.GET)
	public boolean changeBookState2(int book_id) {
		return service.changeBookState2(book_id);
	}

	// state1으로 변경(예약취소, 반납)
	@ResponseBody
	@RequestMapping(value = "/changeBookState1", method = RequestMethod.GET)
	public boolean changeBookState1(int book_id) {
		return service.changeBookState1(book_id);
	}
	
	// book_id로 책주인 검색
	@ResponseBody
	@RequestMapping(value = "/getBookOwner", method = RequestMethod.GET)
	public String getBookOwner(int book_id) {
		return service.getBookOwner(book_id);
	}
	
	// book_id로 책정보 전체 검색
	@ResponseBody
	@RequestMapping(value = "/getBookInfo", method = RequestMethod.GET)
	public BookVO getBookInfo(int book_id) {
		return service.getBookInfo(book_id);
	}

	// ------------------------------------네이버 책
	// api---------------------------------------//

	// 리턴할 때 한글로 인코딩 해서 보여주는 거: produces =
	@ResponseBody
	@RequestMapping(value = "/naverBookSearch", method = RequestMethod.GET, produces = "application/text;charset=UTF-8")
	public String naverBookSearch(String keyword, BookVO book) {
		String clientId = "lLhpxGB8vpFt8ZUpZsDO"; // 애플리케이션 클라이언트 아이디값"
		String clientSecret = "1paRu2jdsA"; // 애플리케이션 클라이언트 시크릿값"

		System.out.println(keyword + book);

		String text = "";
		String book_name = "", author = "", isbn = "", publisher = "";
		if (book == null) {
			book = new BookVO();
		}

		try {
			if (keyword != null)
				text = URLEncoder.encode(keyword, "UTF-8");
			if (book.getBook_name() != null)
				book_name = URLEncoder.encode(book.getBook_name(), "UTF-8");
			if (book.getAuthor() != null)
				author = URLEncoder.encode(book.getAuthor(), "UTF-8");
			if (book.getIsbn() != null)
				isbn = URLEncoder.encode(book.getIsbn(), "UTF-8");
			if (book.getPublisher() != null)
				publisher = URLEncoder.encode(book.getPublisher(), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("검색어 인코딩 실패", e);
		}

		String apiURL = null;

		if (keyword != null) {
			apiURL = "https://openapi.naver.com/v1/search/book?query=" + text; // json 결과
		} else {
			apiURL = "https://openapi.naver.com/v1/search/book_adv?" + "d_titl=" + book_name + "&d_auth=" + author
					+ "&d_isbn=" + isbn + "&d_publ=" + publisher; // json 결과
		}
		// https://book.naver.com/search/search.nhn?publishStartDay=&publishEndDay=&categoryId=&serviceSm=advbook.basic&ic=service.summary&title=&author=%EC%A0%95%EC%8A%B9%ED%98%84&publisher=&isbn=&toc=&subject=&cate1Depth=&cate2Depth=&cate3Depth=&cate4Depth=&publishStartYear=&publishStartMonth=&publishEndYear=&publishEndMonth=&x=26&y=15

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders);

		System.out.println(responseBody);

		return responseBody;
	}

	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}

	// ------------------------------------네이버 책 api
	// 끝-----------------------------------//

}
