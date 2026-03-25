
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style3.css">
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3>ADMIN CTU COMIC</h3>

    <a href="admin.php">
        <i class="fa-solid fa-house"></i> Dashboard
    </a>

    <a href="manage_comics.php">
        <i class="fa-solid fa-book"></i> Quản lý truyện
    </a>

    <a href="manage_orders.php">
        <i class="fa-solid fa-file-invoice"></i> Quản lý đơn hàng
    </a>

    <a href="logout.php">
        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
    </a>
</div>

<!-- Navbar -->
<div class="navbar">
    <!--<div>
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" placeholder="Tìm kiếm...">
    </div>-->

    <div>
        Xin chào, <b><?php echo $_SESSION['user']['ten_dang_nhap']; ?></b>
    </div>
</div>
