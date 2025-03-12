<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Library Management</title>
    
     <script>
        window.onload = function() {
            var message = "<%= request.getAttribute("message") %>";
            if (message && message !== "null") {
                alert(message);
            }
        };
    </script>
    <style>
        /* Full-Screen Background */
        body {
            font-family: Arial, sans-serif;
            background: url('/images/login.jpeg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: #654321; /* Dark brown text color */
        }

        /* Container for the entire content */
        .container {
            padding: 20px;
            border-radius: 12px;
            width: 80%;
            max-width: 1000px;
            text-align: center;
            background: rgba(245, 222, 179, 0.9); /* Light brown semi-transparent background */
        }

        /* Introductory Section */
        .intro-section {
            margin-bottom: 10px; /* Reduced margin */
            padding: 20px;
            border-radius: 12px;
        }

        /* Flex container for Login and About sections */
        .content-section {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px; /* Reduced gap between sections */
        }

        /* Individual sections */
        .login-section, .info-section {
            padding: 20px;
            border-radius: 12px;
            width: 100%; /* Full width on small screens */
            max-width: 45%; /* Max width on larger screens */
            background: transparent; /* Transparent background */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        h1, h2, h3 {
            color: #8B4513; /* SaddleBrown color for headings */
            margin-bottom: 15px;
        }

        label {
            font-size: 16px;
            display: block;
            margin-top: 10px;
        }

        select, input {
            width: 90%;
            padding: 12px;
            margin-top: 5px;
            border: 1px solid #8B4513; /* Border matching heading color */
            border-radius: 6px;
            font-size: 16px;
        }

        input[type="submit"] {
            background: #8B4513;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 15px;
        }

        input[type="submit"]:hover {
            background: #A0522D; /* Sienna color on hover */
            transform: scale(1.05);
        }

        .info-section p {
            font-size: 16px;
            line-height: 1.5;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content-section {
                flex-direction: column;
                align-items: center;
            }
            .login-section, .info-section {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Introductory Section -->
    <div class="intro-section">
        <h1>📚 Welcome to Our Library Management System</h1>
        <p>
            Our mission is to provide seamless access to a vast collection of resources, empowering users with knowledge and fostering a love for reading. Explore, discover, and connect with the world of information at your fingertips.
        </p>
    </div>

    <div class="content-section">
        <!-- Login Form -->
        <div class="login-section">
            <h2>🔑 Login</h2>
            <form id="loginForm" method="post">
                <label for="role">Role:</label>
                <select id="role" name="role" required onchange="updateAction()">
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>

                <label for="userid">User ID:</label>
                <input type="number" id="userid" name="userid" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <input type="submit" value="Login">
            </form>
        </div>

        <!-- Knowledge Importance Section -->
        <div class="info-section">
            <h3>📖 The Power of Books</h3>
            <p>
                "Books are a uniquely portable magic. They empower, inspire, and educate us. A library is not just a collection of books but a treasure house of knowledge. Every book you read adds new dimensions to your understanding of the world."
            </p>
            <p><strong>"A reader lives a thousand lives before he dies." - George R.R. Martin</strong></p>
        </div>
    </div>
</div>

<script>
    function updateAction() {
        var role = document.getElementById("role").value;
        var form = document.getElementById("loginForm");

        if (role === "admin") {
            form.action = "adminLogin";  // Admin Login
        } else {
            form.action = "userLogin";   // User Login
        }
    }

    // Set action on page load
    updateAction();
</script>



</body>
</html>


