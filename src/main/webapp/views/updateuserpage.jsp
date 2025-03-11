<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.demo.Entity.Users" %>
<%
    Users user = (Users) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Update Page</title>
    <style>
        /* Reset some basic elements for consistency across browsers */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Light tan background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        legend {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #8b4513; /* Saddle Brown */
            text-align: center;
        }

        label {
            display: block;
            margin-top: 10px;
            color: #2f4f4f; /* Dark Slate Gray */
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }

        button {
            background-color: #8b4513; /* Saddle Brown */
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            font-size: 1em;
        }

        button:hover {
            background-color: #a0522d; /* Sienna */
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Update User Details</h2>
        
        <form action="/admin/updateUserDetails" method="post">
            <input type="hidden" name="userid" value="<%= user.getId() %>">
            
            <label>Name:</label>
            <input type="text" name="name" value="<%= user.getName() %>" required>
            
            <label>Mobile Number:</label>
            <input type="tel" name="mobilenum" value="<%= user.getMobilenum() %>" required>
            
            <label>Email:</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" required>
            
            <label>Designation:</label>
            <input type="text" name="designation" value="<%= user.getDesignation() %>" required>

            <button type="submit">Update</button>
        </form>
    </div>

</body>
</html>
