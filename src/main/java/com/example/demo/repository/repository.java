package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.Users;


public interface repository extends JpaRepository<Users, Integer>{
	
}
