package com.spring.javawebS.vo;

import lombok.Data;

@Data
public class BoardVO {
	
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String email;
	private String homePage;
	private String content;
	private int readNum;
	private String hostIp;
	private String openSw;
	private String wDate;
	private int good;
	
	// 게시글 시간 차이 계산용
	private int hour_diff;
	
	// 게시글 날짜 차이 계산용
	private int day_diff;
	
	// 이전글/다음글을 위한 변수 설정
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	// 댓글 개수
	private int replyCount;
}
