<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';

checkRole('admin');

// lấy id
$id = $_GET['id'];

// lấy dữ liệu truyện
$sql = "SELECT * FROM san_pham WHERE ma_sp = $id";
$result = $conn->query($sql);
$sp = $result->fetch_assoc();

// lấy thể loại
$loai = $conn->query("SELECT * FROM loai_sp");

// xử lý submit
if($_SERVER["REQUEST_METHOD"] == "POST"){

    $ten = $_POST['ten_sp'];
    $tacgia = $_POST['tac_gia'];
    $gia = str_replace(['.', ','], '', $_POST['gia']);
    $gia_cu = str_replace(['.', ','], '', $_POST['gia_cu']);
    $ton = $_POST['so_luong_ton'];
    $mota = $_POST['mo_ta'];
    $loai_id = $_POST['ma_loai'];
    $trang_thai = $_POST['trang_thai'];
    $banchay = isset($_POST['ban_chay']) ? $_POST['ban_chay'] : 0;

    // giữ ảnh cũ
    $anh = $sp['anh_sp'];

    // nếu có upload ảnh mới
    if(isset($_FILES['anh_sp']) && $_FILES['anh_sp']['error'] == 0){

        $anh = time() . "_" . $_FILES['anh_sp']['name'];
        $target = __DIR__ . "/uploads/" . $anh;

        move_uploaded_file($_FILES['anh_sp']['tmp_name'], $target);
    }

    // update
    $sql = "UPDATE san_pham SET
        ten_sp = '$ten',
        tac_gia = '$tacgia',
        gia = '$gia',
        gia_cu = '$gia_cu',
        so_luong_ton = '$ton',
        mo_ta = '$mota',
        ma_loai = '$loai_id',
        trang_thai = '$trang_thai',
        ban_chay = '$ban_chay',
        anh_sp = '$anh'
        WHERE ma_sp = $id";

    if($conn->query($sql)){
        header("Location: manage_comics.php");
        exit();
    } else {
        echo "Lỗi: " . $conn->error;
    }
}
?>

<div class="content">
<h1>Sửa truyện</h1>
<style>
    .form-row {
        display: block;
        width: 600px;
        margin: 20px auto;
    }

    .form-group {
        margin-bottom: 15px;
        display: flex;
        flex-direction: column;
    }

    input, select {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    textarea {
        width: 100%;
        height: 120px;
        padding: 8px;
    }
</style>

<form method="POST" enctype="multipart/form-data">
<div class="form-row">
    <div class="form-group">
        <label>Tên truyện *</label>
        <input type="text" name="ten_sp" value="<?= $sp['ten_sp'] ?>" required>
    </div>

    <div class="form-group">
        <label>Tác giả *</label>
        <input type="text" name="tac_gia" value="<?= $sp['tac_gia'] ?>" required>
    </div>

    <div class="form-group">
        <label>Giá *</label>
        <input type="text" name="gia" value="<?= $sp['gia'] ?>" required>
    </div>

    <div class="form-group">
        <label>Giá cũ</label>
        <input type="text" name="gia_cu" value="<?= $sp['gia_cu'] ?>">
    </div>

    <div class="form-group">
        <label>Số lượng tồn *</label>
        <input type="number" name="so_luong_ton" value="<?= $sp['so_luong_ton'] ?>" required>
    </div>

    <div class="form-group">
        <label>Thể loại *</label>
        <select name="ma_loai" required>
            <?php while($l = $loai->fetch_assoc()): ?>
                <option value="<?= $l['ma_loai'] ?>"
                    <?= $l['ma_loai'] == $sp['ma_loai'] ? 'selected' : '' ?>>
                    <?= $l['ten_loai'] ?>
                </option>
            <?php endwhile; ?>
        </select>
    </div>

    <div class="form-group">
        <label>Trạng thái *</label>
        <select name="trang_thai" required>
            <option value="1" <?= $sp['trang_thai'] ? 'selected' : '' ?>>Hiển thị</option>
            <option value="0" <?= !$sp['trang_thai'] ? 'selected' : '' ?>>Ẩn</option>
        </select>
    </div>

    <div class="form-group">
        <label>Bán chạy</label>
        <select name="ban_chay">
            <option value="0" selected>Không</option>
            <option value="1">Có</option>
        </select>
        <br>
    </div>

    <div class="form-group">
        <label>Mô tả</label>
        <textarea name="mo_ta"><?= $sp['mo_ta'] ?></textarea>
    </div>

    <div class="form-group">
        <label>Ảnh hiện tại</label><br>
        <img src="uploads/<?= $sp['anh_sp'] ?>" width="120"><br>
    </div>

    <div class="form-group">
        <label>Đổi ảnh mới</label>
        <input type="file" name="anh_sp">

        <br><br>
    </div>

        <button class="btn btn-add">Cập nhật</button>
        <a href="manage_comics.php">
            <button type="button" class="btn btn-delete">Quay lại</button>
        </a>
</div>
</form>
</div>