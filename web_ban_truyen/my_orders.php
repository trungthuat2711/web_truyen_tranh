<?php
require __DIR__ . '/config/database.php';
require __DIR__ . '/check_login.php';
require __DIR__ . '/includes/cart_functions.php';

// Đảm bảo chỉ xem được đơn hàng của chính tài khoản đăng nhập
if (empty($_SESSION['user']) || !isset($_SESSION['user']['ma_tk'])) {
    header('Location: login.php');
    exit;
}

$currentUserId = (int)$_SESSION['user']['ma_tk'];

$q = trim($_GET['q'] ?? '');
$page = max(1, (int)($_GET['page'] ?? 1));
$perPage = 10;
$offset = ($page - 1) * $perPage;

// Mặc định lọc theo ma_kh = tài khoản hiện tại
$where = 'WHERE o.ma_kh = ?';
$params = [$currentUserId];
$types = 'i';

if ($q !== '') {
    $orderId = ctype_digit($q) ? (int)$q : 0;
    $conds = [];
    if ($orderId > 0) {
        $conds[] = 'o.ma_don = ?';
        $params[] = $orderId;
        $types .= 'i';
    }
    $conds[] = 'o.ten_khach LIKE ?';
    $params[] = "%$q%";
    $types .= 's';

    $conds[] = 'o.so_dien_thoai LIKE ?';
    $params[] = "%$q%";
    $types .= 's';

    $where .= ' AND (' . implode(' OR ', $conds) . ')';
}

$countQuery = "SELECT COUNT(*) as total FROM don_hang o $where";
$stmt = $conn->prepare($countQuery);
if ($stmt) {
    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    $totalOrders = (int)$result->fetch_assoc()['total'];
    $stmt->close();
} else {
    $totalOrders = 0;
}

$totalPages = max(1, (int)ceil($totalOrders / $perPage));

$orderQuery = "
    SELECT o.ma_don, o.ten_khach, o.so_dien_thoai, o.dia_chi_giao, o.tong_tien, o.phuong_thuc_thanh_toan, o.trang_thai, o.ngay_dat
    FROM don_hang o
    $where
    ORDER BY o.ngay_dat DESC
    LIMIT ? OFFSET ?
";

$stmt = $conn->prepare($orderQuery);
if ($stmt) {
    $bindParams = array_merge($params, [$perPage, $offset]);
    $stmt->bind_param($types . 'ii', ...$bindParams);
    $stmt->execute();
    $orders = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
} else {
    $orders = [];
}

$orderIds = array_map(fn($o) => (int)$o['ma_don'], $orders);
$itemsByOrder = [];
if (!empty($orderIds)) {
    $placeholders = implode(',', array_fill(0, count($orderIds), '?'));

    $stmt = $conn->prepare(
        "SELECT cth.ma_don, cth.so_luong, cth.gia_tai_thoi_diem_dat, sp.ten_sp
         FROM chi_tiet_don_hang cth
         LEFT JOIN san_pham sp ON sp.ma_sp = cth.ma_sp
         WHERE cth.ma_don IN ($placeholders)"
    );
    $types = str_repeat('i', count($orderIds));
    $stmt->bind_param($types, ...$orderIds);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $itemsByOrder[(int)$row['ma_don']][] = $row;
    }
    $stmt->close();
}

function formatVnd($value) {
    return number_format((float)$value, 0, ',', '.') . ' đ';
}

function formatDate($date) {
    return date('H:i d/m/Y', strtotime($date));
}

function statusBadge($status) {
    $map = [
        'cho_xac_nhan' => ['label' => 'Chờ xác nhận', 'class' => 'bg-warning text-dark'],
        'dang_giao' => ['label' => 'Đang giao', 'class' => 'bg-info'],
        'da_giao' => ['label' => 'Đã giao', 'class' => 'bg-success'],
        'huy' => ['label' => 'Đã hủy', 'class' => 'bg-danger'],
    ];
    $s = strtolower($status);
    if (!isset($map[$s])) {
        return '<span class="badge bg-secondary">' . htmlspecialchars($status) . '</span>';
    }
    return '<span class="badge ' . $map[$s]['class'] . '">' . htmlspecialchars($map[$s]['label']) . '</span>';
}

