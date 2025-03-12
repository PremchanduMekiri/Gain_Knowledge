<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.Entity.Books" %>
<%@ page import="com.example.demo.Entity.BorrowedBooks" %>
<%@ page import="com.example.demo.Entity.Users" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <!-- Include your CSS styles here -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Light tan background */
            margin: 0;
            padding: 0;
            justify-content: center;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-top: 30px;
        }
        h1, h2 {
            color: #8b4513; /* Saddle Brown */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
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
        .btn {
            padding: 10px 15px;
            background-color: #8b4513; /* Saddle Brown */
            color: white;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-top: 20px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #a0522d; /* Sienna */
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
    
     <%
			    String messageNon = (String) session.getAttribute("returned");
			    session.removeAttribute("returned");
			
			    String messageDel = (String) session.getAttribute("borrowed");
			    session.removeAttribute("borrowed");
			
			    String message = (String) session.getAttribute("borrowunabel");
			    session.removeAttribute("borrowunabel");
			
			%>
			
			<script>
			    window.onload = function() {
			        var messageNon = "<%= messageNon %>";
			        var messageDel = "<%= messageDel %>";
			        var message = "<%= message %>";
			       
			        if (messageNon && messageNon !== "null") {
			            alert(messageNon);
			        }
			
			        if (messageDel && messageDel !== "null") {
			            alert(messageDel);
			        }
			
			        if (message && message !== "null") {
			            alert(message);
			        }
			
			      
			    };
			</script>
</head>
<body>
    <div class="container">
        <%
            // Retrieve the logged-in user from the session
            Users loggedInUser = (Users) session.getAttribute("loggedInUser");
            if (loggedInUser == null) {
                // Redirect to login page if user is not logged in
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <h1>Welcome, <%= loggedInUser.getName() %>!</h1>

        <h2>Available Books:</h2>
        <%
            // Retrieve the list of available books from the request attribute
            List<Books> availableBooks = (List<Books>) request.getAttribute("books");
            if (availableBooks == null || availableBooks.isEmpty()) {
        %>
            <p>No books are currently available for borrowing.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Book ID</th>
                    <th>Book Title</th>
                    <th>Author</th>
                    <th>Available Quantity</th>
                    <th>Action</th>
                </tr>
                <% for (Books book : availableBooks) { %>
                    <tr>
                        <td><%= book.getBookid() %></td>
                        <td><%= book.getBookname() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getAvailablequantity() %></td>
                        <td>
                        <form action="/user/borrowBook" method="post">
						    <input type="hidden" name="bookid" value="<%= book.getBookid()%>">
						    <button type="submit">Borrow</button>
						</form>
		                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>

        <h2>Your Borrowed Books:</h2>
        <%
            // Retrieve the list of borrowed books for the user
            List<BorrowedBooks> borrowedBooks = (List<BorrowedBooks>) request.getAttribute("borrowedbooks");
            if (borrowedBooks == null || borrowedBooks.isEmpty()) {
        %>
            <p>You have not borrowed any books.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Book ID</th>
                   
                 <!--    <th>Read Book</th> -->
                    <th>Action</th>
                </tr>
                <% for (BorrowedBooks borrowedBook : borrowedBooks) { %>
                    <tr>
                        <td><%= borrowedBook.getId().getBookId() %></td>
                       
                      <%--   <td>
                        	  <% if (borrowedBook.getPdf() != null && !borrowedBook.getPdf().isEmpty()) { %>
				            	<a href="/books/pdf/<%= borrowedBook.getPdf() %>" target="_blank">View PDF</a>
				        	  <% } 
                        	  else { %>
				            	No PDF Available
				        		<% } %>
                        
                        
                        </td> --%>
                        <td>
                           <form action="/user/returnBook" method="post">
							    <input type="hidden" name="bookid" value="<%=borrowedBook.getId().getBookId()%>">
							    <button type="submit">Return</button>
							</form>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
           </div>
        <div class="logout-container">
    	<a href="logout123" class="logout-btn">🚪 Previous_page</a>
		</div>
        
</body>
</html>


    