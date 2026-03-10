<?php
require_once __DIR__ . '/cart_functions.php';
$headerFlash = getFlash();
?>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Shop Truyện Tranh</title>

    <!-- favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="assets/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="assets/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/favicon/favicon-16x16.png">
    <link rel="manifest" href="assets/favicon/site.webmanifest">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome (icon) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

    <!-- style css -->
    <link rel="stylesheet" href="assets/css/style.css">

    <?php if (!empty($extraHead)) {
        echo $extraHead;
    } ?>

</head>

<body class="d-flex flex-column min-vh-100">

    <!-- điều hướng -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark py-4 sticky-top">
        <div class="container">

            <!-- logo -->
            <a class="navbar-brand fw-bold logo-name" href="index.php">
                CTU COMIC
            </a>

            <!-- hamburger menu -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">

                <div class="d-flex flex-column flex-lg-row align-items-lg-center flex-grow-1 justify-content-between gap-3"
                    style="white-space: nowrap;">
                    <!-- Search -->
                    <form class="d-flex w-100 w-lg-auto flex-lg-grow-1 mx-lg-3" method="GET"
                        action="products.php" onsubmit="return checkSearch()">
                        <?php if (isset($_GET['sort'])) { ?>
                            <input type="hidden" name="sort" value="<?php echo $_GET['sort']; ?>">
                        <?php } ?>
                        <div class=" input-group">
                            <input class="form-control" type="search" name="keyword" placeholder="Tìm truyện...">
                            <button class="btn btn-search" type="submit">
                                <i class="fa-solid fa-magnifying-glass" style="color: inherit;"></i>
                            </button>
                        </div>
                    </form>

                    <!-- Hotline -->
                    <div class="text-white mx-4 d-none d-lg-block">
                        <span class="hotline">Hotline:</span>
                        <span>0909 123 456</span>
                    </div>

                    <!-- Menu -->
                    <ul class="navbar-nav d-flex flex-row gap-3">
                        <li class="nav-item">
                            <a class="nav-link" href="cart.php">
                                <i class="fa fa-cart-shopping" style="color: #eb7c26;"></i> Giỏ hàng
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

            </div>
        </div>
    </nav>

    <div class="container mt-4">
    <?php if (!empty($headerFlash)): ?>
    <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
        <?php echo htmlspecialchars($headerFlash); ?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
    </div>
    <?php endif; ?>