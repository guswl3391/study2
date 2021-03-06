package kr.co.vo;

import java.util.Date;

public class ReplyVO {

	private int bno;
	private int rno;
	private String content;
	private String writer;
	private String pw;
	private Date regdate;
	private String boardYN;

	
	
	
	public String getBoardYN() {
		return boardYN;
	}

	public void setBoardYN(String boardYN) {
		this.boardYN = boardYN;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
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
		return "ReplyVO [bno=" + bno + ", rno=" + rno + ", content=" + content + ", writer=" + writer + ", pw=" + pw
				+ ", regdate=" + regdate + ", boardYN=" + boardYN + "]";
	}


}
