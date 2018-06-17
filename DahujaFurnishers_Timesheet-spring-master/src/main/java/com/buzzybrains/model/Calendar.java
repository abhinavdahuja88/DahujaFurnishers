package com.buzzybrains.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "calendar")
public class Calendar {
	
	public Calendar()
	{
		
	}
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name = "calendar_id")	
	private int id;

	@Temporal(TemporalType.DATE)
	private Date start;
	private String title;
	private int employeeId;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getStart() {
		return start;
	}
	public void setStart(Date start) {
		this.start = start;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getEmployeeID() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	
	

}
