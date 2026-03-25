<?php
require_once __DIR__ . '/check_role.php';
require_once __DIR__ . '/config/database.php';
require __DIR__ . '/includes/admin_header.php';
checkRole('admin');


// tìm kiếm
$keyword = isset($_GET['search']) ? $_GET['search'] : '';

$sql = "SELECT sp.*, l.ten_loai 
        FROM san_pham sp
        LEFT JOIN loai_sp l ON sp.ma_loai = l.ma_loai
        WHERE sp.ten_sp LIKE '%$keyword%'";

$result = $conn->query($sql);

?>

<!DOCTYPE html>
<html>

<head>
    <title>Quản lý truyện</title>
</head>

<body>


    <!-- Content -->
    <div class="content">

        <h1>Quản lý truyện</h1>

        <div class="top-bar">
            <a href="add_comic.php">
                <button class="btn btn-add">
                    <i class="fa fa-plus"></i> Thêm truyện
                </button>
            </a>

            <form method="GET">
                <input type="text" name="search" placeholder="Tìm truyện..." value="<?php echo $keyword; ?>">
                <button><i class="fa fa-search"></i></button>
            </form>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Ảnh</th>
                <th>Tên</th>
                <th>Tác giả</th>
                <th>Giá</th>
                <th>Giá cũ</th>
                <th>Tồn</th>
                <th>Thể loại</th>
                <th>Trạng thái</th>
                <th>Bán chạy</th>
                <th>Ngày tạo</th>
                <th>Thao tác</th>
            </tr>

            <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['ma_sp'] ?></td>

                <td>
                    <img src="uploads/<?php echo $row['anh_sp']; ?>">
                </td>

                <td><?= $row['ten_sp'] ?></td>

                <td><?= $row['tac_gia'] ?></td>

                <td><?= number_format($row['gia'],0,',','.') ?>đ</td>

                <td><?= ($row['gia_cu'] != NULL) ? number_format($row['gia_cu'],0,',','.').'đ' : '-'?></td>

                <td><?= $row['so_luong_ton'] ?></td>

                <td><?= $row['ten_loai'] ?></td>

                <td>
                    <?= $row['trang_thai'] ? 'Hiển thị' : 'Ẩn' ?>
                </td>

                <td>
                    <?= $row['ban_chay'] ? '🔥' : '' ?>
                </td>

                <td><?= $row['ngay_tao'] ?></td>

                <td>
                    <a href="edit_comic.php?id=<?php echo $row['ma_sp']; ?>">
                        <button class="btn btn-edit">
                            <i class="fa fa-pen"></i>
                        </button>
                    </a>

                    <a href="delete_comic.php?id=<?php echo $row['ma_sp']; ?>"
                        onclick="return confirm('Bạn có chắc muốn xóa truyện này?')">
                        <button class="btn btn-delete">
                            <i class="fa fa-trash"></i>
                        </button>
                    </a>
                </td>
            </tr>
            <?php endwhile; ?>

        </table>

    </div>

</body>

</html>