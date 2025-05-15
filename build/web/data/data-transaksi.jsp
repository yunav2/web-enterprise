<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Data Transaksi</title>
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
    .detail-barang {
      font-size: 0.9rem;
      color: #333;
    }
  </style>
</head>
<body>
<div class="container">
  <h3 class="mb-4">Data Transaksi Nih Gann !</h3>
  <a href="tambah-transaksi.jsp" class="btn btn-primary mb-3">Tambah Transaksi</a>
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <th>No</th>
        <th>Nama User</th>
        <th>Detail Barang</th>
        <th>Total Jumlah Barang</th>
        <th>Total Biaya</th>
        <th>Aksi</th>
      </tr>
    </thead>
    <tbody>
<%
  Connection conn = null;
  PreparedStatement psTransaksi = null;
  PreparedStatement psDetail = null;
  ResultSet rsTransaksi = null;
  ResultSet rsDetail = null;
  int no = 1;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");

    // Query untuk mengambil data transaksi beserta nama user
    // Asumsi tabel transaksi punya kolom: id, user_id, total_biaya
    // Asumsi tabel detail_transaksi punya kolom: id, transaksi_id, barang_id, jumlah
    // Asumsi tabel barang punya kolom: id, nama_barang, harga_barang
    // Asumsi tabel user sudah ada seperti info Anda

    String sqlTransaksi = "SELECT t.id, u.nama, t.total_biaya FROM transaksi t JOIN user u ON t.user_id = u.id ORDER BY t.id DESC";
    psTransaksi = conn.prepareStatement(sqlTransaksi);
    rsTransaksi = psTransaksi.executeQuery();

    while(rsTransaksi.next()) {
      String transaksiId = rsTransaksi.getString("id");
      String namaUser = rsTransaksi.getString("nama");
      double totalBiaya = rsTransaksi.getDouble("total_biaya");

      // Ambil detail barang untuk transaksi ini
      String sqlDetail = "SELECT b.nama_barang, dt.jumlah FROM detail_transaksi dt JOIN barang b ON dt.barang_id = b.id WHERE dt.transaksi_id = ?";
      psDetail = conn.prepareStatement(sqlDetail);
      psDetail.setString(1, transaksiId);
      rsDetail = psDetail.executeQuery();

      // Simpan detail barang dan jumlah dalam list untuk ditampilkan
      List<String> detailList = new ArrayList<>();
      int totalJumlahBarang = 0;
      while(rsDetail.next()) {
        String namaBarang = rsDetail.getString("nama_barang");
        int jumlah = rsDetail.getInt("jumlah");
        totalJumlahBarang += jumlah;
        detailList.add(namaBarang + " (x" + jumlah + ")");
      }
%>
      <tr>
        <td><%= no++ %></td>
        <td><%= namaUser %></td>
        <td class="detail-barang">
          <ul style="padding-left: 20px; margin-bottom: 0;">
            <% for(String detail : detailList) { %>
              <li><%= detail %></li>
            <% } %>
          </ul>
        </td>
        <td><%= totalJumlahBarang %></td>
        <td>Rp <%= String.format("%,.2f", totalBiaya) %></td>
        <td>
          <form action="update-transaksi.jsp" method="post" class="d-inline">
            <input type="hidden" name="id" value="<%= transaksiId %>" />
            <button type="submit" class="btn btn-edit btn-sm">Edit</button>
          </form>

          <form action="delete-transaksi.jsp" method="post" class="d-inline" onsubmit="return confirm('Yakin ingin menghapus data ini?');">
            <input type="hidden" name="id" value="<%= transaksiId %>" />
            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
          </form>
        </td>
      </tr>
<%
      if (rsDetail != null) { rsDetail.close(); }
      if (psDetail != null) { psDetail.close(); }
    }
  } catch(Exception e) {
    out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
  } finally {
    if (rsTransaksi != null) try { rsTransaksi.close(); } catch(Exception e) {}
    if (psTransaksi != null) try { psTransaksi.close(); } catch(Exception e) {}
    if (conn != null) try { conn.close(); } catch(Exception e) {}
  }
%>
    </tbody>
  </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
