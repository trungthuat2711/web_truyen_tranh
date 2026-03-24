<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';
checkRole('admin');

// tổng doanh thu
$doanhthu = $conn->query("
SELECT SUM(tong_tien) as tong 
FROM don_hang 
WHERE trang_thai='da_giao'
")->fetch_assoc()['tong'] ?? 0;

// số đơn
$donhang = $conn->query("
SELECT COUNT(*) as total FROM don_hang
")->fetch_assoc()['total'];

// sản phẩm
$sanpham = $conn->query("
SELECT COUNT(*) as total FROM san_pham
")->fetch_assoc()['total'];

// khách hàng
$khach = $conn->query("
SELECT COUNT(*) as total FROM tai_khoan WHERE vai_tro='khach'
")->fetch_assoc()['total'];


// doanh thu theo tháng
$dataMonth = [];
$res = $conn->query("
SELECT MONTH(ngay_dat) as thang, SUM(tong_tien) as tong
FROM don_hang
WHERE trang_thai='da_giao'
GROUP BY MONTH(ngay_dat)
");

while($row = $res->fetch_assoc()){
    $dataMonth[$row['thang']] = $row['tong'];
}

// chuẩn hóa 12 tháng
$labels = [];
$data = [];

for($i=1;$i<=12;$i++){
    $labels[] = "Tháng $i";
    $data[] = $dataMonth[$i] ?? 0;
}
//trạng thái
$statusData = [];
$res = $conn->query("
SELECT trang_thai, COUNT(*) as total 
FROM don_hang 
GROUP BY trang_thai
");

while($row = $res->fetch_assoc()){
    $statusData[$row['trang_thai']] = $row['total'];
}

// doanh thu + số đơn theo ngày
$dataNgay = [];

$res = $conn->query("
SELECT DATE(ngay_dat) as ngay,
       SUM(tong_tien) as doanhthu,
       COUNT(*) as sodon
FROM don_hang
GROUP BY DATE(ngay_dat)
ORDER BY ngay DESC
LIMIT 7
");

while($row = $res->fetch_assoc()){
    $dataNgay[$row['ngay']] = $row;
}

// chuẩn hóa dữ liệu 7 ngày
$labelsDay = [];
$dataDoanhThu = [];
$dataDon = [];

for($i = 6; $i >= 0; $i--){
    $date = date('Y-m-d', strtotime("-$i days"));

    $labelsDay[] = $date;

    $dataDoanhThu[] = $dataNgay[$date]['doanhthu'] ?? 0;
    $dataDon[] = $dataNgay[$date]['sodon'] ?? 0;
}
?>

<style>
    .box {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
    }

    .box div {
        background: #3498db;
        color: white;
        padding: 15px;
        border-radius: 10px;
        flex: 1;
        text-align: center;
        font-weight: bold;
}
</style>
<!-- Content -->
<div class="content">
    <h1>Dashboard</h1>

    <div class="box">
        <div>Tổng doanh thu: <?= number_format($doanhthu,0,',','.') ?>đ</div>
        <div>Tổng đơn: <?= $donhang ?></div>
        <div>Sản phẩm: <?= $sanpham ?></div>
        <div>Khách hàng: <?= $khach ?></div>
    </div>

    <br>
    <h2>Doanh thu tháng</h2>
    <canvas id="chartDoanhThu"></canvas>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const ctx = document.getElementById('chartDoanhThu');

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: <?= json_encode($labels) ?>,
                datasets: [{
                    label: 'Doanh thu',
                    data: <?= json_encode($data) ?>,
                    borderWidth: 1
                }]
            }
        });
    </script>

    <br>
    <h2>Thống kê 7 ngày gần nhất</h2>
    <canvas id="chartNgay"></canvas>
    <script>
        new Chart(document.getElementById('chartNgay'), {
            type: 'line',
            data: {
                labels: <?= json_encode($labelsDay) ?>,
                datasets: [
                    {
                        label: 'Doanh thu',
                        data: <?= json_encode($dataDoanhThu) ?>
                    },
                    {
                        label: 'Số đơn',
                        data: <?= json_encode($dataDon) ?>
                    }
                ]
            }
        });
    </script>

    <br>
    <h2>Trạng thái năm</h2>
    <div style="width:300px; height:300px; margin:auto;">
        <canvas id="chartStatus"></canvas>
        <script>
            new Chart(document.getElementById('chartStatus'), {
                type: 'pie',
                data: {
                    labels: <?= json_encode(array_keys($statusData)) ?>,
                    datasets: [{
                        data: <?= json_encode(array_values($statusData)) ?>
                    }]
                }
            });
        </script>
    </div>
</div>

</body>
</html>