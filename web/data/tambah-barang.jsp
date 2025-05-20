<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, java.nio.file.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%
    request.setCharacterEncoding("UTF-8");

    // Cek login
    Object isLoggedInObj = session.getAttribute("loggedIn");
    boolean isLoggedIn = false;
    if (isLoggedInObj instanceof Boolean) {
        isLoggedIn = (Boolean) isLoggedInObj;
    } else if (isLoggedInObj instanceof String) {
        isLoggedIn = Boolean.parseBoolean((String) isLoggedInObj);
    }
    if (!isLoggedIn) {
        response.sendRedirect("../form/Form_Login.jsp?error=Silakan login terlebih dahulu");
        return;
    }

    // Cek metode POST
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("../main/dashboard.jsp?error=Form tidak valid");
        return;
    }

    // Ambil parameter
    String nama_barang = request.getParameter("nama_barang");
    String deskripsi_barang = request.getParameter("deskripsi_barang");
    String harga_barang = request.getParameter("harga_barang");
    String stok_barang = request.getParameter("stok_barang");
    int stok = 0;
    double harga = 0;

    // Validasi input
    if (nama_barang == null || nama_barang.trim().isEmpty()) {
        response.sendRedirect("../main/dashboard.jsp?error=Nama barang harus diisi!");
        return;
    }

    try {
        harga = Double.parseDouble(harga_barang);
    } catch (NumberFormatException e) {
        response.sendRedirect("../main/dashboard.jsp?error=Harga harus berupa angka!");
        return;
    }

    try {
        stok = Integer.parseInt(stok_barang);
        if (stok < 0) {
            response.sendRedirect("../main/dashboard.jsp?error=Stok tidak boleh negatif!");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("data-barang.jsp?error=Stok harus berupa angka bulat!");
        return;
    }

    // Proses upload gambar
    String gambar_barang = "";
    Part filePart = null;
    try {
        if (request.getContentType() != null && request.getContentType().toLowerCase().contains("multipart/form-data")) {
            filePart = request.getPart("gambar_barang");
        }
    } catch (Exception e) {
        System.out.println("Error getting file part: " + e.getMessage());
    }

    if (filePart != null && filePart.getSize() > 0) {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExt = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = "barang_" + System.currentTimeMillis() + fileExt;
        gambar_barang = uniqueFileName;

        // Path ke build/assets/img
        String buildPath = application.getRealPath("") + File.separator + "assets" + File.separator + "img";
        File buildDir = new File(buildPath);
        if (!buildDir.exists()) buildDir.mkdirs();
        filePart.write(buildPath + File.separator + uniqueFileName);

        // Copy ke web/assets/img
        try {
            String rootPath = new File(application.getRealPath("")).getParentFile().getParent();
            String persistentPath = rootPath + File.separator + "web" + File.separator + "assets" + File.separator + "img";
            File persistentDir = new File(persistentPath);
            if (!persistentDir.exists()) persistentDir.mkdirs();

            Files.copy(
                new File(buildPath + File.separator + uniqueFileName).toPath(),
                new File(persistentPath + File.separator + uniqueFileName).toPath(),
                StandardCopyOption.REPLACE_EXISTING
            );
        } catch (Exception e) {
            System.out.println("Gagal copy gambar ke web/assets/img: " + e.getMessage());
        }
    }

    // Simpan ke database
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yuna?autoReconnect=true&useSSL=false", "root", "");
        String sql = "INSERT INTO barang (nama_barang, deskripsi_barang, harga_barang, stok_barang, gambar_barang) VALUES (?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, nama_barang);
        ps.setString(2, deskripsi_barang);
        ps.setDouble(3, harga);
        ps.setInt(4, stok);
        ps.setString(5, gambar_barang);

        int result = ps.executeUpdate();
        if (result > 0) {
            response.sendRedirect("../main/dashboard.jsp?success=Barang berhasil ditambahkan");
        } else {
            response.sendRedirect("../main/dashboard.jsp?error=Gagal menambahkan barang");
        }

    } catch (Exception e) {
        response.sendRedirect("../main/dashboard.jsp?error=Error: " + e.getMessage());
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
