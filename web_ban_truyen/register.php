<?php
$conn = new mysqli("localhost","root","","comic_store");

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

$message = "";

if(isset($_POST['username']))
{
    $username  = trim($_POST['username']);
    $email     = trim($_POST['email']);
    $password  = $_POST['password'];
    $password2 = $_POST['password2'];
    $phone     = trim($_POST['phone']);
    $address   = trim($_POST['address']);

    if($password != $password2)
    {
        $message = "Mật khẩu nhập lại không đúng";
    }
    else
    {
        // kiểm tra trùng username
        $stmt = $conn->prepare("SELECT ma_tk FROM tai_khoan WHERE ten_dang_nhap = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows > 0)
        {
            $message = "Tên đăng nhập đã tồn tại";
        }
        else
        {
            //  mã hóa MD5
            $hashedPassword = md5($password);

            $stmt = $conn->prepare("
                INSERT INTO tai_khoan
                (ten_dang_nhap, mat_khau, email, so_dien_thoai, dia_chi, vai_tro)
                VALUES (?, ?, ?, ?, ?, 'khach')
            ");

            $stmt->bind_param("sssss", $username, $hashedPassword, $email, $phone, $address);

            if($stmt->execute())
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
?>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <link rel="stylesheet" href="./assets/css/style1.css">
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
                <a class="nav-link" href="cart.php">
                    <i class="fa fa-cart-shopping" style="color: #eb7c26;"></i> Giỏ hàng
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

            <h3 class="auth-title">Đăng ký tài khoản</h3>

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
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Địa chỉ</label>
                    <textarea name="address" class="form-control" required></textarea>
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

            <div class="auth-link mt-3 text-center">
                <a href="login.php">Đã có tài khoản? Đăng nhập</a>
            </div>

        </div>
    </div>
</div>

<footer class="bg-dark text-white mt-auto pt-4 pb-3">
    <div class="container text-center">
        <p class="mb-2 fw-bold">© <?php echo date('Y')?> Shop Truyện</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>