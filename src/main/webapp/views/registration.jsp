<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5dc; /* Light tan background */
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
        input[type="number"],
        input[type="email"],
        input[type="password"] {
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
        <form action="/admin/RegisterServlet" method="post">
            <fieldset>
                <legend>Registration Page</legend>
                <label for="id">ID:</label>
                <input type="number" id="id" name="id" required>

                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="mobilenum">Mobile Number:</label>
                <input type="text" id="mobilenum" name="mobilenum" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>

                <label for="designation">Designation:</label>
                <input type="text" id="designation" name="designation" required>

                <button type="submit">Register</button>
            </fieldset>
        </form>
    </div>
</body>
</html>
