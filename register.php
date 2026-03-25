<?php
$conn = new mysqli("localhost","root","","comic_store");

$message = "";

if(isset($_POST['username']))
{
    $username  = $_POST['username'];
    $email     = $_POST['email'];
    $password  = md5($_POST['password']);
    $password2 = md5($_POST['password2']);

    if($password != $password2)
    {
        $message = "Mật khẩu xác nhận không đúng!";
    }
    else
    {
        // kiểm tra trùng username
        $checkName = "SELECT * FROM tai_khoan WHERE ten_dang_nhap='$username'";
        $result = $conn->query($checkName);

        if($result->num_rows > 0)
        {
            $message = "Tên đăng nhập đã tồn tại!";
        }
        else
        {
            $checkEmail = "SELECT * FROM tai_khoan WHERE email='$email'";
            $result = $conn->query($checkEmail);
            if($result->num_rows > 0)
            {
                $message = "Email đã tồn tại!";
            }
            else{
                $sql = "INSERT INTO tai_khoan
                    (ten_dang_nhap,mat_khau,email,vai_tro)
                    VALUES('$username','$password','$email','khach')";

                if($conn->query($sql) === TRUE)
                {
                    header("Location: login.php");
                    exit();
                }
                else
                {
                    $message = "Lỗi đăng ký";
                }
            }
        }
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

    <link rel="stylesheet" href=".\assets\css\style1.css">
</head>

<body class="d-flex flex-column min-vh-100 register-bg">

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4 sticky-top">
        <div class="container">

            <a class="navbar-brand fw-bold logo-name" href="index.php">
                CTU COMIC
            </a>

            <ul class="navbar-nav d-flex flex-row gap-3">

                <li class="nav-item">
                    <a class="nav-link cart-link" href="cart.php">
                        <span>
                            <i class="fa fa-cart-shopping" style="color: #eb7c26;"></i>
                        </span>
                        <span class="ms-1">Giỏ hàng</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="my_orders.php">
                        <i class="fa fa-receipt" style="color: #eb7c26;"></i> Đơn hàng của tôi
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

                <h3 class="auth-title">
                    Đăng ký tài khoản
                </h3>

                <?php if($message != ""){ ?>

                <div class="alert alert-danger">
                    <?php echo $message ?>
                </div>

                <?php } ?>

                <form method="post">

                    <div class="mb-3">
                        <label>Tên đăng nhập</label>

                        <input type="text" name="username" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Email</label>

                        <input type="email" name="email" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Mật khẩu</label>

                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Nhập lại mật khẩu</label>

                        <input type="password" name="password2" class="form-control" required>
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


    <footer class="bg-dark text-white mt-auto pt-4 pb-3">
        <div class="container text-center">

            <p class="mb-2 fw-bold">© <?php echo date('Y')?> Shop Truyện Tranh</p>

            <p class="mb-3">
                Email: shoptruyen@gmail.com | 0123 456 789
            </p>

            <div class="d-flex justify-content-center gap-4 fs-4">

                <a href="#" class="text-white social-icon">
                    <i class="fa-brands fa-facebook" style="color: #4267b2;"></i>
                </a>

                <a href="#" class="text-white social-icon">
                    <i class="fa-brands fa-instagram" style="color: #cd486b;"></i>
                </a>

                <a href="#" class="text-white social-icon">
                    <i class="fa-brands fa-youtube" style="color: #ff0000;"></i>
                </a>

                <a href="#" class="text-white social-icon">
                    <i class="fab fa-tiktok"></i>
                </a>

            </div>

        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>