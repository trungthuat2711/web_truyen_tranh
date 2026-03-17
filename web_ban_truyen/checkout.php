<?php
require __DIR__ . '/check_login.php';
require __DIR__ . '/config/database.php';
require __DIR__ . '/includes/cart_functions.php';

$flashMessage = getFlash();
$cart = getCart();

// Xác định tài khoản khách hàng (nếu đã đăng nhập)
$currentUserId = null;
if (!empty($_SESSION['user']) && isset($_SESSION['user']['ma_tk'])) {
    $currentUserId = (int)$_SESSION['user']['ma_tk'];
}

// Load product data for the items in the cart
$productIds = array_column($cart, 'id');
$productsById = [];
if (!empty($productIds)) {
    $placeholders = implode(',', array_fill(0, count($productIds), '?'));
    $types = str_repeat('i', count($productIds));
    $stmt = $conn->prepare("SELECT ma_sp, ten_sp, gia, anh_sp FROM san_pham WHERE ma_sp IN ($placeholders)");
    if ($stmt) {
        $stmt->bind_param($types, ...$productIds);
        $stmt->execute();
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
            $productsById[(int)$row['ma_sp']] = $row;
        }
        $stmt->close();
    }
}

$totals = calculateCartTotals($productsById, $cart);

// Nếu giỏ hàng trống thì không cho vào checkout
if (empty($cart) || empty($productsById)) {
    flash('Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi thanh toán.');
    header('Location: cart.php');
    exit;
}

$errors = [];
$values = [
    'fullname' => '',
    'email' => '',
    'phone' => '',
    'address' => '',
    'notes' => '',
    'payment' => 'cod',
];

