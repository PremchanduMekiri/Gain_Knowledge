package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.concurrent.Flow.Publisher;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Entity.Books;
import com.example.demo.Entity.Queries;
import com.example.demo.Entity.Users;
import com.example.demo.service.queryService;
import com.example.demo.service.serviceClass;
import com.example.demo.service.userService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private serviceClass userservice;
    
    @Autowired
    private userService us;
    
    @Autowired
    private queryService adminService;
    

    // Check Admin Session
    private boolean isAdminLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("adminUser") != null);
    }

    // Admin Dashboard
    @RequestMapping("/dashboardadmin")
    public String showAdminDashboard(HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/login";
        }
        return "adminDashboard";
    }

    // Show Books List
    @GetMapping("/bookslist")
    public String listBooks(HttpServletRequest request,RedirectAttributes redirectAttributes) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/login";
        }
        redirectAttributes.addFlashAttribute("books", userservice.getAllBooks());
        return "redirect:/admin/updatedbookslist";
      
    }
  
    @GetMapping("/updatedbookslist")
    public String listoffbooks(HttpServletRequest request) {
    	if (!isAdminLoggedIn(request)) {
    		return "redirect:/login";
    	}
       
        return "showbooks";
    }

    // Add New Book
    @GetMapping("/addbooks")
    public String showAddBookPage(HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/";
        }
        return "addbooks";
    }
    @PostMapping("/addBookservlet")
    public String addBook(@RequestParam("bookid") int bookid,
                          @RequestParam("bookname") String bookname,
                          @RequestParam("author") String author,
                          @RequestParam("availablequantity") int availablequantity,
                          @RequestParam(value = "retrivalqauantity", required = false, defaultValue = "0") int retrivalqauantity,
                          @RequestParam("pdf") MultipartFile pdfFile,
                          @RequestParam("image") MultipartFile imageFile,
                          HttpServletRequest request) {
        
        if (!isAdminLoggedIn(request)) {
            return "redirect:/login";
        }

        try {
            Books book = new Books();
            book.setBookid(bookid);
            book.setBookname(bookname);
            book.setAuthor(author);
            book.setAvailablequantity(availablequantity);
            book.setRetrivalqauantity(retrivalqauantity);
           
            //To save a pdf file as a multi part file
            if (pdfFile != null && !pdfFile.isEmpty()) {
                String uploadDir ="src/main/resources/static/books/pdf/";
               
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String fileName = bookid + "_" + pdfFile.getOriginalFilename();
                String imagePath = request.getServletContext().getRealPath("/books/pdf/");
                Path filePath = Paths.get(uploadDir + fileName);                
                Files.copy(pdfFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                book.setPdf(fileName);
            } else {
                book.setPdf(null); 
            }
            // to save the image
            if (imageFile != null && !imageFile.isEmpty()) {
                String imageUploadDir = "src/main/resources/static/books/images/";
             
                File imageDir = new File(imageUploadDir);
                if (!imageDir.exists()) {
                    imageDir.mkdirs();
                }

                String imageFileName = bookid + "_" + imageFile.getOriginalFilename();
                Path imageFilePath = Paths.get(imageUploadDir + imageFileName);
                Files.copy(imageFile.getInputStream(), imageFilePath, StandardCopyOption.REPLACE_EXISTING);
                book.setImagePath(imageFileName);
            } else {
                book.setImagePath(null); 
            }

           
            userservice.addbooks(book);
           
            request.getSession().setAttribute("message", "Book added successfully");
            
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/bookslist?error=fileUploadFailed";
        }
        
        return "redirect:/admin/bookslist";
    }
    

    // Delete Book
    @PostMapping("/deleteBook")
    public String deleteBook(@RequestParam Integer bookid, HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
            return "redirect:/login";
        }
        Books book = userservice.getBookById(bookid);
        if(book.getRetrivalqauantity()>0) {
        	request.getSession().setAttribute("message_non","Make_ensure_Retrival_Quanttity_is_0");
        	
        	return "redirect:/admin/bookslist?error=u_cant_delete_book";
        	
        }
        userservice.deleteBookById(bookid);
        request.getSession().setAttribute("message_del","Book_Deleted_Sucessfully");
        return "redirect:/admin/bookslist?success=book_deleted";
    }
    
    
    //Update Book
    @PostMapping("/updateBook")
    public String updateBook(@RequestParam Integer bookid,@RequestParam Integer quantity,HttpServletRequest request) {
    	if (!isAdminLoggedIn(request)) {
            return "redirect:/login";
        }
    	if(quantity<=0) {
    		request.getSession().setAttribute("lowquant","Enter_the_valid_Quantity");
    		return "redirect:/admin/bookslist?error=enter valid quantity";
    	}
    	userservice.updateBookQuantity(bookid, quantity);
    	request.getSession().setAttribute("updated", "Book_updated");
    	return "redirect:/admin/bookslist?success=book_updated";
    }


    // Show Users List
    
    @GetMapping("/showuserslist")
    public String showUsers(RedirectAttributes model, HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/login";
        }
        model.addFlashAttribute("users", userservice.getAllUsers());
        return "redirect:/admin/updatedusersList";
    }
    
    @GetMapping("/updatedusersList")
    public String userslist(HttpServletRequest request) {
    	 if (!isAdminLoggedIn(request)) {
         	return "redirect:/login";
         }
    	 return "showusers";
    }
    

    // Register New User
    @GetMapping("/register")
    public String registerUserPage(HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/";
        }
        return "registration";
    }

    @PostMapping("/RegisterServlet")
    public String registerUser(@ModelAttribute Users user, HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/login";
        }
        userservice.registerUser(user);
       request.getSession().setAttribute("register", "user_registered_sucessfully");
        return "redirect:/admin/showuserslist";
    }
    @GetMapping("/updateUser")
    public String updatepage( HttpServletRequest request,@RequestParam int userid,Model model) {
    	if (!isAdminLoggedIn(request)) {
        	return "redirect:/login";
        }
    	Users user=userservice.getUserById(userid);
    	if(user == null) {
    		return "redirect:/login"; 
    	}
    	
    	model.addAttribute("user",user);
    	
    	return "updateuserpage";
    }
    
    	@PostMapping("/updateUserDetails")
    	public String updateUser(@ModelAttribute Users user, HttpServletRequest request,@RequestParam int userid) {
    	    if (!isAdminLoggedIn(request)) {
    	    	return "redirect:/login";
    	    }

    	    
    	    Users existingUser = userservice.getUserById(userid);
    	    if (existingUser == null) {
    	        return "redirect:/admin/showuserslist?error=user_not_found";
    	    }

    	    userservice.updateUser(existingUser, user);  // Updating existingUser with new details
    	    request.getSession().setAttribute("updateuser", "User_updated_sucessfully");

    	    return "redirect:/admin/showuserslist";
    	}


    // Delete User
    @ PostMapping("/deleteUser")
    public String deleteUser(@RequestParam int userid, HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/";
        }
        boolean hasBorrowedBooks = us.hasBorrowedBooks(userid);

        if (hasBorrowedBooks) {
           
            request.getSession().setAttribute("deleteuser_error", "User cannot be deleted because they have borrowed books.");
            return "redirect:/admin/showuserslist";
        }
        
        userservice.deleteUserById(userid);
        request.getSession().setAttribute("deleteuser", "User_deleted_sucessfully");
        return "redirect:/admin/showuserslist";
    }
    
    //logout
    @GetMapping("/logout1")
    public String logout() {
        return"redirect:/login";
    }
    //back button
    @GetMapping("/moveback")
    public String moveback() {
        return "redirect:/admin/dashboardadmin";
    }
    //backbutton
    @GetMapping("back")
    public String back() {
        return "redirect:/admin/dashboardadmin";
    }
    
    //load the chat page
    @GetMapping("/chat")
    public String adminChat(Model model) {
        List<Queries> allQueries = adminService.getAllQueries();
        model.addAttribute("queries", allQueries);
        return "adminChat";
    }
    
    //reply for the query
    @PostMapping("/replyquery")
    public String replyQuery(@RequestParam int queryId, @RequestParam String reply) {
        adminService.updateQueryReply(queryId, reply);
        return "redirect:/admin/chat";
    }
    
    //previous page
    @GetMapping("/admindashboard")
    public String backbu() {
        return "redirect:/admin/dashboardadmin";
    }
    //clear chat
    @GetMapping("clearChat")
    public String clearch(HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
            return "redirect:/";
        }
        adminService.clearAllQueries();
        return "redirect:/admin/chat";
    }
    
    }

