<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>MC6 - Fashion & Luxury E-Commerce</title>

  <!-- Bootstrap Icons CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    /* Reset dan dasar */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Poppins', Poppins, Arial, sans-serif;
    }
    body {
      background-color: white; /* ubah ke gelap */
      color: #eee;
      line-height: 1.5;
      font-weight: 300;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
    a {
      text-decoration: none;
      color: inherit;
    }

    /* Header */
    header {
      background-color: #1c1c1c;
      padding: 20px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      border-bottom: 1px solid #333;
    }
    .logo {
      font-size: 2rem;
      font-weight: 700;
      letter-spacing: 3px;
      color: #d4af37; /* gold accent */
      font-family: 'Georgia', serif;
      cursor: default;
    }
    nav {
      display: flex;
      gap: 30px;
      flex-wrap: wrap;
    }
    nav a {
      color: #eee; /* putih terang */
      font-weight: 400;
      font-size: 1rem;
      padding: 8px 12px;
      border-radius: 4px;
      transition: background-color 0.3s ease, color 0.3s ease;
    }
    nav a:hover {
      background-color: #d4af37; /* gold hover */
      color: #121212;
    }

    /* Search bar */
    .search-container {
      margin-left: 30px;
      flex-grow: 1;
      max-width: 320px;
    }
    .search-container input[type="text"] {
      width: 100%;
      padding: 10px 16px;
      border-radius: 30px;
      border: none;
      outline: none;
      font-size: 1rem;
      background-color: #2a2a2a;
      color: #eee;
      transition: background-color 0.3s ease;
    }
    .search-container input[type="text"]::placeholder {
      color: #aaa;
    }
    .search-container input[type="text"]:focus {
      background-color: #3a3a3a;
    }

    /* Cart icon */
    .cart-icon {
      position: relative;
      font-size: 1.8rem;
      cursor: pointer;
      margin-left: 30px;
      color: #eee;
      transition: color 0.3s ease;
    }
    .cart-icon:hover {
      color: #d4af37;
    }
    .cart-count {
      position: absolute;
      top: -8px;
      right: -12px;
      background-color: #d4af37;
      color: #121212;
      font-size: 0.75rem;
      padding: 3px 7px;
      border-radius: 50%;
      font-weight: 700;
      font-family: 'Poppins', Poppins, Arial, sans-serif;
    }

    /* Banner */
    .banner {
      position: relative;
      max-width: 1000vh;
      overflow: hidden;
    }
    .banner img {
      width: 100%;
      height: 400px;
      object-fit: cover;
      display: block;
      filter: brightness(0.75);
      transition: filter 0.3s ease;
    }
    .banner:hover img {
      filter: brightness(0.9);
    }
    .banner-text {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: #d4af37;
      text-align: center;
      font-family: 'Poppins', serif;
      font-weight: 700;
      font-size: 3rem;
      text-shadow: 0 0 10px rgba(212,175,55,0.8);
      user-select: none;
      pointer-events: none;
    }

    /* Produk grid */
    .product-grid {
      max-width: 1000vh;
      display: grid;
      margin: 100px 0;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 28px;
      padding: 0 40px;
    }
    .product-card {
      background-color: #1e1e1e;
      display: flex;
      flex-direction: column;
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
    }
/*    .product-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 10px 25px rgba(212,175,55,0.7);
    }*/
    .product-image {
      width: 100%;
      height: 220px;
      object-fit: cover;
      border-bottom: 1px solid #333;
      transition: transform 0.3s ease;
    }
    .product-card:hover .product-image {
      transform: scale(1.05);
    }
    .product-info {
      padding: 18px 20px;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .product-name {
      font-weight: 600;
      margin-bottom: 10px;
      font-size: 15px;
      color: #d4af37;
      font-family: 'Poppins', serif;
    }
    
    .price-link-container {
    display: flex;
    align-items: center;
    gap: 12px; /* Jarak antara harga dan link */
    margin-top: 12px;
  }

  .product-price {
    font-weight: 700;
    color: #eee;
    margin-bottom: 0; /* Hilangkan margin bawah agar sejajar */
    font-size: 15px;
    white-space: nowrap; /* Agar harga tidak terpotong */
  }

  .buy-link {
    color: #d4af37;
    font-weight: 700;
    font-size: 1rem;
    text-decoration: underline;
    cursor: pointer;
    user-select: none;
    transition: color 0.3s ease;
    margin-left: 75px;
  }

  .buy-link:hover,
  .buy-link:focus {
    color: #fff;
    outline: none;
  }


    /* Footer */
    footer {
      background-color: #1c1c1c;
      color: #777;
      padding: 30px 40px;
      text-align: center;
      font-size: 0.9rem;
      border-top: 1px solid #333;
      font-weight: 300;
    }
    footer a {
      padding: 10px 0;
      color: #d4af37;
      margin: 0 12px;
      font-weight: 600;
      transition: color 0.3s ease;
    }
    footer a:hover {
      color: #eee;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      header {
        padding: 15px 20px;
      }
      .search-container {
        margin-left: 15px;
        max-width: 200px;
      }
      .banner {
        margin: 20px 20px;
      }
      .banner img {
        height: 280px;
      }
      .banner-text {
        font-size: 2rem;
      }
      .product-grid {
        padding: 0 20px;
        gap: 20px;
      }
      .product-card {
        border-radius: 8px;
      }
      .product-image {
        height: 180px;
      }
    }
    @media (max-width: 480px) {
      header {
        flex-direction: column;
        align-items: flex-start;
      }
      nav {
        width: 100%;
        justify-content: flex-start;
        gap: 15px;
        margin-top: 12px;
      }
      .search-container {
        margin: 12px 0;
        max-width: 100%;
        width: 100%;
      }
      .cart-icon {
        margin-left: 0;
        margin-top: 12px;
      }
    }
  </style>
</head>
<body>

  <header>
    <div class="logo">MC6</div>
    <nav>
      <a href="#">Beranda</a>
      <a href="#">Kacamata</a>
      <a href="#">Sepatu</a>
      <a href="#">Aksesoris</a>
      <a href="#">Promo</a>
      <a href="#">Kontak</a>
    </nav>
    <div class="search-container">
      <input type="text" placeholder="Cari produk..." aria-label="Cari produk" />
    </div>
    <div class="cart-icon" aria-label="Keranjang Belanja" role="button" tabindex="0">
      <i class="bi bi-cart"></i>
      <span class="cart-count">5</span>
    </div>
  </header>

  <section class="banner" aria-label="Banner Promo">
    <img src="https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=1200&q=80" alt="Banner Promo MC6" />
    <div class="banner-text">Eksklusif & Stylish</div>
  </section>

 <section class="product-grid" aria-label="Daftar Produk MC6">
  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=400&q=80" alt="Kacamata Hitam Stylish" />
    <div class="product-info">
      <h3 class="product-name">Kacamata Hitam</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 1.250.000</p>
        <a href="#" class="buy-link" aria-label="Beli Kacamata Hitam">Beli</a>
      </div>
    </div>
  </article>

  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1512499617640-c2f99912a0f9?auto=format&fit=crop&w=400&q=80" alt="Sepatu Sneakers Premium" />
    <div class="product-info">
      <h3 class="product-name">Sepatu Sneakers</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 2.100.000</p>
        <a href="#" class="buy-link" aria-label="Beli Sepatu Sneakers">Beli</a>
      </div>
    </div>
  </article>
     
      <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1512499617640-c2f99912a0f9?auto=format&fit=crop&w=400&q=80" alt="Sepatu Sneakers Premium" />
    <div class="product-info">
      <h3 class="product-name">Sepatu Sneakers</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 2.100.000</p>
        <a href="#" class="buy-link" aria-label="Beli Sepatu Sneakers">Beli</a>
      </div>
    </div>
  </article>

  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1503602642458-232111445657?auto=format&fit=crop&w=400&q=80" alt="Tas Kulit Eksklusif" />
    <div class="product-info">
      <h3 class="product-name">Tas Kulit</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 3.500.000</p>
        <a href="#" class="buy-link" aria-label="Beli Tas Kulit">Beli</a>
      </div>
    </div>
  </article>
     
  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1503602642458-232111445657?auto=format&fit=crop&w=400&q=80" alt="Tas Kulit Eksklusif" />
    <div class="product-info">
      <h3 class="product-name">Tas Kulit</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 3.500.000</p>
        <a href="#" class="buy-link" aria-label="Beli Tas Kulit">Beli</a>
      </div>
    </div>
  </article>
     
  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1503602642458-232111445657?auto=format&fit=crop&w=400&q=80" alt="Tas Kulit Eksklusif" />
    <div class="product-info">
      <h3 class="product-name">Tas Kulit</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 3.500.000</p>
        <a href="#" class="buy-link" aria-label="Beli Tas Kulit">Beli</a>
      </div>
    </div>
  </article>

  <article class="product-card" tabindex="0">
    <img class="product-image" src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=400&q=80" alt="Jam Tangan Mewah" />
    <div class="product-info">
      <h3 class="product-name">Jam Tangan</h3>
      <div class="price-link-container">
        <p class="product-price">Rp 4.750.000</p>
        <a href="#" class="buy-link" aria-label="Beli Jam Tangan">Beli</a>
      </div>
    </div>
  </article>
</section>




  <footer>
    <p> Rutth-Shop</p>
    <p>
      <a href="#">Kebijakan Privasi</a> | 
      <a href="#">Syarat & Ketentuan</a> | 
      <a href="#">Kontak</a>
    </p>
  </footer>

</body>
</html>
