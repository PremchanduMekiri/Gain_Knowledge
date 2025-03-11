package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.Users;
import com.example.demo.repository.BookRepo;
import com.example.demo.repository.repository;

import jakarta.persistence.criteria.Path;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;


@Service
public class serviceClass {
	
	@Autowired
	private repository repo;
	
	@Autowired
	private BookRepo repo1;
	

	
	public boolean addbooks(Books book) {
	    try {
	        repo1.save(book);
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	

	 
	 
	  //delete the book
	 @Transactional
	  public void deleteBookById(int bookId) {
	        repo1.deleteById(bookId);
	    }
	  
	//update the book
	 @Transactional
	    public void updateBookQuantity(int bookId, int quantity) {
	        Books book = repo1.findById(bookId).orElse(null);
	        if (book != null) {
	            book.setAvailablequantity(book.getAvailablequantity()+quantity);
	            repo1.save(book);
	        }
	    }
	    
	    //see all users
	 @Transactional
	    public List<Users> getAllUsers() {
	        return repo.findAll();
	    }
		
//		registeuser
	    @Transactional
		 public boolean registerUser(Users user) {
			 if(repo.existsById(user.getId())) {
				 return false;
			 }
			 return repo.save(user)!=null;
			 } 
	    
	    //delete the user
		 @Transactional
	    public void deleteUserById(int userid) {
	        repo.deleteById(userid);
	    }
	    
	    //get the user by id
	    public Users getUserById(int userid) {
	        return repo.findById(userid).orElse(null);
	    }
	     
	    //update the user by id
	    @Transactional
		public void updateUser(Users existingUser, Users updatedUser) {
		    existingUser.setName(updatedUser.getName());
		    existingUser.setMobilenum(updatedUser.getMobilenum());
		    existingUser.setEmail(updatedUser.getEmail());
		    existingUser.setDesignation(updatedUser.getDesignation());

		    repo.save(existingUser);  // Save updated user details
		}
	    public Books getBookById(int id) {
	        return repo1.findById(id).orElse(null); // ✅ Returns the book or null if not found
	    }




		public List<Books> getAllBooks() {
			// TODO Auto-generated method stub
			
			return repo1.findAll();
			}
		
		



		




	
		
//	    @Transactional
//	    public String saveuser(Users user) {
//	    	 return "repo.save(user)";
//	    }
		
//		 public boolean userlogin(Users user, String userid, String password) {
//	    if (user != null && String.valueOf(user.getId()).equals(userid) && user.getPassword().equals(password)) {
//	        return true; 
//	    }
//	    else {
//	    	return false;
//	  
//	    }
//	}
	    


}


