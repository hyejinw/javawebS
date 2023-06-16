package com.spring.javawebS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javawebS.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public int setBoardInput(BoardVO vo);

	public void imgCheck(String content);

	public BoardVO getBoardContent(int idx);

	public void setBoardReadNum(int idx);

	public ArrayList<BoardVO> getPrevNext(int idx);

}
