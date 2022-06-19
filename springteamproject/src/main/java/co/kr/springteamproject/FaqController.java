package co.kr.springteamproject;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model; // request.setAttribute("key", value)
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;//***

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.apache.ibatis.session.SqlSession; // MyBatis 사용
import model.board.FaqDto;

@RequestMapping("/faqboard")
@Controller
public class FaqController {
	@Autowired
	SqlSession sqlSession; // 자동 setter 작업

	// 입력 폼으로 이동, writeForm
	@RequestMapping("/writeForm.do")
	public String writeForm(Model model,String num,String ref,String re_step,String re_level,String pageNum) {
		//답글,원글 처리
		if(num==null) {
			//원글쓰기
			num="0";
			ref="1"; //글 그룹
			re_step="0"; //글순서
			re_level="0";  //답글깊이
		}
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("num",new Integer(num));
		model.addAttribute("ref",new Integer(ref));
		model.addAttribute("re_step",new Integer(re_step));
		model.addAttribute("re_level",new Integer(re_level));
		//return "/board/writeForm"; // 뷰 리턴 writeForm.jsp
		return ".main.faqboard.writeForm"; // 뷰 리턴 writeForm.jsp
	}//writeForm()-end

	// DB insert, 입력(글쓰기)
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(@ModelAttribute("faqDto") FaqDto faqDto,HttpServletRequest request) {
		int maxNum=0; //최대 글번호 넣을 변수
		if(sqlSession.selectOne("faqboard.numMax") != null) {
			//최대 글번호가 null이 아니면
			maxNum=sqlSession.selectOne("faqboard.numMax"); //최대 글번호 얻기
		}

		if(maxNum != 0) { //이미 글이 있을때
			maxNum=maxNum+1; //글 그룹으로 사용하려고
		}else {
			maxNum=1; //처음글일때, 글 그룹으로 사용 하려고
		}

		faqDto.setIp(request.getRemoteAddr());

		if(faqDto.getNum()!=0) { //글 번호가 있으면,답글이면 
			//답글 위치 확보 
			sqlSession.update("faqboard.reStep",faqDto);
			faqDto.setRe_step(faqDto.getRe_step()+1); //글순서
			faqDto.setRe_level(faqDto.getRe_level()+1); //답글깊이
		}else { //원글이면
			faqDto.setRef(new Integer(maxNum)); //글그룹
			faqDto.setRe_step(0);
			faqDto.setRe_level(0);
		}

		//글쓰기
		sqlSession.insert("faqboard.insertDao", faqDto);
		return "redirect:/faqboard/list.do";
	}//writePro()-end

	//리스트
	@RequestMapping("/list.do")
	public String listBoard(@ModelAttribute("faqDto") FaqDto faqDto,
			Model model,@RequestParam(value="pageNum",required=false )String pageNum,HttpServletRequest request){
		if(pageNum==null) {
			pageNum="1";
		}
		
		int pageSize=10;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize+1; //한 페이지의 첫번째 row를구한다
		int endRow=currentPage*pageSize; //한페이지의 마지막 row를 구한다
		int count=0; //총 글 수 넣을 변수
		int pageBlock=10; //블럭당 페이지 수
		count=sqlSession.selectOne("faqboard.selectCount"); //총 글 갯수 얻기
		int number=count-(currentPage-1)*pageSize; //글번호 역순 출력
		
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		int startPage=(currentPage/10)*10+1;
		int endPage=startPage+pageBlock-1;
		//                1+10-1=10 end페이지
		
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("start", startRow-1); //시작위치,mysql은 0부터 시작
		map.put("cnt",pageSize);
		
		String keyField=request.getParameter("keyField");
		String keyWord=request.getParameter("keyWord");
		
		HashMap<String, Object> map2=new HashMap<String, Object>();
		map2.put("start", startRow-1);
		map2.put("cnt",pageSize);
		map2.put("keyField",keyField);
		map2.put("keyWord",keyWord);
		
		List<FaqDto> list=null;
		
		if(keyWord != null) { //검색
			list=sqlSession.selectList("faqboard.searchListDao",map2);
		}else {
			list=sqlSession.selectList("faqboard.listDao",map);
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
		//return "/board/list"; //list.jsp뷰리턴
		return ".main.faqboard.list"; //list.jsp뷰리턴
	}
	//조회수 증가
	//글내용 보기
	@RequestMapping("content.do")
	public String content(Model model,String num,String pageNum) {
		int num1=Integer.parseInt(num);
		sqlSession.update("faqboard.readCount",num1); //조회수 증가
		FaqDto faqDto=sqlSession.selectOne("faqboard.getBoard",num1);
		model.addAttribute("faqDto",faqDto); //jsp에서 사용할 데이터
		model.addAttribute("num",num1);
		model.addAttribute("pageNum",pageNum);
		//return "/board/content";
		return ".main.faqboard.content"; //content.jsp 뷰 리턴
	}
	
	//글수정폼
	@RequestMapping("editForm.do")
	public String editForm(String num,String pageNum,Model model) {
		int num1=Integer.parseInt(num);
		FaqDto faqDto=sqlSession.selectOne("faqboard.getBoard",num1);
		model.addAttribute("faqDto",faqDto);
		model.addAttribute("pageNum",pageNum);
		
		return ".main.faqboard.editForm"; //editForm.jsp 뷰리턴
	}
	
	//DB글수정
	@RequestMapping(value="editPro.do",method=RequestMethod.POST)
	public String editPro(FaqDto faqDto,String pageNum,Model model) {
		sqlSession.update("faqboard.boardUpdate",faqDto);
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/faqboard/list.do";
	}
	
	//DB글삭제
	@RequestMapping("delete.do")
	public String deletePro(Model model,String num,String pageNum) {
		sqlSession.delete("faqboard.boardDelete",new Integer(num));
		model.addAttribute("pageNum",pageNum);
		return "redirect:/faqboard/list.do";
	}
	
	//
	@RequestMapping("faqHome.do")
	public String faqHomePro() {
		return ".main.faqboard.faqHome";
	}
	
	@RequestMapping("faqGuideline.do")
	public String faqGuidelinePro() {
		return ".main.faqboard.faqGuideline";
	}
	
	@RequestMapping("faqoperationpolicy.do")
	public String faqoperationpolicyPro() {
		return ".main.faqboard.faqoperationpolicy";
	}
	
	@RequestMapping("faqmanner.do")
	public String faqmannerPro() {
		return ".main.faqboard.faqmanner";
	}
	
	@RequestMapping("faqprohibition.do")
	public String faqprohibitionPro() {
		return ".main.faqboard.faqprohibition";
	}
}
