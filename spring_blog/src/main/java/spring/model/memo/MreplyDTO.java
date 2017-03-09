package spring.model.memo;

public class MreplyDTO {
	private int rnum;
	private String content;
	private String regdate;
	private int memono;
	private String id;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getMemono() {
		return memono;
	}
	public void setMemono(int memono) {
		this.memono = memono;
	}


}