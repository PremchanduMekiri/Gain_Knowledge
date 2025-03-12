<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.demo.Entity.Queries" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Chat</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light Blue/Cream Background */
            color: #333;
            margin: 0;
            padding: 20px;
            position: relative;
        }
        .chat-container {
            max-width: 60%;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .chat-box {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-height: 400px;
            overflow-y: auto;
            padding: 10px;
        }
        .user-msg {
            background: #d1e7ff; /* Light Blue */
            color: #003366;
            align-self: flex-end;
            padding: 10px;
            border-radius: 12px;
            max-width: 70%;
        }
        .admin-msg {
            background: #d4edda; /* Light Green */
            color: #155724;
            align-self: flex-start;
            padding: 10px;
            border-radius: 12px;
            max-width: 70%;
        }
        .chat-controls {
            display: flex;
            margin-top: 10px;
            gap: 10px;
            position: relative;
        }
        .query-input {
            flex: 1;
            padding: 10px;
            font-size: 14px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
        }
        .send-button {
            background: #28a745; /* Green */
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 50%;
            font-size: 16px;
        }
        .send-button i {
            font-size: 18px;
        }
        .clear-chat {
            position: fixed;
            top: 15px;
            right: 25px;
            background: red;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .back-button {
            background: gray;
            color: white;
            padding: 10px;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
</head>
<body>

    <button class="clear-chat" onclick="clearChat()"><i class="fas fa-trash-alt"></i> Clear Chat</button>
     <a href="dashboarduser124" class="back-button">Back to Dashboard</a>

    <div class="chat-container">
        <h3 style="text-align: center;">User Chat</h3>

        <div class="chat-box">
            <% 
                List<Queries> queries = (List<Queries>) request.getAttribute("queries");
                if (queries != null) {
                    for (Queries query : queries) { %>
                        <div class="user-msg"><%= query.getQuery() %></div>
                        <div class="admin-msg"><%= (query.getReply() != null && !query.getReply().isEmpty()) ? query.getReply() : "No reply yet" %></div>
            <%      }
                }
            %>
        </div>

        <form class="chat-controls" action="inputquery" method="post">
            <input type="text" name="query" required placeholder="Enter your query" class="query-input">
            <button type="submit" class="send-button"><i class="fas fa-paper-plane"></i></button>
        </form>

        <br><br>
       
    </div>

    <script>
        function clearChat() {
            if (confirm("Are you sure you want to clear the chat?")) {
                window.location.href = "clearChat";
            }
        }
    </script>

</body>
</html>

