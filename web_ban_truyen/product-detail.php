<?php
require "config/database.php";
include "includes/header.php";

if (isset($_GET['id'])) {
    $id = $_GET['id'];
}

$result = $conn->query("SELECT * FROM san_pham WHERE ma_sp = $id");
$row = $result->fetch_assoc();
$loai = $conn->query("SELECT * FROM loai_sp WHERE ma_loai = $row[ma_loai]")->fetch_assoc();
$ten_loai = $loai['ten_loai'];

?>
<div class="row d-flex justify-content-center">
    <div class="col-md-10">

        <div class="bg-white p-3 mb-5 product-detail">

            <div class="row">

                <div class="col-md-5 text-center">
                    <img src="uploads/big_<?php echo $row['anh_sp']; ?>" class="img-fluid product-image">
                </div>

                <div class="col-md-7 mt-md-0 mt-3">

                    <h1 class="title"><?php echo $row['ten_sp']; ?></h1>

                    <div class="mb-2">
                        <span class="author"><?php echo $row['tac_gia']; ?></span>
                        <small>(Tác giả)</small>
                    </div>

                    <p class="price mb-1">
                        <?php echo number_format($row['gia']); ?> đ
                    </p>

                    <p class="status mb-2">
                        <span style="opacity: 0.7;">Tình trạng:</span>
                        <span class="status-value">
                            <?php echo $row['trang_thai'] ? "Còn hàng" : "Hết hàng"; ?>
                        </span>
                    </p>

                    <p class="category mb-3">
                        Thể loại:
                        <span class="category-name"><?php echo $ten_loai; ?></span>
                    </p>
                    <hr class="d-lg-none d-block">

                    <div class="quantity-box">
                        <span>Số lượng:</span>

                        <div class="quantity">
                            <button type="button" class="qty-btn minus" style="border-right: 1px solid #ddd">-</button>
                            <input id="quantity" name="quantity" type="number" min="1" value="1">
                            <button type="button" class="qty-btn plus" style="border-left: 1px solid #ddd">+</button>
                        </div>
                    </div>

                    <div class="product-buttons">
                        <form action="add-to-cart.php" method="POST" id="form-add-cart" class="d-inline">
                            <input type="hidden" name="product_id" value="<?php echo $row['ma_sp']; ?>">
                            <input type="hidden" name="quantity" id="qty-add-cart" value="1">
                            <button type="submit" class="btn-add">
                                THÊM VÀO GIỎ HÀNG
                            </button>
                        </form>
                        <form action="checkout-single.php" method="POST" id="form-buy-now" class="d-inline">
                            <input type="hidden" name="product_id" value="<?php echo $row['ma_sp']; ?>">
                            <input type="hidden" name="quantity" id="qty-buy-now" value="1">
                            <button type="submit" class="btn-buy">
                                THANH TOÁN
                            </button>
                        </form>
                    </div>

                    <p class="hotline-detail">
                        Gọi đặt hàng:
                        <span>0123 456 789</span>
                        hoặc
                        <span>0909 123 456</span>
                    </p>

                    <div class="product-extra">

                        <h5>Thông tin & Khuyến mãi</h5>

                        <p style="margin-bottom: 10px;">Đổi trả hàng trong vòng 7 ngày</p>

                        <p style="margin-bottom: 10px;">Freeship toàn quốc từ 250.000đ</p>

                    </div>

                </div>

            </div>

        </div>

    </div>
</div>
<?php include "includes/footer.php"; ?>