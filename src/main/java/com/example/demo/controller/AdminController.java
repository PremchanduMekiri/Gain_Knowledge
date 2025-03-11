package com.example.demo.controller;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
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
import com.example.demo.Entity.BorrowedBooks;
import com.example.demo.Entity.Users;
import com.example.demo.service.service;
import com.example.demo.service.userService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private service userservice;
    @Autowired
    private userService us;

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

    //borrowed books list
    @GetMapping("/borrowedbookslist")
    public String borrowedbookslist(Model model,HttpServletRequest request) {
    	 if (!isAdminLoggedIn(request)) {
         	return "redirect:/login";
         }
    	model.addAttribute("books", us.borrowebookslist());
    	return "listofbooksborrowed";
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
                          HttpServletRequest request) {
        
        if (!isAdminLoggedIn(request)) {
            return "redirect:/login";
        }

        try {
            // ✅ Create Book Object Manually
            Books book = new Books();
            book.setBookid(bookid);
            book.setBookname(bookname);
            book.setAuthor(author);
            book.setAvailablequantity(availablequantity);
            book.setRetrivalqauantity(retrivalqauantity);

            // ✅ Process PDF File
            if (pdfFile != null && !pdfFile.isEmpty()) {
                String uploadDir ="src/main/resources/static/books/pdf/";
                
                // Ensure directory exists
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                // Generate a unique filename
                String fileName = bookid + "_" + pdfFile.getOriginalFilename();
                Path filePath = Paths.get(uploadDir + fileName);

                // Save file to system
                Files.copy(pdfFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                // ✅ Store only file name (not full path)
                book.setPdf(fileName);
            } else {
                book.setPdf(null); // Set to null if no file is uploaded
            }

            // ✅ Save book to DB
            userservice.addbooks(book);
            request.getSession().setAttribute("message", "Book added successfully");
            
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/bookslist?error=fileUploadFailed";
        }
        
        return "redirect:/admin/bookslist";
    }
    
//    private static final String UPLOAD_DIR = "D:/Spring_MVC/demo-9/src/main/webapp/Books/";
//
//    @GetMapping("/addBookservlet")
//    public void getPdf(@RequestParam("filename") String filename, HttpServletResponse response) {
//        try {
//            Path filePath = Paths.get(UPLOAD_DIR).resolve(filename).normalize();
//            File file = filePath.toFile();
//
//            if (file.exists() && file.isFile()) {
//                response.setContentType(MediaType.APPLICATION_PDF_VALUE);
//                response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getName() + "\"");
//                Files.copy(filePath, response.getOutputStream());
//                response.getOutputStream().flush();
//            } else {
//                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
//            }
//        } catch (Exception e) {
//            try {
//                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching file");
//            } catch (Exception ignored) {
//            }
//            }
//        }



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
    		return "redirect:/bookslist?error=enter valid quantity";
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

    	    return "redirect:/admin/showuserslist";
    	}


    // Delete User
    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam int userid, HttpServletRequest request) {
        if (!isAdminLoggedIn(request)) {
        	return "redirect:/";
        }
        userservice.deleteUserById(userid);
        return "redirect:/admin/showuserslist";
    }
    
    }

