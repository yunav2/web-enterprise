<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login Form</title>
  <style>
    body {
      background-color: #c7d9f7;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .login-container {
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 320px;
    }
    .login-container h2 {
      margin-bottom: 20px;
      font-weight: 700;
      color: #222;
    }
    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 600;
      color: #444;
      font-size: 14px;
    }
    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px 12px;
      margin-bottom: 18px;
      border: 1.5px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }
    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus {
      border-color: orange;
      outline: none;
    }
    /* Styling placeholder agar seragam */
    input::placeholder {
      color: #999999;
      font-style: normal;
      font-weight: 400;
    }
    button {
      width: 100%;
      padding: 12px;
      background-color: #000;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      font-weight: 700;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    button:hover {
      background-color: orange;
    }
    .forgot-password {
      margin-top: 12px;
      text-align: center;
      font-size: 13px;
      color: #666;
      cursor: pointer;
    }
    .new-user {
      font-weight: 600;
      font-size: 14px;
      color: #f39c12;
      margin-bottom: 15px;
      cursor: pointer;
    }
    
    .new-user  a{
        text-decoration: none;
        color: orange;
    }
  </style>
</head>
<body>
  <div class="login-container">
      <div class="new-user"><a href="Form_Login.jsp">Orang Lama ?</a></div>
    <h2>Welcome</h2>
    <form action="reg.jsp" method="post">
      <label for="nama">Namanya siapa ?</label>
      <input type="text" id="nama" name="nama" placeholder="Masukkan nama" required />

      <label for="email">Emailnya apa ?</label>
      <input type="email" id="email" name="email" placeholder="Masukkan email" required />

      <label for="password">Passwordnya apa ?</label>
      <input type="password" id="password" name="password" placeholder="Masukkan password" required />

      <button type="submit">Register</button>
    </form>
    <div class="forgot-password">Lupa Password Kali ?</div>
  </div>
</body>
</html>
