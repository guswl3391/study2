package kr.co.vo;

import java.util.Date;

public class BoardVO {

	//private String uuid;
	private int bno;
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
	
	public BoardVO() {
		super();
	}

	

	
	
	

	






	public BoardVO(int bno, int parent_bno, int depth, int nextdepth, int sort, String title, String content,
			String writer, String pw, Date regdate, int rnum, int reply_cnt, String delete_yn, String boardYN,
			int ordernum, int rrnum) {
		super();
		this.bno = bno;
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

	public String getTitle() {
		return title;
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














	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", parent_bno=" + parent_bno + ", depth=" + depth + ", nextdepth=" + nextdepth
				+ ", sort=" + sort + ", title=" + title + ", content=" + content + ", writer=" + writer + ", pw=" + pw
				+ ", regdate=" + regdate + ", rnum=" + rnum + ", reply_cnt=" + reply_cnt + ", delete_yn=" + delete_yn
				+ ", boardYN=" + boardYN + ", ordernum=" + ordernum + ", rrnum=" + rrnum + "]";
	}








	
	
}
