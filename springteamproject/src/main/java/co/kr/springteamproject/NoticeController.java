package co.kr.springteamproject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;//***
import org.springframework.web.servlet.ModelAndView;


import model.notice.NoticeDto;

import java.util.*;//HashMap
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;
//1시간

@RequestMapping("/notice")
@Controller
public class NoticeController {
  @Autowired
  SqlSession sqlSession;
  
  //글쓰기 폼
  @RequestMapping("/writeForm.do")
  public String writeForm() {
	  return ".main.notice.writeForm";//writeForm.jsp
  }
   
  //DB글쓰기
  @RequestMapping(value="writePro.do",method=RequestMethod.POST)
  public String writepro(@ModelAttribute("noticeDto") NoticeDto noticeDto,HttpServletRequest request) {
	  sqlSession.insert("notice.insertDao",noticeDto);
	  return "redirect:/notice/list.do";
	 // return ".main.notice.writeForm";//writeForm.jsp
  }//writepro()-end
 
//리스트
  @RequestMapping("/list.do")
	public String listdo(@ModelAttribute("noticeDto") NoticeDto noticeDto,
			  Model model,
			  @RequestParam(value="pageNum",required=false)String pageNum,
			  HttpServletRequest request) {
		
	  if(pageNum==null) {
		  pageNum="1";
	  }
	  
	  int pageSize=10;
	  int currentPage=Integer.parseInt(pageNum);
	  int startRow=(currentPage-1)*pageSize+1;//한 페이지의 첫번재 row를 구한다 
	  int endRow=currentPage*pageSize;//한 페이지의 마지막 row을 구한다 
	  
	  int count=0;//총 글수 넣을 ㅂ녀수
	  int pageBlock=10;//블럭당 페이지 수
	  
	  count=sqlSession.selectOne("notice.selectCount");//총 글갯수 얻기 
	  int number=count-(currentPage-1)*pageSize;//글번호 역순으로 출력
	  
	  
	  int pageCount=count/pageSize+(count%pageSize==0?0:1);//총페이지 수
	  int startPage=(currentPage/10)*10+1;
	  int endPage=startPage+pageBlock-1;
	  //             1+10-1=10 end페이지 

	  
	  HashMap<String,Integer> map=new HashMap<String,Integer>();
	  map.put("start",startRow-1);//시작위치,mysql은 0부터 시작
	  map.put("cnt",pageSize);
	  
	  String keyField=request.getParameter("keyField");
	  String keyWord=request.getParameter("keyWord");
	  
	  HashMap<String, Object> map2=new HashMap<String, Object>();
	  map2.put("start",startRow-1);
	  map2.put("cnt",pageSize);
	  map2.put("keyField",keyField);
	  map2.put("keyWord",keyWord);
	  
	  
	  
	  List<NoticeDto> list=null;
	  
	  if (keyWord != null) {
		  list=sqlSession.selectList("notice.searchListDao",map2);		
	}else {
		list=sqlSession.selectList("notice.listDao",map);		
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
	 
	 // return "/notice/list";//list.jsp뷰 리턴
	  return ".main.notice.list";//list.jsp뷰 리턴
		
  }
  
  
//조회수증가
  //글내용보기
  @RequestMapping("content.do")
  public String content(Model model,String noticeno,String pageNum) {
	  int noticeno1=Integer.parseInt(noticeno);
	  
	  sqlSession.update("notice.readCount",noticeno1);//조회수증기
	  
	  NoticeDto noticeDto=sqlSession.selectOne("notice.getNotice",noticeno1);
	  model.addAttribute("noticeDto",noticeDto);//jsp에서 사용할데이터
	  model.addAttribute("noticeno",noticeno1);
	  model.addAttribute("pageNum",pageNum);
	  //return "/notice/content";//content.jsp
	  return ".main.notice.content";//content.jsp
  }

  //글수정 폼
  @RequestMapping("editForm.do")
  public String editForm(String noticeno,String pageNum,Model model) {
	  int noticeno1=Integer.parseInt(noticeno);
	  NoticeDto noticeDto=sqlSession.selectOne("notice.getNotice",noticeno1);
	  model.addAttribute("noticeDto",noticeDto);
	  model.addAttribute("pageNum",pageNum);
	  
	 // return "/board/editForm";
	   return ".main.notice.editForm";
  }
  
  //DB 글수정
  @RequestMapping(value="editPro.do",method=RequestMethod.POST)
  public String editPro(NoticeDto noticeDto,String pageNum,Model model) {
	  sqlSession.update("notice.noticeUpdate",noticeDto);
	  model.addAttribute("pageNum",pageNum);
	  
	  return "redirect:/notice/list.do";
  }
  
  //DB 글삭제
  @RequestMapping("delete.do")
  public String deletePro(Model model,String noticeno,String pageNum) {
	  sqlSession.delete("notice.noticeDelete", new Integer(noticeno));
	  
	  model.addAttribute("pageNum",pageNum);
	  
	  return  "redirect:/notice/list.do";
  }
}//class-end
