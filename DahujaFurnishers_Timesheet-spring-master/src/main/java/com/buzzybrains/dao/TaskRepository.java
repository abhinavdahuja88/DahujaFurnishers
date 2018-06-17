package com.buzzybrains.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.buzzybrains.model.Task;

public interface TaskRepository extends CrudRepository<Task, Integer> {

	
	@Query(value="SELECT * FROM t_tasks  where user_id=?1 order by task_date desc", nativeQuery = true)
	List<Task> findTaskListByuserId(int userid);
	
	@Modifying
	@Transactional
	@Query(value="update t_tasks  set  name=?2,description=?3,status=?4,comments=?5   where id=?1 ", nativeQuery = true)
     Integer updateTask(int id,String name,String description,String status,String comments);
	
	
}
