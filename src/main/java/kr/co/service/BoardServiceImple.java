package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.BoardDAO;
import kr.co.dao.ReplyDao;
import kr.co.util.FileUtils;
import kr.co.vo.BoardVO;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Service
public class BoardServiceImple implements BoardService {
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Inject
	private BoardDAO dao;

	@Inject
	private ReplyDao replyDao;

	// 게시글 작성
	/*
	 * @Override public void write(BoardVO boardVO) throws Exception {
	 * dao.write(boardVO); }
	 */
	@Override
	public void write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.write(boardVO); // 문제: 여기서 bno가 생성 db보다 -1값으로 생성됨 (ex. db는 mp_board.bno=63인데, 여기서는 62로 나옴)
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.insertFile(list.get(i)); //bno가 있다는 것을 debug를 통해 알 수 있음
		}
	}

	// 게시물 목록 조회
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		return dao.list(scri);
	}

	// 게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return dao.listCount(scri);
	}

	// 게시물 목록 조회
	@Override
	public BoardVO read(int bno) throws Exception {

		return dao.read(bno);
	}

	// 게시물 업데이트
	@Override
	public void update(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
	
		dao.update(boardVO);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardVO, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i = 0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("is_new").equals("Y")) {
				dao.insertFile(tempMap);
			}else {
				dao.updateFile(tempMap);
			}
		}
		
	}
	
	// 게시판 첨부 파일 삭제
	@Override
	public boolean deleteFile(int file_no) throws Exception {
		int result = dao.deleteFile(file_no);
		return true;
	}

	// 게시물 삭제
	@Override
	public void delete(ReplyVO replyVO) throws Exception {

		replyDao.deleteReply(replyVO);
		dao.delete(replyVO.getBno());
	}

	//패스워드 체크
	@Override
	public BoardVO pwcheck(int bno) throws Exception {
		return dao.pwcheck(bno);

	}

	@Override
	public void answer(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.answer(boardVO);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.insertFile(list.get(i)); //bno가 있다는 것을 debug를 통해 알 수 있음
		}
	}

	
	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return dao.selectFileList(bno);
	}
	
	// 첨부파일 다운로드
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}

	@Override
	public List<BoardVO> excelList(SearchCriteria scri) throws Exception {
		return dao.excelList(scri);
	}

	

	
}