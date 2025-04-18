package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.BorrowedBooks;
import com.example.demo.Entity.BorrowedBooksId;
import com.example.demo.Entity.Queries;
import com.example.demo.Entity.Users;
import com.example.demo.service.queryService;
import com.example.demo.service.userService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private userService userService;
    
    @Autowired
    private queryService userqQueryService;

    // Check User Session
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("loggedInUser") != null);
    }
    
    //see borrowed books list to read the books
    @GetMapping("/dashboarduser")
    public String readBooks(HttpServletRequest request, Model model) {
        Users user = (Users) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            System.out.println("there is no userid");
            return "redirect:/login";
        } 
        Integer userId = user.getId();
        List<Books> borrowedBooks = userService.getBorrowedBooksByUser(userId);
        model.addAttribute("borrowedBooks", borrowedBooks);

        return "Readbooks"; 
    }
    
    //Available books in the library and the borrowed books service layer for user
    @GetMapping("/booksList")
    public String seebooksList(HttpServletRequest request, Model model) {
        if (!isUserLoggedIn(request)) {
            return "redirect:/login";
        }
        
        model.addAttribute("books", userService.getAllBooks());
        model.addAttribute("borrowedbooks", userService.borrowebookslist()); 

        return "UserDashboard";  // Ensure this JSP file exists
    }

    //Borrowed book
    @PostMapping("/borrowBook")
    public String borrowBook(@RequestParam int bookid, HttpSession session,HttpServletRequest request) {
        Users user = (Users) session.getAttribute("loggedInUser"); 

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        int userId = user.getId();  
            
        // Check if the user already borrowed this book
        BorrowedBooksId borrowedBooksId = new BorrowedBooksId(userId, bookid);
        BorrowedBooks borrowedBook = userService.getBorrowedBookById(borrowedBooksId);

        if (borrowedBook != null) {
            request.getSession().setAttribute("borrowunabel","Book already borrowed"); 
            return "redirect:/user/booksList?error=alreadyborrowed"; 
        }

        Books book = userService.getBookById(bookid);  
        if (book == null) {
            return "redirect:/user/booksList?error=booknotfound";
        }

        
        borrowedBook = new BorrowedBooks(borrowedBooksId, book.getPdf());
        userService.saveBorrowedBook(borrowedBook);  // Save borrowed book
        
        userService.decreaseBookQuantity(bookid);    // Decrease available quantity
        
        request.getSession().setAttribute("borrowed", "borrowed book sucessfully");
        return "redirect:/user/booksList?success=bookborrowed";
    }
    //return book
    @PostMapping("/returnBook")
    public String returnBook(@RequestParam int bookid, HttpSession session,HttpServletRequest request) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        int userid = user.getId();
        BorrowedBooksId borrowedBooksId = new BorrowedBooksId(userid, bookid);
        
      
        if (userService.getBorrowedBookById(borrowedBooksId) != null) {
            userService.deletbookbyid(borrowedBooksId);
            userService.increaseBookQuantity(bookid);
            request.getSession().setAttribute("returned", "returned book sucessfully");
        }
       
        return "redirect:/user/booksList";
    }
    //logout
    @GetMapping("/logout12")
    public String logout() {
        return "redirect:/login";
    }
    //back button
    @GetMapping("/logout123")
    public String logoutback() {
        return "redirect:/user/dashboarduser";
    }
    // to get the chat page with list of quries of user
    @GetMapping("/chat")
    public String userChat(Model model, HttpSession session) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        List<Queries> userQueries = userqQueryService.getUserQueries(user.getId());
        model.addAttribute("queries", userQueries);

        return "userChat";
    }
    //save the queries to database
    @PostMapping("/inputquery")
    public String inputQuery(@RequestParam String query, HttpSession session) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login?error=notloggedin";
        }

        Queries newQuery = new Queries();
        newQuery.setUserid(user.getId());
        newQuery.setQuery(query);
        newQuery.setReply("");

        userqQueryService.saveQuery(newQuery);
        return "redirect:/user/chat";
    }
    //back button
    @GetMapping("/dashboarduser124")
    public String back() {
        return"redirect:/user/dashboarduser";
    }
    // to clear the chat
    @GetMapping("/clearChat")
    public String clearUserChat(HttpSession session) {
        Users user = (Users) session.getAttribute("loggedInUser");

        if (user != null) {
            userqQueryService.clearUserQueries(user.getId());
        }

        return "redirect:/user/chat";
    }
}
    
    







