<?php
session_start();
require __DIR__ . '/config/database.php';
require __DIR__ . '/includes/cart_functions.php';

$bankConfigFile = __DIR__ . '/config/bank.json';
$bankConfig = file_exists($bankConfigFile)
    ? json_decode(file_get_contents($bankConfigFile), true) ?: []
    : ['bank_id' => 'bidv', 'account_no' => '', 'account_name' => '', 'transfer_content' => 'DON HANG'];
$transferContentFormat = $bankConfig['transfer_content'] ?? 'DON HANG';

$orderId = isset($_GET['orderId']) ? (int)$_GET['orderId'] : 0;
$orderEmail = trim($_GET['email'] ?? '');
if ($orderEmail === '') {
    $orderEmail = null;
}
$order = null;
$items = [];

if ($orderId > 0) {
    $stmt = $conn->prepare(
        'SELECT ma_don, ten_khach, so_dien_thoai, dia_chi_giao, email, ghi_chu, tong_tien, phuong_thuc_thanh_toan, trang_thai, ngay_dat FROM don_hang WHERE ma_don = ?'
    );
    $stmt->bind_param('i', $orderId);
    $stmt->execute();
    $order = $stmt->get_result()->fetch_assoc();
    $stmt->close();

    if ($order) {
        $stmt = $conn->prepare(
            'SELECT cth.ma_sp, cth.so_luong, cth.gia_tai_thoi_diem_dat, sp.ten_sp
             FROM chi_tiet_don_hang cth
             LEFT JOIN san_pham sp ON sp.ma_sp = cth.ma_sp
             WHERE cth.ma_don = ?'
        );
        $stmt->bind_param('i', $orderId);
        $stmt->execute();
        $items = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        // Tính toán phụ phí (phí vận chuyển) tương ứng với logic tại checkout
        $subtotal = 0;
        foreach ($items as $item) {
            $subtotal += (float)$item['gia_tai_thoi_diem_dat'] * (int)$item['so_luong'];
        }
        $shipping = $subtotal === 0 ? 0 : ($subtotal >= 250000 ? 0 : 20000);
    }
}

function statusLabel($status)
{
    $map = [
        'cho_xac_nhan' => 'Chờ xác nhận',
        'dang_giao' => 'Đang giao',
        'da_giao' => 'Đã giao',
        'huy' => 'Đã hủy',
    ];
    $key = strtolower($status ?? '');
    return $map[$key] ?? ucfirst(str_replace('_', ' ', $status));
}

function paymentLabel($value)
{
    switch (strtoupper($value)) {
        case 'COD':
            return 'Thanh toán khi nhận hàng';
        case 'BANK':
            return 'Chuyển khoản ngân hàng';
        default:
            return 'Chưa xác định';
    }
}

function formatVnd($value)
{
    return number_format((float)$value, 0, ',', '.') . ' đ';
}

function formatDateTime($dateTime)
{
    return date('H:i d/m/Y', strtotime($dateTime));
}

$extraHead = '<link rel="stylesheet" href="assets/css/checkout.css">';
include __DIR__ . '/includes/header.php';
?>

