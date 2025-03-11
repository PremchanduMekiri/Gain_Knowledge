package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.BorrowedBooks;
import com.example.demo.Entity.BorrowedBooksId;
import com.example.demo.Entity.Users;
import com.example.demo.repository.BookRepo;
import com.example.demo.repository.BorrowedBooksRepository;
import com.example.demo.repository.repository;

@Service
public class userService {
	
	@Autowired
	private repository repo;
	
	@Autowired
	private BookRepo br;
	
	@Autowired
	private BorrowedBooksRepository bbr;
	
	//get the books list
	public List<Books> getAllBooks() {
		List<Books> books=br.findAll();
		return books;
		
	}
	
	
	public Users getUserById(int id) {
	    return repo.findById(id).orElse(null);
	}
	
	  public BorrowedBooks getBorrowedBookById(BorrowedBooksId id) {
	        Optional<BorrowedBooks> borrowedBook =bbr.findById(id);
	        return borrowedBook.orElse(null);
	  }

	    
	    public void saveBorrowedBook(BorrowedBooks borrowedBook) {
	        bbr.save(borrowedBook);
	        
	    }

	  
	    @Transactional
	    public void decreaseBookQuantity(int bookId) {
	        Books book = br.findById(bookId).orElse(null);
	        if (book != null && book.getAvailablequantity() > 0) {
	            book.setAvailablequantity(book.getAvailablequantity() - 1);
	            book.setRetrivalqauantity(book.getRetrivalqauantity()+1);
	            br.save(book);
	        }
	    }
	    
	    public List<BorrowedBooks> borrowebookslist(){
	    	
	    	List<BorrowedBooks> borrowedbooks=bbr.findAll();
	    	return borrowedbooks;
	    }
	   

	    @Transactional
	    public void increaseBookQuantity(int bookId) {
	        Books book = br.findById(bookId).orElse(null);

	        if (book != null) {
	            // Increase the book quantity
	            book.setAvailablequantity(book.getAvailablequantity() + 1);
	            book.setRetrivalqauantity(book.getRetrivalqauantity()-1);
	            // Save the updated book record
	            br.save(book);
	      
	    }
}
	    public int getTotalBooksBorrowedByUser(int userId) {
	        return bbr.countTotalBorrowedBooksByUser(userId);
	    }

	    @Transactional
	    public boolean deletbookbyid(BorrowedBooksId bookid) {
			 bbr.deleteById(bookid);
			 return true;
	    	
	    }
	    public Books getBookById(int bookId) {
	        return br.findById(bookId).orElse(null);
	    }
	    public boolean hasBorrowedBooks(int userid) {
	        // ✅ Check if any record exists for the given user in borrowed books
	        return bbr.countByUserId(userid) > 0;
	    }

       

}
