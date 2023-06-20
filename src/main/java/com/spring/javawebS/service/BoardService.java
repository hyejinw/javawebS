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

	public void boardGoodFlagCheck(int idx, int gFlag);

	public List<BoardVO> getBoardListSearch(int startIndexNo, int pageSize, String search, String searchString);

	public void imgDelete(String content);

	public int setBoardDelete(int idx);

	public void imgCheckUpdate(String content);

	public int setBoardUpdate(BoardVO vo);

}
