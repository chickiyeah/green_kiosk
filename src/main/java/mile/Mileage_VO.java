package mile;

public class Mileage_VO {
	  private String index;
	  private int mileage;
	  private String value;
	  private String type;
		public Mileage_VO(String index, int mileage, String value, String type) {
			super();
			this.index = index;
			this.mileage = mileage;
			this.value = value;
			this.type = type;
		}
		  
	public String getIndex() {
		return index;
	}
	public int getMileage() {
		return mileage;
	}
	public String getValue() {
		return value;
	}
	public String getType() {
		return type;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public void setType(String type) {
		this.type = type;
	}
}
