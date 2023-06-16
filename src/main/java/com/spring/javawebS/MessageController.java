package com.spring.javawebS;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			Model model) {
		
		if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "게시글이 등록 실패~~~");
			model.addAttribute("url", "/guest/guestInput");
		}
		else if(msgFlag.equals("guestAdminOk")) {
			model.addAttribute("msg", "관리자 인증 성공");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestAdminNo")) {
			model.addAttribute("msg", "관리자 인증 실패~~~");
			model.addAttribute("url", "/guest/adminLogin");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("msg", "관리자 로그아웃");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "방명록의 글이 삭제 되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("msg", "방명록의 글이 삭제 실패~~~");
			model.addAttribute("url", "/guest/guestList");
		}
		// 메일 전송관련
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송 완료!");
			model.addAttribute("url", "/study/mail/mailForm");
		}
		// 아이디 중복 체크 관련(join)
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "아이디가 중복되었습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		// 닉네임 중복 체크 관련(join)
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "닉네임이 중복되었습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 되었습니다. 반갑습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입이 실패했습니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+ "님 로그인 되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인에 실패했습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid +"님 로그아웃 되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 사용가능한 창입니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("levekCheckNo")) {
			model.addAttribute("msg", "회원 등급을 확인해주세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("msg", "입력하신 아이디는 없는 회원입니다.");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		else if(msgFlag.equals("memberEmailCheckNo")) {
			model.addAttribute("msg", "입력하신 이메일을 확인해주세요.");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		
		else if(msgFlag.equals("memberImsiPwdOk")) {
			model.addAttribute("msg", "임시비밀번호가 발급되었습니다.\\n이메일을 확인해주세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberImsiPwdNo")) {
			model.addAttribute("msg", "임시비밀번호 전송이 실패했습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/member/memberPwdFind");
		}
		else if(msgFlag.equals("memberPwdUpdateOk")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일 업로드 실패했습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUploadForm");
		}
		else if(msgFlag.equals("memberPwdCheckNo")) {
			model.addAttribute("msg", "회원 정보를 확인하세요.");
			model.addAttribute("url", "/member/memberPwdCheck");
		}
		else if(msgFlag.equals("memberNickCheckNo")) {
			model.addAttribute("msg", "닉네임을 확인하세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원정보가 수정되지 못했습니다.\\n재시도 부탁드립니다.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "탈퇴되었습니다. 함께 해주셔서 감사했습니다!");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "탈퇴되지 않았습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글이 등록되지 않았습니다.\\n재시도 부탁드립니다.");
			model.addAttribute("url", "/board/boardInput");
		}
		
		
		return "include/message";
	}
	
	
}
