<?php

/**
 * Trang thanh toán cho 1 sản phẩm duy nhất (từ nút MUA NGAY / Thanh toán trên trang chi tiết sản phẩm).
 * Không sử dụng giỏ hàng.
 */
require __DIR__ . '/config/database.php';
require __DIR__ . '/includes/cart_functions.php';

$productId = isset($_POST['product_id']) ? (int)$_POST['product_id'] : (isset($_GET['product_id']) ? (int)$_GET['product_id'] : 0);
$quantity = isset($_POST['quantity']) ? max(1, (int)$_POST['quantity']) : (isset($_GET['quantity']) ? max(1, (int)$_GET['quantity']) : 1);

$product = null;
if ($productId > 0) {
    $stmt = $conn->prepare('SELECT ma_sp, ten_sp, gia, anh_sp FROM san_pham WHERE ma_sp = ? AND trang_thai = 1 LIMIT 1');
    $stmt->bind_param('i', $productId);
    $stmt->execute();
    $result = $stmt->get_result();
    $product = $result->fetch_assoc();
    $stmt->close();
}

if (!$product) {
    flash('Sản phẩm không tồn tại hoặc đã hết hàng.');
    header('Location: index.php');
    exit;
}

$price = (float)$product['gia'];
$subtotal = $price * $quantity;
$shipping = $subtotal >= 250000 ? 0 : 20000;
$total = $subtotal + $shipping;

