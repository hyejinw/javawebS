package com.spring.javawebS;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.common.ARIAUtil;
import com.spring.javawebS.common.SecurityUtil;
import com.spring.javawebS.service.MemberService;
import com.spring.javawebS.service.StudyService;
import com.spring.javawebS.vo.MailVO;
import com.spring.javawebS.vo.MemberVO;

@Controller
@RequestMapping("/study")
public class StudyController {

	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;
	
	
	
	// 암호화연습(sha256)
	@RequestMapping(value = "/password/sha256", method = RequestMethod.GET)
	public String sha256Get() {
		return "study/password/sha256";
	}
	
	// 암호화연습(sha256) : 결과처리
	@ResponseBody
	@RequestMapping(value = "/password/sha256", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String sha256Post(String pwd) {
		String encPwd = SecurityUtil.encryptSHA256(pwd);
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		return pwd;
	}
	
  // 암호화연습(ARIA)
	@RequestMapping(value = "/password/aria", method = RequestMethod.GET)
	public String ariaGet() {
		return "study/password/aria";
	}
	
	// 암호화연습(ARIA) : 결과처리
	@ResponseBody
	@RequestMapping(value = "/password/aria", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String ariaPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String encPwd = "";
		String decPwd = "";
		
		encPwd = ARIAUtil.ariaEncrypt(pwd);
		decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd + " / 복호화된 비밀번호 : " + decPwd;
		
		return pwd;
	}
	
	// 암호화연습(bCryptPasswordEncoder방식)
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.GET)
	public String bCryptPasswordGet() {
		return "study/password/bCryptPassword";
	}
	
	// 암호화연습(bCryptPasswordEncoder) : 결과처리
	@ResponseBody
	@RequestMapping(value = "/password/bCryptPassword", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd);
		
