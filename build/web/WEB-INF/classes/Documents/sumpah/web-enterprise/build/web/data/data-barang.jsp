<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.nio.file.Paths" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%
  // Proses form submit tambah barang
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    request.setCharacterEncoding("UTF-8");

    // Ambil parameter dengan null-safe dan trim
    String nama_barang = request.getParameter("nama_barang");
    String harga_barang = request.getParameter("harga_barang");
    String stok_barang = request.getParameter("stok_barang");

    if (nama_barang != null) nama_barang = nama_barang.trim();
    else nama_barang = "";

    if (harga_barang != null) harga_barang = harga_barang.trim();
    else harga_barang = "";

    if (stok_barang != null) stok_barang = stok_barang.trim();
    else stok_barang = "";

    String errorMsg = null;
    String fileName = null;

    // Validasi input sederhana (tidak boleh kosong atau hanya spasi)
    if (nama_barang.isEmpty()) {
      errorMsg = "Nama barang harus diisi!";
    } else if (harga_barang.isEmpty()) {
      errorMsg = "Harga barang harus diisi!";
    } else if (stok_barang.isEmpty()) {
      errorMsg = "Stok barang harus diisi!";
    }

    // Jika validasi sukses, proses upload gambar (jika ada)
    if (errorMsg == null) {
      try {
        Part filePart = request.getPart("gambar_barang");
        if (filePart != null && filePart.getSize() > 0) {
          fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
          String uploadPath = application.getRealPath("") + "uploads/";
          java.io.File uploadDir = new java.io.File(uploadPath);
          if (!uploadDir.exists()) uploadDir.mkdir();
          filePart.write(uploadPath + fileName);
        }
      } catch (Exception e) {
        errorMsg = "Gagal upload gambar: " + e.getMessage();
      }
    }

    // Simpan data ke database jika tidak ada error
    if (errorMsg == null) {
      Connection conn = null;
      PreparedStatement ps = null;
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
        String sql = "INSERT INTO barang (nama_barang, harga_barang, stok_barang, gambar_barang) VALUES (?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, nama_barang);
        ps.setString(2, harga_barang);
        ps.setString(3, stok_barang);
        ps.setString(4, fileName != null ? "uploads/" + fileName : null);
        ps.executeUpdate();

        // Redirect agar form tidak submit ulang saat refresh
        response.sendRedirect("data-barang.jsp");
        return;
      } catch (Exception e) {
        errorMsg = "Error simpan data: " + e.getMessage();
      } finally {
        if (ps != null) try { ps.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
      }
    }

    // Jika ada error, tampilkan alert
    if (errorMsg != null) {
%>
      <script>alert("<%= errorMsg.replace("\"", "\\\"") %>");</script>
<%
    }
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Data Barang</title>
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
    img.gambar-barang {
      max-width: 80px;
      max-height: 60px;
      object-fit: contain;
    }
  </style>
</head>
<body>
<div class="container">
  <h3 class="mb-4">Data Barang Nih Gann !</h3>

  <!-- Tombol buka modal tambah barang -->
  <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#tambahBarangModal">
    Tambah Barang
  </button>

  <!-- Tabel data barang -->
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <th>No</th>
        <th>Nama Barang</th>
        <th>Harga Barang</th>
        <th>Stok Barang</th>
        <th>Gambar Barang</th>
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
        rs = stmt.executeQuery("SELECT * FROM barang");

        while(rs.next()) {
          String id = rs.getString("id");
          String nama = rs.getString("nama_barang");
          String harga = rs.getString("harga_barang");
          String stok = rs.getString("stok_barang");
          String gambar = rs.getString("gambar_barang");
    %>
      <tr>
        <td><%= no++ %></td>
        <td><%= nama %></td>
        <td><%= harga %></td>
        <td><%= stok %></td>
        <td>
          <% if (gambar != null && !gambar.trim().isEmpty()) { %>
            <img src="<%= gambar %>" alt="Gambar <%= nama %>" class="gambar-barang" />
          <% } else { %>
            <span class="text-muted">Tidak ada gambar</span>
          <% } %>
        </td>
        <td>
          <!-- Edit dan Delete bisa Anda buat terpisah -->
          <form action="update-barang.jsp" method="post" class="d-inline">
            <input type="hidden" name="id" value="<%= id %>" />
            <input type="hidden" name="nama_barang" value="<%= nama %>" />
            <input type="hidden" name="harga_barang" value="<%= harga %>" />
            <input type="hidden" name="stok_barang" value="<%= stok %>" />
            <input type="hidden" name="gambar_barang" value="<%= gambar %>" />
            <button type="submit" class="btn btn-edit btn-sm">Edit</button>
          </form>

          <form action="delete-barang.jsp" method="post" class="d-inline" onsubmit="return confirm('Yakin ingin menghapus data ini?');">
            <input type="hidden" name="id" value="<%= id %>" />
            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
          </form>
        </td>
      </tr>
    <%
        }
      } catch(Exception e) {
        out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
      } finally {
        if (rs != null) try { rs.close(); } catch(Exception e) {}
        if (stmt != null) try { stmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
      }
    %>
    </tbody>
  </table>
</div>

<!-- Modal Tambah Barang -->
<div class="modal fade" id="tambahBarangModal" tabindex="-1" aria-labelledby="tambahBarangModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="data-barang.jsp" method="post" enctype="multipart/form-data" novalidate>
        <div class="modal-header">
          <h5 class="modal-title" id="tambahBarangModalLabel">Tambah Barang Baru</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="nama_barang" class="form-label">Nama Barang</label>
            <input type="text" class="form-control" id="nama_barang" name="nama_barang" required />
          </div>
          <div class="mb-3">
            <label for="harga_barang" class="form-label">Harga Barang</label>
            <input type="text" class="form-control" id="harga_barang" name="harga_barang" required />
          </div>
          <div class="mb-3">
            <label for="stok_barang" class="form-label">Stok Barang</label>
            <input type="text" class="form-control" id="stok_barang" name="stok_barang" required />
          </div>
          <div class="mb-3">
            <label for="gambar_barang" class="form-label">Gambar Barang</label>
            <input type="file" class="form-control" id="gambar_barang" name="gambar_barang" accept="image/*" />
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
          <button type="submit" class="btn btn-primary">Simpan Barang</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
