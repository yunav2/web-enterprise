<%-- 
    Document   : reg
    Created on : 23 Apr 2025, 12.01.13
    Author     : Pongo
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Proses Registrasi</title>
</head>
<body>
<%
  String nama = request.getParameter("nama");
  String email = request.getParameter("email");
  String password = request.getParameter("password");

  Connection conn = null;
  PreparedStatement ps = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");

    // Cek apakah email sudah terdaftar
    ps = conn.prepareStatement("SELECT * FROM user WHERE email = ?");
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();

    if(rs.next()) {
%>
<script>
  alert('Email sudah terdaftar! Silakan gunakan email lain.');
  window.location = 'Form_Register.jsp';
</script>
<%
    } else {
      rs.close();
      ps.close();

      // Insert data user baru
      ps = conn.prepareStatement("INSERT INTO user (nama, email, password) VALUES (?, ?, ?)");
      ps.setString(1, nama);
      ps.setString(2, email);
      ps.setString(3, password); // Untuk keamanan, sebaiknya password di-hash dulu
      int result = ps.executeUpdate();

      if(result > 0) {
%>
<script>
  alert('Registrasi berhasil! Silakan login.');
  window.location = 'Form_Login.jsp';
</script>
<%
      } else {
%>
<script>
  alert('Registrasi gagal! Silakan coba lagi.');
  window.location = 'Form_Register.jsp';
</script>
<%
      }
    }
  } catch(Exception e) {
%>
<p>Error: <%= e.getMessage() %></p>
<%
  } finally {
    if(ps != null) ps.close();
    if(conn != null) conn.close();
  }
%>
</body>
</html>
