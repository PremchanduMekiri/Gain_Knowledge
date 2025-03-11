<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Library Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('/images/library.jpg'); /* ✅ Fixed background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 80px auto;
            background: rgba(0, 0, 0, 0.85);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.3);
        }

        h2 {
            margin-bottom: 15px;
            font-size: 30px;
            font-weight: bold;
        }

        .admin-message {
            font-size: 16px;
            font-style: italic;
            margin-bottom: 25px;
            color: #ffcc00;
        }

        .dashboard-links {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
        }

        .dashboard-links a {
            display: flex;
            align-items: center;
            justify-content: flex-start; /* ✅ Align text and icon properly */
            width: 250px;
            padding: 12px;
            background: #ffcc00;
            color: black;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            border-radius: 8px;
            transition: 0.3s;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3);
        }

        .dashboard-links a:hover {
            background: #ff9900;
            transform: scale(1.05);
        }

        .icon {
            width: 30px;
            height: 30px;
            margin-right: 15px; /* ✅ Ensure proper spacing between icon and text */
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📚 Welcome, Admin</h2>
    
    <p class="admin-message">
        "A great library needs a great administrator. Your role is crucial in shaping knowledge, 
        maintaining order, and helping countless readers find their way!"
    </p>

    <div class="dashboard-links">
        <a href="bookslist"><img src="/images/books.webp" class="icon"> View Available Books</a>
        <a href="showuserslist"><img src="/images/download1.jpg" class="icon"> View Users List</a>
        <a href="borrowedbookslist"><img src="/images/download3.png" class="icon"> View Borrowed Books</a>
        <a href="logout"><img src="/images/logout.jpg" class="icon"> Logout</a>
    </div>
</div>

</body>
</html>
