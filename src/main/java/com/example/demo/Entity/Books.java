package com.example.demo.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Books {
	
	@Id
	private int bookid;
	private String bookname;
	private String author;
	private int availablequantity;
	private int retrivalqauantity;
    private String pdf;
    private String imagePath;

}
