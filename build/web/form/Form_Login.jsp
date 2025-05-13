<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String errorMessage = null;

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
      Connection conn = null;
      PreparedStatement ps = null;
      ResultSet rs = null;

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false";
        String dbUser = "root";
        String dbPass = "";

        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // Cek apakah email ada
        String sqlEmail = "SELECT * FROM user WHERE email = ?";
        ps = conn.prepareStatement(sqlEmail);
        ps.setString(1, email);
        rs = ps.executeQuery();

        if (!rs.next()) {
          errorMessage = "Email tidak ditemukan.";
        } else {
          // Email ada, cek password
          rs.close();
          ps.close();

          String sqlPass = "SELECT * FROM user WHERE email = ? AND password = ?";
          ps = conn.prepareStatement(sqlPass);
          ps.setString(1, email);
          ps.setString(2, password);
          rs = ps.executeQuery();

          if (rs.next()) {
            // Login berhasil
            session.setAttribute("userEmail", email);
            response.sendRedirect("dashboard.jsp");
            return;
          } else {
            errorMessage = "Password salah.";
          }
        }
      } catch (Exception e) {
        errorMessage = "Terjadi kesalahan: " + e.getMessage();
      } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
      }
    } else {
      errorMessage = "Email dan password harus diisi.";
    }
  }
%>
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
      background: #fff;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 320px;
      position: relative;
    }
    .menu-icon {
      position: absolute;
      top: 20px;
      right: 20px;
      width: 30px;
      height: 25px;
      cursor: pointer;
    }
    .menu-icon div {
      height: 4px;
      background-color: #f4a261;
      margin: 4px 0;
      border-radius: 2px;
    }
    .new-user {
      color: #f4a261;
      font-weight: 600;
      font-size: 14px;
      margin-bottom: 10px;
      cursor: pointer;
    }
    
    .new-user a {
        text-decoration: none;
        color: orange;
    }
    
    h2 {
      margin: 0 0 25px 0;
      font-weight: 700;
      color: #333;
    }
    label {
      display: block;
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 6px;
      color: #555;
    }
    
    
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px 12px;
      margin-bottom: 20px;
      border: 1.5px solid #ddd;
      border-radius: 8px;
      font-size: 15px;
      transition: border-color 0.3s;
    }
    input[type="email"]:focus,
    input[type="password"]:focus {
      border-color: #f4a261;
      outline: none;
    }
    button {
      width: 100%;
      padding: 12px;
      background-color: #000;
      color: #fff;
      font-weight: 700;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    button:hover {
      background-color: orange;
    }
    .forgot-password {
      margin-top: 15px;
      text-align: center;
      font-size: 14px;
      color: #777;
      cursor: pointer;
    }
    .forgot-password:hover {
      color: #f4a261;
    }
  </style>
  <script>
    function validateLoginForm() {
      var email = document.getElementById('email').value.trim();
      var password = document.getElementById('password').value.trim();

      if (email === '') {
        alert('Email harus diisi!');
        document.getElementById('email').focus();
        return false;
      }
      if (password === '') {
        alert('Password harus diisi!');
        document.getElementById('password').focus();
        return false;
      }
      return true;
    }
  </script>
</head>
<body>
  <div class="login-container">
    <div class="new-user"><a href="Form_Register.jsp">Orang Baru ?</a></div>
    <h2>Welcome Back.</h2>

    <form action="../main/dashboard.jsp" method="post" onsubmit="return validateLoginForm();">
      <label for="email">Emailnya apa ?</label>
      <input type="email" id="email" name="email" placeholder="Masukkan email" required value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
      <label for="password">Passwordnya apa ?</label>
      <input type="password" id="password" name="password" placeholder="Masukkan password" required />
      <button type="submit">Login</button>
    </form>
    <div class="forgot-password">Lupa Password Kali ?</div>
  </div>

  <% if (errorMessage != null) { %>
    <script>
      alert("<%= errorMessage.replace("\"", "\\\"") %>");
    </script>
  <% } %>
</body>
</html>