<div class="success-container">
    <div class="success-icon">
        <i class="fas fa-check"></i>
    </div>

    <h1 class="success-title">Đặt hàng thành công!</h1>
    <p class="success-text">
        Cảm ơn bạn đã tin tưởng và mua hàng tại CTU COMIC STORE. Đơn hàng của bạn đã được xác nhận!
    </p>

    <?php if (!empty($order)): ?>
        <div class="order-info">
            <div class="order-info-row">
                <span class="order-info-label">Trạng thái</span>
                <span class="order-info-value status-label"><?php echo statusLabel($order['trang_thai']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Mã đơn hàng</span>
                <span class="order-info-value">#<?php echo htmlspecialchars($order['ma_don']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Ngày đặt hàng</span>
                <span class="order-info-value"><?php echo formatDateTime($order['ngay_dat']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Họ và tên</span>
                <span class="order-info-value"><?php echo htmlspecialchars($order['ten_khach']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Địa chỉ giao hàng</span>
                <span class="order-info-value"><?php echo htmlspecialchars($order['dia_chi_giao']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Số điện thoại</span>
                <span class="order-info-value"><?php echo htmlspecialchars($order['so_dien_thoai']); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Email</span>
                <span class="order-info-value"><?php echo htmlspecialchars($order['email'] ?? $orderEmail ?? '—'); ?></span>
            </div>
            <div class="order-info-row">
                <span class="order-info-label">Phương thức thanh toán</span>
                <span class="order-info-value"><?php echo paymentLabel($order['phuong_thuc_thanh_toan']); ?></span>
            </div>
            <?php if (!empty($order['ghi_chu'])): ?>
                <div class="order-info-row">
                    <span class="order-info-label">Ghi chú</span>
                    <span class="order-info-value"><?php echo nl2br(htmlspecialchars($order['ghi_chu'])); ?></span>
                </div>
            <?php endif; ?>
            <div class="order-info-row">
                <span class="order-info-label">Tổng tiền</span>
                <span class="order-info-value"><?php echo formatVnd($order['tong_tien']); ?></span>
            </div>
        </div>

        <div class="order-items mb-3">
            <h5>Chi tiết đơn hàng</h5>
            <?php if (empty($items)): ?>
                <div class="text-muted">Không có sản phẩm trong đơn hàng.</div>
            <?php else: ?>
                <div class="list-group">
                    <?php foreach ($items as $item): ?>
                        <div class="list-group-item d-flex justify-content-between align-items-start flex-wrap">
                            <div class="me-3 text-start">
                                <div class="fw-semibold"><?php echo htmlspecialchars($item['ten_sp'] ?? 'Sản phẩm'); ?></div>
                                <div class="text-muted text-start" style="font-size:0.9rem;">Số lượng: <?php echo (int)$item['so_luong']; ?></div>
                            </div>
                            <div class="text-end">
                                <div class="fw-semibold"><?php echo formatVnd($item['gia_tai_thoi_diem_dat'] * $item['so_luong']); ?></div>
                                <div class="text-muted" style="font-size:0.85rem;">(<?php echo formatVnd($item['gia_tai_thoi_diem_dat']); ?> / 1)</div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                <div class="list-group-item d-flex justify-content-between align-items-start flex-wrap">
                    <span class="fw-semibold">Phí vận chuyển</span>
                    <span class="fw-semibold"><?php echo formatVnd($shipping ?? 0); ?></span>
                </div>
                </div>
            <?php endif; ?>
        </div>

        <?php if (strtoupper($order['phuong_thuc_thanh_toan'] ?? '') === 'BANK'): ?>
            <?php
            $totalAmount = (int)round((float)$order['tong_tien']);
            $transferContent = $transferContentFormat . ' ' . (int)$order['ma_don'];
            $description = strtoupper(preg_replace('/[^a-zA-Z0-9\s]/', '', $transferContent));
            $addInfo = rawurlencode(mb_substr($description, 0, 50));
            $accountNameEncoded = rawurlencode($bankConfig['account_name']);
            $qrUrl = sprintf(
                'https://img.vietqr.io/image/%s-%s-compact2.png?amount=%d&addInfo=%s&accountName=%s',
                $bankConfig['bank_id'],
                $bankConfig['account_no'],
                $totalAmount,
                $addInfo,
                $accountNameEncoded
            );
            ?>
            <div class="bank-qr-box mb-4">
                <h6 class="mb-3"><i class="fas fa-qrcode me-2"></i>Quét mã QR để chuyển khoản</h6>
                <span>Vui lòng thanh toán trong vòng 24h sau khi đặt hàng,<br>nếu không đơn hàng sẽ bị hủy sau 24h.<br><br></span>
                <div class="bank-qr-placeholder">
                    <img src="<?php echo htmlspecialchars($qrUrl); ?>" alt="QR chuyển khoản ngân hàng" class="img-fluid" style="max-width: 300px;">
                    <p class="mt-2 small text-muted mb-0">Số tiền: <strong><?php echo formatVnd($order['tong_tien']); ?></strong></p>
                    <p class="small text-muted mb-0">Nội dung chuyển khoản: <strong><?php echo htmlspecialchars($transferContent); ?></strong></p>
                </div>
            </div>
        <?php endif; ?>

        <div class="button-group">
            <a href="products.php" class="btn btn-primary">
                <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
            </a>
            <a href="my_orders.php?q=<?php echo (int)($order['ma_don'] ?? 0); ?>" class="btn btn-outline-primary">
                <i class="fas fa-history me-2"></i>Xem đơn hàng của tôi
            </a>
        </div>
    <?php else: ?>
        <p class="success-text">
            Không tìm thấy thông tin đơn hàng. Vui lòng kiểm tra lại đường dẫn hoặc quay về cửa hàng.
        </p>
        <div class="button-group">
            <a href="products.php" class="btn btn-primary">
                <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
            </a>
            <a href="my_orders.php" class="btn btn-outline-primary">
                <i class="fas fa-history me-2"></i>Xem đơn hàng của tôi
            </a>
        </div>
    <?php endif; ?>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>