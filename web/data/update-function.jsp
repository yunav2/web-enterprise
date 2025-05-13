<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
  String id = request.getParameter("id");
  String nama = request.getParameter("nama");
  String email = request.getParameter("email");
  String action = request.getParameter("action");
  String message = null;

  if ("update".equals(action)) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
      String sql = "UPDATE user SET nama = ?, email = ? WHERE id = ?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, request.getParameter("nama"));
      pstmt.setString(2, request.getParameter("email"));
      pstmt.setInt(3, Integer.parseInt(request.getParameter("id")));
      int updated = pstmt.executeUpdate();

      if (updated > 0) {
        response.sendRedirect("data-user.jsp");
        return;
      } else {
        message = "Update gagal, data tidak ditemukan.";
      }
    } catch(Exception e) {
      message = "Error saat update: " + e.getMessage();
    } finally {
      if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
      if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Edit User</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body { background: #f8f9fa; }
    .container { margin-top: 60px; max-width: 600px; }
  </style>
</head>
<body>
<div class="container">
  <h3>Edit Data User</h3>
  <% if (message != null) { %>
    <div class="alert alert-danger"><%= message %></div>
  <% } %>
  <form action="update-function.jsp" method="post">
    <input type="hidden" name="id" value="<%= id %>" />
    <input type="hidden" name="action" value="update" />
    <div class="mb-3">
      <label for="nama" class="form-label">Nama</label>
      <input type="text" class="form-control" id="nama" name="nama" value="<%= nama %>" required />
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Email</label>
      <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required />
    </div>
    <button type="submit" class="btn btn-primary">Update</button>
    <a href="data-user.jsp" class="btn btn-secondary">Batal</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
