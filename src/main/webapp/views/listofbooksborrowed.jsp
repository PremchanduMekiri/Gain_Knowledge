<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 50%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f4a460; /* Sandy Brown */
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .no-data {
            text-align: center;
            color: #888;
            margin-top: 20px;
        }
    </style>

</head>
<body>
   <h2>Borrowed Books List</h2>
   
  <table border="1">
    <tr>
        <th>Book ID</th>
        <th>User id</th>
       
        
    </tr>

    <% List<BorrowedBooks> books = (List<BorrowedBooks>) request.getAttribute("books"); %>
    
    <% if (books != null && !books.isEmpty()) { %>
        <% for (BorrowedBooks book : books) { %>
            <tr>
                <td><%= book.getId().getBookId() %></td>
                <td><%=book.getId() %>
                
            </tr>
        <% } %>
    <% } else { %>
        <tr><td colspan="2">No borrowed books found.</td></tr>
    <% } %>
</table>
  
</body>
</html>