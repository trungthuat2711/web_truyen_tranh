<?php
require __DIR__ . '/config/database.php';
require __DIR__ . '/includes/cart_functions.php';

// Xử lý hành động (cập nhật, xóa)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update') {
    if (!empty($_POST['qty']) && is_array($_POST['qty'])) {
        foreach ($_POST['qty'] as $id => $qty) {
            $productId = (int)$id;
            $quantity = max(0, (int)$qty);
            if ($productId <= 0) {
                continue;
            }
            if ($quantity <= 0) {
                removeFromCart($productId);
            } else {
                // Giới hạn số lượng hợp lệ
                if ($quantity > 100) {
                    $quantity = 100;
                }
                updateCartItem($productId, $quantity);
            }
        }
    }

    flash('Giỏ hàng đã được cập nhật.');
    header('Location: cart.php');
    exit;
}

if (isset($_GET['remove'])) {
    $removeId = (int)$_GET['remove'];
    if ($removeId > 0) {
        removeFromCart($removeId);
        flash('Đã xóa sản phẩm khỏi giỏ hàng.');
    }
    header('Location: cart.php');
    exit;
}

$flashMessage = getFlash();
$cart = getCart();

// Lấy dữ liệu sản phẩm từ database
$productIds = array_column($cart, 'id');
$productsById = [];

