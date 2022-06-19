package model.board;
import java.sql.Timestamp;

public class AskBoardDto {

	private int ask_num;
	private String ask_writer;
	private String ask_subject;
	private String ask_content;
	private Timestamp ask_regdate;
	private int ask_ref;
	private int ask_relevel;
	private int ask_restep;
	
	// getters and setters
	public int getAsk_num() {
		return ask_num;
	}
	public void setAsk_num(int ask_num) {
		this.ask_num = ask_num;
	}
	public String getAsk_writer() {
		return ask_writer;
	}
	public void setAsk_writer(String ask_writer) {
		this.ask_writer = ask_writer;
	}
	public String getAsk_subject() {
		return ask_subject;
	}
	public void setAsk_subject(String ask_subject) {
		this.ask_subject = ask_subject;
	}
	public String getAsk_content() {
		return ask_content;
	}
	public void setAsk_content(String ask_content) {
		this.ask_content = ask_content;
	}
	public Timestamp getAsk_regdate() {
		return ask_regdate;
	}
	public void setAsk_regdate(Timestamp ask_regdate) {
		this.ask_regdate = ask_regdate;
	}
	public int getAsk_ref() {
		return ask_ref;
	}
	public void setAsk_ref(int ask_ref) {
		this.ask_ref = ask_ref;
	}
	public int getAsk_relevel() {
		return ask_relevel;
	}
	public void setAsk_relevel(int ask_relevel) {
		this.ask_relevel = ask_relevel;
	}
	public int getAsk_restep() {
		return ask_restep;
	}
	public void setAsk_restep(int ask_restep) {
		this.ask_restep = ask_restep;
	}
	
}//class-end
