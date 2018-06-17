package com.buzzybrains.model;

import javax.persistence.Entity;


@Entity
public class Orders {

@org.springframework.data.annotation.Id
public String Id;

public String name;

public String address;
	
}
