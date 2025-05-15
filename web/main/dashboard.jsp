<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // Contoh: pastikan session sudah ada atribut "username" saat user login
  // Jika belum ada, Anda bisa set session ini di halaman login atau servlet login
  // session.setAttribute("username", "NamaUserContoh");
%>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <title>RUTTHSHOP Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
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
    /* Navbar menu tabs centered */
    #nav-tabs {
      display: flex;
      justify-content: center;
      width: 100%;
    }
    .welcome-text {
      margin-top: 40px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      text-align: left; /* Rata kiri */
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
    /* Style for settings button */
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
            <a class="nav-link active" href="#" data-tab="dashboard">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" data-tab="data-user">Data User</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" data-tab="data-barang">Data Barang</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" data-tab="data-transaksi">Data Transaksi</a>
          </li>
        </ul>
        <form class="d-flex" role="search" onsubmit="return false;">
          <input class="form-control me-2 search-bar" type="search" placeholder="Search" aria-label="Search" />
          <button class="btn btn-outline-primary" type="submit">Search</button>
        </form>
        <button class="btn-settings ms-3" title="Settings" aria-label="Settings">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
            class="bi bi-gear" viewBox="0 0 16 16">
            <path
              d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492zM5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0z" />
            <path
              d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.54 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.901 2.54-2.54l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.901-3.433-2.54-2.54l-.292.159a.873.873 0 0 1-1.255-.52l-.094-.319zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.69 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.69l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.69l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.69 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.69-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291a1.873 1.873 0 0 0-1.116-2.69l-.318-.094c-.835-.246-.835-1.428 0-1.674l.319-.094a1.873 1.873 0 0 0 1.115-2.69l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.291.159a1.873 1.873 0 0 0 2.69-1.116l.094-.318z" />
          </svg>
        </button>
      </div>
    </div>
  </nav>

  <!-- Main Content -->
  <div class="container">
    <div id="tab-content">
      <!-- Dashboard Tab -->
      <div id="dashboard" class="tab-pane active">
        <div class="welcome-text">
          <h2>Wasuppp Ma G !!</h2>
          <p>Gimane Kabarnya ??</p>
        </div>
      </div>

      <!-- Data User Tab -->
      <div id="data-user" class="tab-pane" style="display:none;">
        <iframe src="../data/data-user.jsp" style="width:100%; height:600px; border:none;"></iframe>
      </div>

      <!-- Data Barang Tab -->
      <div id="data-barang" class="tab-pane" style="display:none;">
        <iframe src="../data/data-barang.jsp" style="width:100%; height:600px; border:none;"></iframe>
      </div>

      <!-- Data Transaksi Tab -->
      <div id="data-transaksi" class="tab-pane" style="display:none;">
        <iframe src="../data/data-transaksi.jsp" style="width:100%; height:600px; border:none;"></iframe>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Tab switching logic
    document.querySelectorAll('#nav-tabs .nav-link').forEach(link => {
      link.addEventListener('click', function (e) {
        e.preventDefault();
        // Remove active class from all tabs
        document.querySelectorAll('#nav-tabs .nav-link').forEach(nav => nav.classList.remove('active'));
        // Hide all tab panes
        document.querySelectorAll('#tab-content .tab-pane').forEach(pane => pane.style.display = 'none');

        // Activate clicked tab
        this.classList.add('active');
        const tabId = this.getAttribute('data-tab');
        const tabPane = document.getElementById(tabId);
        if (tabPane) {
          tabPane.style.display = 'block';
        }
      });
    });
  </script>
</body>
</html>
