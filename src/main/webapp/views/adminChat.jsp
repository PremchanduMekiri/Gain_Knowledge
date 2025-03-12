<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.demo.Entity.Queries" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Chat</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color:lightblue;
            color: white;
            margin: 0;
            padding: 20px;
            position: relative;
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .clear-chat {
            position: absolute;
            top: 15px;
            right: 20px;
            background: red;
            color: white;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }
        .chat-box {
            max-width: 60%;
            margin: auto;
            padding: 20px;
        }
        .query {
            padding: 10px;
            border-radius: 5px;
            margin: 5px;
            font-size: 16px;
        }
        .user-query {
            color:#4B0082; /* White text for user */
            text-align: right;
        }
        .admin-reply {
            color: #000000; /* Gold text for admin */
            text-align: left;
        }
        .reply-form {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 10px;
        }
        .reply-form input {
            flex: 1;
            padding: 8px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
        }
        .reply-form button {
            background: green;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        .chat-controls {
            text-align: center;
            margin-top: 20px;
        }
        .back-button {
            background: gray;
            color: white;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>

    <a href="clearChat" class="clear-chat">Clear Chat</a>

    <h3>Admin Chat Panel</h3>

    <div class="chat-box">
        <% 
            List<Queries> queries = (List<Queries>) request.getAttribute("queries");
            if (queries != null) {
                for (Queries query : queries) { %>
                    <div class="query user-query">
                        <strong>User:</strong> <%= query.getQuery() %>
                    </div>
                    <div class="query admin-reply">
                        <strong>Reply:</strong> <%= (query.getReply() != null && !query.getReply().isEmpty()) ? query.getReply() : "No reply yet" %>
                    </div>

                    <form class="reply-form" action="replyquery" method="post">
                        <input type="hidden" name="queryId" value="<%= query.getId() %>">
                        <input type="text" name="reply" required placeholder="Enter reply">
                        <button type="submit">Send Reply</button>
                    </form>
                    <hr>
        <%      }
            }
        %>
    </div>

    <div class="chat-controls">
        <a href="admindashboard" class="back-button">Back to Dashboard</a>
    </div>

</body>
</html>




