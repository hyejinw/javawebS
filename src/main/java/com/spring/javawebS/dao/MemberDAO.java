package com.spring.javawebS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);

	public ArrayList<MemberVO> getMemberList();

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public String getMemberMidFind(@Param("name") String name, @Param("email") String email);
	
	public void setMemberUpdateOk(@Param("vo") MemberVO vo);
	
	public int getMemberDelete(@Param("mid") String mid);

}
