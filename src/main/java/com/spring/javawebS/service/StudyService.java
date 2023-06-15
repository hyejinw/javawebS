package com.spring.javawebS.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javawebS.vo.MemberVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public MemberVO getMemberMidSearch(String name);

	public ArrayList<MemberVO> getMemberMidSearch2(String name);

	public int fileUpload(MultipartFile fName, String mid);

}
