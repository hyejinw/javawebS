package com.spring.javawebS.service;

import java.util.ArrayList;

import com.spring.javawebS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public ArrayList<MemberVO> getMemberList();

	public void setMemberPwdUpdate(String mid, String pwd);

	public String getMemberMidFind(String name, String email);

}
