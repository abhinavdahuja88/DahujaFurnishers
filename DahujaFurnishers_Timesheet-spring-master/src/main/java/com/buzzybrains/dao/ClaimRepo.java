package com.buzzybrains.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.Claim;

public interface ClaimRepo extends CrudRepository<Claim, Integer>{

	

	@Query(value="SELECT * FROM claim  where user_id=?1 order by 1 desc", nativeQuery = true)
	List<Claim> findClaimListByuserId(int userid);
	
	
	
	
}
