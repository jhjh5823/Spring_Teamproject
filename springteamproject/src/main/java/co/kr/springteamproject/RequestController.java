package co.kr.springteamproject;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model; // request.setAttribute("key", value)
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.apache.ibatis.session.SqlSession; // MyBatis 사용
import model.board.RequestDto;
import model.board.BoardDto;

@RequestMapping("/request")
@Controller
public class RequestController {

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
	      
	      return ".main.request.writeForm"; //writeForm.jsp
	   }//writeForm()-end
	
	//DB글쓰기
	@RequestMapping(value = "writePro.do", method = RequestMethod.POST)
	   public String writepro(@ModelAttribute("requestDto") RequestDto requestDto,HttpServletRequest request) {
	      
		int maxNum=0; //최대 글번호 넣을 변수
		
		if(sqlSession.selectOne("request.numMax") != null) {
			//최대 글번호가 null이 아니면
			maxNum=sqlSession.selectOne("request.numMax");
		}
		
		if(maxNum != 0) { //이미 글이 있을 때
			maxNum=maxNum+1; //글 그룹으로 사용
		}else {
			maxNum=1; //처음 글일때, 글 그룹으로 사용
		}      
	      
		requestDto.setIp(request.getRemoteAddr());
	      
	      if(requestDto.getNum() != 0) {//글 번호가 있으면, 답글이면
	    	  
	    	  //답글 끼워넣기 위치
	    	  sqlSession.update("request.reStep", requestDto);
	    	  requestDto.setRe_step(requestDto.getRe_step()+1); //글순서
	    	  requestDto.setRe_level(requestDto.getRe_level()+1); //답글 깊이
	      }else {//원글이면
	    	  requestDto.setRef(new Integer(maxNum)); //글 그룹
	    	  requestDto.setRe_step(0);
	    	  requestDto.setRe_level(0);
	      }    
	      
	      //글쓰기
	      sqlSession.insert("request.insertDao",requestDto);
	      
	      return "redirect:/request/requestList.do";
	   }//writePro()-end

	//리스트
	@RequestMapping("/requestList.do")
	   public String listBoard(@ModelAttribute("requestDto")RequestDto requestDto, 
			   Model model, @RequestParam(value="pageNum",required=false)String pageNum,
			   HttpServletRequest request) {
	      
		if(pageNum==null) {
			pageNum="1";
		}
		
		
		
		
		
		int pageSize=10;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize+1; // 해당 페이지의 첫번째 row
		int endRow=currentPage*pageSize; // 해당 페이지의 마지막 row
		
		int count=0; //총 글 개수 넣을 변수
		int pageBlock=10; // 블럭당 페이지 수
		
		count=sqlSession.selectOne("request.selectCount"); //총 글 개수
		int number=count-(currentPage-1)*pageSize; //현재 페이지
	     
	     int pageCount=count/pageSize+(count%pageSize==0?0:1); //총 페이지수
	     int startPage=(currentPage/10)*10+1;
	     int endPage=startPage+pageBlock-1;
	     //				1+10-1=10 end페이지
	     
	     HashMap<String,Integer> map=new HashMap<String,Integer>();
	     map.put("start",startRow-1); //시작 위치, mysl은 0부터 시작
	     map.put("cnt",pageSize); //
	      
	     String keyField=request.getParameter("keyField");
	     String keyWord=request.getParameter("keyWord");
	     
	     HashMap<String,Object> map2=new HashMap<String,Object>();
	     map2.put("start",startRow-1);
	     map2.put("cnt",pageSize);
	     map2.put("keyField",keyField);
	     map2.put("keyWord",keyWord);
	          
	     List<RequestDto> list=null;
	     
	     if(keyWord != null) {//검색
	    	 list=sqlSession.selectList("request.searchListDao",map2);
	     }else {	     
	     list=sqlSession.selectList("request.listDao", map);
	     }
	     //JSP에서 사용할 데이터
	     model.addAttribute("currentPage",currentPage);
	     model.addAttribute("startRow",startRow);
	     model.addAttribute("endRow",endRow);
	     
	     model.addAttribute("pageBlock",pageBlock);
	     model.addAttribute("pageCount",pageCount);
	     
	     model.addAttribute("startPage",startPage);
	     model.addAttribute("endPage",endPage);
	     
	     model.addAttribute("count",count);
	     model.addAttribute("pageSize",pageSize);
	     
	     model.addAttribute("number",number);
	     model.addAttribute("list",list);
	     
	      return ".main.request.requestList"; // 뷰 리턴 list.jsp
	}
	//조회수 증가
	//글내용보기
	@RequestMapping("content.do")
	public String content(Model model,String num, String pageNum) {
		int num1=Integer.parseInt(num);
		
		sqlSession.update("request.readCount",num1);
		
		RequestDto requestDto=sqlSession.selectOne("request.getBoard",num1);
		
		model.addAttribute("requestDto",requestDto);
		model.addAttribute("num",num1);
		model.addAttribute("pageNum",pageNum);
		
		return ".main.request.content";
	}
	
	//글수정 폼
	@RequestMapping("editForm.do")
	public String editForm(String num,String pageNum,Model model) {
		int num1=Integer.parseInt(num);
		RequestDto requestDto=sqlSession.selectOne("request.getBoard",num1);
		model.addAttribute("requestDto",requestDto);
		model.addAttribute("pageNum",pageNum);
		
		return ".main.request.editForm";
	}
	
	//DB글 수정
	@RequestMapping(value="editPro.do", method=RequestMethod.POST)
	public String editPro(RequestDto requestDto, String pageNum, Model model) {
		
		sqlSession.update("request.boardUpdate",requestDto);
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/request/requestList.do";
	}
	//DB글 삭제
	@RequestMapping(value="delete.do")
	public String deletePro(Model model,String num,String pageNum) {
		sqlSession.delete("request.boardDelete",new Integer(num));
		
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/request/requestList.do";
	}
}
