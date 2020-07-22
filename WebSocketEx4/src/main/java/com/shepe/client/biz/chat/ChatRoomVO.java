package com.shepe.client.biz.chat;

import java.sql.Date;

public class ChatRoomVO {
	
	private String userid;
	private int chatroomnum;
	private int chatcomplete;
	private String chatsubject;
	private Date chatdate;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getChatroomnum() {
		return chatroomnum;
	}
	public void setChatroomnum(int chatroomnum) {
		this.chatroomnum = chatroomnum;
	}
	public int getChatcomplete() {
		return chatcomplete;
	}
	public void setChatcomplete(int chatcomplete) {
		this.chatcomplete = chatcomplete;
	}
	public String getChatsubject() {
		return chatsubject;
	}
	public void setChatsubject(String chatsubject) {
		this.chatsubject = chatsubject;
	}
	public Date getChatdate() {
		return chatdate;
	}
	public void setChatdate(Date chatdate) {
		this.chatdate = chatdate;
	}
}
