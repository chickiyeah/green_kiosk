package menu;

public class Menu_menu_Bean {
	
	private int menu_no;           //순서
	private String menu_name;      //메뉴 이름
	private String menu_gubn;	   //메뉴 카테고리 구분
	private int menu_isSale;       //행사 메뉴 분류
	private String menu_imgPath;   //메뉴 이미지 경로
	private String menu_component; //관련 메뉴 재료 번호 ","로 구분
	private int menu_price;        //메뉴가격
	private int menu_sell_amount;  //메뉴의 판매 수량
	private int menu_recommend;    //추천 메뉴 분류
	private String menu_content;   //메뉴에 대한 설명
	private  int menu_isUse;           
	private int menu_couponable; //메뉴 쿠폰 사용 여부 
	
	public int getMenu_no() {
		return menu_no;
	}
	public void setMenu_no(int menu_no) {
		this.menu_no = menu_no;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_gubn() {
		return menu_gubn;
	}
	public void setMenu_gubn(String menu_gubn) {
		this.menu_gubn = menu_gubn;
	}
	public int getMenu_isSale() {
		return menu_isSale;
	}
	public void setMenu_isSale(int menu_isSale) {
		this.menu_isSale = menu_isSale;
	}
	public String getMenu_imgPath() {
		return menu_imgPath;
	}
	public void setMenu_imgPath(String menu_imgPath) {
		this.menu_imgPath = menu_imgPath;
	}
	public String getMenu_component() {
		return menu_component;
	}
	public void setMenu_component(String menu_component) {
		this.menu_component = menu_component;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	public int getMenu_sell_amount() {
		return menu_sell_amount;
	}
	public void setMenu_sell_amount(int menu_sell_amount) {
		this.menu_sell_amount = menu_sell_amount;
	}
	public int getMenu_recommend() {
		return menu_recommend;
	}
	public void setMenu_recommend(int menu_recommend) {
		this.menu_recommend = menu_recommend;
	}
	public String getMenu_content() {
		return menu_content;
	}
	public void setMenu_content(String menu_content) {
		this.menu_content = menu_content;
	}
	public int getMenu_isUse() {
		return menu_isUse;
	}
	public void setMenu_isUse(int menu_isUse) {
		this.menu_isUse = menu_isUse;
	}
	public int getMenu_couponable() {
		return menu_couponable;
	}
	public void setMenu_couponable(int menu_couponable) {
		this.menu_couponable = menu_couponable;
	}
	
	
	
}
