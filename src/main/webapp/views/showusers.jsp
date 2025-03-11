<%@ page import="com.example.demo.Entity.Users" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Users List</title>
    
     <%
			    String register = (String) session.getAttribute("register");
			    session.removeAttribute("register");
			
			    String updateuser = (String) session.getAttribute("updateuser");
			    session.removeAttribute("updateuser");
			
			    String deleteuser = (String) session.getAttribute("deleteuser");
			    session.removeAttribute("deleteuser");
			    
			    String undelete=(String) session.getAttribute("deleteuser_error");
			    session.removeAttribute("deleteuser_error");
			
			 
			%>
			
			<script>
			    window.onload = function() {
			        var messageNon = "<%= register %>";
			        var messageDel = "<%= updateuser %>";
			        var message = "<%= deleteuser %>";
			        var manage="<%= undelete%>";
			        
			       
			
			        if (messageNon && messageNon !== "null") {
			            alert(messageNon);
			        }
			
			        if (messageDel && messageDel !== "null") {
			            alert(messageDel);
			        }
			
			        if (message && message !== "null") {
			            alert(message);
			        }
			        if (manage && manage !== "null") {
			            alert(manage);
			        }
			
			      
			    };
			</script>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Light tan background */
            color: #4b2e1e; /* Dark brown text */
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        table {
            width: 80%;
            margin: 20px 0;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            border: 1px solid #d3c4a6;
            text-align: center;
        }
        th {
            background-color: #8b4513; /* SaddleBrown */
            color: #ffffff;
        }
        tr:nth-child(even) {
            background-color: #f5deb3; /* Wheat */
        }
        tr:nth-child(odd) {
            background-color: #fffaf0; /* FloralWhite */
        }
        button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .update-btn {
            background-color: #a0522d; /* Sienna */
            color: #ffffff;
        }
        .update-btn:hover {
            background-color: #8b4513; /* SaddleBrown */
        }
        .delete-btn {
            background-color: #b22222; /* FireBrick */
            color: #ffffff;
        }
        .delete-btn:hover {
            background-color: #8b0000; /* DarkRed */
        }
        .create-user-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #a0522d; /* Sienna */
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
        }
        .create-user-link:hover {
            background-color: #8b4513; /* SaddleBrown */
        }
    </style>
</head>
<body>

    <h2>Users List</h2>

    <table>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Mobile Number</th>
            <th>Email</th>
           
            <th>Actions</th>
        </tr>
        <% 
            List<Users> userList = (List<Users>) request.getAttribute("users");
            if (userList != null) { 
                for (Users user : userList) { 
        %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getName() %></td>
            <td><%= user.getDesignation() %></td>
            <td><%= user.getMobilenum() %></td>
            <td><%= user.getEmail() %></td>
            <td>
                <form action="/admin/updateUser" method="get" style="display: inline;">
                    <input type="hidden" name="userid" value="<%= user.getId() %>">
                    <button type="submit" class="update-btn">Update</button>
                </form>
                
                <form action="/admin/deleteUser" method="post" style="display: inline;">
                    <input type="hidden" name="userid" value="<%= user.getId() %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <% 
                }
            } else { 
        %>
        <tr>
            <td colspan="6">No users found.</td>
        </tr>
        <% } %>
    </table>

    <a href="register" class="create-user-link">Create User</a>

</body>
</html>

