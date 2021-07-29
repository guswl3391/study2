package kr.co.vo;

import java.util.Date;

public class BoardVO {

	// private String uuid;
	private int bno;
	private int bno2; //정렬 위해서 만들었음 boardMapper 참고 NVL(U.bno2, 0) as bno2
	private int parent_bno;
	private int depth;
	private int nextdepth;
	
	private int sort;
	private String title;
	private String content;
	private String writer;
	private String pw;
	
	private Date regdate;
	private int rnum;
	private int reply_cnt;
	private String delete_yn;
	private String boardYN;
	
	private int ordernum;
	private int rrnum;
	private String file_yn;

	public BoardVO() {
		super();
	}

	

	public BoardVO(int bno, int bno2, int parent_bno, int depth, int nextdepth,
			int sort, String title, String content, String writer, String pw,
			Date regdate, int rnum, int reply_cnt, String delete_yn, String boardYN,
			int ordernum, int rrnum, String file_yn) {
		super();
		
		this.bno = bno;
		this.bno2 = bno2;
		this.parent_bno = parent_bno;
		this.depth = depth;
		this.nextdepth = nextdepth;
		
		this.sort = sort;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.pw = pw;
		
		this.regdate = regdate;
		this.rnum = rnum;
		this.reply_cnt = reply_cnt;
		this.delete_yn = delete_yn;
		this.boardYN = boardYN;
		
		this.ordernum = ordernum;
		this.rrnum = rrnum;
		this.file_yn = file_yn;
	}



	// public int getBno2() {
	public String getBno2() {
		return (bno2 > 0) ? Integer.toString(bno2) : "▶"; // 모델 안에서 뷰의 처리를 하고 있다! // 예외상황: 뷰의 종류가 하나 더 있을 경우
	}

	public void setBno2(int bno2) {
		this.bno2 = bno2;
	}

	public int getRrnum() {
		return rrnum;
	}

	public void setRrnum(int rrnum) {
		this.rrnum = rrnum;
	}

	public int getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getBoardYN() {
		return boardYN;
	}

	public void setBoardYN(String boardYN) {
		this.boardYN = boardYN;
	}

	public int getReply_cnt() {
		return reply_cnt;
	}

	public void setReply_cnt(int reply_cnt) {
		this.reply_cnt = reply_cnt;
	}

	public int getNextdepth() {
		return nextdepth;
	}

	public void setNextdepth(int nextdepth) {
		this.nextdepth = nextdepth;
	}

	public int getParent_bno() {
		return parent_bno;
	}

	public void setParent_bno(int parent_bno) {
		this.parent_bno = parent_bno;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {  // 모델 안에서 뷰의 처리를 하고 있다! // 예외상황: 뷰의 종류가 하나 더 있을 경우 // 문제: list가 아니라 상세에서도 같은 모델을 보는 다른 뷰가 있었음 -> 여기서 모델을 조회해 오는 곳이 달랐다 -> 
		if ("N".equals(delete_yn)) {
			return title;
			
		} else { // 삭제 
			if (parent_bno == 0) { // 원글
				return "== 원글이 삭제되었습니다. ==";
				
			} else { // 답글
				return "== 답글이 삭제되었습니다. ==";
			}
		}
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getFile_yn() {
		return file_yn;
	}


	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", bno2=" + bno2 + ", parent_bno=" + parent_bno + ", depth=" + depth
				+ ", nextdepth=" + nextdepth + ", sort=" + sort + ", title=" + title + ", content=" + content
				+ ", writer=" + writer + ", pw=" + pw + ", regdate=" + regdate + ", rnum=" + rnum + ", reply_cnt="
				+ reply_cnt + ", delete_yn=" + delete_yn + ", boardYN=" + boardYN + ", ordernum=" + ordernum
				+ ", rrnum=" + rrnum + "]";
	}

	
	public boolean isDeleted() {
		return ("Y".equals(delete_yn));
	}
}
