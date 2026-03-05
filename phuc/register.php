<?php
$conn = new mysqli("localhost","root","","db_ctu_comic");

$message = "";

if(isset($_POST['username']))
{
    $username  = $_POST['username'];
    $email     = $_POST['email'];
    $password  = $_POST['password'];
    $password2 = $_POST['password2'];

    if($password != $password2)
    {
        $message = "Mật khẩu nhập lại không đúng";
    }
    else
    {
        $sql = "INSERT INTO tai_khoan
                (ten_dang_nhap,mat_khau,email,vai_tro)
                VALUES('$username','$password','$email','khach')";

        if($conn->query($sql) === TRUE)
        {
            $message = "Đăng ký thành công";
        }
        else
        {
            $message = "Lỗi đăng ký";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">
    <title>Shop Truyện Tranh</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icon -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="style.css">

</head>

<body class="d-flex flex-column min-vh-100 register-bg">

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

                        <button class="btn btn-warning">
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
                Đăng ký tài khoản
            </h3>

            <?php if($message != ""){ ?>

                <div class="alert alert-info">
                    <?php echo $message ?>
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
                    <label>Email</label>

                    <input type="email"
                           name="email"
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


                <div class="mb-3">
                    <label>Nhập lại mật khẩu</label>

                    <input type="password"
                           name="password2"
                           class="form-control"
                           required>
                </div>


                <button class="btn btn-success w-100">
                    Đăng ký
                </button>

            </form>

            <div class="auth-link">

                <a href="login.php">
                    Đã có tài khoản? Đăng nhập
                </a>

            </div>

        </div>

    </div>

</div>


<footer class="bg-dark text-white text-center py-3 mt-auto">

    <div class="container">

        <p class="mb-1">© 2026 Shop Truyện Tranh</p>

        <p class="mb-0">
            Email: shoptruyen@gmail.com | 0123 456 789
        </p>

    </div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>