$errors = [];
$values = [
    'fullname' => '',
    'email' => '',
    'phone' => '',
    'address' => '',
    'notes' => '',
    'payment' => 'cod',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['place_order'])) {
    $values['fullname'] = trim($_POST['fullname'] ?? '');
    $values['email'] = trim($_POST['email'] ?? '');
    $values['phone'] = trim($_POST['phone'] ?? '');
    $values['address'] = trim($_POST['address'] ?? '');
    $values['notes'] = trim($_POST['notes'] ?? '');
    $values['payment'] = in_array($_POST['payment'] ?? 'cod', ['cod', 'bank']) ? $_POST['payment'] : 'cod';
    $productId = (int)($_POST['product_id'] ?? 0);
    $quantity = max(1, (int)($_POST['quantity'] ?? 1));

    if ($values['fullname'] === '') {
        $errors['fullname'] = 'Vui lòng nhập họ và tên.';
    }
    if ($values['email'] === '' || !filter_var($values['email'], FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Vui lòng nhập email hợp lệ.';
    }
    if ($values['phone'] === '' || !preg_match('/^[0-9]{10,}$/', $values['phone'])) {
        $errors['phone'] = 'Vui lòng nhập số điện thoại hợp lệ.';
    }
    if ($values['address'] === '') {
        $errors['address'] = 'Vui lòng nhập địa chỉ giao hàng.';
    }

    if ($productId <= 0 || !$product) {
        $errors['product'] = 'Sản phẩm không hợp lệ.';
    }

    if (empty($errors)) {
        $total = ($price * $quantity) + ($price * $quantity >= 250000 ? 0 : 20000);
        $paymentMethod = strtoupper($values['payment']);

        $stmt = $conn->prepare("INSERT INTO don_hang (ten_khach, so_dien_thoai, dia_chi_giao, email, ghi_chu, tong_tien, phuong_thuc_thanh_toan, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?, 'cho_xac_nhan')");
        $stmt->bind_param('sssssds', $values['fullname'], $values['phone'], $values['address'], $values['email'], $values['notes'], $total, $paymentMethod);

        if ($stmt->execute()) {
            $orderId = $conn->insert_id;
            $stmt->close();

            $stmtItem = $conn->prepare("INSERT INTO chi_tiet_don_hang (ma_don, ma_sp, so_luong, gia_tai_thoi_diem_dat) VALUES (?, ?, ?, ?)");
            $stmtItem->bind_param('iiid', $orderId, $productId, $quantity, $price);
            $stmtItem->execute();
            $stmtItem->close();

            header('Location: thankyou.php?orderId=' . $orderId . '&email=' . urlencode($values['email']));
            exit;
        } else {
            $errors['general'] = 'Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.';
        }
    }
}

$extraHead = '<link rel="stylesheet" href="assets/css/checkout.css">';
include __DIR__ . '/includes/header.php';
?>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Thanh toán nhanh (1 sản phẩm)</h4>
                    <a href="product-detail.php?id=<?php echo (int)$product['ma_sp']; ?>" class="btn btn-sm btn-light">
                        <i class="fa fa-arrow-left me-2"></i>Quay lại sản phẩm
                    </a>
                </div>

                <?php if (!empty($errors['general'])): ?>
                    <div class="alert alert-danger" role="alert">
                        <?php echo htmlspecialchars($errors['general']); ?>
                    </div>
                <?php endif; ?>

                <form method="post" novalidate>
                    <input type="hidden" name="product_id" value="<?php echo (int)$product['ma_sp']; ?>">
                    <input type="hidden" name="quantity" value="<?php echo (int)$quantity; ?>">
                    <input type="hidden" name="place_order" value="1">

                    <div class="card p-4 mb-4">
                        <h6 class="section-title">Thông tin khách hàng</h6>

                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" name="fullname" class="form-control <?php echo isset($errors['fullname']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['fullname']); ?>" required>
                                <?php if (isset($errors['fullname'])): ?>
                                    <div class="invalid-feedback"><?php echo htmlspecialchars($errors['fullname']); ?></div>
                                <?php endif; ?>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" name="email" class="form-control <?php echo isset($errors['email']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['email']); ?>" required>
                                <?php if (isset($errors['email'])): ?>
                                    <div class="invalid-feedback"><?php echo htmlspecialchars($errors['email']); ?></div>
                                <?php endif; ?>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" name="phone" class="form-control <?php echo isset($errors['phone']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['phone']); ?>" pattern="[0-9]{10,}" required>
                                <?php if (isset($errors['phone'])): ?>
                                    <div class="invalid-feedback"><?php echo htmlspecialchars($errors['phone']); ?></div>
                                <?php endif; ?>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                <input type="text" name="address" class="form-control <?php echo isset($errors['address']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['address']); ?>" required>
                                <?php if (isset($errors['address'])): ?>
                                    <div class="invalid-feedback"><?php echo htmlspecialchars($errors['address']); ?></div>
                                <?php endif; ?>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Ghi chú đơn hàng</label>
                            <textarea name="notes" class="form-control" rows="3"><?php echo htmlspecialchars($values['notes']); ?></textarea>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Phương thức thanh toán</label>

                            <div class="payment-method <?php echo $values['payment'] === 'cod' ? 'active' : ''; ?>" data-value="cod" onclick="selectPayment('cod')">
                                <input id="paymentCod" type="radio" name="payment" value="cod" <?php echo $values['payment'] === 'cod' ? 'checked' : ''; ?>>
                                <label for="paymentCod" class="mb-0">
                                    <div class="fw-500">Thanh toán khi nhận hàng</div>
                                    <small class="text-muted">Thanh toán tiền mặt khi nhận hàng</small>
                                </label>
                                <div class="ms-auto">
                                    <i class="fas fa-money-bill text-success fs-5"></i>
                                </div>
                            </div>

                            <div class="payment-method <?php echo $values['payment'] === 'bank' ? 'active' : ''; ?>" data-value="bank" onclick="selectPayment('bank')">
                                <input id="paymentBank" type="radio" name="payment" value="bank" <?php echo $values['payment'] === 'bank' ? 'checked' : ''; ?>>
                                <label for="paymentBank" class="mb-0">
                                    <div class="fw-500">Chuyển khoản ngân hàng</div>
                                    <small class="text-muted">Chuyển tiền vào tài khoản ngân hàng</small>
                                </label>
                                <div class="ms-auto">
                                    <i class="fas fa-university text-primary fs-5"></i>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="primary-btn btn-lg">
                                <i class="fas fa-lock me-2"></i>Đặt hàng và thanh toán
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card p-3">
                <h6 class="fw-bold mb-3">Tóm tắt đơn hàng</h6>

                <div class="product-item-summary">
                    <img src="uploads/<?php echo htmlspecialchars($product['anh_sp'] ?: 'default.jpg'); ?>" alt="<?php echo htmlspecialchars($product['ten_sp']); ?>">
                    <div class="product-item-summary-info">
                        <div class="product-item-summary-name"><?php echo htmlspecialchars($product['ten_sp']); ?></div>
                        <div class="product-item-summary-qty">Số lượng: <?php echo (int)$quantity; ?></div>
                    </div>
                    <div class="product-item-summary-price"><?php echo number_format($subtotal); ?>đ</div>
                </div>

                <div class="total-box">
                    <div class="total-row">
                        <span class="total-label">Tạm tính</span>
                        <span class="total-value"><?php echo number_format($subtotal); ?>đ</span>
                    </div>
                    <div class="total-row">
                        <span class="total-label">Phí vận chuyển</span>
                        <span class="total-value"><?php echo number_format($shipping); ?>đ</span>
                    </div>
                </div>
                <div class="text-center py-3">
                    <div class="small text-muted mb-2">Tổng thanh toán</div>
                    <div class="fs-3 fw-bold grand-total"><?php echo number_format($total); ?>đ</div>
                </div>

                <div class="small text-muted text-center mt-3">
                    Miễn phí vận chuyển cho đơn hàng từ 250.000đ.
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function selectPayment(value) {
        document.querySelectorAll('.payment-method').forEach(el => {
            const input = el.querySelector('input[name="payment"]');
            if (el.dataset.value === value) {
                el.classList.add('active');
                if (input) input.checked = true;
            } else {
                el.classList.remove('active');
            }
        });
    }
    document.querySelectorAll('input[name="payment"]').forEach(radio => {
        radio.addEventListener('change', () => selectPayment(radio.value));
    });
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>