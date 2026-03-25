<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';

checkRole('admin');

// kiểm tra id
if(!isset($_GET['id'])){
    header("Location: manage_comics.php");
    exit();
}

$id = (int)$_GET['id'];

// xóa dữ liệu
$sql = "DELETE FROM san_pham WHERE ma_sp = $id";

if($conn->query($sql)){
    echo "<script>
        alert('Xóa sản phẩm thành công!');
        window.location.href='manage_comics.php';
    </script>";
    exit();
}else{
    echo "Lỗi: " . $conn->error;
}
?>