<?php
require "config/database.php";
include "includes/header.php";

// Lấy danh mục
$ds_loai = $conn->query("SELECT * FROM loai_sp");

$result = $conn->query("
    SELECT * FROM san_pham 
    WHERE trang_thai = 1 AND ban_chay = 1"
);
?>

<div class="row">

    <!-- ===== SIDEBAR ===== -->
    <div class="col-md-3">
        <div class="card border-0 rounded-0">
            <div class="card-header bg-dark text-white rounded-0">
                Danh mục
            </div>
            <div class="list-group list-group-flush">
                <?php while($loai = $ds_loai->fetch_assoc()) { ?>
                <a href="products.php?ma_loai=<?php echo $loai['ma_loai'];?>
                    <?php if(isset($_GET['gia'])) echo '&gia='.$_GET['gia']; ?>"
                    class="list-group-item list-group-item-action">
                    <?php echo $loai['ten_loai']; ?>
                </a>
                <?php } ?>
            </div>
        </div>

        <!-- ===== LỌC THEO GIÁ ===== -->
        <div class="card border-0 my-3 rounded-0">
            <div class="card-header bg-dark text-white rounded-0">
                Lọc theo giá
            </div>

            <div class="list-group list-group-flush">

                <a href="products.php?gia=1<?php if(isset($_GET['ma_loai'])) echo '&ma_loai='.$_GET['ma_loai']; ?>"
                    class="list-group-item list-group-item-action">
                    Dưới 50.000đ
                </a>

                <a href="products.php?gia=2<?php if(isset($_GET['ma_loai'])) echo '&ma_loai='.$_GET['ma_loai']; ?>"
                    class="list-group-item list-group-item-action">
                    50.000đ - 100.000đ
                </a>

                <a href="products.php?gia=3<?php if(isset($_GET['ma_loai'])) echo '&ma_loai='.$_GET['ma_loai']; ?>"
                    class="list-group-item list-group-item-action">
                    100.000đ - 200.000đ
                </a>

                <a href="products.php?gia=4<?php if(isset($_GET['ma_loai'])) echo '&ma_loai='.$_GET['ma_loai']; ?>"
                    class="list-group-item list-group-item-action">
                    Trên 200.000đ
                </a>

            </div>
        </div>
    </div>

    <div class="col-md-9">

        <!-- ===== BANNER ===== -->
        <div id="bannerCarousel" class="carousel slide mb-4" data-bs-ride="carousel" data-bs-interval="3500">

            <div class="carousel-inner">

                <div class="carousel-item active">
                    <img src="uploads/banner1.jpg" class="d-block w-100" style="height:420px; object-fit:cover;">
                </div>

                <div class="carousel-item">
                    <img src="uploads/banner2.jpg" class="d-block w-100" style="height:420px; object-fit:cover;">
                </div>

                <div class="carousel-item">
                    <img src="uploads/banner3.jpg" class="d-block w-100" style="height:420px; object-fit:cover;">
                </div>

            </div>
        </div>


        <!-- ===== SẢN PHẨM ===== -->
        <div class="bg-white p-4 mb-5">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0">Truyện tranh bán chạy</h4>

                <a href="products.php" class="text-decoration-none">
                    Xem tất cả <i class="fa fa-arrow-right"></i>
                </a>
            </div>

            <hr>

            <div class="row">
                <?php while($row = $result->fetch_assoc()) { ?>
                <div class="col-lg-3 col-md-4 col-6">
                    <div class="card border-0 h-100 ">

                        <div style="height: 180px; overflow: hidden;" class="d-flex justify-content-center">
                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>">
                                <img src="uploads/<?php echo $row['anh_sp']; ?>"
                                    style="height: 100%; width:auto; object-fit: contain;">
                            </a>
                        </div>

                        <div class="card-body d-flex flex-column p-2">
                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>" class="product-name">
                                <?php echo $row['ten_sp']; ?>
                            </a>

                            <p class="author-name">
                                <?php echo $row['tac_gia']; ?>
                            </p>

                            <p class="product-price fw-bold mb-2">
                                <?php echo number_format($row['gia']); ?>đ
                            </p>

                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>"
                                class="btn btn-sm btn-outline-primary mt-auto">
                                Xem chi tiết
                            </a>
                        </div>

                    </div>
                </div>
                <?php } ?>
            </div>

        </div>

    </div>

</div>

<?php include "includes/footer.php"; ?>