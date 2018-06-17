package com.buzzybrains.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.UserProfile;


@Transactional
public interface UserProfileRepo extends CrudRepository<UserProfile, Integer> {

	
	@Query(value = "SELECT * FROM user_profile  where employee_id=?1", nativeQuery = true)
	UserProfile findByEmployeeId(int employeeId);
	
	
	
	@Query(value = "SELECT * FROM user_profile  where supervisor_id=?1", nativeQuery = true)
	List<UserProfile> findTeamBySupervisorId(int userid);
	
	
	@Query(value = "SELECT * FROM user_profile  where employee_id=?1 or employee_name like CONCAT('%',?1,'%')", nativeQuery = true)
	List<UserProfile> findEmployeeByKeyword(String keyword);
	
	@Modifying
	@Query(value = "update user_profile set supervisor_id=?1  where user_id=?2", nativeQuery = true)
	void updateSupervisorId(int supervisorid,int userid);
	
}
