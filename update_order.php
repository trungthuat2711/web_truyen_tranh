<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';

checkRole('admin');

$ma_tk = $_SESSION['user']['ma_tk'] ?? 0;// người cập nhật

if(!$ma_tk){
    die("Lỗi: chưa đăng nhập");
}

$id = $_GET['id'] ?? 0;

$sqlLS = "
SELECT ls.*, tk.ten_dang_nhap
FROM lich_su_trang_thai_don ls
LEFT JOIN tai_khoan tk ON ls.nguoi_cap_nhat = tk.ma_tk
WHERE ls.ma_don = $id
ORDER BY ls.thoi_gian_cap_nhat DESC
";

$resultLS = $conn->query($sqlLS);

// lấy thông tin đơn
$sql = "SELECT * FROM don_hang WHERE ma_don = $id";
$don = $conn->query($sql)->fetch_assoc();

// FLOW trạng thái
$flow = [
    'cho_xac_nhan' => ['dang_giao', 'da_huy'],
    'dang_giao'    => ['da_giao', 'da_huy'],
    'da_giao'      => [],
    'da_huy'       => []
];

// xử lý cập nhật
if(isset($_POST['trang_thai'])){
    $trang_thai_moi = $_POST['trang_thai'];
    $trang_thai_cu = $don['trang_thai'];

    if(!in_array($trang_thai_moi, $flow[$trang_thai_cu])){
        echo "<script>alert('Chuyển trạng thái không hợp lệ!');</script>";
    } else {

        // update + ngày
        if($trang_thai_moi == 'dang_giao'){
            $sqlUpdate = "UPDATE don_hang 
                          SET trang_thai='$trang_thai_moi', ngay_duyet_don=NOW() 
                          WHERE ma_don=$id";
        }
        else if($trang_thai_moi == 'da_giao'){
            $sqlUpdate = "UPDATE don_hang 
                          SET trang_thai='$trang_thai_moi', ngay_hoan_tat=NOW() 
                          WHERE ma_don=$id";
        }
        else{
            $sqlUpdate = "UPDATE don_hang 
                          SET trang_thai='$trang_thai_moi' 
                          WHERE ma_don=$id";
        }

        $conn->query($sqlUpdate);

        // lưu lịch sử
        $conn->query("
            INSERT INTO lich_su_trang_thai_don(ma_don, trang_thai, nguoi_cap_nhat, thoi_gian_cap_nhat)
            VALUES ($id, '$trang_thai_moi', $ma_tk, NOW())
        ");

        echo "<script>alert('Cập nhật thành công'); window.location='manage_orders.php';</script>";
        exit();
    }
}

?>

<style>
    select {
    padding: 8px;
    width: 200px;
    }
    .timeline {
    border-left: 3px solid #3498db;
    margin-top: 15px;
    padding-left: 15px;
    }

    .timeline-item {
        margin-bottom: 15px;
        position: relative;
    }

    .timeline-item::before {
        content: '';
        position: absolute;
        left: -9px;
        top: 5px;
        width: 12px;
        height: 12px;
        background: #3498db;
        border-radius: 50%;
    }

    .time {
        font-size: 16px;
        color: gray;
    }

    .content {
        background: #f5f5f5;
        padding: 8px;
        border-radius: 6px;
    }
</style>

<div class="content">

<h1>Cập nhật đơn hàng #<?= $don['ma_don'] ?></h1>
<br>
<form method="POST">

    <p><b>Khách hàng:</b> <?= $don['ten_khach'] ?></p>
    <p><b>SĐT:</b> <?= $don['so_dien_thoai'] ?></p>
    <p><b>Địa chỉ:</b> <?= $don['dia_chi_giao'] ?></p>
    <p><b>Tổng tiền:</b> <?= number_format($don['tong_tien'],0,',','.') ?>đ</p>

    <br>

    <label>Trạng thái:</label><br>
    <select name="trang_thai" required>

        <option value="cho_xac_nhan" <?= ($don['trang_thai']=='cho_xac_nhan')?'selected':'' ?>>
            Chờ xác nhận
        </option>

        <option value="dang_giao" <?= ($don['trang_thai']=='dang_giao')?'selected':'' ?>>
            Đang giao
        </option>

        <option value="da_giao" <?= ($don['trang_thai']=='da_giao')?'selected':'' ?>>
            Đã giao
        </option>

        <option value="da_huy" <?= ($don['trang_thai']=='da_huy')?'selected':'' ?>>
            Đã hủy
        </option>

    </select>

    <br><br>

    <button type="submit" name="submit" class="btn btn-add">Cập nhật</button>

    <a href="manage_orders.php">
        <button type="button" class="btn btn-delete">Quay lại</button>
    </a>

</form>
<br><br>
<h3>Lịch sử trạng thái</h3>

<div class="timeline">

<?php while($ls = $resultLS->fetch_assoc()): ?>
    <div class="timeline-item">

        <div class="time">
            <?= $ls['thoi_gian_cap_nhat'] ?>
        </div>

        <div class="content">
            <b>
            <?php
            switch($ls['trang_thai']){
                case 'cho_xac_nhan': echo "Chờ xác nhận"; break;
                case 'dang_giao': echo "Đang giao"; break;
                case 'da_giao': echo "Đã giao"; break;
                case 'da_huy': echo "Đã hủy"; break;
            }
            ?>
            </b>

            <br>
            <small>By: <?= $ls['ten_dang_nhap'] ?? 'System' ?></small>
        </div>

    </div>
<?php endwhile; ?>

</div>
</div>