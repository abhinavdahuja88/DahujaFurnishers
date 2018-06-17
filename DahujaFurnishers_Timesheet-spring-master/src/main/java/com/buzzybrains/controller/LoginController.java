package com.buzzybrains.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.UserCredentialsRepository;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.UserCredentials;

@Controller
public class LoginController {

	@Autowired
	UserCredentialsRepository userCredentialsRepository;
	@Autowired
	UserProfileRepo userProfileRepo;

	@RequestMapping("/hi")
	public @ResponseBody String hiThere() {
		return "hello world!";
	}

	@GetMapping("/login")
	public String home(HttpServletRequest request) {

		String redirect = "";
		HttpSession session = request.getSession();

		// check for browser back button is pressed
		if (session.getAttribute("SessionUsername") == null && session.getAttribute("SessionUserid") == null) {
			redirect = "login";
		} else {
			//String userId = (String) session.getAttribute("SessionUserid");
			//request.setAttribute("mode", "MODE_HOME");
			//redirect = "redirect:home?userid=" + userId;
			//redirect = ""
					
			request.setAttribute("teamlist", userProfileRepo.findAll());  //findTeamBySupervisorId(userid));	
			request.setAttribute("mode", "MODE_TEAM");
			return "myteam";
		}

		return redirect;
	}

	@GetMapping("/")
	public String redirectToValidPage(HttpServletRequest request) {

		String redirect = "";
		HttpSession session = request.getSession();

		// check for browser back button is pressed
		if (session.getAttribute("SessionUsername") == null) {
			redirect = "login";
		} else {
			/*String userId = (String) session.getAttribute("SessionUserid");
			request.setAttribute("mode", "MODE_HOME");
			redirect = "redirect:home?userid=" + userId;*/
			request.setAttribute("teamlist", userProfileRepo.findAll());  //findTeamBySupervisorId(userid));	
			request.setAttribute("mode", "MODE_TEAM");
			return "myteam";
		}

		return redirect;
	}

	@PostMapping("/validate")
	public String validateLoginDetails(@ModelAttribute UserCredentials userCredentials, BindingResult bindingResult,
			HttpServletRequest request, HttpServletResponse response) {
		String username = userCredentials.getUserName();
		String password = userCredentials.getPassword();
		String redirect = "";

		UserCredentials userObject = userCredentialsRepository.findByUserName(username);

		if (userObject != null) {
			if (userObject.getPassword().equals(password)) {

				// creating a session
				HttpSession session = request.getSession();
				session.setAttribute("SessionUsername", username);
				session.setAttribute("SessionUserid", Integer.toString(userObject.getUserId()));

				request.setAttribute("teamlist", userProfileRepo.findAll());  //findTeamBySupervisorId(userid));	
				request.setAttribute("mode", "MODE_TEAM");
				return "myteam";
				//request.setAttribute("mode", "MODE_HOME");

				//redirect = "redirect:" + "/home?userid=" + userObject.getUserId();
			}

			else {
				redirect = "redirect:/login";
			}
		} else {
			redirect = "redirect:/login";

		}
		return redirect;
	}

	@GetMapping("/logout")
	private String eraseCookie(HttpServletRequest req, HttpServletResponse resp) {

		HttpSession session = req.getSession(false);
		if (session != null) {
			session.removeAttribute("SessionUserid");
			session.removeAttribute("SessionUsername");
			session.invalidate();

		}
		return "redirect:" + "/login";
	}

	@GetMapping("/app/validate")
	@ResponseBody
	public Boolean validateLoginDetailsApp(String username, String password) {

		UserCredentials userObject = userCredentialsRepository.findByUserName(username);
		boolean flag = false;
		if (userObject != null) {
			if (userObject.getPassword().equals(password)) {
				flag = true;
			}
		}
		return flag;
	}

}
