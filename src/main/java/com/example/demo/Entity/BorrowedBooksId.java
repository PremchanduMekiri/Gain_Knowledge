package com.example.demo.Entity;

import java.io.Serializable;
import java.util.Objects;
import jakarta.persistence.Embeddable;

@Embeddable
public class BorrowedBooksId implements Serializable {
    
    private int userId;
    private int bookId;

    // Default constructor (required by JPA)
    public BorrowedBooksId() {}

    // Parameterized constructor
    public BorrowedBooksId(int userId, int bookId) {
        this.userId = userId;
        this.bookId = bookId;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) {  
        this.userId = userId;  
    }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    // Overriding equals() and hashCode() for proper comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BorrowedBooksId that = (BorrowedBooksId) o;
        return userId == that.userId && bookId == that.bookId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, bookId);
    }
}

