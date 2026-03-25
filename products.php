<?php
require_once __DIR__ . '/check_role.php';
checkNotAdmin();
require "config/database.php";
include "includes/header.php";

$where = "WHERE trang_thai IN(0,1)";

$order = "ORDER BY ma_sp DESC";
if(isset($_GET['sort'])){
    switch($_GET['sort']){
        case 'name_asc':
            $order = "ORDER BY ten_sp ASC";
            break;
        case 'name_desc':
            $order = "ORDER BY ten_sp DESC";
            break;
        case 'price_asc':
            $order = "ORDER BY gia ASC";
            break;
        case 'price_desc':
            $order = "ORDER BY gia DESC";
            break;
        case 'best_seller':
            $where .= " AND ban_chay = 1";
            break;
    }
}

$ds_loai = $conn->query("SELECT * FROM loai_sp");

// Lọc theo danh mục
if(isset($_GET['ma_loai'])){
    $ma_loai = (int)$_GET['ma_loai'];
    $where .= " AND ma_loai = $ma_loai";
}

// Lọc theo giá
if(isset($_GET['gia'])){
    $gia = (int)$_GET['gia'];

    switch($gia){
        case 1:
            $where .= " AND gia < 50000";
            break;
        case 2:
            $where .= " AND gia BETWEEN 50000 AND 100000";
            break;
        case 3:
            $where .= " AND gia BETWEEN 100000 AND 200000";
            break;
        case 4:
            $where .= " AND gia > 200000";
            break;
    }
}

// Lọc theo tên
$isSearch = false;
if(isset($_GET['keyword']) && $_GET['keyword'] != ""){
    $name = trim($_GET['keyword']);
    $name = $conn->real_escape_string($name);
    $where .= " AND ten_sp LIKE '%$name%'";
    $isSearch = true;
}

//  phân trang 
$limit = 20;

$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
if($page < 1) $page = 1;

$total_result = $conn->query("SELECT COUNT(*) as total FROM san_pham $where");
$total_row = $total_result->fetch_assoc();
$total_products = $total_row['total'];

$total_pages = ceil($total_products / $limit);
$offset = ($page - 1) * $limit;

$result = $conn->query("SELECT * FROM san_pham $where $order LIMIT $limit OFFSET $offset");
?>

