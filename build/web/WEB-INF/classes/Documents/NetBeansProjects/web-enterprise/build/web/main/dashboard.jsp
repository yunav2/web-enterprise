<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Autentikasi Admin
    Boolean isLoggedIn = (Boolean) session.getAttribute("loggedIn");
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    
    if (isLoggedIn == null || !isLoggedIn || isAdmin == null || !isAdmin) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Ambil user ID dari session
    String userID = (String) session.getAttribute("userID");
    String userName = "";

    java.sql.Connection conn = null;
    java.sql.PreparedStatement pstmt = null;
    java.sql.ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/web_enterprise", "root", "");
        String query = "SELECT nama FROM user WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("nama");
        }
    } catch (Exception e) {
        e.printStackTrace();
        userName = (String) session.getAttribute("userName");
        if (userName == null) userName = "Admin";
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <title>RUTTHSHOP Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .navbar-brand {
      font-weight: 700;
      font-size: 1.5rem;
      color: orange;
    }
    .nav-link.active {
      font-weight: 700;
      color: orange !important;
    }
    .search-bar {
      max-width: 300px;
    }
    #nav-tabs {
      display: flex;
      justify-content: center;
      width: 100%;
    }
    .welcome-text {
      margin-top: 40px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      text-align: left;
    }
    .welcome-text h2 {
      font-size: 2.5rem;
      font-weight: 700;
    }
    .welcome-text p {
      font-size: 1.25rem;
      color: #555;
    }
    #tab-content {
      margin-top: 30px;
    }
    .btn-settings {
      border: none;
      background: transparent;
      cursor: pointer;
      color: orange;
      font-size: 1.25rem;
      padding: 0;
    }
    .btn-settings:hover {
      color: #000;
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container-fluid">
      <a class="navbar-brand" href="dashboard.jsp">RUTTHSHOP</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mx-auto mb-2 mb-lg-0" id="nav-tabs">
          <li class="nav-item">
            <a class="nav-link active" href="dashboard.jsp">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="account_list.jsp">Data User</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="barang.jsp">Data Barang</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="transaksi.jsp">Data Transaksi</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-danger" href="logout.jsp">Logout</a>
          </li>
        </ul>
        <form class="d-flex" role="search" onsubmit="return false;">
          <input class="form-control me-2 search-bar" type="search" placeholder="Search" aria-label="Search" />
          <button class="btn btn-outline-primary" type="submit">Search</button>
        </form>
        <button class="btn-settings ms-3" title="Settings" aria-label="Settings">
          <i class="bi bi-gear"></i>
        </button>
      </div>
    </div>
  </nav>

  <!-- Main Content -->
  <div class="container mt-5">
    <div class="welcome-text">
      <h2>Selamat Datang, <%= userName %> 👋</h2>
      <p>Anda login sebagai <strong>Admin</strong>. Gunakan menu navigasi di atas untuk mengelola data.</p>
    </div>

    <div id="tab-content" class="row mt-4">
      <div class="col-md-6">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h5 class="card-title"><i class="bi bi-person-lines-fill me-2"></i>Manajemen Pengguna</h5>
            <p class="card-text">Kelola daftar pengguna dalam sistem.</p>
            <a href="account_list.jsp" class="btn btn-warning">Lihat Pengguna</a>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h5 class="card-title"><i class="bi bi-box-seam me-2"></i>Manajemen Barang</h5>
            <p class="card-text">Kelola daftar produk/barang.</p>
            <a href="barang.jsp" class="btn btn-warning">Lihat Barang</a>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h5 class="card-title"><i class="bi bi-receipt me-2"></i>Data Transaksi</h5>
            <p class="card-text">Kelola data transaksi penjualan.</p>
            <a href="transaksi.jsp" class="btn btn-warning">Lihat Transaksi</a>
          </div>
        </div>
      </div>

      <div class="col-md-6">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h5 class="card-title"><i class="bi bi-person-circle me-2"></i>Profil Anda</h5>
            <p class="card-text">Edit informasi profil admin Anda.</p>
            <a href="account_update.jsp" class="btn btn-warning">Edit Profil</a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
