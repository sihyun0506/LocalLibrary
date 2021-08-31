package com.sbk.locallib.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 사용자 로그인 확인 인터셉터. HandlerInterceptorAdapter를 상속받아서 정의.
 */
//HandlerInterceptorAdapter 가로채는 기능을 가지고 있는 클래스 -> @Override로 기능을 설정
public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	//콘트롤러의 메서드 실행 전에 처리 (bean이 없어서 @Autowired를 못받음)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("LoginInterceptor 실행");
		
		//세션의 로그인 정보 읽기 (스프링을 안쓸때는 이렇게 불러옴)
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		//로그인되지 않은 경우 로그인 페이지로 이동
		if (loginId == null) {
			//request.getContextPath()로 루트 경로를 구하여 절대 경로로 처리, sendRedirect는 절대경로로 사용
			response.sendRedirect(request.getContextPath() + "/member/loginForm");
			return false;
		}
		//로그인 된 경우 요청한 경로로 진행
		return super.preHandle(request, response, handler);
	}

}
