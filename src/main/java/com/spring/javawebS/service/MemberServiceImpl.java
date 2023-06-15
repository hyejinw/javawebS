package com.spring.javawebS.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.common.JavawebProvide;
import com.spring.javawebS.dao.MemberDAO;
import com.spring.javawebS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo, MultipartFile fName) {
		int res = 0;
		try {
			// 업로드된 사진을 서버 파일시스템에 저장처리한다.
			String oFileName = fName.getOriginalFilename();
			
			if(oFileName.equals("")) {
				vo.setPhoto("noimage.jpg");
			}
			else {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "member");
				
				vo.setPhoto(saveFileName);
			}	 
			
			// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
			memberDAO.setMemberJoinOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	
	
	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
		
	}

	@Override
	public ArrayList<MemberVO> getMemberList() {
		return memberDAO.getMemberList();
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	@Override
	public String getMemberMidFind(String name, String email) {
		return memberDAO.getMemberMidFind(name, email);
	}

	@Override
	public int setMemberUpdateOk(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			
			// 파일 정보 수정이 있을 경우에만 수정하라
			if(!oFileName.equals("")) {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(fName, saveFileName, "member");
				
				// 기존에 존재하는 파일은 삭제처리한다.
				if(!vo.getPhoto().equals("noimage.jpg")) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					String realPath = request.getSession().getServletContext().getRealPath("/resources/data/member/");
					File file = new File(realPath + vo.getPhoto());
					file.delete();
				}
				// 기존에 존재하는 파일을 지우고, 새로 업로드시킨 파일명을 set시켜준다.
				vo.setPhoto(saveFileName);
				
			}
			memberDAO.setMemberUpdateOk(vo);
			res = 1;
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int getMemberDelete(String mid) {
		return memberDAO.getMemberDelete(mid);
	}
	
}