if (!empty($productIds)) {
    $placeholders = implode(',', array_fill(0, count($productIds), '?'));
    $types = str_repeat('i', count($productIds));
    $stmt = $conn->prepare("SELECT ma_sp, ten_sp, gia, anh_sp, so_luong_ton FROM san_pham WHERE ma_sp IN ($placeholders)");
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

include __DIR__ . '/includes/header.php';
?>

<link rel="stylesheet" href="assets/css/cart.css">

<div class="container py-5">
    <?php if ($flashMessage): ?>
        <div class="alert alert-success" role="alert">
            <?php echo htmlspecialchars($flashMessage); ?>
        </div>
    <?php endif; ?>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0 fw-bold">Giỏ hàng</h3>
        <a href="products.php" onclick="history.back(); return false;" class="text-decoration-none">
            <i class="fa fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card p-3">
                <?php if (empty($cart)): ?>
                    <div class="cart-empty card-body text-center">
                        <div>
                            <svg width="90" height="90" viewBox="0 0 24 24" fill="none">
                                <path d="M3 3h2l.4 2M7 13h10l4-8H5.4" stroke="#6c757d" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                            <h5 class="mt-3">Giỏ hàng của bạn trống</h5>
                            <p class="text-muted">Hãy thêm vài sản phẩm yêu thích vào giỏ nhé.</p>
                            <a href="products.php" class="btn btn-outline-primary">Tiếp tục mua sắm</a>
                        </div>
                    </div>
                <?php else: ?>
                    <form id="cartForm" method="post">
                        <input type="hidden" name="action" value="update">
                        <?php foreach ($cart as $item):
                            $id = (int)$item['id'];
                            $qty = (int)$item['qty'];
                            $product = $productsById[$id] ?? null;
                            if (!$product) {
                                continue;
                            }

                            $name = htmlspecialchars($product['ten_sp']);
                            $price = (float)$product['gia'];
                            $img = htmlspecialchars($product['anh_sp'] ?: 'default.jpg');
                            $lineTotal = $price * $qty;
                        ?>
                            <div class="d-flex align-items-start gap-2 gap-lg-3 p-3 rounded mb-2 product-row">
                                <img class="product-img flex-shrink-0" src="uploads/<?php echo $img; ?>" alt="<?php echo $name; ?>">
                                <div class="flex-grow-1 min-w-0">
                                    <div class="d-flex justify-content-between align-items-start gap-2 flex-wrap">
                                        <div class="min-w-0">
                                            <a class="fw-semibold product-name d-inline-block" href="product-detail.php?id=<?php echo $id; ?>">
                                                <?php echo $name; ?>
                                            </a>
                                            <div class="small text-muted">Mã sản phẩm: <?php echo $id; ?></div>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <div class="fw-bold product-price"><?php echo number_format($price); ?>đ</div>
                                        </div>
                                    </div>

                                    <div class="d-flex align-items-center gap-2 mt-2 mt-lg-3 cart-bottom-row">
                                        <div class="input-group cart-qty-group">
                                            <button type="button" class="btn btn-outline-secondary btn-sm qty-btn dec" onclick="handleQtyChange(<?php echo $id; ?>, -1)"><i class="fa fa-minus"></i></button>
                                            <input type="number" class="form-control form-ctrl-qty form-control-sm text-center qty-input" name="qty[<?php echo $id; ?>]" value="<?php echo $qty; ?>" min="1" max="100" inputmode="numeric" autocomplete="off">
                                            <button type="button" class="btn btn-outline-secondary btn-sm qty-btn inc" onclick="handleQtyChange(<?php echo $id; ?>, 1)"><i class="fa fa-plus"></i></button>
                                        </div>

                                        <div class="cart-line-total fw-bold">
                                            <div class="small text-muted">Thành tiền</div>
                                            <div class="fw-bold line-total"><?php echo number_format($lineTotal); ?>đ</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="cart-remove flex-shrink-0">
                                    <a href="cart.php?remove=<?php echo $id; ?>" class="btn btn-light btn-sm remove-btn" title="Xóa"><i class="fa fa-trash text-danger"></i></a>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </form>
                <?php endif; ?>
            </div>
        </div>

        <!-- Thông tin đơn hàng và thanh toán -->
        <div class="col-lg-4">
            <div class="card p-3 rounded-soft">
                <h6 class="fw-bold mb-3">Tóm tắt đơn hàng</h6>

                <div class="d-flex justify-content-between mb-2">
                    <div>Tạm tính</div>
                    <div id="subtotal"><?php echo number_format($totals['subtotal']); ?>đ</div>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <div>Phí vận chuyển</div>
                    <div id="shipping"><?php echo number_format($totals['shipping']); ?>đ</div>
                </div>
                <div class="total-box mb-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="small text-muted">Tổng thanh toán</div>
                        <div id="grandTotal" class="fs-4 fw-bold"><?php echo number_format($totals['total']); ?>đ</div>
                    </div>
                </div>

                <div class="d-grid mb-2">
                    <?php if (empty($cart)): ?>
                        <button type="button" class="primary-btn d-flex justify-content-center align-items-center disabled" disabled>
                            Tiến hành thanh toán
                        </button>
                        <div class="small text-danger mt-2">Giỏ hàng trống. Vui lòng thêm sản phẩm trước khi tiếp tục.</div>
                    <?php else: ?>
                        <a href="checkout.php" class="primary-btn d-flex justify-content-center align-items-center" style="text-decoration: none;">
                            Tiến hành thanh toán
                        </a>
                    <?php endif; ?>
                </div>

                
            </div>
        </div>
    </div>
</div>

<script>
    function submitCartForm() {
        const form = document.getElementById('cartForm');
        if (!form) return;
        form.submit();
    }

    function clampQty(val) {
        // Cho phép trạng thái tạm thời khi đang gõ (rỗng)
        if (val === '' || val === null || typeof val === 'undefined') return '';
        let n = parseInt(val, 10);
        if (Number.isNaN(n)) return '';
        n = Math.max(1, Math.min(100, n));
        return String(n);
    }

    function handleQtyChange(id, delta) {
        const input = document.querySelector('input[name="qty[' + id + ']"]');
        if (!input) return;
        const current = clampQty(input.value);
        let value = parseInt(current === '' ? '1' : current, 10);
        value = Math.max(1, Math.min(100, value + delta));
        input.value = String(value);
        submitCartForm();
    }

    document.querySelectorAll('.qty-input').forEach(input => {
        // Không submit khi đang gõ để tránh reload lúc nhập 2+ chữ số
        input.addEventListener('input', () => {
            const v = input.value;
            const clamped = clampQty(v);
            // Chỉ sửa khi vượt max hoặc <1 hoặc có ký tự lạ; còn lại để người dùng gõ tự nhiên
            if (clamped !== '' && clamped !== v && /^[0-9]+$/.test(v)) {
                const num = parseInt(v, 10);
                if (num > 100 || num < 1) input.value = clamped;
            }
        });

        // Submit khi rời ô (blur) hoặc user nhấn Enter
        input.addEventListener('blur', () => {
            const clamped = clampQty(input.value);
            input.value = clamped === '' ? '1' : clamped;
            submitCartForm();
        });

        input.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                input.blur(); // sẽ trigger submit ở blur
            }
        });
    });
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>