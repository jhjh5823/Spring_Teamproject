package co.kr.springteamproject;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.ModelAttribute;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import java.util.*;
import model.board.AskBoardDto;
import model.board.FaqDto;

@RequestMapping("/askBoard")
@Controller
public class AskBoardController {

	@Autowired
	SqlSession sqlSession;
	
	// ----------------------------------------------------------
	// 글쓰기, 답글쓰기
		@RequestMapping("/writeAskForm.do")
		public String writeAskForm(Model model, String ask_num, String ask_ref, String ask_restep, String ask_relevel, String pageNum, HttpServletRequest request) {
			if(ask_num == null) {
				// 원글
				ask_num = "0";
				ask_ref = "1"; // 글그룹
				ask_restep = "0"; // 글순서
				ask_relevel = "0"; // 들여쓰기
			} else { 
				// 답글이면
				ask_num = request.getParameter("ask_num");
				ask_ref = request.getParameter("ask_ref");
				ask_restep = request.getParameter("ask_restep");
				ask_relevel = request.getParameter("ask_relevel");
			}
	
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("ask_num", new Integer(ask_num));
			model.addAttribute("ask_ref", new Integer(ask_ref));
			model.addAttribute("ask_restep", new Integer(ask_restep));
			model.addAttribute("ask_relevel", new Integer(ask_relevel));
			
			return ".main.askBoard.writeAskForm"; // writeAskForm.jsp
		}//writeAskForm
		
	// ----------------------------------------------------------
	// DB 글쓰기
	@RequestMapping(value = "/writeAskPro.do", method = RequestMethod.POST)
	public String writeAskPro(@ModelAttribute("askBoardDto") AskBoardDto askBoardDto, HttpServletRequest request) {
		int maxNum = 0; // 최대 글번호 넣을 변수

		if(sqlSession.selectOne("askBoard.numMax") != null) {
			// 최대 글번호가 null이 아니면
			maxNum = sqlSession.selectOne("askBoard.numMax"); // 최대 글번호 얻기
		}
			
		if(maxNum != 0){ // 이미 글이 있을 때
			maxNum = maxNum+1; // 글그룹으로 사용
		} else {
			maxNum = 1; // 첫 글일 때 글그룹으로 사용
		}
			
		if(askBoardDto.getAsk_num() != 0) { // 글번호가 있으면(답글이면)
			// 답글 끼워넣기 위치 확보
			sqlSession.update("askBoard.askReStep", askBoardDto);
			askBoardDto.setAsk_restep(askBoardDto.getAsk_restep()+1); //글순서
			askBoardDto.setAsk_relevel(askBoardDto.getAsk_relevel()+1); //답글 깊이
				
		} else { // 원글이면
			askBoardDto.setAsk_ref(new Integer(maxNum)); // 글그룹
			askBoardDto.setAsk_restep(0);
			askBoardDto.setAsk_relevel(0);
		}
			
		// 글쓰기
		sqlSession.insert("askBoard.insertAskDao", askBoardDto);
			
		return "redirect:/askBoard/askList.do";
	}//writeAskPro()-end
		
	// ----------------------------------------------------------
	// 리스트
	@RequestMapping("/askList.do")
	public String askListBoard(@ModelAttribute("askBoardDto") AskBoardDto askBoardDto, Model model,
			@RequestParam(value = "pageNum", required = false)String pageNum, HttpServletRequest request) {
			
		if(pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1) * pageSize + 1; // 한 페이지의 첫번째 row 구하기
		int endRow = currentPage & pageSize; // 한 페이지의 마지막 row 구하기
			
		int count = 0; // 총글개수 넣을 변수
		int pageBlock = 20; // 블럭당 페이지수
			
		count = sqlSession.selectOne("askBoard.selectAskCount"); // 총글개수 얻기
		int number = count - (currentPage-1) * pageSize; // 글번호 역순으로 출력
			
		int pageCount = count / pageSize + (count%pageSize==0?0:1); // 총페이지수
		int startPage = (currentPage/10) * 10 + 1;
		int endPage = startPage + pageBlock - 1;
		//				      1 + 10        - 1 = 10  --> end 페이지

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", startRow - 1); // 시작 위치, mysql은 0부터 시작
		map.put("cnt", pageSize); // 개수
		
		List<AskBoardDto> list=null;
		
		list = sqlSession.selectList("askBoard.listAskDao",map);
			
		// JSP에서 사용할 데이터
		model.addAttribute("currentPage", currentPage); // 현재 페이지
		model.addAttribute("startRow", startRow);
		model.addAttribute("endRow", endRow); 
			
		model.addAttribute("pageBlock", pageBlock); 
		model.addAttribute("pageCount", pageCount); 
			
		model.addAttribute("startPage", startPage); // 시작 페이지
		model.addAttribute("endPage", endPage);
			
		model.addAttribute("count", count);
		model.addAttribute("pageSize", pageSize);
			
		model.addAttribute("number", number); // 글번호 (역순으로)
		model.addAttribute("list", list);

		return ".main.askBoard.askList";
	}//askListBoard()-end
	
	// ----------------------------------------------------------
	// 글내용 보기
	@RequestMapping("/askContent.do")
	public String askContent(Model model, String ask_num, String pageNum) {
		//int num1 = Integer.parseInt(ask_num); // 문자열이니까 숫자로 바꿔 줌
		int num1 = 0;
		try {
			String num = ask_num;
			num1 = Integer.parseInt(num);
		} catch(NumberFormatException e) {
			num1 = 100;
		}
		AskBoardDto askBoardDto = sqlSession.selectOne("askBoard.getAskBoard", num1);
			
		model.addAttribute("askBoardDto", askBoardDto);// JSP에서 사용할 데이터
		model.addAttribute("ask_num", num1);
		model.addAttribute("pageNum", pageNum);
			
		return ".main.askBoard.askContent"; // askContent.jsp 뷰 리턴
	}//askContent()-end
	
	// ----------------------------------------------------------
	// DB 글삭제
	@RequestMapping("/askDelete.do")
	public String deleteAskPro(Model model, String ask_num, String pageNum) {
		int num1 = 0;
		try {
			String num = ask_num;
			num1 = Integer.parseInt(num);
		} catch(NumberFormatException e) {
			num1 = 1;
		}
		sqlSession.delete("askBoard.askBoardDelete", new Integer(num1));
		
		model.addAttribute("pageNum", pageNum);
		return "redirect:/askBoard/askList.do";
	}//deleteAskPro()-end
	
}
