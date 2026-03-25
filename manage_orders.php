<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';

checkRole('admin');
//Lọc
$status = $_GET['status'] ?? '';
$keyword = $_GET['keyword'] ?? '';

$sql = "SELECT * FROM don_hang WHERE 1";

if($status != ''){
    $sql .= " AND trang_thai = '$status'";
}

if($keyword != ''){
    $sql .= " AND (ten_khach LIKE '%$keyword%' OR so_dien_thoai LIKE '%$keyword%')";
}

$sql .= " ORDER BY ngay_dat DESC";

$result = $conn->query($sql);

// lấy danh sách đơn hàng
//$sql = "SELECT * FROM don_hang ORDER BY ngay_dat DESC";
//$result = $conn->query($sql);
?>

<div class="content">
<h1>Quản lý đơn hàng</h1>
<style>
    td {
    max-width: 200px;
    word-wrap: break-word;
    }

    .badge {
    padding: 5px 10px;
    border-radius: 6px;
    color: white;
    font-size: 13px;
    }

    input, select {
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    textarea {
        height: 120px;
        padding: 8px;
    }

    .badge-orange { background: orange; }
    .badge-blue { background: #3498db; }
    .badge-green { background: #2ecc71; }
    .badge-red { background: #e74c3c; }
    
</style>
<form method="GET" style="margin-bottom:15px; display:flex; gap:10px;">
    
    <select name="status">
        <option value="">-- Tất cả trạng thái --</option>

        <option value="cho_xac_nhan" <?= ($status=='cho_xac_nhan')?'selected':'' ?>>
            Chờ xác nhận
        </option>

        <option value="dang_giao" <?= ($status=='dang_giao')?'selected':'' ?>>
            Đang giao
        </option>

        <option value="da_giao" <?= ($status=='da_giao')?'selected':'' ?>>
            Đã giao
        </option>

        <option value="da_huy" <?= ($status=='da_huy')?'selected':'' ?>>
            Đã hủy
        </option>
    </select>

    <input type="text" name="keyword" placeholder="Tìm tên / SĐT" value="<?= $keyword ?>">

    <button style="border-radius: 20px;" type="submit">Lọc</button>
</form>
<table>
    <tr>
        <th>Mã đơn</th>
        <th>Mã KH</th>
        <th>Khách hàng</th>
        <th>SĐT</th>
        <th>Email</th>
        <th>Địa chỉ giao</th>
        <th>Tổng tiền</th>
        <th>Thanh toán</th>
        <th>Trạng thái</th>
        <th>Ngày đặt</th>
        <th>Thao tác</th>
    </tr>

<?php while($row = $result->fetch_assoc()): ?>
<tr>

    <td><?= $row['ma_don'] ?></td>

    <td><?= $row['ma_kh'] ?></td>

    <td><?= $row['ten_khach'] ?></td>

    <td><?= $row['so_dien_thoai'] ?></td>

    <td><?= $row['email'] ?></td>

    <td><?= $row['dia_chi_giao'] ?></td>

    <td><?= number_format($row['tong_tien'],0,',','.') ?>đ</td>

    <td><?= $row['phuong_thuc_thanh_toan'] ?></td>

    <td>
    <?php
    switch($row['trang_thai']){
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
    </td>

    <td><?= $row['ngay_dat'] ?></td>

    <td>
        <a href="order_detail.php?id=<?= $row['ma_don'] ?>">
            <button class="btn btn-view">
                <i class="fa fa-eye"></i>
            </button>
        </a>

        <a href="update_order.php?id=<?= $row['ma_don'] ?>">
            <button class="btn btn-edit">
                <i class="fa fa-pen"></i>
            </button>
        </a>
    </td>

</tr>
<?php endwhile; ?>

</table>
</div>