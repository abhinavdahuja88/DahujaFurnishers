package com.buzzybrains.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.UserProfile;

@RestController
@RequestMapping("/API/{userId}")
public class PRactiseController {
	
	UserProfileRepo repo ;
	
	@Autowired
	public PRactiseController(UserProfileRepo repo) {
		this.repo = repo;
	}

	@GetMapping
	public UserProfile getUsername(@PathVariable int userId) {
		return repo.findByEmployeeId(userId);
	}
	
	@PostMapping
	public ResponseEntity saveUserProfile(@PathVariable int userId, @RequestBody  UserProfile profile) {
		repo.updateSupervisorId(supervisorid, userid);(profile);
		
        return ResponseEntity.status(HttpStatus.CREATED).build();
	}
	
}
