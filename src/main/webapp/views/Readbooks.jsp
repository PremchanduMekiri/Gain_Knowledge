<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"  %>
<%@ page import="com.example.demo.Entity.Books" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Read Books</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5dc; /* Light tan background */
            text-align: center;
            margin: 0;
            padding: 0;
            color: #5a4a42; /* Dark brown text */
        }

        /* Page Title */
        h2 {
            margin-top: 30px;
            font-size: 28px;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: #4d3b32; /* Warm brown */
        }

        /* Book Container */
        .book-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            padding: 20px;
        }

        /* Individual Book Card */
        .book-card {
            background: #fff8e7; /* Soft beige */
            border: 1px solid #d2b48c; /* Tan border */
            padding: 15px;
            border-radius: 10px;
            width: 220px;
            text-align: center;
            box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: scale(1.05);
            box-shadow: 4px 6px 15px rgba(0, 0, 0, 0.3);
        }

        /* Book Image */
        .book-card img {
            width: 180px;
            height: 250px;
            object-fit: cover;
            cursor: pointer;
            border-radius: 8px;
            border: 2px solid #8b6f47; /* Warm brown border */
            transition: transform 0.3s ease-in-out;
        }

        .book-card img:hover {
            transform: scale(1.1);
        }

        /* Book Details */
        .book-card p {
            margin: 8px 0;
            font-size: 16px;
            font-weight: bold;
            color: #5a4a42; /* Dark brown */
        }

        /* Library Link */
        .library-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #8b6f47; /* Coffee brown */
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .library-link:hover {
            background: #6b4f34; /* Darker brown */
        }
        
        /* Centering the logout button */
		.logout-container {
		    display: flex;
		    justify-content: center; /* Horizontally center */
		    margin-top: 30px;
		}
		
		/* Styled Logout Button */
		.logout-btn {
		    padding: 12px 20px;
		    background: #8b4513; /* Saddle Brown (matching page theme) */
		    color: white;
		    text-decoration: none;
		    font-size: 18px;
		    font-weight: bold;
		    border-radius: 5px;
		    border: none;
		    cursor: pointer;
		    transition: background 0.3s ease;
		}
		
		.logout-btn:hover {
		    background: #a0522d; /* Darker shade of Saddle Brown */
		}
        
    </style>
</head>
<body>

    <h2>📚 Welcome! Here are Your Books 📖</h2>

   <div class="book-container">
    <% 
        List<Books> borrowedBooks = (List<Books>) request.getAttribute("borrowedBooks"); 
        if (borrowedBooks != null && !borrowedBooks.isEmpty()) {
            for (Books book : borrowedBooks) { 
    %>
    
        <div class="book-card">
            <!-- Link to PDF file -->
            <a href="<%= request.getContextPath() %>/books/pdf/<%= book.getPdf() %>" target="_blank">
                <!-- Display Book Cover Image -->
                <img src="<%= request.getContextPath() %>/books/images/<%= book.getImagePath() %>" 
                     alt="Book Cover">
            </a>

            <!-- Display Book Information -->
            <p><strong>Book ID:</strong> <%= book.getBookid() %></p>
            <p><strong>Author:</strong> <%= book.getAuthor() %></p>
        </div>

    <% 
            } 
        } else { 
    %>
        <p>No borrowed books found.</p>
    <% } %>
</div>

<br>
<a href="booksList" class="library-link">📚 Go to Library</a>

<div class="logout-container">
    <a href="logout12" class="logout-btn">🚪 Logout</a>
</div>


</body>
</html>



