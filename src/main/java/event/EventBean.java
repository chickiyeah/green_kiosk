package event;

import java.sql.Timestamp;

public class EventBean {
	private int event_no;
	private String event_name;
    private Timestamp event_issueDate;
    private Timestamp event_expireDate;
    private Timestamp event_limitTime1;
    private Timestamp event_limitTime2;
	public int getEvent_no() {
		return event_no;
	}
	public String getEvent_name() {
		return event_name;
	}
	public Timestamp getEvent_issueDate() {
		return event_issueDate;
	}
	public Timestamp getEvent_expireDate() {
		return event_expireDate;
	}
	public Timestamp getEvent_limitTime1() {
		return event_limitTime1;
	}
	public Timestamp getEvent_limitTime2() {
		return event_limitTime2;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}
	public void setEvent_issueDate(Timestamp event_issueDate) {
		this.event_issueDate = event_issueDate;
	}
	public void setEvent_expireDate(Timestamp event_expireDate) {
		this.event_expireDate = event_expireDate;
	}
	public void setEvent_limitTime1(Timestamp event_limitTime1) {
		this.event_limitTime1 = event_limitTime1;
	}
	public void setEvent_limitTime2(Timestamp event_limitTime2) {
		this.event_limitTime2 = event_limitTime2;
	}
	
}
