package co.kr.springteamproject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;//***
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import model.free.FreeDto;
import model.free.ReplyDto;

import java.awt.Dialog.ModalExclusionType;
import java.io.File;
import java.io.IOException;
import java.util.*;//HashMap
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;
//1시간
@RequestMapping("/free")
@Controller
public class FreeController {
	@Autowired
	SqlSession sqlSession;
	  
	//글쓰기 폼
	@RequestMapping("/writeForm.do")
	public String writeForm() {
		return ".main.free.writeForm";//writeForm.jsp
	}

	//DB글쓰기
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writepro(@ModelAttribute("freeDto") FreeDto freeDto,HttpServletRequest request
			,MultipartHttpServletRequest mRequest)throws IOException{

		String realPath=request.getSession().getServletContext().getRealPath("/");
		String upPath=realPath+"/resources/freeimgs/";
		
		MultipartFile uploadFile=mRequest.getFile("imgFile");
		
		if(!uploadFile.isEmpty()) {

			String originalFileName=uploadFile.getOriginalFilename();//원래 파일 이름
			System.out.println("그림파일이름:"+originalFileName);
			uploadFile.transferTo(new File(upPath+originalFileName));//파일럽로드
			
			freeDto.setImg(originalFileName);
			
		}

		sqlSession.insert("free.insertDao",freeDto);

		return "redirect:/free/list.do";

		 //return ".main.free.writeForm";//writeForm.jsp
	}//writepro()-end

	  
	  //리스트
	  @RequestMapping("/list.do")
		public String listdo(@ModelAttribute("freeDto") FreeDto freeDto,
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
		  
		  count=sqlSession.selectOne("free.selectCount");//총 글갯수 얻기 
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
		  
		  
		  
		  List<FreeDto> list=null;
		  
		  if (keyWord != null) {
			  list=sqlSession.selectList("free.searchListDao",map2);//검색		
		}else {
			list=sqlSession.selectList("free.listDao",map);		//
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
		  return ".main.free.list";//list.jsp뷰 리턴
			
	  }
	  
	//조회수증가
	  //댓글달기
	  @RequestMapping("content.do")
	     public String content(Model model,String free_no,String pageNum) {
		    
	        int free_no1=Integer.parseInt(free_no);
	        
	        List<FreeDto> list=null;
	        List<ReplyDto> reply=null;
	        
	        list=sqlSession.selectList("free.listDao2");
	        reply=sqlSession.selectList("reply.getReply",free_no1);
	         
	        sqlSession.update("free.readCount",free_no1);//조회수증기
	        
	        FreeDto freeDto=sqlSession.selectOne("free.getFree",free_no1);
	        
	        model.addAttribute("freeDto",freeDto);//jsp에서 사용할데이터
	        model.addAttribute("free_no",free_no1);
	        model.addAttribute("pageNum",pageNum);
	        model.addAttribute("list",list);
	        model.addAttribute("reply",reply);
	      //  model.addAttribute("")
	        //return "/notice/content";//content.jsp
	        return ".main.free.content";//content.jsp
	     }
	  
	//댓글 작성
	   @RequestMapping(value="replyWritePro.do",method=RequestMethod.POST)
	   public String writePro(ReplyDto replyDto) throws Exception{
	      sqlSession.insert("reply.replyWrite",replyDto);
	      //      System.out.println("replyDto.item_no:"+replyDto.getItem_no());
	      //      System.out.println("replyDto.writer:"+replyDto.getReply_writer());
	      //      System.out.println("replyDto.content:"+replyDto.getReply_content());
	      return "redirect:/free/content.do?free_no="+replyDto.getFree_no();
	     
	   }
	  
	  //글수정 폼
	  @RequestMapping("editForm.do")
	  public String editForm(String free_no,String pageNum,Model model) {
		  int free_no1=Integer.parseInt(free_no);
		  FreeDto freeDto=sqlSession.selectOne("free.getFree",free_no1);
		  model.addAttribute("freeDto",freeDto);
		  model.addAttribute("pageNum",pageNum);
		  
		 // return "/board/editForm";
		   return ".main.free.editForm";
	  }
	  
	  //DB 글수정
	  @RequestMapping(value="editPro.do",method=RequestMethod.POST)
	  public String editPro(FreeDto freeDto,String pageNum,Model model) {
		  sqlSession.update("free.freeUpdate",freeDto);
		  model.addAttribute("pageNum",pageNum);
		  
		  return "redirect:/free/list.do";
	  }
	  
	//DB 글삭제
	  @RequestMapping("delete.do")
	  public String deletePro(Model model,String free_no,String pageNum) {
		  sqlSession.delete("free.freeDelete", new Integer(free_no));
		  model.addAttribute("pageNum",pageNum);
		  return  "redirect:/free/list.do";
	  }
	  //DB 댓글삭제
	  @RequestMapping("replyDelete.do")
	  public String replydeletePro(Model model,String reply_rno,String free_no,String pageNum) {
		  
		  int rno=Integer.parseInt(reply_rno);
		  int no=Integer.parseInt(free_no);
		  
		  Map<String, Integer>map=new HashMap<String, Integer>();
		  map.put("reply_rno", new Integer(rno));
		  map.put("free_no", new Integer(no));
		  
				  
		  sqlSession.delete("reply.replyDelete",map);
		  model.addAttribute("pageNum",pageNum);
		  
		  return "redirect:/free/content.do?reply_rno="+reply_rno;
	  }
	  
}
