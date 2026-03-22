<?php
session_start();
require_once __DIR__ . '/check_login.php';
require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/includes/cart_functions.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$referer = (isset($_SERVER['HTTP_REFERER']) && parse_url($_SERVER['HTTP_REFERER'], PHP_URL_HOST) === ($_SERVER['HTTP_HOST'] ?? ''))
    ? $_SERVER['HTTP_REFERER']
    : 'index.php';

$productId = isset($_POST['product_id']) ? (int)$_POST['product_id'] : 0;
$quantity  = isset($_POST['quantity'])   ? (int)$_POST['quantity']   : 1;
$quantity  = max(1, $quantity);

// Lấy thêm so_luong_ton, bỏ store_result()
$stmt = $conn->prepare('SELECT ma_sp, so_luong_ton FROM san_pham WHERE ma_sp = ? AND trang_thai = 1 LIMIT 1');
$stmt->bind_param('i', $productId);
$stmt->execute();
$product = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$product) {
    flash('Sản phẩm không tồn tại hoặc đã bị gỡ.');
    header('Location: index.php');
    exit;
}

// Cộng thêm số lượng đã có trong giỏ
$inCart = $_SESSION['cart'][$productId]['quantity'] ?? 0;
if (($inCart + $quantity) > $product['so_luong_ton']) {
    flash("Số lượng vượt quá hàng tồn kho! Chỉ còn {$product['so_luong_ton']} sản phẩm.");
    header('Location: ' . $referer);
    exit;
}

addToCart($productId, $quantity);
flash('Đã thêm sản phẩm vào giỏ hàng.');
header('Location: ' . $referer);
exit;