		pwd = "원본 비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	// 메일 연습
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.GET)
	public String mailFormGet(Model model) {
		ArrayList<MemberVO> vos = memberService.getMemberList();
		
		model.addAttribute("vos", vos);
		return "study/mail/mailForm";
	}
	
	// 메일 전송
	@RequestMapping(value = "/mail/mailForm", method = RequestMethod.POST)
	public String mailFormPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage(); 
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
		
		// 메일보관함에 회원이 보내온 메시지의 정보를 저장 후, 작업 처리
		messageHelper.setTo(toMail.split(";"));
		messageHelper.setSubject(title);
		//messageHelper.setText(content);
		
		// 메시지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>CJ Green에서 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaweb8J/'>CJ Greem 프로젝트</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
	
		// 본문에 기재된 그림파일의 경로를 별도 표시 후, 다시 보관함에 저장
		FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.jpg");
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기(서버 파일시스템에 존재하는 파일 전송)
		file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\chicago.jpg");
		messageHelper.addAttachment("chicago.jpg", file);

		file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.zip");
		messageHelper.addAttachment("main.zip", file);
		
		// 파일시스템에 설계한 파일이 저장된 실제경로(realPath)를 이용
		//file = new FileSystemResource(request.getRealPath("/resources/images/paris.jpg"));
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/paris.jpg"));
		messageHelper.addAttachment("paris.jpg", file);
		
		
		// 메일 전송
		mailSender.send(message);
		
		return "redirect:/message/mailSendOk";
	}
	
	// UUID 연습
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.GET)
	public String uuidFormGet() {
		return "study/uuid/uuidForm";
	}
	
	// UUID 결과
	@ResponseBody
	@RequestMapping(value = "/uuid/uuidForm", method = RequestMethod.POST)
	public String uuidFormPost() {
		UUID uid = UUID.randomUUID();
		
		return uid.toString();
	}
	
	// ajax 연습
	@RequestMapping(value = "/ajax/ajaxForm", method = RequestMethod.GET)
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
	// ajax 연습1
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest1", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String ajaxTest1Post(int idx) {
		idx = (int) (Math.random()*idx) + 1;
		
		return idx + " : Have a Good Time!";
	}
	
	// ajax 연습2_1
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.GET)
	public String ajaxTest2_1Get() {
		return "study/ajax/ajaxTest2_1";
	}
	
	// 일반 배열값의 전달
	// ajax 연습2_1
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_1", method = RequestMethod.POST)
	public String[] ajaxTest2_1Post(String dodo) {
//		String[] strArray = new String[100];
//		strArray = studyService.getCityStringArray(dodo);
//		return strArray;
		
		return studyService.getCityStringArray(dodo);
	}
	
	// ajax 연습2_2
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.GET)
	public String ajaxTest2_2Get() {
		return "study/ajax/ajaxTest2_2";
	}
	
	// 객체배열(ArrayList)값의 전달
	// ajax 연습2_2
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest2_2Post(String dodo) {
		
		return studyService.getCityArrayList(dodo);
	}
	
	
	// ajax 연습2_3
	@RequestMapping(value = "/ajax/ajaxTest2_3", method = RequestMethod.GET)
	public String ajaxTest2_3Get() {
		return "study/ajax/ajaxTest2_3";
	}
	
	// Map(HashMap<k,v>)값의 전달
	// ajax 연습2_3
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest2_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest2_3Post(String dodo) {
		
		ArrayList<String> vos = new ArrayList<String>();
		vos = studyService.getCityArrayList(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	
	// ajax 연습3
	@RequestMapping(value = "/ajax/ajaxTest3", method = RequestMethod.GET)
	public String ajaxTest3Get() {
		return "study/ajax/ajaxTest3";
	}
	
	// DB 활용한 값의 전달(vo 사용)
	// ajax 연습3_1
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_1", method = RequestMethod.POST)
	public MemberVO ajaxTest3_1Post(String name) {
		return studyService.getMemberMidSearch(name);
	}
	
	// DB 활용한 값의 전달(vos 사용)
	// ajax 연습3_2
	@ResponseBody
	@RequestMapping(value = "/ajax/ajaxTest3_2", method = RequestMethod.POST)
	public ArrayList<MemberVO> ajaxTest3_2Post(String name) {
		return studyService.getMemberMidSearch2(name);
	}
	
	// 파일 업로드 폼
	@RequestMapping(value = "/fileUpload/fileUploadForm", method=RequestMethod.GET)
	public String fileUploadGet(Model model, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study");
		String[] files = new File(realPath).list(); // 하나의 폴더의 정보를 읽도록 해야 한다.
		
//		for(String file : files) {
//			System.out.println("file : " + file);
//		}
		model.addAttribute("files", files);
		model.addAttribute("fileCount", files.length);
		
		return "study/fileUpload/fileUploadForm";
	}
	
	// 파일 업로드 처리
	@RequestMapping(value = "/fileUpload/fileUploadForm", method = RequestMethod.POST)
	public String fileUploadPost(MultipartFile fName, String mid) {
//		System.out.println("fName : " + fName);
//		System.out.println("mid : " + mid);
		
		int res = studyService.fileUpload(fName, mid);
		
		if(res == 1) return "redirect:/message/fileUploadOk";
		else return "redirect:/message/fileUploadNo";
	}
	
	// 파일 삭제
	@ResponseBody
	@RequestMapping(value = "/fileUpload/fileDelete", method = RequestMethod.POST)
	public String fileDeletePost(HttpServletRequest request,
			@RequestParam(name="file", defaultValue = "", required=false) String fName) {
		String res = "0";
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		File file = new File(realPath + fName);
		
		if(file.exists()) {
			file.delete();
			res = "1";
		}
		return res;
	}
	
	// 파일 다운로드 메소드
	@RequestMapping(value="/fileUpload/fileDownAction", method=RequestMethod.GET)
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String file = request.getParameter("file");
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");		
		
		File downFile = new File(realPath + file);
		String downFileName = new String(file.getBytes("UTF-8"), "8859_1");
		response.setHeader("Content-Disposition", "attachment:filename=" +downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[2048];  // 2k란 의미!
		int data = 0;
		while((data = fis.read(buffer, 0, buffer.length)) != -1) {
			sos.write(buffer, 0, data);
		}
		sos.flush();  // 찌꺼기 없애기
		sos.close();
		fis.close();
		
		//return "study/fileUpload/fileUploadForm";
	}
	
}
