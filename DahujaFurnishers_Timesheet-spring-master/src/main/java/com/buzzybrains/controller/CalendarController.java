package com.buzzybrains.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.CalendarRepo;
import com.buzzybrains.model.Calendar;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CalendarController {

	@Autowired
	CalendarRepo calendarRepo;

	@GetMapping("/home")
	public String showCalendar(HttpServletRequest request, int employeeId) {
		List<Calendar> dataArray = calendarRepo.findCalendarByEmployeeId(employeeId);

		int year = Year.now().getValue();

		String start = "01/01/" + year;
		String end = "12/31/" + year;

		try {

			Date dateStart = new SimpleDateFormat("MM/dd/yyyy").parse(start);
			Date dateEnd = new SimpleDateFormat("MM/dd/yyyy").parse(end);

			int leave_availed = calendarRepo.findLeaveCountByEmployeeId(employeeId, dateStart, dateEnd);
			request.setAttribute("leaveAvailed", leave_availed);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ObjectMapper mapper = new ObjectMapper();

		try {
			String calData = mapper.writeValueAsString(dataArray);
			request.setAttribute("caldata", calData);
		} catch (JsonProcessingException e) {

			e.printStackTrace();
		}

		return "calendar";
	}

	@PostMapping("/calendar-data")
	@ResponseBody
	public Calendar insertCalDatar(@ModelAttribute Calendar calendar, BindingResult bindingResult,
			HttpServletRequest request) {

		TimeZone.setDefault(TimeZone.getTimeZone("GMT+05:30"));
		Calendar caldata = null;

		int cnt = calendarRepo.checkIfPresent(calendar.getStart(), calendar.getEmployeeID());

		if (cnt == 0) {
			caldata = calendarRepo.save(calendar);
		}

		return caldata;
	}

	@GetMapping("/app/home")
	@ResponseBody
	public List<Calendar> sendAttendanceData(int userid) {
		List<Calendar> dataArray = calendarRepo.findCalendarByEmployeeId(userid);

		return dataArray;
	}

	
	@PostMapping("app/calendar-data")
	@ResponseBody
	public ResponseEntity<Calendar> insertCalDataApp(@RequestBody Calendar calendar) {
		Calendar caldata = null;
		int cnt = calendarRepo.checkIfPresent(calendar.getStart(), calendar.getEmployeeID());
		if (cnt == 0) {
			caldata = calendarRepo.save(calendar);
		}

		return new ResponseEntity<Calendar>(caldata, HttpStatus.OK);
	}

}
