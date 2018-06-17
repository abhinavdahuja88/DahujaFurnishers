package com.buzzybrains.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.buzzybrains.dao.ClaimItemsRepo;
import com.buzzybrains.dao.ClaimRepo;
import com.buzzybrains.dao.UserProfileRepo;
import com.buzzybrains.model.Claim;
import com.buzzybrains.model.ClaimItems;
import com.buzzybrains.model.UserProfile;
import com.buzzybrains.util.PDFDownload;

@Controller
public class ClaimController {

	@Autowired
	ClaimRepo claimRepo;

	@Autowired
	ClaimItemsRepo claimItemsRepo;
	
	@Autowired
	UserProfileRepo userProfileRepo;

	@GetMapping("/claim-form")
	public String showClaimForm(HttpServletRequest request) {

		request.setAttribute("mode", "MODE_NEW");
		return "claim";
	}

	@GetMapping("/claim-list")
	public String  getClaimList(HttpServletRequest request,  int userid) {

		List<Claim> claimList=claimRepo.findClaimListByuserId(userid);
		request.setAttribute("claimList", claimList);
		request.setAttribute("mode", "MODE_HISTORY");
		return "claim";
	}
	


	@PostMapping("/create-claim")
	public String submitClaim(@ModelAttribute Claim claim, BindingResult bindingResult, HttpServletRequest request) {

		claimRepo.save(claim);
		int claimId = claim.getClaimId();

		List<ClaimItems> claimList = claim.getClaimItems();

		for (ClaimItems ci : claimList) {
			ci.setClaimId(claimId);
			claimItemsRepo.save(ci);
		}

		request.setAttribute("mode", "MODE_NEW");
		return "claim";
	}
	
	@GetMapping("/claim-download")
	@ResponseBody
	public void  generateClaimPdf(HttpServletResponse response,  int claimid) {

		Claim claim=claimRepo.findOne(claimid);
		int userid=claim.getUserId();
		UserProfile userProfile=userProfileRepo.findByEmployeeId(userid);
		claim.setClaimItems(claimItemsRepo.findItemListByClaimId(claimid));
		SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-YYYY");
		String fileName=sdf.format(claim.getStart())+"__"+sdf.format(claim.getEnd())+".pdf";
				  	
		try {
			PDFDownload pdfDownload=new PDFDownload(claim,userProfile);
			
			  ByteArrayOutputStream baos =pdfDownload.generatePDF();
			  response.setHeader("Expires", "0");
		      response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
		      response.setHeader("Pragma", "public");
		      response.setContentType("application/pdf");
		      response.setContentLength(baos.size());
			  response.setHeader("Content-disposition", "attachment; filename="+fileName);
			  ServletOutputStream out = response.getOutputStream();
		     
			  baos.writeTo(out);
		      out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 

	}

}
