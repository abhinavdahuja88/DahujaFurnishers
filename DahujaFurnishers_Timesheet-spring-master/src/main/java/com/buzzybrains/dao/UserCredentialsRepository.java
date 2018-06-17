package com.buzzybrains.dao;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.UserCredentials;

public interface UserCredentialsRepository extends CrudRepository<UserCredentials, Integer> {

	@Query(value = "SELECT * FROM user_credentials  where user_name=?1", nativeQuery = true)
	UserCredentials findByUserName(String username);

}
