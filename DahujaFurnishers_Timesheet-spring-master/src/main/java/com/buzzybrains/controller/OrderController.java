package com.buzzybrains.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.buzzybrains.dao.OrderRepo;
import com.buzzybrains.model.Orders;

@RestController
public class OrderController {
	
	@Autowired
	private OrderRepo repo;
	
	@RequestMapping("/api")
	public Orders findOrder(@PathVariable String orderName) {
		return repo.findByName(orderName);
	}
	

}
