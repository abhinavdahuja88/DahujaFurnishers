package com.buzzybrains.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.ClaimItems;

public interface ClaimItemsRepo extends CrudRepository<ClaimItems, Integer> {

	
	

	@Query(value="SELECT * FROM claim_items  where claim_id=?1 order by 1 desc", nativeQuery = true)
	List<ClaimItems> findItemListByClaimId(int claimid);
	
	
}
