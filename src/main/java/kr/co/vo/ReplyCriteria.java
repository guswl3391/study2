package kr.co.vo;

public class ReplyCriteria {

	private int page;
	private int perPageNum; 
	private int rowStart; 
	private int rowEnd;
	
	public ReplyCriteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public void setPage(int page) { //음수나 0이면 그 페이지는 무조건 1로 리턴
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {  
		if (perPageNum <= 0 || perPageNum > 100) { //안전 장치 의도되지 않은 상황이 발생할 수 있으므로 걸어둠
			this.perPageNum = 10; // 
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
		
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1; //페이지 번호가 1이라면: 1-->1, 2-->11, 3-->21
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = page * perPageNum; //1-->10, 2-->20, 3-->30 rowstart와 관계 없이 진행이 가능하다
		return rowEnd;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	
	
}
