package com.buzzybrains.wrapper;

import java.util.List;

import com.buzzybrains.model.Claim;
import com.buzzybrains.model.ClaimItems;

public class ClaimWrapper {
	
	private Claim claim;
	private List<ClaimItems> claimItems;
	
	public List<ClaimItems> getClaimItems() {
		return claimItems;
	}
	public void setClaimItems(List<ClaimItems> claimItems) {
		this.claimItems = claimItems;
	}
	
	public Claim getClaim() {
		return claim;
	}
	public void setClaim(Claim claim) {
		this.claim = claim;
	}
	
	
	
	

}
