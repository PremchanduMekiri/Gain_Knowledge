package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.BorrowedBooks;
import com.example.demo.Entity.BorrowedBooksId;
import com.example.demo.Entity.Users;
import com.example.demo.service.userService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private userService userService;

    // Check User Session
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("loggedInUser") != null);
    }

    // User Dashboard
//    @GetMapping("/dashboarduser")
//    public String userDashboard(HttpServletRequest request) {
//        if (!isUserLoggedIn(request)) {
//        	return "redirect:/login?error=invalidcredentials";
//        }
//        return "userdashboard";
//    }
    
    //see books list
    @GetMapping("/dashboarduser")
    public String seebooksList(HttpServletRequest request, Model model) {
        if (!isUserLoggedIn(request)) {
            return "redirect:/login";
        }
        
        model.addAttribute("books", userService.getAllBooks());
        model.addAttribute("borrowedbooks", userService.borrowebookslist()); // Fixed attribute name

        return "UserDashboard";  // Ensure this JSP file exists
    }


    @PostMapping("/borrowBook")
    public String borrowBook(@RequestParam int bookid, HttpSession session) {
        Users user = (Users) session.getAttribute("loggedInUser"); 

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        int userId = user.getId();  
            
        // Check if the user already borrowed this book
        BorrowedBooksId borrowedBooksId = new BorrowedBooksId(userId, bookid);
        BorrowedBooks borrowedBook = userService.getBorrowedBookById(borrowedBooksId);

        if (borrowedBook != null) {
            return "redirect:/user/dashboarduser?error=alreadyborrowed"; // Prevent multiple borrowings
        }

        Books book = userService.getBookById(bookid);  
        if (book == null) {
            return "redirect:/user/dashboarduser?error=booknotfound";
        }

        // Save borrowed book
        borrowedBook = new BorrowedBooks(borrowedBooksId, book.getPdf());
        userService.saveBorrowedBook(borrowedBook);

        // Decrease available quantity
        userService.decreaseBookQuantity(bookid);  

        return "redirect:/user/dashboarduser?success=bookborrowed";
    }

    @PostMapping("/returnBook")
    public String returnBook(@RequestParam int bookid, HttpSession session) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        int userid = user.getId();
        BorrowedBooksId borrowedBooksId = new BorrowedBooksId(userid, bookid);
        
        // ✅ Check if the book exists in BorrowedBooks before deleting
        if (userService.getBorrowedBookById(borrowedBooksId) != null) {
            userService.deletbookbyid(borrowedBooksId);
            userService.increaseBookQuantity(bookid);
        }

        return "redirect:/user/dashboarduser";
    }


}




