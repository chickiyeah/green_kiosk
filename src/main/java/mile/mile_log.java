package mile;

public class mile_log {

	private int mile_no; 			// 변동기록번호
	private String mile_uid; 		// 변동이 생긴 유저의 고유번호
	private String mile_type; 		// 종류
	private String mile_reason; 	// 변동이 생긴 이유
	private int mile_deff; 		// 마일리지 변동 양

	public int getMile_no() {

		return mile_no;
	}

	public void setMile_no(int mile_no) {
		this.mile_no = mile_no;
	}

	public String getMile_uid() {
		return mile_uid;
	}

	public void setMile_uid(String mile_uid) {
		this.mile_uid = mile_uid;
	}

	public String getMile_type() {
		return mile_type;
	}

	public void setMile_type(String mile_type) {
		this.mile_type = mile_type;
	}

	public String getMile_reason() {
		return mile_reason;
	}

	public void setMile_reason(String mile_reason) {
		this.mile_reason = mile_reason;
	}

	public int getMile_deff() {
		return mile_deff;
	}

	public void setMile_deff(int mile_deff) {
		this.mile_deff = mile_deff;
	}

}
