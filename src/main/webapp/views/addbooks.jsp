<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Beige background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Form Container */
        .form-container {
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 380px;
            text-align: center;
        }

        fieldset {
            border: none;
            padding: 10px 0;
        }

        legend {
            font-size: 1.4em;
            font-weight: bold;
            color: #8b4513; /* Saddle Brown */
            text-align: center;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin-top: 12px;
            font-size: 16px;
            color: #2f4f4f; /* Dark Slate Gray */
            text-align: left;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }

        button {
            background-color: #8b4513; /* Saddle Brown */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
            width: 100%;
            transition: background 0.3s ease-in-out;
        }

        button:hover {
            background-color: #a0522d; /* Sienna */
        }

        .logout-container {
            margin-top: 15px;
        }

        .logout-container a {
            display: inline-block;
            text-decoration: none;
            font-size: 16px;
            color: #8b4513; /* Saddle Brown */
            font-weight: bold;
            margin-top: 10px;
            transition: color 0.3s ease;
        }

        .logout-container a:hover {
            color: #a0522d; /* Sienna */
        }

        .logout-container img {
            width: 20px;
            vertical-align: middle;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <form action="/admin/addBookservlet" method="post" enctype="multipart/form-data">
            <fieldset>
                <legend>📖 Add New Book</legend>
                
                <label for="bookid">📌 Book ID:</label>
                <input type="number" id="bookid" name="bookid" required>

                <label for="bookname">📚 Book Name:</label>
                <input type="text" id="bookname" name="bookname" required>

                <label for="author">✍️ Author:</label>
                <input type="text" id="author" name="author" required>

                <label for="availablequantity">🔢 Quantity:</label>
                <input type="number" id="availablequantity" name="availablequantity" required>
            </fieldset>

            <fieldset>
                <legend>📂 Upload Files</legend>

                <label for="pdf">📄 Upload PDF:</label>
                <input type="file" id="pdf" name="pdf" accept=".pdf" required>

                <label for="image">🖼️ Upload Book Image:</label>
                <input type="file" id="image_path" name="image" accept="image/*" required>
            </fieldset>

            <button type="submit">➕ Add Book</button>

            <div class="logout-container">
                <a href="logout"><img src="/images/logout.jpg"> Logout</a>
            </div>
        </form>
    </div>
</body>
</html>

