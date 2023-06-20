package com.spring.javawebS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.MemberVO;

public interface StudyDAO {

	MemberVO getMemberMidSearch(@Param("name") String name);

	ArrayList<MemberVO> getMemberMidSearch2(@Param("name") String name);

}