<div class="row">
    <?php if(!$isSearch) { ?>
    <!-- SIDEBAR -->
    <div class="col-md-3">

        <!-- Danh mục -->
        <div class="card border-0 rounded-0">
            <div class="card-header bg-dark text-white rounded-0">
                Danh mục
            </div>

            <div class="list-group list-group-flush">
                <?php while($loai = $ds_loai->fetch_assoc()) { ?>
                <a href="products.php?ma_loai=<?php echo $loai['ma_loai']; ?>
                <?php if(isset($_GET['gia'])) echo '&gia='.$_GET['gia'];?>
                <?php if(isset($_GET['sort'])) echo '&sort='.$_GET['sort'];?>"
                    class="list-group-item list-group-item-action 
                    <?php if(isset($_GET['ma_loai']) && $_GET['ma_loai'] == $loai['ma_loai']) echo ' active-category'?>">
                    <?php echo $loai['ten_loai']; ?>
                </a>
                <?php } ?>

                <a href="products.php
                <?php 
                    if(isset($_GET['gia']) && isset($_GET['sort'])){
                        echo '?gia='.$_GET['gia'].'&sort='.$_GET['sort'];
                    }else if(isset($_GET['gia'])){
                        echo '?gia='.$_GET['gia'];
                    }else if(isset($_GET['sort'])){
                        echo '?sort='.$_GET['sort'];
                    }
                ?>" class=" list-group-item list-group-item-action">
                    Bỏ chọn danh mục
                </a>
            </div>
        </div>

        <!-- Lọc giá -->
        <div class="card border-0 my-3 rounded-0">
            <div class="card-header bg-dark text-white rounded-0">
                Lọc theo giá
            </div>

            <div class="list-group list-group-flush">

                <?php
                    $priceRanges = [
                        1 => "Dưới 50.000đ",
                        2 => "50.000đ - 100.000đ",
                        3 => "100.000đ - 200.000đ",
                        4 => "Trên 200.000đ"
                    ];
                    foreach($priceRanges as $key => $label){
                ?>
                <a href="products.php?gia=<?php echo $key; ?> 
                <?php if(isset($_GET['ma_loai'])) echo '&ma_loai='.$_GET['ma_loai'];?>
                <?php if(isset($_GET['sort'])) echo '&sort='.$_GET['sort'];?>
                " class="list-group-item list-group-item-action 
                <?php if(isset($_GET['gia']) && $_GET['gia'] == $key) echo ' active-price';
                ?>">
                    <?php echo $label; ?>
                </a>
                <?php } ?>

                <a href="products.php
                <?php
                    if(isset($_GET['ma_loai']) && isset($_GET['sort'])){
                        echo '?ma_loai='.$_GET['ma_loai'].'&sort='.$_GET['sort'];
                    }else if(isset($_GET['ma_loai'])){
                        echo '?ma_loai='.$_GET['ma_loai'];
                    }else if(isset($_GET['sort'])){
                        echo '?sort='.$_GET['sort'];
                    }
                ?>" class="list-group-item list-group-item-action">
                    Bỏ chọn giá
                </a>

            </div>
        </div>

    </div>
    <?php }?>

    <!--  Sản phẩm-->
    <div class="<?php echo $isSearch ? "col-md-12" : "col-md-9"; ?>">

        <div class="bg-white p-4 mb-2">

            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap">

                <?php
                    if($isSearch){
                ?>
                <a href="products.php<?php if(isset($_GET['sort'])) echo "?sort=". $_GET['sort'];?>"
                    class="text-decoration-none">
                    <i class="fa fa-arrow-left"></i>
                    Thoát tìm kiếm
                </a>
                <?php
                }
                ?>

                <?php
                    if($isSearch){
                        echo "
                                <h4>
                                    <i class='fa fa-search' style='color: #1d9d74;'></i>
                                    <strong class=search-name>$name</strong>
                                </h4>
                            ";
                ?>
                <?php
                    }else{
                        echo "<h4 class=mb-0> Tất cả truyện tranh </h4>";
                    }
                ?>

                <!-- lọc sản phẩm -->
                <form method=" GET">
                    <?php if(isset($_GET['ma_loai'])) { ?>
                    <input type="hidden" name="ma_loai" value="<?php echo $_GET['ma_loai']; ?>">
                    <?php } ?>

                    <?php if(isset($_GET['gia'])) { ?>
                    <input type="hidden" name="gia" value="<?php echo $_GET['gia']; ?>">
                    <?php } ?>

                    <?php if(isset($_GET['keyword'])) { ?>
                    <input type="hidden" name="keyword" value="<?php echo $_GET['keyword']; ?>">
                    <?php } ?>

                    <select name="sort" class="form-select" onchange="this.form.submit()">

                        <option value="">Sắp xếp</option>

                        <option value="name_asc"
                            <?php if(isset($_GET['sort']) && $_GET['sort']=='name_asc') echo 'selected'; ?>>
                            Tên A → Z
                        </option>

                        <option value="name_desc"
                            <?php if(isset($_GET['sort']) && $_GET['sort']=='name_desc') echo 'selected'; ?>>
                            Tên Z → A
                        </option>

                        <option value="price_asc"
                            <?php if(isset($_GET['sort']) && $_GET['sort']=='price_asc') echo 'selected'; ?>>
                            Giá tăng dần
                        </option>

                        <option value="price_desc"
                            <?php if(isset($_GET['sort']) && $_GET['sort']=='price_desc') echo 'selected'; ?>>
                            Giá giảm dần
                        </option>

                        <option value="best_seller"
                            <?php if(isset($_GET['sort']) && $_GET['sort']=='best_seller') echo 'selected'; ?>>
                            Sản phẩm bán chạy
                        </option>

                    </select>
                </form>

            </div>
            <hr>

            <!-- hiện sp -->
            <div class="row">
                <?php while($row = $result->fetch_assoc()) { ?>
                <div class="col-lg-3 col-md-4 col-6 mb-5">
                    <div class="card border-0 h-100">

                        <div class="d-flex justify-content-center align-items-center"
                            style="height: 180px; overflow: hidden;">

                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>">
                                <img src="uploads/<?php echo $row['anh_sp']; ?>"
                                    style="height:100%; width:auto; object-fit:contain;">
                            </a>

                        </div>

                        <div class="card-body p-2 d-flex flex-column">

                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>" class="product-name">
                                <?php echo $row['ten_sp']; ?>
                            </a>

                            <p class="author-name">
                                <?php echo $row['tac_gia']; ?>
                            </p>

                            <p class="fw-bold mb-2 product-price">
                                <?php echo number_format($row['gia']); ?>đ
                            </p>

                            <a href="product-detail.php?id=<?php echo $row['ma_sp']; ?>"
                                class="btn btn-sm btn-outline-primary mt-auto">
                                Xem chi tiết
                            </a>

                        </div>

                    </div>
                </div>
                <?php } ?>
            </div>

        </div>

        <div class="bg-white px-4 pt-2 pb-4 mb-5">
            <!-- phân trang sản phẩm  -->
            <nav>
                <ul class="pagination justify-content-center">

                    <?php if($page > 1): ?>
                    <li class="page-item">
                        <a class="page-link" href="?<?php 
                            echo http_build_query(array_merge($_GET, ['page' => $page-1])); 
                        ?>">
                            &lt;
                        </a>
                    </li>
                    <?php endif; ?>

                    <?php for($i = 1; $i <= $total_pages; $i++): ?>
                    <li class="page-item <?php if($i == $page) echo 'active'; ?>">
                        <a class="page-link" href="?<?php 
                            echo http_build_query(array_merge($_GET, ['page' => $i])); 
                        ?>">
                            <?php echo $i; ?>
                        </a>
                    </li>
                    <?php endfor; ?>

                    <?php if($page < $total_pages): ?>
                    <li class="page-item">
                        <a class="page-link" href="?<?php 
                            echo http_build_query(array_merge($_GET, ['page' => $page+1])); 
                        ?>">
                            &gt;
                        </a>
                    </li>
                    <?php endif; ?>

                </ul>
            </nav>
            <div class="introduce">
                <h4 class="introduce-title">Giới thiệu</h4>
                <p class="introduce-content">
                    Không chỉ trẻ em và lứa tuổi Teen yêu thích <strong>truyện tranh</strong> mà cả người lớn cũng mê
                    những cuốn truyện đầy hình vẽ. <strong>Tiệm truyện tranh online CTU COMIC</strong> đem đến cho bạn
                    những bộ <strong>truyện tranh hot và mới nhất:</strong> Jujutsu Kaisen, Naruto, Doraemon,
                    Conan,...đủ các thể loại: manga, manhwa, comic với tốc độ update nhanh nhất có thể từ các
                    đơn vị phát hành uy tín: NXB Trẻ, NXB Kim Đồng, TVM Comics, Phan Thị, Skybooks Comics,...
                </p>
                <p></p>
                <p class="introduce-content"><strong>CTU COMIC</strong> - kênh <strong>bán truyện tranh</strong> đầy đủ,
                    giao hàng nhanh nhất Việt Nam!</p>
            </div>
        </div>
    </div>


</div>

<?php include "includes/footer.php"; ?>