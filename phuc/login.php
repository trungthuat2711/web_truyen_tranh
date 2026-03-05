<?php
session_start();
$conn = new mysqli("localhost","root","","db_ctu_comic");

$error = "";

if(isset($_POST['username']))
{
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM tai_khoan
            WHERE ten_dang_nhap='$username'
            AND mat_khau='$password'";

    $result = $conn->query($sql);

    if($result->num_rows > 0)
    {
        $row = $result->fetch_assoc();

        $_SESSION['user_id'] = $row['ma_tk'];
        $_SESSION['username'] = $row['ten_dang_nhap'];
        $_SESSION['role'] = $row['vai_tro'];

        header("Location: index.php");
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
    <title>Shop Truyện Tranh</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="style.css">
</head>

<body class="d-flex flex-column min-vh-100 login-bg">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
    <div class="container">

        <a class="navbar-brand fw-bold" href="index.php">
            CTU COMIC
        </a>

        <button class="navbar-toggler" 
                type="button" 
                data-bs-toggle="collapse" 
                data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">

            <div class="d-flex align-items-center flex-grow-1 justify-content-between">

                <form class="d-flex flex-grow-1 mx-5"
                      method="GET"
                      action="index.php"
                      style="max-width:600px;">

                    <div class="input-group">
                        <input class="form-control"
                               type="search"
                               name="keyword"
                               placeholder="Tìm truyện...">

                        <button class="btn btn-warning" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </form>

                <div class="text-white mx-4">
                    <span class="fw-bold">Hotline:</span>
                    <span class="text-warning">0909 123 456</span>
                </div>

                <ul class="navbar-nav d-flex flex-row gap-3">

                    <li class="nav-item">
                        <a class="nav-link" href="cart.php">
                            <i class="fa fa-shopping-cart"></i> Giỏ hàng
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="login.php">
                            <i class="fa fa-user"></i> Đăng nhập
                        </a>
                    </li>

                </ul>

            </div>
        </div>
    </div>
</nav>


<div class="container mt-5">

    <div class="auth-box">

        <div class="auth-card">

            <h3 class="auth-title">
                Đăng nhập
            </h3>

            <?php if($error != ""){ ?>
                <div class="alert alert-danger">
                    <?php echo $error ?>
                </div>
            <?php } ?>

            <form method="post">

                <div class="mb-3">
                    <label>Tên đăng nhập</label>
                    <input type="text"
                           name="username"
                           class="form-control"
                           required>
                </div>

                <div class="mb-3">
                    <label>Mật khẩu</label>
                    <input type="password"
                           name="password"
                           class="form-control"
                           required>
                </div>

                <button class="btn btn-warning w-100">
                    Đăng nhập
                </button>

            </form>

            <div class="auth-link">
                <a href="register.php">
                    Chưa có tài khoản? Đăng ký
                </a>
            </div>

        </div>
    </div>

</div>


<footer class="bg-dark text-white text-center py-3 mt-auto">
    <div class="container">
        <p class="mb-1">© 2026 Shop Truyện Tranh</p>
        <p class="mb-0">Email: shoptruyen@gmail.com | 0123 456 789</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>