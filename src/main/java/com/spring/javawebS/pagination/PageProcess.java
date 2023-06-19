package com.spring.javawebS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.BoardDAO;
import com.spring.javawebS.dao.GuestDAO;

@Service
public class PageProcess {

	@Autowired
	GuestDAO guestDAO;

	@Autowired
	BoardDAO boardDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String search, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("guest"))	totRecCnt = guestDAO.totRecCnt();
//		else if(section.equals("member"))	totRecCnt = memberDAO.totRecCnt();
		else if(section.equals("board"))	{
			if(search.equals("")) totRecCnt = boardDAO.totRecCnt();
			else {
				totRecCnt = boardDAO.totRecCntSearch(search, searchString);   // 오버로딩!! 매개변수의 타입이나 개수 순서를 다르게 쓰는 것
			}
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}

}
