package com.buzzybrains.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.UserCredentialsRepository;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.UserCredentials;
import com.buzzybrains.model.UserProfile;

@Controller
public class ProfileController {
	
	@Autowired
	UserProfileRepo userProfileRepo;
	
	@Autowired
	UserCredentialsRepository userCredentialsRepository;
		
	
	@GetMapping("/myProfile")
	public String displayProfile(HttpServletRequest request, int userid) {
		//request.setAttribute("userProfile", userProfileRepo.findByUserId(userid));
		request.setAttribute("mode", "MODE_PROFILE");
		return "profile";
	}
	
	
	@GetMapping("/get-profile")
	@ResponseBody
	public UserProfile getProfile(int employeeId) {
	
		return  userProfileRepo.findByEmployeeId(employeeId);
	}

	@PostMapping("/saveProfile")
	@ResponseBody
	public UserProfile saveProfile(@ModelAttribute UserProfile userProfile, BindingResult bindingResult,HttpServletRequest request) {
		
		return userProfileRepo.save(userProfile);

		 
	}
	
	@GetMapping("/change-password")
	public String changePassword(HttpServletRequest request) {

		request.setAttribute("mode", "MODE_PASSWORD_CHANGE");

		return "profile";
	}
	
	@PostMapping("/update-password")
	public String updatePassword(@ModelAttribute UserCredentials userCredentials,BindingResult bindingResult,HttpServletRequest request) {

		userCredentialsRepository.save(userCredentials);
		
		return "redirect:logout";
	}
}
