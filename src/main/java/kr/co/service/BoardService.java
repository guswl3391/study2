package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.vo.BoardVO;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

public interface BoardService {

		// 게시글 작성
		//public void write(BoardVO boardVO) throws Exception;
		public void write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;
		
		// 게시물 목록 조회
		public List<BoardVO> list(SearchCriteria scri) throws Exception;
			
		//게시물 총 갯수
		public int listCount(SearchCriteria scri) throws Exception;
		
		// 게시물 조회
		public BoardVO read(int bno) throws Exception;
		
		// 게시판 첨부 파일 삭제
		public boolean deleteFile(int file_no) throws Exception;

		/*
		 * 게시물 수정 public void update(BoardVO boardVO) throws Exception;
		 */
		
		// 게시물 수정
		// public void update(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception;
		public void update(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;
		
		// 게시물 삭제
		public void delete(ReplyVO replyVO) throws Exception;	
		
		//pw check
		public BoardVO pwcheck(int bno) throws Exception;
		
		// 답글 작성
		public void answer(BoardVO boardVO) throws Exception;
		
		// 첨부파일 조회
		public List<Map<String, Object>> selectFileList(int bno) throws Exception;
		
		// 첨부파일 다운
		public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	    
		
		// 엑셀 리스트
		public List<BoardVO> excelList(SearchCriteria scri) throws Exception;
		
	         
	}