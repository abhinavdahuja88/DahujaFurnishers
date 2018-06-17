package com.buzzybrains.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.buzzybrains.model.Calendar;

public interface CalendarRepo extends CrudRepository<Calendar, Integer> {

	@Query(value = "SELECT * FROM calendar  where employee_id=?1 ", nativeQuery = true)
	List<Calendar> findCalendarByEmployeeId(@Param("employee_id")int employeeId);

	@Query(value = "select count(1) from calendar c where (c.start >= :fromDate AND c.start <= :endDate )and c.title='Leave' and c.employee_id=  :employee_id", nativeQuery = true)
	int findLeaveCountByEmployeeId(@Param("employee_id") int employee_id,@Param("fromDate") Date from, @Param("endDate") Date end);
	
	
	@Query(value = "SELECT count(1) FROM calendar  where start= :inDate and employee_id=:employee_id", nativeQuery = true)
	int checkIfPresent(@Param("inDate") Date date,@Param("employee_id") int employeeId);
}
