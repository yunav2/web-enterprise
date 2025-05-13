<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
  String id = request.getParameter("id");

  if (id == null || id.trim().isEmpty()) {
    out.println("<script>alert('ID tidak ditemukan!'); window.location='data-user.jsp';</script>");
    return;
  }

  Connection conn = null;
  PreparedStatement pstmt = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");

    String sql = "DELETE FROM user WHERE id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);

    int affectedRows = pstmt.executeUpdate();

    if (affectedRows > 0) {
      response.sendRedirect("data-user.jsp");
    } else {
      out.println("<script>alert('Data tidak ditemukan atau gagal dihapus.'); window.location='data-user.jsp';</script>");
    }
  } catch(Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='data-user.jsp';</script>");
  } finally {
    if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
  }
%>
