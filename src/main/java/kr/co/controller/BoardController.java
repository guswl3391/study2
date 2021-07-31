package kr.co.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.BoardVO;
import kr.co.vo.PageMaker;
import kr.co.vo.ReplyVO;
import kr.co.vo.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = {RequestMethod.GET, RequestMethod.POST})
	public void writeView() throws Exception{
		logger.info("writeView");
		
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/board/write", method = {RequestMethod.GET, RequestMethod.POST})
	public String write(
			BoardVO boardVO,
			MultipartHttpServletRequest mpRequest
		) throws Exception{
		logger.info("write");
		
		/*
		 * //uuid 생성 String id = UUID.randomUUID().toString();
		 * System.out.println("UUID Value: " + id);
		 * 
		 * boardVO.setUuid(id);
		 */
				
		service.write(boardVO, mpRequest);
		
		return "redirect:/board/list";
	}
	

	// 게시판 수정뷰
	@RequestMapping(value = "/answerView",  method = {RequestMethod.GET, RequestMethod.POST})
	public String answerView(BoardVO boardVO, Model model) throws Exception{
		logger.info("answerView");
				
//		BoardVO Vo = service.read(boardVO.getBno());
		
		
		model.addAttribute("answer", service.read(boardVO.getBno()));
				
		return "board/answerView";
	}
			
	// 게시판 답글 작성
	@RequestMapping(value = "/board/answer",  method = {RequestMethod.GET, RequestMethod.POST})
	public String answer(
			BoardVO boardVO,
			MultipartHttpServletRequest mpRequest
		) throws Exception{
		logger.info("answer");
			
		service.answer(boardVO, mpRequest);
				
		return "redirect:/board/list";
	}


	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list");
		
		System.out.println("scri :" + scri);
		
		model.addAttribute("list", service.list(scri));
		int totalCount = service.listCount(scri);
		// model.addAttribute("totalCount", totalCount); //ordernum 정렬 떄문에 만들었음 // bno2가 있어서 이제는 필요가 없다!
		
		
			
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(totalCount); //서비스에 게시물 총 갯수 totalcount담아서 pagemaker로
			
		model.addAttribute("pageMaker", pageMaker);
			
		return "board/list";
			
		}
	
	
	// 게시판 조회
	@RequestMapping(value = "/readView",  method = {RequestMethod.GET, RequestMethod.POST})
	public String read(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("read");
		

		BoardVO vo = service.read(boardVO.getBno());
		
		//치환 - get으로 먼저 가져와서 바꿔주고 다시 set으로 넣어줘야 함
		//vo.getContent().replaceAll("\n", "<br/>");
		vo.setContent(vo.getContent().replaceAll("\n", "<br/>"));
		
		model.addAttribute("read", vo);
		
//		model.addAttribute("read", service.read(boardVO.getUuid()));
		
		model.addAttribute("rnum", boardVO.getRnum());
		
		
		//댓글은 게시물에 종속되어 있으므로 따로 controller 없이 조회 부분에!
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno());
		model.addAttribute("replyList", replyList);
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);

		return "board/readView";
		}
	
	
	// 게시판 수정뷰
	@RequestMapping(value = "/updateView",  method = {RequestMethod.GET, RequestMethod.POST})
	public String updateView(BoardVO boardVO, Model model) throws Exception{
		logger.info("updateView");
			
		model.addAttribute("update", service.read(boardVO.getBno()));
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		return "board/updateView";
		}
		
	// 게시판 수정
		@RequestMapping(value = "/update", method = RequestMethod.POST)
		public String update(
				BoardVO boardVO, 
//				 @ModelAttribute("scri") SearchCriteria scri, 
//				 RedirectAttributes rttr,
				@RequestParam(name = "fileNoDel[]", required = false) List<Integer> fileNoDel,
				 MultipartHttpServletRequest mpRequest
			 ) throws Exception {
			logger.info("update");
			
			//fileNoDel가 null일(required = false //optional) 가능성이 있기 때문에 if문으로 한번 감싸줘서 체크가 필요함
			if(fileNoDel != null) {
				for (Integer file_no : fileNoDel) {
					service.deleteFile(file_no);
				}
			}
			
			/*
			 * for (int i = 0; fileNoDel != null && i < fileNoDel.size(); i++) { Integer
			 * file_no = fileNoDel.get(i); service.deleteFile(file_no); }
			 */
			
			service.update(boardVO, mpRequest);

//			rttr.addAttribute("page", scri.getPage());
//			rttr.addAttribute("perPageNum", scri.getPerPageNum());
//			rttr.addAttribute("searchType", scri.getSearchType());
//			rttr.addAttribute("keyword", scri.getKeyword());
//
//			return "redirect:/board/list";
			return "redirect:/board/list";
		}
		
	// 게시판 첨부 파일 삭제
	@RequestMapping(value = "/deleteFile",  method = {RequestMethod.POST})
	@ResponseBody
	public boolean deleteFile(int file_no) throws Exception {
		boolean result = service.deleteFile(file_no);
		return result;
	}
		
	// 게시판 삭제
	@RequestMapping(value = "/delete",  method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(ReplyVO replyVO) throws Exception{
		logger.info("delete");
				
		System.out.println("rrrrrrrrrr -> " + replyVO.toString());
		
		service.delete(replyVO);
				
		return "redirect:/board/list";
		}

		
	// 비밀번호 체크
	@RequestMapping(value = "/pwcheck",  method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> pwcheck(BoardVO boardVO, Model model) throws Exception{
		
		System.out.println("vo:" + boardVO.toString());
		
		// 1. 내가 입력한 비밀번호를 구한다.
		String pw = boardVO.getPw(); // 얘는 잘 읽어짐
		
		// 2. bno 정보를 이용하여, 게시판 정보를 불러온다.
		int bno = boardVO.getBno(); // 문제: bno가 0으로 온다... 
		BoardVO vo = service.pwcheck(bno);

		// 3. DB에 있는 비밀번호(2.)와 입력한 비밀번호(1.)를 비교하여, 판별한다.
		System.out.println("vo: " + vo.getPw());
		Map<String, Object> map = new HashMap<String, Object>();	
		if(vo.getPw().equals(pw)) {
			model.addAttribute("pwcheck", true);
			map.put("pwcheck", true);
		} else {
			model.addAttribute("pwcheck",false);
			map.put("pwcheck", false);
		}
		
		return map;
	}
	
	

	/*
	 * // 리스트 조회
	 * 
	 * @RequestMapping(value = "/replyList", method = RequestMethod.GET) public
	 * String replyList(Model model, @ModelAttribute("scri") ReplySearchCriteria
	 * scri) throws Exception{ logger.info("replyList");
	 * 
	 * model.addAttribute("replyList", service.replyList(scri));
	 * 
	 * ReplyPageMaker replyPageMaker = new ReplyPageMaker();
	 * replyPageMaker.setRcri(scri);
	 * replyPageMaker.setTotalCount(service.replylistCount(scri)); //서비스에 게시물 총 갯수
	 * totalcount담아서 pagemaker로
	 * 
	 * model.addAttribute("replyPageMaker", replyPageMaker);
	 * 
	 * return "board/answerView";
	 * 
	 * }
	 */
	

	//댓글 작성
	//RedirectAttributes는 redirect 했을 때 값들을 물고 이동 
	// └> 그래서 SearchCriteria의 값을 넣어서 댓글을 저장 한 뒤 원래 페이지로 redirect하여 이동
	@RequestMapping(value="/replyWrite",  method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.writeReply(vo);
			
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		Map<String, Object> map = new HashMap<String, Object>();	
		
		return map;
	}
	
	
	
	//댓글 수정 GET
	@RequestMapping(value="/replyUpdateView",method = {RequestMethod.GET, RequestMethod.POST})
	public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
			
		model.addAttribute("replyUpdate", replyService.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
			
		return "board/replyUpdateView";
	}
		
	//댓글 수정 POST
	//컨트롤러의 메서드는 이름 지어준 기능을 하도록 만든다 따라서, 이름 밖에 있는 기능은 여기서 해 주지 않는다 따로 만들어준다
	@RequestMapping(value="/replyUpdate", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> replyUpdate(ReplyVO replyVO, SearchCriteria scri, RedirectAttributes rttr, Model model) throws Exception {
		logger.info("reply Write");
			
		//비밀번호 비교
		// 1. 내가 입력한 비밀번호를 구한다.
		String pw = replyVO.getPw(); // 얘는 잘 읽어짐
		System.out.println("View PW -> " +pw);
				
		// 2. rno 정보를 이용하여, 게시판 정보를 불러온다.
		int rno = replyVO.getRno(); // 문제: bno가 0으로 온다... 
		
		System.out.println("View rno -> " +rno);
		
		ReplyVO vo = replyService.pwcheck(rno);

		System.out.println("ReplyVO vo -> " +vo.toString());
		
		// 3. DB에 있는 비밀번호(2.)와 입력한 비밀번호(1.)를 비교하여, 판별한다.
		System.out.println("vo: " + vo.getPw());
		Map<String, Object> map = new HashMap<String, Object>();	
		if(vo.getPw().equals(pw)) {
			model.addAttribute("pwcheck", true);
			map.put("pwcheck", true);
		
			replyService.updateReply(replyVO);
		
		} else {
			model.addAttribute("pwcheck",false);
			map.put("pwcheck", false);
		}
				
		
		
		/* replyService.updateReply(replyVO); */
		
			
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		
		
		return map;
	}
	
	
	
	//댓글 삭제 GET
	@RequestMapping(value="/replyDeleteView",method = {RequestMethod.GET, RequestMethod.POST})
	public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
		
		model.addAttribute("replyDelete", replyService.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
		

		return "board/replyDeleteView";
	}
	
	//댓글 삭제 POST
	@RequestMapping(value="/replyDelete", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> replyDelete(ReplyVO replyVO, SearchCriteria scri, RedirectAttributes rttr, Model model) throws Exception {
		logger.info("reply Write");
		
		//비밀번호 비교
		// 1. 내가 입력한 비밀번호를 구한다.
		String pw = replyVO.getPw(); // 얘는 잘 읽어짐
		System.out.println("View PW -> " +pw);
						
		// 2. rno 정보를 이용하여, 게시판 정보를 불러온다.
		int rno = replyVO.getRno(); // 문제: bno가 0으로 온다... 
				
		System.out.println("View rno -> " +rno);
				
		ReplyVO vo = replyService.pwcheck(rno);

		System.out.println("ReplyVO vo -> " +vo.toString());
				
		// 3. DB에 있는 비밀번호(2.)와 입력한 비밀번호(1.)를 비교하여, 판별한다.
		System.out.println("vo: " + vo.getPw());
		Map<String, Object> map = new HashMap<String, Object>();	
		if(vo.getPw().equals(pw)) {
			model.addAttribute("pwcheck", true);
			map.put("pwcheck", true);
		
			replyService.deleteReply(replyVO);
		
		} else {
			model.addAttribute("pwcheck",false);
			map.put("pwcheck", false);
		}
				

		
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return map;
	}	
	
	
	// 댓글 비밀번호 체크
	@RequestMapping(value = "/replyPwcheck",  method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> replyPwcheck(ReplyVO replyVO, Model model) throws Exception{
		
		System.out.println("vo:" + replyVO.toString());
		
		//비밀번호 비교
		// 1. 내가 입력한 비밀번호를 구한다.
		String pw = replyVO.getPw(); // 얘는 잘 읽어짐
		System.out.println("View PW -> " +pw);
				
		// 2. rno 정보를 이용하여, 게시판 정보를 불러온다.
		int rno = replyVO.getRno(); 
		
		System.out.println("View rno -> " +rno);
		
		ReplyVO vo = replyService.pwcheck(rno);

		System.out.println("ReplyVO vo -> " +vo.toString());
		
		// 3. DB에 있는 비밀번호(2.)와 입력한 비밀번호(1.)를 비교하여, 판별한다.
		System.out.println("vo: " + vo.getPw());
		Map<String, Object> map = new HashMap<String, Object>();	
		if(vo.getPw().equals(pw)) {
			model.addAttribute("pwcheck", true);
			map.put("pwcheck", true);

		} else {
			model.addAttribute("pwcheck",false);
			map.put("pwcheck", false);
		}
				
		return map;
	}
		
	
	//파일 다운로드	
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\mp\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	
	@GetMapping("/excel/download")
    public void excelDownload(
    		HttpServletResponse response,
    		@ModelAttribute("scri") SearchCriteria scri //얘 때문에 주소값 파라미터가 안 들어오니까 그냥 싹 다 다운이 됐던 것!
		) throws Exception {
//        Workbook wb = new HSSFWorkbook();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        
        //sheet 컬럼마다 너비 구하기 excel poi - index는 0부터 시작함
        sheet.setColumnWidth(1, 24000); //제목 셀 길게 하기 위함
        sheet.setColumnWidth(3, 3000); //등록일 셀 다 안 보여서 조금 늘림
        //sheet.setDefaultColumnWidth(20); // sheet 전체 고정 너비 구하기
        
		/*
		 * //poi cellstyle 기능이긴 한데,, 안 됨 ㅠ CellStyle mergeRowStyle1 =
		 * wb.createCellStyle(); // cell style 선언
		 * mergeRowStyle1.setBorderTop(BorderStyle.THICK);
		 * mergeRowStyle1.setBorderLeft(BorderStyle.MEDIUM_DASH_DOT_DOT);
		 */
        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("제목");
        cell = row.createCell(2);
        cell.setCellValue("작성자");
        cell = row.createCell(3);
        cell.setCellValue("등록일");
        
		/*
		 * SearchCriteria scri = new SearchCriteria(); scri.setPerPageNum(10000);
		 */
        
        //setPerPageNum(10000)을  안 해주게 되면, 단지 보이는만큼만 엑셀로 다운이 되기 떄문에 해 줌
        //setPage(1)도 안 해 주면, 보이는 페이지만! 다운이 됨, 1을 해 줘야 1페이지부터 10000페이지까지 모두 다운이 됨(검색된 키워드로)
        scri.setPage(1);
        scri.setPerPageNum(10000);
        
        // List<BoardVO> list = service.excelList(scri);
       List<BoardVO> list = service.list(scri);
        
        // int totalCount = service.listCount(scri);
       
		/* String delete_yn = */
       
		/*
		 * cell = row.createCell(1); 
		 * cell.setCellValue(new Date());
		 */
       
       
        // Body
        for (BoardVO boardVO : list) {
        	// boolean isDeleted = (boardVO.getDelete_yn().equals("Y"));
        	// boolean isDeleted = ("Y".equals(boardVO.getDelete_yn()));
			/*
			 * boolean isDeleted = boardVO.isDeleted(); if (isDeleted) { continue; //early
			 * return }
			 */
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            // cell.setCellValue(totalCount - boardVO.getRrnum() + 1); // ${totalCount - list.rrnum + 1}
            cell.setCellValue(boardVO.getBno2());
            
            cell = row.createCell(1);
            cell.setCellValue(boardVO.getTitleView()); //${'Y' eq list.delete_yn && 0 eq list.parent_bno}
            
            cell = row.createCell(2);
            cell.setCellValue(boardVO.getWriter());
            
            CellStyle cellStyle = wb.createCellStyle();
            CreationHelper createHelper = wb.getCreationHelper();
            cellStyle.setDataFormat(
                createHelper.createDataFormat().getFormat("m/d/yy"));
            
            cell = row.createCell(3);
			cell.setCellValue(boardVO.getRegdate()); // <fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/> 
			/* cell.setCellValue(new Date()); */
            cell.setCellStyle(cellStyle);
        }

        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        // response.setHeader("Content-Disposition", "attachment;filename=example.xls");
        response.setHeader("Content-Disposition", "attachment;filename=excelList.xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }
	
	
	
	
	
	
	
	
	
	
}