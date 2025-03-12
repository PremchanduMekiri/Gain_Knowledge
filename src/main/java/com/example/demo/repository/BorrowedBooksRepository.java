package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.Entity.BorrowedBooks;
import com.example.demo.Entity.BorrowedBooksId;

public interface BorrowedBooksRepository extends JpaRepository<BorrowedBooks, BorrowedBooksId>{
	@Query("SELECT COUNT(b) FROM BorrowedBooks b WHERE b.id.userId = :userId")
	int countTotalBorrowedBooksByUser(@Param("userId") int userId);

	  @Query("SELECT COUNT(b) FROM BorrowedBooks b WHERE b.id.userId = :userid")
	    long countByUserId(@Param("userid") int userid);
	  
	 
	  @Query(value = "SELECT * FROM borrowed_books WHERE user_id = :userId", nativeQuery = true)
	    List<BorrowedBooks> findByIdUserId(@Param("userId") int userId);

   
	  
	}
	
	




