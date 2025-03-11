<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script>
        
    </script>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Beige background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        fieldset {
            border: none;
            padding: 0;
        }
        legend {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #8b4513; /* Saddle Brown */
        }
        label {
            display: block;
            margin-top: 10px;
            color: #2f4f4f; /* Dark Slate Gray */
        }
        input[type="text"],
        input[type="number"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #8b4513; /* Saddle Brown */
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
        }
        button:hover {
            background-color: #a0522d; /* Sienna */
        }
    </style>
</head>
<body>
    <div class="form-container">
       <form action="/admin/addBookservlet" method="post" enctype="multipart/form-data">
    <fieldset>
        <legend>Add New Book</legend>
        <label for="bookid">Book ID:</label>
        <input type="number" id="bookid" name="bookid" required>

        <label for="bookname">Book Name:</label>
        <input type="text" id="bookname" name="bookname" required>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required>

        <label for="availablequantity">Quantity:</label>
        <input type="number" id="availablequantity" name="availablequantity" required>

        <label for="pdf">Upload PDF:</label>
        <input type="file" id="pdf" name="pdf" accept=".pdf" required>

        <button type="submit">Add Book</button>
    </fieldset>
</form>
    </div>
</body>
</html>