$extraHead = '<link rel="stylesheet" href="assets/css/style.css">';
include __DIR__ . '/includes/header.php';
?>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0 fw-bold">Đơn hàng của tôi</h3>
        <a href="products.php" onclick="history.back(); return false;" class="text-decoration-none">
            <i class="fa fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <form method="get" class="row gy-2 gx-2 align-items-center mb-4">
        <div class="col-auto">
            <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" class="form-control" placeholder="Tìm mã đơn / tên / số điện thoại">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
    </form>

    <?php if (empty($orders)): ?>
        <div class="alert alert-info">
            <?php echo $q !== '' ? 'Không tìm thấy đơn hàng phù hợp. Hãy thử thay đổi từ khóa tìm kiếm.' : 'Bạn chưa có đơn hàng nào.'; ?>
        </div>
    <?php else: ?>
        <?php foreach ($orders as $order): ?>
            <div class="card mb-4">
                <div class="card-body">
                    <div class="d-flex justify-content-between flex-wrap gap-2 mb-3">
                        <div>
                            <div class="fw-semibold">Đơn #<?php echo htmlspecialchars($order['ma_don']); ?></div>
                            <div class="text-muted" style="font-size:0.9rem;">Ngày: <?php echo formatDate($order['ngay_dat']); ?></div>
                        </div>
                        <div class="text-end d-flex align-items-center gap-2">
                            <?php echo statusBadge($order['trang_thai']); ?>
                            <a href="thankyou.php?orderId=<?php echo (int)$order['ma_don']; ?>" class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-2"><strong>Khách hàng:</strong> <?php echo htmlspecialchars($order['ten_khach']); ?></div>
                            <div class="mb-2"><strong>SĐT:</strong> <?php echo htmlspecialchars($order['so_dien_thoai']); ?></div>
                            <div class="mb-2"><strong>Địa chỉ:</strong> <?php echo htmlspecialchars($order['dia_chi_giao']); ?></div>
                            <div class="mb-2"><strong>Thanh toán:</strong> <?php echo htmlspecialchars(strtoupper($order['phuong_thuc_thanh_toan'])); ?></div>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <div class="mb-2"><strong>Tổng tiền:</strong> <?php echo formatVnd($order['tong_tien']); ?></div>
                        </div>
                    </div>

                    <div class="order-items mt-3">
                        <?php $items = $itemsByOrder[(int)$order['ma_don']] ?? []; ?>
                        <?php if (empty($items)): ?>
                            <div class="text-muted">Không có sản phẩm.</div>
                        <?php else: ?>
                            <?php foreach ($items as $item): ?>
                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <div class="flex-fill">
                                        <div class="fw-semibold"><?php echo htmlspecialchars($item['ten_sp'] ?? 'Sản phẩm'); ?></div>
                                        <div class="text-muted" style="font-size:0.9rem;">Số lượng: <?php echo (int)$item['so_luong']; ?></div>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-semibold"><?php echo formatVnd($item['gia_tai_thoi_diem_dat'] * $item['so_luong']); ?></div>
                                        <div class="text-muted" style="font-size:0.85rem;">(<?php echo formatVnd($item['gia_tai_thoi_diem_dat']); ?>/1)</div>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>

        <nav aria-label="Page navigation">
            <ul class="pagination">
                <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                    <li class="page-item <?php echo $i === $page ? 'active' : ''; ?>">
                        <a class="page-link" href="?q=<?php echo urlencode($q); ?>&page=<?php echo $i; ?>"><?php echo $i; ?></a>
                    </li>
                <?php endfor; ?>
            </ul>
        </nav>
    <?php endif; ?>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>