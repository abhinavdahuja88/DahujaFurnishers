package com.buzzybrains.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.CalendarRepo;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.Calendar;
import com.buzzybrains.model.UserProfile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MyTeamController {

	
	@Autowired
	UserProfileRepo userProfileRepo;
	
	@Autowired
	CalendarRepo calendarRepo;
	
	
	@GetMapping("/direct-report")
	public String  getDirectReports(HttpServletRequest request)
	{					
		request.setAttribute("teamlist", userProfileRepo.findAll());  //findTeamBySupervisorId(userid));	
		request.setAttribute("mode", "MODE_TEAM");
		return "myteam";
		
	}
	
	
	@GetMapping("/get-attendance-data")
	@ResponseBody
	public String showCalendar(int employeeId) {
		List<Calendar> dataArray = calendarRepo.findCalendarByEmployeeId(employeeId);
		ObjectMapper mapper = new ObjectMapper();
		String calData="";
		try {
			 calData = mapper.writeValueAsString(dataArray);

		
		} catch (JsonProcessingException e) {
		
			e.printStackTrace();
		}

		return calData;
	}
	
	@GetMapping("/addSupervisor")
	@ResponseBody
	public String addSupervisor() {
		
		//userProfileRepo.updateSupervisorId(supervisorid, userid);
		
		return "Success";
	}
	
	@GetMapping("/search-employee")
	@ResponseBody
	public List<UserProfile> searchEmployee(String keyword) {
		
		return userProfileRepo.findEmployeeByKeyword(keyword);
		
	}
}
