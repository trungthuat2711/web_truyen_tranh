<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';

checkRole('admin');

$categories = $conn->query("SELECT * FROM loai_sp");

$error = "";

if(isset($_POST['submit'])){

    $ten = trim($_POST['ten_sp']);
    $tacgia = trim($_POST['tac_gia']);
    $gia = $_POST['gia'];
    $gia_cu = $_POST['gia_cu'];
    $ton = $_POST['so_luong_ton'];
    $maloai = $_POST['ma_loai'];
    $mota = $_POST['mo_ta'];
    $trangthai = $_POST['trang_thai'];
    $banchay = isset($_POST['ban_chay']) ? $_POST['ban_chay'] : 0;

    // validate
    if($ten == "" || $tacgia == "" || $gia == "" || $ton == "" || $maloai == "" || $trangthai == "" || $_FILES['anh_sp']['name'] == ""){
        $error = "⚠️ Vui lòng nhập đầy đủ các trường bắt buộc!";
    } elseif($gia < 0){
        $error = "⚠️ Giá phải lớn hơn hoặc bằng 0!";
    } else {

        // upload ảnh
        $anh = "";
        $anh_chi_tiet = "";

        if(isset($_FILES['anh_sp']) && $_FILES['anh_sp']['error'] == 0){

            $anh = $_FILES['anh_sp']['name'];

            $target = __DIR__ . "/uploads/" . $anh;

            move_uploaded_file($_FILES['anh_sp']['tmp_name'], $target);
        }

        if(isset($_FILES['anh_chi_tiet_sp']) && $_FILES['anh_chi_tiet_sp']['error'] == 0){

            $anh_chi_tiet = $_FILES['anh_chi_tiet_sp']['name'];

            $target = __DIR__ . "/uploads/" . $anh_chi_tiet;

            move_uploaded_file($_FILES['anh_chi_tiet_sp']['tmp_name'], $target);
        }

        $sql = "INSERT INTO san_pham
                (ten_sp, tac_gia, gia, gia_cu, so_luong_ton, anh_sp, mo_ta, ma_loai, trang_thai, ban_chay)
                VALUES
                ('$ten','$tacgia','$gia','$gia_cu','$ton','$anh','$mota','$maloai','$trangthai','$banchay')";

        if($conn->query($sql)){
            header("Location: manage_comics.php");
            exit();
        } else {
            $error = "Lỗi: " . $conn->error;
        }
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Thêm truyện</title>
    <style>
    .form-container {
        width: 600px;
        margin: 20px auto;
    }

    input,
    select,
    textarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .add_btn-group {
        display: flex;
        gap: 10px;
    }

    .add_error {
        color: red;
        margin-bottom: 10px;
    }
    </style>
</head>

<body>

    <div class="form-container">
        <h2>Thêm truyện</h2>

        <!-- hiển thị lỗi -->
        <?php if($error != ""): ?>
        <div class="add_error"><?= $error ?></div>
        <?php endif; ?>

        <form method="POST" enctype="multipart/form-data">

            <label>Tên truyện *</label>
            <input type="text" name="ten_sp" required>

            <label>Tác giả *</label>
            <input type="text" name="tac_gia" required>

            <label>Giá *</label>
            <input type="number" name="gia" required min="0" step="1000" placeholder="VD: 120000">

            <label>Giá cũ</label>
            <input type="number" name="gia_cu" min="0">

            <label>Số lượng*</label>
            <input type="number" name="so_luong_ton" value="0" min="0" require>

            <label>Thể loại *</label>
            <select name="ma_loai" required>
                <?php while($row = $categories->fetch_assoc()): ?>
                <option value="<?= $row['ma_loai'] ?>">
                    <?= $row['ten_loai'] ?>
                </option>
                <?php endwhile; ?>
            </select>

            <label>Ảnh *</label>
            <input type="file" name="anh_sp" require>

            <label>Ảnh chi tiết*</label>
            <input type="file" name="anh_chi_tiet_sp" require>

            <label>Mô tả</label>
            <textarea name="mo_ta"></textarea>

            <label>Trạng thái *</label>
            <select name="trang_thai" required>
                <option value="1">Hiển thị</option>
                <option value="0">Ẩn</option>
            </select>

            <label>Bán chạy</label>
            <select name="ban_chay">
                <option value="0" selected>Không</option>
                <option value="1">Có</option>
            </select>
            <br>

            <div class="add_btn-group">
                <button type="submit" name="submit" class="btn btn-add">Thêm truyện</button>

                <a href="manage_comics.php">
                    <button type="button" class="btn btn-delete">Quay lại</button>
                </a>
            </div>

        </form>
    </div>

</body>

</html>