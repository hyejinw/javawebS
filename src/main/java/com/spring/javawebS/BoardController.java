package com.spring.javawebS;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javawebS.pagination.PageProcess;
import com.spring.javawebS.pagination.PageVO;
import com.spring.javawebS.service.BoardService;
import com.spring.javawebS.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", "", "");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
		boardService.imgCheck(vo.getContent());
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 board폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/board/)
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = boardService.setBoardInput(vo);
		
		if(res == 1) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	
	// 게시판 글 상세보기
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		
		// 글 조회수 증가(조회수 중복방지 - 세션처리('board+고유번호'를 객체배열에 추가)
		@SuppressWarnings("unchecked")
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			boardService.setBoardReadNum(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전 글, 다음 글 가져오기
		ArrayList<BoardVO> pnVos = boardService.getPrevNext(idx);
		
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "board/boardContent";
	}
	
}
