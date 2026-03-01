<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Shop Truyện Tranh</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome (icon) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100">

    <!-- ===== NAVBAR ===== -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4">
        <div class="container">

            <!-- Logo -->
            <a class="navbar-brand fw-bold" href="index.php">
                CTU COMIC
            </a>

            <!-- Button mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">

                <div class="d-flex align-items-center flex-grow-1 justify-content-between">
                    <!-- Search -->
                    <form class="d-flex flex-grow-1 mx-5" method="GET" action="index.php" style="max-width:600px;">
                        <div class="input-group">
                            <input class="form-control" type="search" name="keyword" placeholder="Tìm truyện...">
                            <button class="btn btn-warning" type="submit">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Hotline -->
                    <div class="text-white mx-4">
                        <span class="fw-bold">Hotline:</span>
                        <span class="text-warning">0909 123 456</span>
                    </div>

                    <!-- Menu -->
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

    <div class="container mt-4">