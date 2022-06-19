package co.kr.springteamproject;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model; // request.setAttribute("key", value)
import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;//***
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.apache.ibatis.session.SqlSession; // MyBatis 사용

import model.item.ItemDto;
import model.item.ReplyDto;

@RequestMapping("/item")
@Controller
public class ItemController {
	@Autowired
	SqlSession sqlSession; //자동 setter작업

	//상품목록 리스트
	@RequestMapping("itemList.do")
	public String itemList(Model model,String search) {
		List<ItemDto> list=null;
		if(search==null) {
			list=sqlSession.selectList("item.itemList");
		}else if(search != null) {
			list=sqlSession.selectList("item.itemSearchList",search);
		}
		model.addAttribute("list",list);
		model.addAttribute("cnt",list.size());
		return ".main.item.itemList"; //itemList.jsp 뷰 리턴
	}

	//상품목록 상세
	@RequestMapping("itemDetail.do")
	public String itemDetail(Model model,String num) {
		List<ItemDto> list=null;
		List<ReplyDto> reply=null;
		int num1=Integer.parseInt(num);
		reply=sqlSession.selectList("itemReply.getReply",num1);
		list=sqlSession.selectList("item.itemList");
		ItemDto itemDto=sqlSession.selectOne("item.getItem",num1);
		//ReplyDto replyDto=sqlSession.selectOne("reply.getReply",num1);
		model.addAttribute("itemDto",itemDto); //jsp에서 사용할 데이터
		//model.addAttribute("replyDto",replyDto); //jsp에서 사용할 데이터
		model.addAttribute("item_no",num1);
		model.addAttribute("list",list);
		model.addAttribute("reply",reply);
		return ".main.item.itemDetail"; //itemDetail.jsp 뷰 리턴
	}

	//댓글 작성
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(ReplyDto replyDto) throws Exception{
		sqlSession.insert("itemReply.replyWrite",replyDto);
		//		System.out.println("replyDto.item_no:"+replyDto.getItem_no());
		//		System.out.println("replyDto.writer:"+replyDto.getReply_writer());
		//		System.out.println("replyDto.content:"+replyDto.getReply_content());
		return "redirect:/item/itemDetail.do?num="+replyDto.getItem_no();
	}

	// 입력 폼으로 이동, itemWriteForm
	@RequestMapping("/itemWriteForm.do")
	public String writeForm(Model model,String num) {
		//System.out.println("item_no:"+num);
		if(num==null) {
			num="0";
		}
		model.addAttribute("item_no",new Integer(num));
		return ".main.item.itemWriteForm"; // 뷰 리턴 writeForm.jsp
	}//writeForm()-end

	// DB insert, 입력(글쓰기)
	@RequestMapping(value="itemWritePro.do",method=RequestMethod.POST)
	public String writePro(@ModelAttribute("itemDto") ItemDto itemDto,MultipartHttpServletRequest mRequest,HttpServletRequest request) throws IOException {
		String realPath=request.getSession().getServletContext().getRealPath("/");   
		String upPath=realPath+"/resources/itemimgs/";

		MultipartFile uploadFile=mRequest.getFile("imgFile");

		if(!uploadFile.isEmpty()) {
			String originalFileName=uploadFile.getOriginalFilename();//원래 파일 이름
			uploadFile.transferTo(new File(upPath+originalFileName));
		}
		String originalFileName=uploadFile.getOriginalFilename();
		itemDto.setItem_image(originalFileName);//DB에 저장하기 위해서

		//글쓰기
		sqlSession.insert("item.insertItem", itemDto);
		return "redirect:/item/itemList.do";
	}//writePro()-end

	//DB글삭제
	@RequestMapping("delete.do")
	public String deletePro(Model model,String num) {
		sqlSession.delete("item.itemDelete",new Integer(num));
		return "redirect:/item/itemList.do";
	}

	//글수정폼
	@RequestMapping("itemEditForm.do")
	public String editForm(String num,Model model) {
		int num1=Integer.parseInt(num);
		ItemDto itemDto=sqlSession.selectOne("item.getItem",num1);
		model.addAttribute("itemDto",itemDto);
		//System.out.println("Form itemDto.item_no:"+itemDto.getItem_no());
		return ".main.item.itemEditForm"; //itemEditForm.jsp 뷰리턴
	}

	//DB글수정
	@RequestMapping(value="editPro.do",method=RequestMethod.POST)
	public String editPro(@ModelAttribute("itemDto") ItemDto itemDto,Model model,MultipartHttpServletRequest mRequest,HttpServletRequest request) throws IOException {
		String realPath=request.getSession().getServletContext().getRealPath("/");   
		String upPath=realPath+"/resources/itemimgs/";
		MultipartFile uploadFile=mRequest.getFile("imgFile");

		if(!uploadFile.isEmpty()) {
			String originalFileName=uploadFile.getOriginalFilename();//원래 파일 이름
			uploadFile.transferTo(new File(upPath+originalFileName));
		}
		String originalFileName=uploadFile.getOriginalFilename();
		itemDto.setItem_image(originalFileName);//DB에 저장하기 위해서
		//		System.out.println("Pro itemDto.item_no:"+itemDto.getItem_no());
		//		System.out.println("Pro itemDto.item_name:"+itemDto.getItem_name());
		//		System.out.println("Pro itemDto.item_price:"+itemDto.getItem_price());
		//		System.out.println("Pro itemDto.item_detail:"+itemDto.getItem_detail());
		//		System.out.println("Pro itemDto.item_area:"+itemDto.getItem_area());
		//		System.out.println("Pro itemDto.item_image:"+itemDto.getItem_image());

		sqlSession.update("item.itemUpdate",itemDto);
		return "redirect:/item/itemList.do";
	}

	//DB 댓글삭제
	@RequestMapping("replyDelete.do")
	public String replyDeletePro(Model model,String num) {
		int num1=Integer.parseInt(num);
		ReplyDto replyDto=sqlSession.selectOne("reply.getReply",num1);
		sqlSession.delete("itemReply.replyDelete",replyDto);
		return "redirect:/item/itemDetail.do?num="+num;
	}
}//class-end
