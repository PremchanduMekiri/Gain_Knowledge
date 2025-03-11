<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.Entity.Books" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book List</title>
    
	    	 <%
			    String messageNon = (String) session.getAttribute("message_non");
			    session.removeAttribute("message_non");
			
			    String messageDel = (String) session.getAttribute("message_del");
			    session.removeAttribute("message_del");
			
			    String message = (String) session.getAttribute("message");
			    session.removeAttribute("message");
			
			    String lowquant = (String) session.getAttribute("lowquant");
			    session.removeAttribute("lowquant");
			
			    String bookupdated = (String) session.getAttribute("updated");
			    session.removeAttribute("updated");
			%>
			
			<script>
			    window.onload = function() {
			        var messageNon = "<%= messageNon %>";
			        var messageDel = "<%= messageDel %>";
			        var message = "<%= message %>";
			        var lowquant = "<%= lowquant %>";
			        var bookupdated = "<%= bookupdated %>";
			
			        if (messageNon && messageNon !== "null") {
			            alert(messageNon);
			        }
			
			        if (messageDel && messageDel !== "null") {
			            alert(messageDel);
			        }
			
			        if (message && message !== "null") {
			            alert(message);
			        }
			
			        if (lowquant && lowquant !== "null") {
			            alert(lowquant);
			        }
			
			        if (bookupdated && bookupdated !== "null") {
			            alert(bookupdated);
			        }
			    };
			</script>
     
    <style>
        /* Table Styling */
        body{
        background-color: #BEBEBE;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
            font-family: Arial, sans-serif;
            background-color: #F5F5DC; /* Beige background */
        }
        th, td {
            border: 1px solid #8B4513; /* Saddle Brown border */
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #D2B48C; /* Tan background */
            color: #2F4F4F; /* Dark Slate Gray text */
        }
        tr:nth-child(even) {
            background-color: #FFF8DC; /* Cornsilk for even rows */
        }
        tr:hover {
            background-color: #EEE8AA; /* PaleGoldenrod on hover */
        }
        /* Button Styling */
        .btn {
            padding: 5px 10px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .delete-btn {
            background-color: #8B0000; /* Dark Red */
            color: white;
        }
        .delete-btn:hover {
            background-color: #B22222; /* Firebrick */
        }
        .update-btn {
            background-color: #4682B4; /* Steel Blue */
            color: white;
        }
        .update-btn:hover {
            background-color: #5F9EA0; /* Cadet Blue */
        }
        /* Link Styling */
        .add-books-link {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #8B4513; /* Saddle Brown */
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .add-books-link:hover {
            background-color: #A0522D; /* Sienna */
        }
    </style>
</head>
<body>
    <h2 style="text-align: center; color: #8B4513;">Book List</h2>

    <% List<Books> bookList = (List<Books>) request.getAttribute("books"); %>

    <table>
        <tr>
            <th>Book ID</th>
            <th>Book Name</th>
            <th>Author</th>
            <th>Books Quantity</th>
            <th>Retrieval Quantity</th>
            <th>Book_pdf</th>
            <th>Actions</th>
        </tr>

        <% if (bookList != null) {
            for (Books book : bookList) { %>
               <tr>
				    <td><%= book.getBookid() %></td>
				    <td><%= book.getBookname() %></td>
				    <td><%= book.getAuthor() %></td>
				    <td><%= book.getAvailablequantity() %></td>
				    <td><%= book.getRetrivalqauantity() %></td>
				    <td>
				        <% if (book.getPdf() != null && !book.getPdf().isEmpty()) { %>
				            <a href="/books/pdf/<%= book.getPdf() %>" target="_blank">View PDF</a>
				        <% } else { %>
				            No PDF Available
				        <% } %>
				    </td>
				    <td>
				        <form action="/admin/deleteBook" method="post" style="display:inline;">
				            <input type="hidden" name="bookid" value="<%= book.getBookid() %>">
				            <button type="submit" class="btn delete-btn">Delete</button>
				        </form>
				
				        <form action="/admin/updateBook" method="post" style="display:inline;">
				            <input type="hidden" name="bookid" value="<%= book.getBookid() %>">
				            <input type="number" name="quantity" placeholder="New Quantity" required>
				            <button type="submit" class="btn update-btn">Update</button>
				        </form>
				    </td>
				</tr>
                
        <% } } else { %>
            <tr><td colspan="6">No books available</td></tr>
        <% } %>
    </table>

    <a href="addbooks" class="add-books-link">Add More Books to the List</a>
</body>
</html>
