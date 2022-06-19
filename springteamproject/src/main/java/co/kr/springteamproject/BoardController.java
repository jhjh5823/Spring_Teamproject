package co.kr.springteamproject;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model; // request.setAttribute("key", value)
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.apache.ibatis.session.SqlSession; // MyBatis 사용
import model.board.BoardDto;

@RequestMapping("/board")
@Controller
public class BoardController {

	@Autowired
	   SqlSession sqlSession; // 자동 setter 작업
	
	//글쓰기 답글 쓰기 폼
	@RequestMapping("/writeForm.do")
	 public String writeForm(Model model, String num,String ref,String re_step,String re_level, String pageNum) {
	      if(num==null) {
	    	  //원글쓰기
	    	  num="0";
	    	  ref="1";
	    	  re_step="0";//글순서
	    	  re_level="0";
	      }
	      model.addAttribute("pageNum", pageNum);
	      model.addAttribute("num", new Integer(num));
	      model.addAttribute("ref", new Integer(ref));
	      model.addAttribute("re_step", new Integer(re_step));
	      model.addAttribute("re_level", new Integer(re_level));
	      
	      return ".main.board.writeForm"; //writeForm.jsp
	   }//writeForm()-end
	
	//DB글쓰기
	@RequestMapping(value = "writePro.do", method = RequestMethod.POST)
	   public String writepro(@ModelAttribute("boardDto") BoardDto boardDto,HttpServletRequest request) {
	      
		int maxNum=0; //최대 글번호 넣을 변수
		
		if(sqlSession.selectOne("board.numMax") != null) {
			//최대 글번호가 null이 아니면
			maxNum=sqlSession.selectOne("board.numMax");
		}
		
		if(maxNum != 0) { //이미 글이 있을 때
			maxNum=maxNum+1; //글 그룹으로 사용
		}else {
			maxNum=1; //처음 글일때, 글 그룹으로 사용
		}      
	      
	      boardDto.setIp(request.getRemoteAddr());
	      
	      if(boardDto.getNum() != 0) {//글 번호가 있으면, 답글이면
	    	  
	    	  //답글 끼워넣기 위치
	    	  sqlSession.update("board.reStep", boardDto);
	    	  boardDto.setRe_step(boardDto.getRe_step()+1); //글순서
	    	  boardDto.setRe_step(boardDto.getRe_level()+1); //답글 깊이
	      }else {//원글이면
	    	  boardDto.setRef(new Integer(maxNum)); //글 그룹
	    	  boardDto.setRe_step(0);
	    	  boardDto.setRe_level(0);
	      }    
	      
	      //글쓰기
	      sqlSession.insert("board.insertDao",boardDto);
	      
	      return "redirect:/board/list.do";
	   }//writePro()-end

	//리스트
	@RequestMapping("/list.do")
	   public String listBoard(@ModelAttribute("boardDto")BoardDto boardDto, 
			   Model model, @RequestParam(value="pageNum",required=false)String pageNum,
			   HttpServletRequest request) {
	      
		
	         
	      return ".main.board.list"; // 뷰 리턴 list.jsp
	}
	//조회수 증가
	//글내용보기
	@RequestMapping("content.do")
	public String content(Model model,String num, String pageNum) {
		int num1=Integer.parseInt(num);
		
		sqlSession.update("board.readCount",num1);
		
		BoardDto boardDto=sqlSession.selectOne("board.getBoard",num1);
		
		model.addAttribute("boardDto",boardDto);
		model.addAttribute("num",num1);
		model.addAttribute("pageNum",pageNum);
		
		return ".main.board.content";
	}
	
	//글수정 폼
	@RequestMapping("editForm.do")
	public String editForm(String num,String pageNum,Model model) {
		int num1=Integer.parseInt(num);
		BoardDto boardDto=sqlSession.selectOne("board.getBoard",num1);
		model.addAttribute("boardDto",boardDto);
		model.addAttribute("pageNum",pageNum);
		
		return ".main.board.editForm";
	}
	
	//DB글 수정
	@RequestMapping(value="editPro.do", method=RequestMethod.POST)
	public String editPro(BoardDto boardDto, String pageNum, Model model) {
		
		sqlSession.update("board.boardUpdate",boardDto);
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/board/list.do";
	}
	//DB글 삭제
	@RequestMapping(value="delete.do")
	public String deletePro(Model model,String num,String pageNum) {
		sqlSession.delete("board.boardDelete",new Integer(num));
		
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/board/list.do";
	}
}
