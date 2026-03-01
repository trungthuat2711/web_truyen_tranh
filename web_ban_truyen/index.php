<?php
require "config/database.php";
include "includes/header.php";

// Lấy danh mục
$ds_loai = $conn->query("SELECT * FROM loai_sp");

// Lọc theo danh mục nếu có
$where = "WHERE trang_thai = 1";

if(isset($_GET['ma_loai'])){
    $ma_loai = (int)$_GET['ma_loai'];
    $where .= " AND ma_loai = $ma_loai";
}

$result = $conn->query("SELECT * FROM san_pham $where");
?>

<div class="row">

    <!-- ===== SIDEBAR ===== -->
    <div class="col-md-3">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">
                Danh mục
            </div>
            <div class="list-group list-group-flush">
                <a href="index.php" class="list-group-item list-group-item-action">
                    Tất cả
                </a>
                <?php while($loai = $ds_loai->fetch_assoc()) { ?>
                <a href="?ma_loai=<?php echo $loai['ma_loai']; ?>" class="list-group-item list-group-item-action">
                    <?php echo $loai['ten_loai']; ?>
                </a>
                <?php } ?>
            </div>
        </div>
    </div>

    <div class="col-md-9">

        <!-- ===== BANNER ===== -->
        <div id="bannerCarousel" class="carousel slide mb-4" data-bs-ride="carousel" data-bs-interval="5000">

            <div class="carousel-inner rounded shadow-sm">

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
        <h4 class="mb-3">Sản phẩm</h4>

        <div class="row">
            <?php while($row = $result->fetch_assoc()) { ?>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100 shadow-sm">

                    <div style="aspect-ratio:3/4; overflow:hidden;">
                        <img src="uploads/<?php echo $row['anh_sp']; ?>" class="w-100 h-100" style="object-fit:cover;">
                    </div>

                    <div class="card-body d-flex flex-column p-2">
                        <h6 class="card-title small">
                            <?php echo $row['ten_sp']; ?>
                        </h6>

                        <p class="text-danger fw-bold mb-2">
                            <?php echo number_format($row['gia']); ?> đ
                        </p>

                        <a href="chi_tiet.php?id=<?php echo $row['ma_sp']; ?>"
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

<?php include "includes/footer.php"; ?>