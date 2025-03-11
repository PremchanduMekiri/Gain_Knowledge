package com.example.demo.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Entity.Books;

@Repository
public interface BookRepo extends JpaRepository<Books, Integer> {
	
	   
	    Books findByPdf(String pdf); // Custom method to find by PDF path
	}

   

