package spring.model.team;

import org.springframework.web.multipart.MultipartFile;

public class TeamDTO {

	private int no;
	private String name;
	private String gender;
	private String phone;
	private String zipcode;
	private String address1;
	private String address2;

	private String hobby;
	private String filename;
	private MultipartFile fileMF;

	public MultipartFile getFileMF() {
		return fileMF;
	}

	public void setFileMF(MultipartFile fileMF) {
		this.fileMF = fileMF;
	}

	/**
	 * DB에서 SELECT한 결과를 저장하는 역할 setter DB에 skill배열을 문자열로 볁환하여 저장(INSERT, UPDATE)
	 * getter
	 */
	private String skillstr;
	/**
	 * createForm에서 입력받은 데이터를 받는다.
	 */
	private String[] skill;

	/**
	 * DB에 INSERT, UPDATE 할때 호출 DB에서 SELECT 한 결과를 JSP페이지에 출력할때 호출
	 */

	public String getSkillstr() {
		if (skill != null) {
			String skillstr = "";
			for (int i = 0; i < skill.length; i++) {
				skillstr += skill[i];
				if (i < skill.length - 1) {
					skillstr += ", ";
				}
			}
			this.skillstr = skillstr;
		}
		return skillstr;
	}

	public void setSkillstr(String skillstr) {
		this.skillstr = skillstr;
	}

	public String[] getSkill() {
		return skill;
	}

	public void setSkill(String[] skill) {
		this.skill = skill;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	/*
	 * public String getStr() { return str; }
	 * 
	 * public void setStr(String str) { this.str = str; }
	 */

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

}
