<?php
session_start();
$conn = new mysqli("localhost","root","","comic_store");

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

require_once __DIR__ . '/includes/cart_functions.php';

// ===== Đếm số lượng sản phẩm trong giỏ =====
$loginCart = getCart();
$loginCartCount = 0;
if (!empty($loginCart)) {
    foreach ($loginCart as $item) {
        $loginCartCount += isset($item['qty']) ? (int)$item['qty'] : 0;
    }
}

$error = "";

// ===== XỬ LÝ LOGIN =====
if(isset($_POST['username']))
{
    $username = trim($_POST['username']);
    $password = $_POST['password'];
    $password_md5 = md5($password); // dùng cho tài khoản mới

    // hỗ trợ cả password thường (cũ) và md5 (mới)
    $stmt = $conn->prepare("
        SELECT * FROM tai_khoan
        WHERE ten_dang_nhap = ?
        AND (mat_khau = ? OR mat_khau = ?)
    ");
    $stmt->bind_param("sss", $username, $password, $password_md5);
    $stmt->execute();

    $result = $stmt->get_result();

    if($result->num_rows > 0)
    {
        $row = $result->fetch_assoc();

        // ===== xử lý giỏ hàng =====
        $currentCart = getCart();
        $_SESSION['user'] = $row;

        if (!empty($currentCart)) {
            saveCart($currentCart);
        }

        // ===== redirect =====
        if(isset($_SESSION['redirect_url']) && $_SESSION['redirect_url'] != 'login.php'){
            $redirect = $_SESSION['redirect_url'];
            unset($_SESSION['redirect_url']);
            header("Location: " . $redirect);
        } 
        else {
            header("Location: index.php");
        }
        exit();
    }
    else
    {
        $error = "Sai tài khoản hoặc mật khẩu";
    }
}
?>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="./assets/css/style1.css">
</head>

<body class="d-flex flex-column min-vh-100 login-bg">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4 sticky-top">
    <div class="container">

        <a class="navbar-brand fw-bold logo-name" href="index.php">
            CTU COMIC
        </a>

        <ul class="navbar-nav d-flex flex-row gap-3">
            <li class="nav-item">
                <a class="nav-link cart-link" href="cart.php">
                    <span class="cart-icon-wrapper">
                        <i class="fa fa-cart-shopping" style="color: #eb7c26;"></i>
                        <?php if ($loginCartCount > 0): ?>
                            <span class="cart-badge"><?php echo $loginCartCount; ?></span>
                        <?php endif; ?>
                    </span>
                    <span class="ms-1">Giỏ hàng</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="my_orders.php">
                    <i class="fa fa-receipt" style="color: #eb7c26;"></i> Đơn hàng
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="login.php">
                    <i class="fa fa-user" style="color: #eb7c26;"></i> Đăng nhập
                </a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-5">

    <div class="auth-box">
        <div class="auth-card">

            <h3 class="auth-title">Đăng nhập</h3>

            <?php if($error != ""){ ?>
                <div class="alert alert-danger">
                    <?php echo $error ?>
                </div>
            <?php } ?>

            <form method="post">

                <div class="mb-3">
                    <label>Tên đăng nhập</label>
                    <input type="text" name="username" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Mật khẩu</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <button class="btn btn-warning w-100">
                    Đăng nhập
                </button>

            </form>

            <div class="auth-link mt-3 text-center">
                <a href="register.php">
                    Chưa có tài khoản? Đăng ký
                </a>
            </div>

        </div>
    </div>

</div>

<footer class="bg-dark text-white mt-auto pt-4 pb-3">
    <div class="container text-center">
        <p class="mb-2 fw-bold">© <?php echo date('Y')?> Shop Truyện Tranh</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>