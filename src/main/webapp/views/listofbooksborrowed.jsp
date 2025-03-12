
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.Entity.BorrowedBooks" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Borrowed Books List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Light Beige */
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #8b4513; /* Saddle Brown */
            font-size: 28px;
        }

        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 16px;
        }

        th {
            background-color: #f4a460; /* Sandy Brown */
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
            transition: background 0.3s ease-in-out;
        }

        .no-data {
            text-align: center;
            color: #888;
            font-size: 18px;
            margin-top: 20px;
        }

        .logout-container {
            margin-top: 20px;
        }

        .logout-container a {
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            color: #8b4513; /* Saddle Brown */
            padding: 10px 20px;
            border-radius: 5px;
            background-color: #f4a460; /* Sandy Brown */
            transition: background 0.3s ease;
            display: inline-block;
        }

        .logout-container a:hover {
            background-color: #a0522d; /* Darker Brown */
            color: #fff;
        }
    </style>
</head>
<body>

    <h2>📚 Borrowed Books List</h2>

    <table>
        <tr>
            <th>📌 Book ID</th>
        </tr>

        <% List<BorrowedBooks> books = (List<BorrowedBooks>) request.getAttribute("books"); %>
        
        <% if (books != null && !books.isEmpty()) { %>
            <% for (BorrowedBooks book : books) { %>
                <tr>
                    <td><%= book.getId().getBookId() %></td>
                </tr>
            <% } %>
        <% } else { %>
            <tr><td colspan="1">No borrowed books found.</td></tr>
        <% } %>
    </table>

    <div class="logout-container">
        <a href="logout">🚪 Logout</a>
    </div>

</body>
</html>
