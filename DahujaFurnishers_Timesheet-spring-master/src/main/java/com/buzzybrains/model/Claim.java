package com.buzzybrains.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity(name = "claim")
public class Claim {

	public Claim() {

	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int claimId;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date start;
	@Temporal(TemporalType.TIMESTAMP)
	private Date end;
	private String manager;
	private String department;
	private String purpose;
	private int advance;
	private int userId;
	private int totalReimbursement;
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Transient
	private List<ClaimItems> claimItems;

	public List<ClaimItems> getClaimItems() {
		return claimItems;
	}

	public void setClaimItems(List<ClaimItems> claimItems) {
		this.claimItems = claimItems;
	}

	public int getClaimId() {
		return claimId;
	}

	public void setClaimId(int claimId) {
		this.claimId = claimId;
	}

	
	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public int getAdvance() {
		return advance;
	}

	public void setAdvance(int advance) {
		this.advance = advance;
	}

	public int getTotalReimbursement() {
		return totalReimbursement;
	}

	public void setTotalReimbursement(int totalReimbursement) {
		this.totalReimbursement = totalReimbursement;
	}



}
