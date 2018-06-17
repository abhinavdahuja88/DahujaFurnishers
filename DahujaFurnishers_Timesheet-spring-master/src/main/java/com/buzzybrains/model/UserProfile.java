package com.buzzybrains.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name = "user_profile")
public class UserProfile {

	public UserProfile() {

	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)

	private int employeeId;
	private String employeeName;
	private String employeePhone;
	private String employeeAge;
	private int employeeSalary;
	private String currentAddress;
	

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}


	public String getEmployeePhone() {
		return employeePhone;
	}

	public void setEmployeePhone(String employeePhone) {
		this.employeePhone = employeePhone;
	}

	

	@Override
	public String toString() {
		return "UserProfile [employeeId=" + employeeId
				+ ", employeeName=" + employeeName + ", employeePhone="
				+ employeePhone + ", age=" + employeeAge + ", salary=" + employeeSalary
				+ ", currentAddress=" + currentAddress + "]";
	}

	public String getEmployeeAge() {
		return employeeAge;
	}

	public void setEmployeeAge(String employeeAge) {
		this.employeeAge = employeeAge;
	}

	public int getEmployeeSalary() {
		return employeeSalary;
	}

	public void setEmployeeSalary(int employeeSalary) {
		this.employeeSalary = employeeSalary;
	}

}
