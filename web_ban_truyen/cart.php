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
        <a href="index.php" class="btn btn-sm btn-light">Tiếp tục mua sắm</a>
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
                            <a href="index.php" class="btn btn-outline-primary">Tiếp tục mua sắm</a>
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
                            <div class="d-flex align-items-center gap-3 p-3 rounded mb-2 product-row">
                                <img class="product-img" src="uploads/<?php echo $img; ?>" alt="<?php echo $name; ?>">
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-semibold product-name"><?php echo $name; ?></div>
                                            <div class="small text-muted">Mã: <?php echo $id; ?></div>
                                        </div>
                                        <div class="text-end">
                                            <div class="fw-bold product-price"><?php echo number_format($price); ?>đ</div>
                                        </div>
                                    </div>

                                    <div class="d-flex align-items-center gap-2 mt-3">
                                        <div class="input-group" style="width:140px">
                                            <button type="button" class="btn btn-outline-secondary qty-btn dec" onclick="handleQtyChange(<?php echo $id; ?>, -1)"><i class="fa fa-minus"></i></button>
                                            <input type="number" class="form-control text-center qty-input" name="qty[<?php echo $id; ?>]" value="<?php echo $qty; ?>" min="1" style="max-width:60px;border-radius:0" onchange="scheduleCartUpdate()">
                                            <button type="button" class="btn btn-outline-secondary qty-btn inc" onclick="handleQtyChange(<?php echo $id; ?>, 1)"><i class="fa fa-plus"></i></button>
                                        </div>

                                        <div class="ms-auto text-end">
                                            <div class="small text-muted">Thành tiền</div>
                                            <div class="fw-bold line-total"><?php echo number_format($lineTotal); ?>đ</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="ms-3">
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
                        <div class="small text-muted">Phương thức thanh toán và vận chuyển sẽ được chọn ở bước tiếp theo.</div>

                    <?php endif; ?>
                </div>

                
            </div>
        </div>
    </div>
</div>

<script>
    // Auto submit cart form khi số lượng thay đổi (debounce)
    let cartUpdateTimer = null;

    function submitCartForm() {
        const form = document.getElementById('cartForm');
        if (!form) return;
        form.submit();
    }

    function scheduleCartUpdate() {
        clearTimeout(cartUpdateTimer);
        cartUpdateTimer = setTimeout(() => {
            submitCartForm();
        }, 450);
    }

    function handleQtyChange(id, delta) {
        const input = document.querySelector('input[name="qty[' + id + ']"]');
        if (!input) return;
        let value = parseInt(input.value) || 1;
        value = Math.max(1, value + delta);
        input.value = value;
        scheduleCartUpdate();
    }

    document.querySelectorAll('.qty-input').forEach(input => {
        input.addEventListener('input', () => {
            // ensure minimum 1
            let val = parseInt(input.value) || 1;
            if (val < 1) val = 1;
            input.value = val;
            scheduleCartUpdate();
        });
    });
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>