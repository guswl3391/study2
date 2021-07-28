package kr.co.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class ReplyPageMaker {
	private int totalCount; // 전체 게시글 수
	private int startPage; // 첫 페이지
	private int endPage; // 끝 페이지
	private int prev; // 이전 페이지 리스트 블럭의 마지막 페이지 
	private int next; // 다음 페이지 리스트 블럭의 처음 페이지
	private int displayPageNum = 10; // 한 페이지에 10개의 글 수 (행의 수)
	private int curPage; // 현재 페이지
	private int startPageList; // 페이지 리스트의 시작
	private int endPageList; // 페이지 리스트의 끝
	private int pageListSize = 10; // 페이지 리스트의 크기
	
	
	/*
	 * private int startIndex = 0; // 
	 * 시작 index private int curRange = 1; // 현재 블럭
	 * private int pageCnt; // 총 페이지 수
	 */
	
	private ReplyCriteria rcri; // Criteria 클래스 받아와야 함 (현재 페이지를 받아 와야 하므로)

	public void setCri(ReplyCriteria rcri) {
		this.rcri = rcri;
		
		this.curPage = rcri.getPage(); //현재 페이지를 가지고 온다, 브라우저에 찍힌(쿼리스트링) 페이지 번호 -> SEARCHCRI로 오고 -> PAGEMAKER로 옴
		calcData();
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount; //전체 글의 수
		calcData();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	
	
	
	public int getStartPageList() {
		return startPageList;
	}

	public void setStartPageList(int startPageList) {
		this.startPageList = startPageList;
	}

	public int getEndPageList() {
		return endPageList;
	}

	public void setEndPageList(int endPageList) {
		this.endPageList = endPageList;
	}

	public int getPageListSize() {
		return pageListSize;
	}

	public void setPageListSize(int pageListSize) {
		this.pageListSize = pageListSize;
	}

	public int getPrev() {
		return prev;
	}

	public int getNext() {
		return next;
	}

	public int isPrev() {
		return prev;
	}

	public int isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;

		calcData();
	}

	/*
	 * public int getCurRange() { return curRange; }
	 * 
	 * public void setCurRange(int curRange) { this.curRange = curRange; }
	 * 
	 * public int getStartIndex() { return startIndex; }
	 * 
	 * public void setStartIndex(int startIndex) { this.startIndex = startIndex; }
	 */

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public void setPrev(int prev) {
		this.prev = prev;
	}

	public void setNext(int next) {
		this.next = next;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}



	/*
	 * public int getPageCnt() { return pageCnt; }
	 * 
	 * public void setPageCnt(int pageCnt) { this.pageCnt = pageCnt; }
	 */

	
	
	public ReplyCriteria getRcri() {
		return rcri;
	}

	public void setRcri(ReplyCriteria rcri) {
		this.rcri = rcri;
	}

	private void calcData() {
		startPage = 1; //첫 페이지
		endPage = totalCount / displayPageNum; //끝 페이지
		int remainder1 = totalCount % displayPageNum; //나머지
		
		//나머지가 0보다 크면 끝페이지에 1을 더해줌 --> 나머지가 0보다 큰 애들은 다음 페이지로 넘어가야 하니까!
		//ex) 전체 글 18개면 displayPageNum으로 나눠주면 끝 page는 당연히 2page(10개, 8개) 단순 나눠주는 걸로 계산하면 몫은 1 나머지는 2임 몫에다가 1을 더해주면 2가 나오는데 이게 바로 endpage가 되는 것
		if(remainder1 > 0) { 
			endPage++; // endPage = endPage + 1;
		}
		
		//페이지 리스트의 시작 구하기
		startPageList = curPage / pageListSize;  // 1. startPageList는 페이지리스트 단위로 현재 페이지를 나눈 몫
		// 1-1) 나누기 이유: 하나의 set로 묶기 위해서(그룹핑하기 위해서) - 몫을 구하는 이유는 결국 자연수로 그룹핑을 할 수 있으므로!
		// 1-2) if문으로 할 경우에는 범위가 정해져 있어야 가능함, 범위가 얼마나 늘어날지는 아무도 모르므로 하나의 공식이 필요함!
		// 1-3) 좌항: 변수 / 우항: 값
		
		int remainder2 = curPage % pageListSize; // 2. remainder2 라는 변수에 페이지리스트단위로 현재 페이지를 나눈 나머지 값을 넣어줌
		if (remainder2 == 0) {					 // 3. 만약 remainder2 변수가 0이면 1번에서 구한 몫에서 1을 빼줘라			
			startPageList--; // startPageList = startPageList - 1;
		}
		
		//!페이지 리스트의 시작 부분 구하는 공식!
		startPageList = startPageList * pageListSize + 1; // 4. startPageList는 위에서 내려온 startPageList(1번의 몫)에 *10(pageListSize)을 하고 1을 더해라
		// 4-1) startPageList = 그룹핑을 위한 자연수 * 10(10개 단위로 묶기 위한 단위) +1;
		
		//페이지 리스트의 끝 구하기
		endPageList = startPageList + 9; //endPageList는 startPageList에 9를 더해라!
		if (endPageList > endPage) {  //예를 들어 1~9 페이지라는 예외가 있기 때문에 조건문 걸어둠 
			endPageList = endPage;	  //11페이지 12페이지 같은 경우도 마찬가지임 endpage가 12페이지면 startPageList는 11페이지+9=20 --> endpageList(20) > 12 --> 12=12; 
		}
		
		prev = startPageList - 1; //prev는 이전 페이지이니까 결국 페이지리스트에서 1을 빼면 바로 전 블럭으로 가는 것
		if (prev <= 0) {          //하지만 1페이지의 경우 0이 되어버리므로(0페이지라는 건 없음) 그러니까 prev를 1로 그냥 고정!!
			prev = 1;
		}
		
		next = endPageList + 1;  //next는 마지막 페이지에서 1을 더하면 다음 블럭으로 넘어 가니까 1을 더해야지!! 
		if (next > endPage) {    //예를 들어서 endpage가 10인데 next를 누르면 11로 가야 하지만(위에서 endpageList에 1을 더해버려서 11이 되어버림) endpage는 10에서 끝인 거임!!
			next = endPage;		 //결국 endpage인 10 값이 next의 값이 되는 거!! 결국 눌러도 그 자리 그대로 
		}
		
	}

	public String makeQuery(int page) {
		// Path나 query에 해당하는 문자열들을 추가해서 원하는 URI를 생성할 때 사용
		UriComponents uriComponents = UriComponentsBuilder.newInstance() // 여러 개의 파라미터들을 연결하여 URL 형태로 만들어 줌
				.queryParam("page", page).queryParam("perPageNum", rcri.getPerPageNum()).build();

		return uriComponents.toUriString();
	}

	public String makeSearch(int page) {
		//쿼리스트링: list?page=13&perPageNum=10&searchType=t&keyword=%EC%9C%84%ED%95%9C 영어 외의 문자들은(아스키코드가 아닌 것들) 인코딩을 거쳐야 한다
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("perPageNum", rcri.getPerPageNum())
				.queryParam("searchType", ((ReplySearchCriteria) rcri).getSearchType())
				.queryParam("keyword", encoding(((ReplySearchCriteria) rcri).getKeyword())).build();
		return uriComponents.toUriString();
	}

	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}

}