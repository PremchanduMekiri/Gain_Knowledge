package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Entity.Users;
import com.example.demo.service.serviceClass;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private serviceClass userservice;

   
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    
    @PostMapping("/adminLogin")
    public String adminLogin(@RequestParam String userid, @RequestParam String password, HttpServletRequest request,RedirectAttributes redirectAttributes) {
        if ("21645A0323".equalsIgnoreCase(userid) && "prem@2002".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", userid);
            return "redirect:admin/dashboardadmin";
        } else {
        	redirectAttributes.addFlashAttribute("message", "Invalid_Credentials");
            return "redirect:/login?error=invalid_credentials";
        }
    }
    @PostMapping("/userLogin")
    public String userLogin(@RequestParam int userid, @RequestParam String password, HttpServletRequest request,RedirectAttributes redirectAttributes) {
        Users user = userservice.getUserById(userid);
        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            return "redirect:user/dashboarduser";
        } else {
        	redirectAttributes.addFlashAttribute("message", "Invalid_Credentials");
            return "redirect:/login?error=invalid_credentials";
        }
        
    }
}


