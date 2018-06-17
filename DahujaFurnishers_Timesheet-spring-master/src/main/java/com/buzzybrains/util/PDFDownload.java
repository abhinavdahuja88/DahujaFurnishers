package com.buzzybrains.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.buzzybrains.model.Claim;
import com.buzzybrains.model.ClaimItems;
import com.buzzybrains.model.UserProfile;
import com.itextpdf.text.BadElementException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFDownload {

	public Claim claim;
	public UserProfile userProfile;

	public PDFDownload(Claim claim, UserProfile userProfile) {
		this.claim = claim;
		this.userProfile = userProfile;
	}
	SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-YYYY");
	private static Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 13, Font.BOLD);
	private static Font redFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.RED);
	private static Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
	private static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 8, Font.BOLD);
	int total = 0;

	public ByteArrayOutputStream generatePDF() {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			Document document = new Document();
		
			PdfWriter.getInstance(document, baos);
			document.open();
			
			addMetaData(document);
			addTitlePage(document);
			addSpace(document);
			createTable(document);
			// addContent(document);
			document.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return baos;

	}

	private void addMetaData(Document document) {
		document.addTitle("Claim PDF");
		document.addSubject("Claim View");

	}


	private void addTitlePage(Document document) throws DocumentException {
		PdfPTable table = new PdfPTable(new float[] { 2, 5 });
		table.getDefaultCell().setBorder(0);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
		
		Image logo;
		try {
			logo = Image.getInstance(System.getProperty("user.dir")+"/src/main/resources/BB_Logo.png");
			//document.add(logo);
			table.addCell(logo);
		} catch (BadElementException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		
		Paragraph preface = new Paragraph();
		
		//preface.add(new Paragraph("BuzzyBrains Software India Pvt. Ltd.",catFont));
		preface.add(new Paragraph("Claim Period:" + sdf.format(claim.getStart()) + " to " + sdf.format(claim.getEnd()),
				catFont));

		preface.add(new Paragraph("Generated At:" + new Date(), smallBold));
		addEmptyLine(preface, 1);
		preface.add(new Paragraph("Name=" + userProfile.getEmployeeName() + "\n\n" + "Id=" + userProfile.getEmployeeId()
				+ "\n\n" + "Phone=" + userProfile.getEmployeePhone() + "\n\n"+"Manager=" + claim.getManager(), smallBold));

		addEmptyLine(preface, 1);
		table.addCell(preface);
		document.add(table);
		
		
		/*
		 * // Start a new page document.newPage();
		 */
	}
	private void addSpace(Document document) throws DocumentException {
		Paragraph space = new Paragraph();
		
		addEmptyLine(space, 2);
		
		document.add(space);
		
		
	}

	private void createTable(Document document) throws DocumentException {
		PdfPTable table = new PdfPTable(new float[] { 2, 3, 2, 2 });
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell("Date");
		table.addCell("Description");
		table.addCell("Category");
		table.addCell("Cost");
		table.setHeaderRows(1);
		PdfPCell[] cells = table.getRow(0).getCells();
		for (int j = 0; j < cells.length; j++) {
			cells[j].setBackgroundColor(BaseColor.GRAY);
		}

		List<ClaimItems> claimList = claim.getClaimItems();
		for (int i = 0; i < claimList.size(); i++) {
			ClaimItems ci = claimList.get(i);
			table.addCell(sdf.format(ci.getExpenseDate()));
			table.addCell(ci.getDescription());
			table.addCell(ci.getCategory());
			table.addCell(Integer.toString(ci.getCost()));
			total += ci.getCost();
		}
		
		Paragraph summary = new Paragraph();
		int advance = claim.getAdvance();
		summary.add(new Paragraph(
				 "Total=" + total + "\n" + "Advance=" + claim.getAdvance() + "\n" +"Balance=" + (total - advance),
				smallBold));

		document.add(table);

		
		addEmptyLine(summary, 1);
		
		summary.add(new Paragraph(
				"Claimant Signature--------------                  Approvar Signature--------------"));
		document.add(summary);

	}
	/*
	 * private static void createList(Section subCatPart) { List list = new
	 * List(true, false, 10); list.add(new ListItem("First point"));
	 * list.add(new ListItem("Second point")); list.add(new
	 * ListItem("Third point")); subCatPart.add(list); }
	 */

	private static void addEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}

}
