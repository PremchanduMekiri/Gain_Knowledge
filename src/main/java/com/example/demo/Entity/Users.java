package com.example.demo.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Users {
	
	@Id
	private int id;
	
	private String name;
	private String mobilenum;
	private String email;
	private String password;
	private String designation;

	

}
