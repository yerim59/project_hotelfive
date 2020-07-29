package com.koreait.hotelfive.command.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.hotelfive.command.Command;
import com.koreait.hotelfive.common.ReservationListPageMaker;
import com.koreait.hotelfive.dao.HotelFiveDAO;
import com.koreait.hotelfive.dto.ReservationViewDTO;

public class AdminReservationListCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map1 = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map1.get("request");
		
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		// page 를 알아야 가져올 list 의 begin 과 end 를 알 수 있다.(ex. 1 ~ 10, 11 ~ 20)
		int recordPerPage = 10; // 한페이지의 게시물 갯수
		int beginRecord = (page -1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		
		// beginRecord + endRecord = Map
		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("beginRecord", beginRecord/2);
		map2.put("endRecord", endRecord/2);
		
		HotelFiveDAO hDAO = sqlSession.getMapper(HotelFiveDAO.class);
		ArrayList<ReservationViewDTO> memeberreservationList = hDAO.reservationList(map2);
		ArrayList<ReservationViewDTO> nonMemberReservationList = hDAO.nonMemberReservationList(map2);
		ArrayList<ReservationViewDTO> reservationList = new ArrayList<>();
		reservationList.addAll(memeberreservationList);
		reservationList.addAll(nonMemberReservationList);
	
		
		// 전체 게시글 갯수 구하기
		int totalReservation = hDAO.getTotalReservationCount();
		
		// 페이지 ( << 1 2 3 >> )
		String pageView = ReservationListPageMaker.getPageView("adminReservationList", 
												page, 
												recordPerPage, 
												totalReservation);
		System.out.println(reservationList.toString());
		
		model.addAttribute("page", page); 
		model.addAttribute("reservationList", reservationList); // 예약리스트
		model.addAttribute("pageView", pageView);
		model.addAttribute("totalReservation", totalReservation); // 예약갯수
	
	
	}

}
