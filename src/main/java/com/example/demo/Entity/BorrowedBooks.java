package com.example.demo.Entity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "borrowed_books")
public class BorrowedBooks {

    @EmbeddedId
    private BorrowedBooksId id;  // Composite primary key (userId + bookId)

//    private int quantity; // Number of copies borrowed
    
    private String pdf;
    // Default constructor (required by JPA)
    public BorrowedBooks() {}

    // Parameterized constructor
    public BorrowedBooks(BorrowedBooksId id,String pdf) {
        this.id = id;
//        this.quantity = quantity;
        this.pdf= pdf;
    }

    // Getters and Setters
    public BorrowedBooksId getId() { return id; }
    public void setId(BorrowedBooksId id) { this.id = id; }

	public String getPdf() {
		return pdf;
	}

	public void setPdf(String pdf) {
		this.pdf = pdf;
	}

//    public int getQuantity() { return quantity; }
//    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    
}

