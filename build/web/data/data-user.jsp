<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Data User</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body { background: #f8f9fa; }
    .container { margin-top: 60px; }
    .table thead { background-color: #343a40; color: white; }
    .btn-edit { background-color: #ffc107; color: black; }
    .btn-edit:hover { background-color: #e0a800; }
    .btn-danger {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 4px 10px;
      border-radius: 4px;
    }
    .btn-danger:hover {
      background-color: #c82333;
      color: white;
    }
  </style>
</head>
<body>
<div class="container">
  <h3 class="mb-4">Data User Nih Gann !</h3>
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <th>No</th>
        <th>Nama</th>
        <th>Email</th>
        <th>Aksi</th>
      </tr>
    </thead>
    <tbody>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;
  int no = 1;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM user");

    while(rs.next()) {
      String id = rs.getString("id");
      String nama = rs.getString("nama");
      String email = rs.getString("email");
%>
      <tr>
        <td><%= no++ %></td>
        <td><%= nama %></td>
        <td><%= email %></td>
        <td>
          <form action="update-function.jsp" method="post" class="d-inline">
            <input type="hidden" name="id" value="<%= id %>" />
            <input type="hidden" name="nama" value="<%= nama %>" />
            <input type="hidden" name="email" value="<%= email %>" />
            <button type="submit" class="btn btn-edit btn-sm">Edit</button>
          </form>

          <form action="delete-function.jsp" method="post" class="d-inline" onsubmit="return confirm('Yakin ingin menghapus data ini?');">
            <input type="hidden" name="id" value="<%= id %>" />
            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
          </form>
        </td>
      </tr>
<%
    }
  } catch(Exception e) {
    out.println("<tr><td colspan='4' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
  } finally {
    if (rs != null) try { rs.close(); } catch(Exception e) {}
    if (stmt != null) try { stmt.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
  }
%>
    </tbody>
  </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
