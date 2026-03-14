<?php
// Thêm sản phẩm vào giỏ hàng (session + cookie) - chỉ cho phép khi đã đăng nhập
require_once __DIR__ . '/check_login.php';
require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/includes/cart_functions.php';

// Chỉ chấp nhận POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$productId = isset($_POST['product_id']) ? (int)$_POST['product_id'] : 0;
$quantity = isset($_POST['quantity']) ? (int)$_POST['quantity'] : 1;
$quantity = max(1, $quantity);

// Kiểm tra sản phẩm tồn tại
$stmt = $conn->prepare('SELECT ma_sp FROM san_pham WHERE ma_sp = ? AND trang_thai = 1 LIMIT 1');
$stmt->bind_param('i', $productId);
$stmt->execute();
$stmt->store_result();
if ($stmt->num_rows === 0) {
    $stmt->close();
    flash('Sản phẩm không tồn tại hoặc đã bị gỡ.');
    header('Location: index.php');
    exit;
}
$stmt->close();

addToCart($productId, $quantity);
flash('Đã thêm sản phẩm vào giỏ hàng.');
$referer = $_SERVER['HTTP_REFERER'] ?? 'index.php';
if (empty($referer) || parse_url($referer, PHP_URL_HOST) !== ($_SERVER['HTTP_HOST'] ?? null)) {
    $referer = 'index.php';
}
header('Location: ' . $referer);
exit;