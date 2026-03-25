
<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';

checkRole('admin');

// lấy id đơn
$id = $_GET['id'] ?? 0;

// lấy thông tin đơn hàng
$sqlDon = "SELECT * FROM don_hang WHERE ma_don = $id";
$don = $conn->query($sqlDon)->fetch_assoc();

// lấy chi tiết đơn hàng + sản phẩm
$sqlCT = "
SELECT ct.*, sp.ten_sp, sp.anh_sp
FROM chi_tiet_don_hang ct
LEFT JOIN san_pham sp ON ct.ma_sp = sp.ma_sp
WHERE ct.ma_don = $id
";

$resultCT = $conn->query($sqlCT);

?>

<style>
    .order-info {
    background: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    line-height: 1.6;
    }

    table img {
        border-radius: 5px;
    }

    .badge {
    padding: 5px 10px;
    border-radius: 6px;
    color: white;

    }

    .badge-orange { background: orange; }
    .badge-blue { background: #3498db; }
    .badge-green { background: #2ecc71; }
    .badge-red { background: #e74c3c; }
</style>

<div class="content">

    <h1>Chi tiết đơn hàng #<?= $don['ma_don'] ?></h1>

    <!-- THÔNG TIN KHÁCH -->
    <div class="order-info">
        <p><b>Khách hàng:</b> <?= $don['ten_khach'] ?></p>
        <p><b>Mã KH:</b> <?= $don['ma_kh'] ?></p>
        <p><b>SĐT:</b> <?= $don['so_dien_thoai'] ?></p>
        <p><b>Email:</b> <?= $don['email'] ?></p>
        <p><b>Địa chỉ:</b> <?= $don['dia_chi_giao'] ?></p>
        <p><b>Ngày đặt:</b> <?= $don['ngay_dat'] ?></p>
        <p>
            <b>Trạng thái:</b>
            <?php
            switch($don['trang_thai']){
                case 'cho_xac_nhan':
                    echo "<span class='badge badge-orange'>Chờ xác nhận</span>";
                    break;
                case 'dang_giao':
                    echo "<span class='badge badge-blue'>Đang giao</span>";
                    break;
                case 'da_giao':
                    echo "<span class='badge badge-green'>Đã giao</span>";
                    break;
                case 'da_huy':
                    echo "<span class='badge badge-red'>Đã hủy</span>";
                    break;
            }
            ?>
        </p>

        <p><b>Thanh toán:</b> <?= $don['phuong_thuc_thanh_toan'] ?></p>
    </div>

    <br>

    <!-- DANH SÁCH SẢN PHẨM -->
    <table>
        <tr>
            <th>Ảnh</th>
            <th>Tên truyện</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Thành tiền</th>
        </tr>

    <?php 
    $tong = 0;
    while($row = $resultCT->fetch_assoc()):
        $thanhTien = $row['so_luong'] * $row['gia_tai_thoi_diem_dat'];
        $tong += $thanhTien;
    ?>
    <tr>

        <td>
            <img src="uploads/<?= $row['anh_sp'] ?>" width="60">
        </td>

        <td><?= $row['ten_sp'] ?></td>

        <td><?= $row['so_luong'] ?></td>

        <td><?= number_format($row['gia_tai_thoi_diem_dat'],0,',','.') ?>đ</td>

        <td><?= number_format($thanhTien,0,',','.') ?>đ</td>

    </tr>
    <?php endwhile; ?>

    </table>

    <h3 style="text-align:right; margin-top:15px;">
        Tổng tiền: <?= number_format($tong,0,',','.') ?>đ
    </h3>

    <br>

    <a href="manage_orders.php">
        <button type="button" class="btn btn-delete">Quay lại</button>
    </a>

</div>
