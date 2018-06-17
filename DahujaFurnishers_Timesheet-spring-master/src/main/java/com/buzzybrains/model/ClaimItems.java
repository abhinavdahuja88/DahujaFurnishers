package com.buzzybrains.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "claim_items")
public class ClaimItems {

	public ClaimItems()
	{
				
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int claimItemId;
	private String description;
	private String category;
	private int cost;
	private int claimId;
	public int getClaimId() {
		return claimId;
	}
	public void setClaimId(int claimId) {
		this.claimId = claimId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	private Date expenseDate;
	public int getClaimItemId() {
		return claimItemId;
	}
	public void setClaimItemId(int claimItemId) {
		this.claimItemId = claimItemId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public Date getExpenseDate() {
		return expenseDate;
	}
	public void setExpenseDate(Date expenseDate) {
		this.expenseDate = expenseDate;
	}
	
	
	
	
	
	
}
