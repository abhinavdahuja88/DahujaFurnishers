package com.buzzybrains.dao;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.buzzybrains.model.Orders;

public interface OrderRepo extends MongoRepository<Orders,String>{

	@Query
	public Orders findByName(String orderName);
	
}