$orderPlaced = false;
$orderId = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $values['fullname'] = trim($_POST['fullname'] ?? '');
    $values['email'] = trim($_POST['email'] ?? '');
    $values['phone'] = trim($_POST['phone'] ?? '');
    $values['address'] = trim($_POST['address'] ?? '');
    $values['notes'] = trim($_POST['notes'] ?? '');
    $values['payment'] = in_array($_POST['payment'] ?? 'cod', ['cod', 'bank']) ? $_POST['payment'] : 'cod';

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

    if (empty($cart)) {
        $errors['cart'] = 'Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi đặt hàng.';
    }
    if (empty($productsById)) {
        $errors['cart'] = 'Không tìm thấy sản phẩm trong giỏ hàng.';
    }

    if (empty($errors)) {
        $total = $totals['total'];
        $paymentMethod = strtoupper($values['payment']);
        // Gắn ma_kh (liên kết với tai_khoan) nếu người dùng đã đăng nhập
        $stmt = $conn->prepare("INSERT INTO don_hang (ma_kh, ten_khach, so_dien_thoai, dia_chi_giao, email, ghi_chu, tong_tien, phuong_thuc_thanh_toan, trang_thai) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'cho_xac_nhan')");
        $stmt->bind_param(
            'isssssds',
            $currentUserId,
            $values['fullname'],
            $values['phone'],
            $values['address'],
            $values['email'],
            $values['notes'],
            $total,
            $paymentMethod
        );

        if ($stmt->execute()) {
            $orderId = $conn->insert_id;
            $stmt->close();

            $stmtItem = $conn->prepare("INSERT INTO chi_tiet_don_hang (ma_don, ma_sp, so_luong, gia_tai_thoi_diem_dat) VALUES (?, ?, ?, ?)");
            foreach ($cart as $item) {
                $productId = (int)$item['id'];
                $quantity = (int)$item['qty'];
                $price = isset($productsById[$productId]['gia']) ? (float)$productsById[$productId]['gia'] : 0;
                $stmtItem->bind_param('iiid', $orderId, $productId, $quantity, $price);
                $stmtItem->execute();
            }
            $stmtItem->close();

            clearCart();
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
    <?php if (!empty($flashMessage)): ?>
        <div class="alert alert-success" role="alert">
            <?php echo htmlspecialchars($flashMessage); ?>
        </div>
    <?php endif; ?>

    <?php if ($orderPlaced): ?>
        <div class="card p-4">
            <h4 class="mb-3">🎉 Đặt hàng thành công!</h4>
            <p class="mb-3">Chúng tôi sẽ liên hệ với bạn sớm nhất để xác nhận và giao hàng.</p>
            <a href="index.php" class="primary-btn">Tiếp tục mua sắm</a>
        </div>
    <?php else: ?>
        <?php if (!empty($errors['cart'])): ?>
            <div class="alert alert-warning" role="alert">
                <?php echo htmlspecialchars($errors['cart']); ?>
                <a href="index.php" class="btn btn-sm btn-link">Quay về cửa hàng</a>
            </div>
        <?php endif; ?>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card p-3">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0">Thanh toán</h4>
                        <a href="cart.php" class="btn btn-sm btn-light">
                            <i class="fa fa-arrow-left me-2"></i>Quay lại giỏ hàng
                        </a>
                    </div>

                    <?php if (!empty($errors['general'])): ?>
                        <div class="alert alert-danger" role="alert">
                            <?php echo htmlspecialchars($errors['general']); ?>
                        </div>
                    <?php endif; ?>

                    <form method="post" novalidate>
                        <div class="card p-4 mb-4">
                            <h6 class="section-title">Thông tin khách hàng</h6>

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" name="fullname" class="form-control form-ctrl-qty <?php echo isset($errors['fullname']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['fullname']); ?>" required>
                                    <?php if (isset($errors['fullname'])): ?>
                                        <div class="invalid-feedback"><?php echo htmlspecialchars($errors['fullname']); ?></div>
                                    <?php endif; ?>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" name="email" class="form-control form-ctrl-qty <?php echo isset($errors['email']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['email']); ?>" required>
                                    <?php if (isset($errors['email'])): ?>
                                        <div class="invalid-feedback"><?php echo htmlspecialchars($errors['email']); ?></div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                    <input type="tel" name="phone" class="form-control form-ctrl-qty <?php echo isset($errors['phone']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['phone']); ?>" pattern="[0-9]{10,}" required>
                                    <?php if (isset($errors['phone'])): ?>
                                        <div class="invalid-feedback"><?php echo htmlspecialchars($errors['phone']); ?></div>
                                    <?php endif; ?>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                    <input type="text" name="address" class="form-control form-ctrl-qty <?php echo isset($errors['address']) ? 'is-invalid' : ''; ?>" value="<?php echo htmlspecialchars($values['address']); ?>" required>
                                    <?php if (isset($errors['address'])): ?>
                                        <div class="invalid-feedback"><?php echo htmlspecialchars($errors['address']); ?></div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Ghi chú đơn hàng</label>
                                <textarea name="notes" class="form-control form-ctrl-qty" rows="3"><?php echo htmlspecialchars($values['notes']); ?></textarea>
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
                                    <i class="fas fa-shopping-bag me-2"></i>Đặt hàng và thanh toán
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card p-3">
                    <h6 class="fw-bold mb-3">Tóm tắt đơn hàng</h6>

                    <?php if (empty($cart)): ?>
                        <div class="text-center text-muted py-4">
                            Giỏ hàng trống.
                        </div>
                    <?php else: ?>
                        <?php foreach ($cart as $item):
                            $pid = (int)$item['id'];
                            $qty = (int)$item['qty'];
                            $product = $productsById[$pid] ?? null;
                            if (!$product) continue;
                            $name = htmlspecialchars($product['ten_sp']);
                            $price = (float)$product['gia'];
                            $lineTotal = $price * $qty;
                            $img = htmlspecialchars($product['anh_sp'] ?: 'default.jpg');
                        ?>
                            <div class="product-item-summary">
                                <img src="uploads/<?php echo $img; ?>" alt="<?php echo $name; ?>">
                                <div class="product-item-summary-info">
                                    <div class="product-item-summary-name"><?php echo $name; ?></div>
                                    <div class="product-item-summary-qty">Số lượng: <?php echo $qty; ?></div>
                                </div>
                                <div class="product-item-summary-price"><?php echo number_format($lineTotal); ?>đ</div>
                            </div>
                        <?php endforeach; ?>

                        <div class="total-box">
                            <div class="total-row">
                                <span class="total-label">Tạm tính</span>
                                <span class="total-value"><?php echo number_format($totals['subtotal']); ?>đ</span>
                            </div>
                            <div class="total-row">
                                <span class="total-label">Phí vận chuyển</span>
                                <span class="total-value"><?php echo number_format($totals['shipping']); ?>đ</span>
                            </div>
                        </div>
                        <div class="text-center py-3">
                            <div class="small text-muted mb-2">Tổng thanh toán</div>
                            <div class="fs-3 fw-bold grand-total"><?php echo number_format($totals['total']); ?>đ</div>
                        </div>

                        <div class="small text-muted text-center mt-3">
                            Miễn phí vận chuyển cho đơn hàng từ 250,000đ.
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    <?php endif; ?>
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

    // Sync active state when user interacts directly with radio input
    document.querySelectorAll('input[name="payment"]').forEach(radio => {
        radio.addEventListener('change', () => {
            selectPayment(radio.value);
        });
    });
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>