package model.item;
import java.util.*;
public class ItemDto {
	private int item_no; //p.k
	private String item_seller; //판매자
	private String item_name; //상품명
	private int item_price;
	private String item_detail; //설명
	private String item_area; //지역
	private Date item_regdate; //날짜
	private String item_image; //이미지 파일 이름
	
	//getter,setter
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public String getItem_seller() {
		return item_seller;
	}
	public void setItem_seller(String item_seller) {
		this.item_seller = item_seller;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public String getItem_detail() {
		return item_detail;
	}
	public void setItem_detail(String item_detail) {
		this.item_detail = item_detail;
	}
	public String getItem_area() {
		return item_area;
	}
	public void setItem_area(String item_area) {
		this.item_area = item_area;
	}
	public Date getItem_regdate() {
		return item_regdate;
	}
	public void setItem_regdate(Date item_regdate) {
		this.item_regdate = item_regdate;
	}
	public String getItem_image() {
		return item_image;
	}
	public void setItem_image(String item_image) {
		this.item_image = item_image;
	}
}
