package com.spring.javawebS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);

	MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	int setMemberJoinOk(@Param("vo") MemberVO vo);

	void setMemberVisitProcess(@Param("vo") MemberVO vo);

	ArrayList<MemberVO> getMemberList();

	void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	String getMemberMidFind(@Param("name") String name, @Param("email") String email);

}
