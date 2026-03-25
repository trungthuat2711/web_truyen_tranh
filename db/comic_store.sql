-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 24, 2026 at 06:40 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `comic_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `ma_ct` int(11) NOT NULL,
  `ma_don` int(11) DEFAULT NULL,
  `ma_sp` int(11) DEFAULT NULL,
  `so_luong` int(11) DEFAULT NULL,
  `gia_tai_thoi_diem_dat` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`ma_ct`, `ma_don`, `ma_sp`, `so_luong`, `gia_tai_thoi_diem_dat`) VALUES
(61, 36, 23, 10, 150000.00),
(62, 36, 22, 1, 150000.00),
(63, 36, 21, 1, 150000.00),
(64, 37, 1, 1, 25000.00),
(65, 38, 26, 999, 65000.00),
(66, 39, 1, 101, 25000.00),
(67, 39, 31, 1, 65000.00),
(68, 40, 1, 1, 25000.00),
(69, 41, 2, 57, 23000.00);

-- --------------------------------------------------------

--
-- Table structure for table `danh_gia`
--

CREATE TABLE `danh_gia` (
  `ma_danh_gia` int(11) NOT NULL,
  `ma_sp` int(11) DEFAULT NULL,
  `ma_kh` int(11) DEFAULT NULL,
  `so_sao` int(11) DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `ngay_danh_gia` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danh_gia`
--

INSERT INTO `danh_gia` (`ma_danh_gia`, `ma_sp`, `ma_kh`, `so_sao`, `noi_dung`, `ngay_danh_gia`) VALUES
(1, 1, 4, 5, 'Truyện rất hay', '2026-03-05 23:20:18'),
(2, 2, 5, 4, 'Đọc khá cuốn', '2026-03-05 23:20:18'),
(3, 3, 6, 5, 'Tuổi thơ luôn', '2026-03-05 23:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `ma_don` int(11) NOT NULL,
  `ma_kh` int(11) DEFAULT NULL,
  `ten_khach` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi_giao` text DEFAULT NULL,
  `tong_tien` decimal(10,2) DEFAULT NULL,
  `phuong_thuc_thanh_toan` varchar(50) DEFAULT 'COD',
  `trang_thai` varchar(50) DEFAULT 'cho_xac_nhan',
  `ngay_dat` datetime DEFAULT current_timestamp(),
  `ngay_duyet_don` datetime DEFAULT NULL,
  `ngay_hoan_tat` datetime DEFAULT NULL,
  `ghi_chu` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma_don`, `ma_kh`, `ten_khach`, `so_dien_thoai`, `dia_chi_giao`, `tong_tien`, `phuong_thuc_thanh_toan`, `trang_thai`, `ngay_dat`, `ngay_duyet_don`, `ngay_hoan_tat`, `ghi_chu`, `email`) VALUES
(36, 7, 'Nguyen Van A', '0987654312', 'Cần Thơ', 1800000.00, 'BANK', 'cho_xac_nhan', '2026-03-15 00:00:44', NULL, NULL, '', 'TVB@gmail.com'),
(37, 8, 'Loc Le', '0123456789', 'Cần Thơ', 45000.00, 'COD', 'cho_xac_nhan', '2026-03-15 00:03:03', NULL, NULL, '', 'locle@gmail.com'),
(38, 1, 'admin', '0123456789', 'adminhouse', 64935000.00, 'COD', 'cho_xac_nhan', '2026-03-15 00:11:50', NULL, NULL, '', 'admin@gmail.com'),
(39, 1, 'Nguyen Van A', '0987654312', 'Cần Thơ', 2590000.00, 'COD', 'cho_xac_nhan', '2026-03-18 08:48:16', NULL, NULL, '', 'TVB@gmail.com'),
(40, 1, 'Nguyen Van A', '0987654312', 'Cần Thơ', 45000.00, 'BANK', 'cho_xac_nhan', '2026-03-18 08:53:23', NULL, NULL, '', 'TVB@gmail.com'),
(41, 7, 'Nguyen Van A', '0987654312', 'Cần Thơ', 1311000.00, 'COD', 'cho_xac_nhan', '2026-03-19 22:09:59', NULL, NULL, '', 'TVB@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `lich_su_trang_thai_don`
--

CREATE TABLE `lich_su_trang_thai_don` (
  `ma_lich_su` int(11) NOT NULL,
  `ma_don` int(11) DEFAULT NULL,
  `trang_thai` varchar(50) DEFAULT NULL,
  `nguoi_cap_nhat` int(11) DEFAULT NULL,
  `thoi_gian_cap_nhat` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loai_sp`
--

CREATE TABLE `loai_sp` (
  `ma_loai` int(11) NOT NULL,
  `ten_loai` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loai_sp`
--

INSERT INTO `loai_sp` (`ma_loai`, `ten_loai`) VALUES
(1, 'Hành động'),
(2, 'Tình cảm'),
(3, 'Kinh dị'),
(4, 'Hài hước');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `ma_sp` int(11) NOT NULL,
  `ten_sp` varchar(255) NOT NULL,
  `tac_gia` varchar(255) DEFAULT NULL,
  `gia` decimal(10,2) NOT NULL,
  `gia_cu` decimal(10,2) DEFAULT NULL,
  `so_luong_ton` int(11) DEFAULT 0,
  `anh_sp` varchar(255) DEFAULT NULL,
  `mo_ta` text DEFAULT NULL,
  `ma_loai` int(11) DEFAULT NULL,
  `trang_thai` tinyint(4) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ban_chay` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`ma_sp`, `ten_sp`, `tac_gia`, `gia`, `gia_cu`, `so_luong_ton`, `anh_sp`, `mo_ta`, `ma_loai`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`, `ban_chay`) VALUES
(1, 'Thám Tử Lừng Danh Conan - Tập 87', 'Gosho Aoyama', 25000.00, NULL, 0, 'conan87.jpg', 'Trong làn mưa anh đào… Ran hồi tưởng lại lần đầu gặp Shinichi ở nhà trẻ Beika! Câu chuyện gợi ra những sắc màu hoàn toàn khác lạ về Ran và Shinichi trong mắt của hai người…! Ở tập này các bạn sẽ có lời giải cho “Những vụ án mạng ở Kawanakajima” và đến với “Vụ giết hại ngôi sao blog”.', 3, 1, '2026-02-26 04:40:06', '2026-03-24 17:25:39', 1),
(2, 'Thám Tử Lừng Danh Conan - Tập 71', 'Gosho Aoyama', 23000.00, NULL, 50, 'conan71.jpg', 'Một vụ án lớn mang cả vị ngọt lẫn vị chua sẽ xảy ra bắt đầu tư những trái dâu tây...\nVà để giải mật mã liên quan đến sách Khải Huyền, báo trước về 1 vụ giết người hàng loạt, Conan sẽ chạy đôn chạy đáo khắp thành London! Tập truyện này cũng gửi đến các bạn câu chuyện về mối tình đầu của thám tử Chiba nữa!!', 3, 1, '2026-02-26 04:40:06', '2026-03-17 04:32:12', 1),
(3, 'Thám Tử Lừng Danh Conan - Tập 70', 'Gosho Aoyama', 45000.00, NULL, 30, 'conan70.jpg', 'Kid gửi đến một thông điệp kì lạ chưa từng có: \"Ta sẽ mang trả báu vật của Ryoma\". Ý hắn là gì?! Cái kết của vụ án bắt cóc \"Air On The G String\" và vụ giết người liên tiếp liên quan đến truyền thuyết quỷ khuyển cũng có trong tập này!!', 3, 1, '2026-02-26 04:40:06', '2026-03-17 04:34:03', 1),
(4, 'Thám Tử Lừng Danh Conan - Tập 67', 'Gosho Aoyama', 30000.00, NULL, 200, 'conan67.jpg', 'Conan và mọi người chứng kiến một vụ đánh bom ở trung tâm mua sắm. Tại hiện trưởng, lại thấy cả bóng dáng Akai Shuichi, Okiya Subaru và cả Gin!! Trong tình thế ngàn cân treo sợi tóc, Conan sẽ giải quyết ra sao? Trong tập này còn có \"Sát nhân Goth - Loli - phần kết\" và \"Câu chuyện tình yêu của thanh tra Shiratori và cô Kobayashi\"!', 3, 1, '2026-02-26 13:22:12', '2026-03-17 04:34:23', 1),
(5, 'Chú Thuật Hồi Chiến - Tập 19', 'Gege', 28000.00, NULL, 150, 'jjk19.jpg', 'Sau khi “luật” mới được thêm vào Tử Diệt Hồi Du, Itadori và Fushiguro quyết định nhắm tới Higuruma Hiromi, người chơi đang nắm giữ 100 điểm. Nhưng khi đột nhập vào kết giới Tokyo số 1, họ bị tách nhau ra. Mỗi người đều có một trợ thủ và lên đường đến chỗ Higuruma...!', 1, 1, '2026-02-26 13:22:12', '2026-03-17 04:36:04', 1),
(6, 'Chú Thuật Hồi Chiến - Tập 18', 'Gege', 35000.00, NULL, 70, 'jjk18.jpg', 'Để nhờ đàn anh năm 3 trường chuyên chú thuật hiện đang bị đình chỉ là Hakari Kinji hợp sức trấn áp “Tử Diệt Hồi Du”, Itadori đã tham gia trận đấu đặt cược do anh ta chủ trì và thử thương lượng trực tiếp. Fushiguro cũng đã thâm nhập và đang trên đường tới căn cứ, nhưng lại bị một thuật sư năm 3 đi cùng Hakari cản trở!!?\n\n', 1, 1, '2026-02-26 13:22:12', '2026-03-17 04:36:24', 1),
(7, 'Shin Cậu Bé Bút Chì - Tập 52', 'Yoshito Usui', 50000.00, NULL, 50, 'shin52.jpg', 'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ \"ngây ngô\" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.\n\nMỗi tập truyện khoảng 190 trang, nhưng cứ thử cầm lên xem, bạn sẽ không thể rời mắt khỏi cuốn sách cho đến tận trang cuối cùng. Với tài năng kể chuyện hấp dẫn, tác giả đã biến các trang sách của mình thành những sân chơi ngập tràn tiếng cười của những cô bé, cậu bé hồn nhiên và một thế giới tuổi thơ đa sắc màu.\n\nNhững bài học giáo dục nhẹ nhàng, thấm thía cũng được lồng ghép một cách khéo léo trong từng tình huống truyện. Có thể Shin là một cậu bé cá tính, hiếu động. Có thể những trò tinh nghịch của Shin đôi khi quá trớn, chẳng chừa một ai. Nhưng sau những \"sự cố\" do Shin gây ra, người lớn thấy mình cần \"quan tâm\" đến trẻ con nhiều hơn nữa, các bạn đọc nhỏ tuổi chắc hẳn cũng được dịp nhìn nhận lại bản thân, để phân biệt điều tốt điều xấu trong cuộc sống.\n\nCộng thêm hình ảnh có màu sắc sẽ khiến cho bộ truyện càng thêm hấp dẫn, hãy cùng theo dõi diễn biến trong mỗi tập nhé', 4, 1, '2026-02-26 04:40:06', '2026-03-17 12:15:26', 1),
(8, 'Shin Cậu Bé Bút Chì - Tập 46', 'Yoshito Usui', 50000.00, NULL, 50, 'shin46.jpg', 'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ \"ngây ngô\" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.\n\nMỗi tập truyện khoảng 190 trang, nhưng cứ thử cầm lên xem, bạn sẽ không thể rời mắt khỏi cuốn sách cho đến tận trang cuối cùng. Với tài năng kể chuyện hấp dẫn, tác giả đã biến các trang sách của mình thành những sân chơi ngập tràn tiếng cười của những cô bé, cậu bé hồn nhiên và một thế giới tuổi thơ đa sắc màu.\n\nNhững bài học giáo dục nhẹ nhàng, thấm thía cũng được lồng ghép một cách khéo léo trong từng tình huống truyện. Có thể Shin là một cậu bé cá tính, hiếu động. Có thể những trò tinh nghịch của Shin đôi khi quá trớn, chẳng chừa một ai. Nhưng sau những \"sự cố\" do Shin gây ra, người lớn thấy mình cần \"quan tâm\" đến trẻ con nhiều hơn nữa, các bạn đọc nhỏ tuổi chắc hẳn cũng được dịp nhìn nhận lại bản thân, để phân biệt điều tốt điều xấu trong cuộc sống.\n\nCộng thêm hình ảnh có màu sắc sẽ khiến cho bộ truyện càng thêm hấp dẫn, hãy cùng theo dõi diễn biến trong mỗi tập nhé\n', 4, 1, '2026-02-26 04:40:06', '2026-03-17 12:15:55', 1),
(9, 'Shin Cậu Bé Bút Chì - Tập 21', 'Yoshito Usui', 50000.00, NULL, 50, 'shin21.jpg', 'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ \"ngây ngô\" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân-sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.\n\nMỗi tập truyện khoảng 120 trang, nhưng cứ thử cầm lên xem, bạn sẽ không thể rời mắt khỏi cuốn sách cho đến tận trang cuối cùng. Với tài năng kể chuyện hấp dẫn, tác giả đã biến các trang sách của mình thành những sân chơi ngập tràn tiếng cười của những cô bé, cậu bé hồn nhiên và một thế giới tuổi thơ đa sắc màu.\n\nNhững bài học giáo dục nhẹ nhàng, thấm thía cũng được lồng ghép một cách khéo léo trong từng tình huống truyện. Có thể Shin là một cậu bé cá tính, hiếu động. Có thể những trò tinh nghịch của Shin đôi khi quá trớn, chẳng chừa một ai. Nhưng sau những \"sự cố\" do Shin gây ra, người lớn thấy mình cần \"quan tâm\" đến trẻ con nhiều hơn nữa, các bạn đọc nhỏ tuổi chắc hẳn cũng được dịp nhìn nhận lại bản thân, để phân biệt điều tốt điều xấu trong cuộc sống.\n\n', 4, 1, '2026-02-26 04:40:06', '2026-03-17 04:39:45', 1),
(10, 'Shin Cậu Bé Bút Chì - Tập 11', 'Yoshito Usui', 50000.00, NULL, 50, 'shin11.jpg', 'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ \"ngây ngô\" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.\n\nMỗi tập truyện khoảng 190 trang, nhưng cứ thử cầm lên xem, bạn sẽ không thể rời mắt khỏi cuốn sách cho đến tận trang cuối cùng. Với tài năng kể chuyện hấp dẫn, tác giả đã biến các trang sách của mình thành những sân chơi ngập tràn tiếng cười của những cô bé, cậu bé hồn nhiên và một thế giới tuổi thơ đa sắc màu.\n\nNhững bài học giáo dục nhẹ nhàng, thấm thía cũng được lồng ghép một cách khéo léo trong từng tình huống truyện. Có thể Shin là một cậu bé cá tính, hiếu động. Có thể những trò tinh nghịch của Shin đôi khi quá trớn, chẳng chừa một ai. Nhưng sau những \"sự cố\" do Shin gây ra, người lớn thấy mình cần \"quan tâm\" đến trẻ con nhiều hơn nữa, các bạn đọc nhỏ tuổi chắc hẳn cũng được dịp nhìn nhận lại bản thân, để phân biệt điều tốt điều xấu trong cuộc sống.\n\nCộng thêm hình ảnh có màu sắc sẽ khiến cho bộ truyện càng thêm hấp dẫn, hãy cùng theo dõi diễn biến trong mỗi tập nhé', 4, 1, '2026-02-26 04:40:06', '2026-03-17 12:16:10', 1),
(11, 'Thanh Gươm Diệt Quỷ - Tập 18', 'Koyoharu Gotouge', 25000.00, NULL, 15, 'thanhguomdietquy18.jpg', 'Tomioka và Tanjiro đang đấu với Thượng huyền tam Akaza. Dù 2 người chỉ đủ sức phòng thủ trước những đòn tấn công áp đảo của hắn, nhưng giữa trận chiến căng thẳng cực độ, Tanjiro đã đạt đến cảnh giới của “Thế giới trong suốt” mà cha cậu đã truyền thụ! Cuối cùng, liệu lưỡi gươm của Tanjiro có chạm đến được Akaza…!?', 1, 1, '2026-03-04 04:50:15', '2026-03-17 12:17:05', 0),
(12, 'Doraemon - Truyện Dài - Tập 2 (Tái Bản 2019)', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon2.jpg', 'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời! \n\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\n\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\n\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', 4, 1, '2026-03-04 04:54:46', '2026-03-24 09:33:15', 0),
(13, 'Doraemon Tập 21: Nobita Và Những Dũng Sĩ Có Cánh [Tái Bản 2023]', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon21.jpg', 'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời!\n\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\n\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\n\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', 4, 1, '2026-03-04 05:35:52', '2026-03-24 09:29:45', 0),
(14, 'Chú Thuật Hồi Chiến - Tập 1', 'Gege', 30000.00, NULL, 20, 'jjk1.png', 'Itadori Yuji là một học sinh cấp Ba sở hữu năng lực thể chất phi thường. Hằng ngày cậu thường tới bệnh viện chăm người ông đang ốm liệt giường. Nhưng một ngày nọ, phong ấn của “chú vật” vốn ngủ yên trong trường bị phá giải, quái vật xuất hiện. Để cứu hai anh chị khóa trên đang gặp nguy hiểm, Itadori đã xông vào trường và... \nPhần chính truyện của CHÚ THUẬT HỒI CHIẾN - Series bom tấn đã bán ra hơn 30 triệu bản tại Nhật năm 2021, bắt đầu…!! \n\n \n\nTháng 3 này, JUJUTSU KAISEN - Tác phẩm Bom tấn hứa hẹn công phá nhiều bảng xếp hạng sách ở tất cả các quốc gia chính thức phát hành tại Việt Nam, với tập 1! \nĐặc biệt hơn, bộ truyện đã được NXB Kim Đồng công bố phát hành 2 ấn bản cùng ra song song cho tới khi kết thúc - Một điều chưa từng có trong tiền lệ. Sách cũng có một bước khởi đầu thành công với hàng vạn bản in được xuất bản để phục vụ bạn đọc! Chắc chắn trong tương lai, CHÚ THUẬT HỒI CHIẾN sẽ còn đạt nhiều thành tích cao hơn nữa!! ', 1, 1, '2026-03-04 05:38:35', '2026-03-17 12:18:50', 0),
(15, 'Thanh Gươm Diệt Quỷ - Tập 15', 'Koyoharu Gotouge', 25000.00, NULL, 15, 'thanhguomdietquy15.jpg', 'Cuối cùng Tanjiro cũng đuổi kịp bản thể của con quỷ Thượng huyền Hantengu. Nhưng trời sắp sáng, Nezuko cũng sẽ bị liên lụy. Tanjiro vừa lo lắng cho Nezuko, vừa lưỡng lự trước ý định tấn công Hantengu. Liệu cậu có tấn công Hantengu không!? Và Nezuko có được an toàn!?', 1, 1, '2026-03-04 05:46:30', '2026-03-17 12:19:21', 0),
(16, 'Thám Tử Lừng Danh Conan - Tập 83', 'Gosho Aoyama', 25000.00, NULL, 12, 'conan83.jpg', 'Nữ thám tử học sinh trung học Masumi SERA là người luôn có những hành động đầy ẩn ý... Mục đích thực sự của cô sẽ phần nào được hé lộ trong vụ án người phụ nữ màu đỏ, với một cái kết đầy bất ngờ!! Trong vụ án liên quan tới tác giả tiểu thuyết ngôn tình xảy ra ở khách sạn nơi Sera đang sống, Conan phát hiện một cô gái bí ẩn?! Ngoài ra, cậu cũng hợp tác với Heiji phá một vụ giao dịch ma túy, và Shinichi sẽ xuất hiện vô cùng hoành tráng trong vụ án thủy cung đấy!! ', 3, 1, '2026-03-04 05:51:16', '2026-03-17 12:19:41', 0),
(17, 'Chú Thuật Hồi Chiến: Trường Chuyên Chú Thuật Tokyo - Tập 0', 'Gege', 30000.00, NULL, 20, 'jjk0.jpg', 'Như vậy là sau thời gian dài \"trong ngóng ngoài trông\", cuối cùng thì dự án JUJUTSU KAISEN - Manga đình đám nhất tại Nhật Bản năm 2021, với tổng số lượng sách bán ra lên đến gần 40 triệu bản in (cho 17 tập) - sẽ chính thức có một cú nổ lớn tại Việt Nam, với tập truyện mang tính khởi đầu, đó chính là Vol.0: Trường chuyên chú thuật Tokyo!\n\nKhốn khổ vì bị oán linh Rika ám, cậu học sinh trung học Yuta Okkotsu định kết liễu đời mình. Đúng lúc đó, Gojo Satoru - giáo viên của trường chuyên chú thuật, một nơi dạy cách giải trừ “lời nguyền” - đã yêu cầu Okkotsu chuyển tới ngôi trường này…!? Mời các bạn cùng bước vào tiền truyện CHÚ THUẬT HỒI CHIẾN - TRƯỜNG CHUYÊN CHÚ THUẬT TOKYO nhé!!\n\nHiện JUJUTSU KAISEN đang tiếp tục gây bão với Movie 0 (Chuyển thể từ chính tập sách này). Hiện phim đã thu về gần 8 tỉ Yên (Khoảng gần 7 triệu đô la Mĩ) và bán được 5.617.950 vé trong 18 ngày đầu tiên công chiếu tại Nhật!! Đây đã là động lực để bạn rinh tập sách đầy ấn tượng này về và hòa mình vào bầu không khí cuồng nhiệt với JUJUTSU KAISEN chưa nhỉ!? Đừng bỏ lỡ nhé!!', 1, 1, '2026-03-04 05:57:49', '2026-03-17 12:20:06', 0),
(18, 'Dragon Ball Super - Tập 2 (Tái Bản 2023)', 'Akira Toriyama Toyotarou', 25000.00, NULL, 50, 'dragonballsuper2.jpg', 'Vũ trụ 6 và 7 tổ chức một đại hội võ thuật nằm mục đích tranh đoạt ngọc rồng siêu cấp. Ở phe địch thủ cũng có người Saiya và một kẻ giống Frieza như lột tên là Frost. Trong trận đối đầu với Goku, quý ông Frost đã thể hiện bản lĩnh gì? ', 1, 1, '2026-03-04 06:04:13', '2026-03-17 12:20:30', 0),
(19, 'Spy X Family - Tập 3', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy3.jpg', 'Yuri, em trai của Yor đã tới thăm nhà Forger!! Twilight và Yuri cùng giấu nhẹm thân phận điệp viên, cũng như cảnh sát mật của mình, và giở đủ chiêu thăm dò lẫn nhau. Yuri, cậu em cuồng chị gái đang gấp rút muốn điều tra xem liệu Twilight có phải là người chồng thật sự của chị mình hay không…!?', 2, 1, '2026-03-04 06:20:30', '2026-03-17 12:20:47', 0),
(20, 'Spy X Family - Tập 2', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy2.jpg', 'Để hoàn thành nhiệm vụ gìn giữ hòa bình cho hai nước Ostania và Westalis, gia đình Forger đã vượt qua kì thi tuyển đầy thử thách của học viện danh tiếng. Nhưng sau đó Anya phải trở thành học sinh ưu tú của trường để tiếp cận Desmond. Kế hoạch tác chiến “xây dựng tình bạn” của Twilight sẽ được thực hiện thế nào đây…!?', 2, 1, '2026-03-04 06:35:42', '2026-03-17 12:21:15', 0),
(21, 'Spy X Family - Tập 1', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy1.jpg', 'Nhằm ngăn chặn âm mưu gây chiến, giữ vững nền hòa bình Đông - Tây, điệp viên hàng đầu của Westalis, Twilight phải xây dựng một gia đình và cho con theo học tại học viện danh giá nhất\n\nOstania hòng tiếp cận yếu nhân cầm đầu phe chủ chiến của đất nước này: Desmon Donavan! Và thật tình cờ, đứa trẻ mà Twilight nhận làm \"con\" ở cô nhi viện, Anya, lại có khả năng đọc suy nghĩ của người khác. Chưa kể \"người vợ\" anh buộc phải chọn lựa trong lúc vội vàng, Yor, lại là một… sát thủ...!! Ba người với lí do riêng để che giấu thân phận đã cùng chung sống với nhau dưới một mái nhà. Từ đây câu chuyện siêu hấp dẫn và hài hước về gia đình điệp viên chính thức mở ra...!!', 2, 1, '2026-03-04 06:38:04', '2026-03-17 12:21:37', 0),
(22, 'Spy X Family - Tập 4', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy4.jpg', 'Họ đã phát hiện được âm mưu dùng chó đánh bom ám sát bộ trưởng của Westalis! Cả gia đình cùng nhau ra ngoài để tìm cho Anya một chú cún cưng, nhưng Twilight lại kết hợp việc đó với chiến dịch chống khủng bố khẩn cấp…!! Và rồi, Anya gặp được một chú chó kì lạ biết rõ cả gia đình Forger…!?\n\nTATSUYA ENDO\n\n“Tôi là người yêu mèo, nhưng chó cũng dễ thương lắm.”', 2, 1, '2026-03-04 06:40:16', '2026-03-17 12:22:02', 0),
(23, 'Spy X Family - Tập 5', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy5.jpg', 'Chú chó có khả năng tiên đoán tương lai, Bond đã trở thành một thành viên trong gia đình. Những tưởng chiến dịch “Strix” cũng như gia đình Forger đã đi vào quỹ đạo, nhưng… Anya lại lâm vào khủng hoảng khi đối mặt với bài thi giữa kì!?\n\nRốt cuộc kì thi hỗn loạn với sao Stella và sét Tonitrus treo lơ lửng trên đầu sẽ có kết quả ra sao…!!', 2, 1, '2026-03-04 06:40:24', '2026-03-17 12:22:30', 0),
(24, 'Chú Thuật Hồi Chiến - Tập 8', 'Gege', 30000.00, NULL, 20, 'jjk8.jpg', 'Nhóm Itadori đã đánh bại anh hai và anh ba trong “Chú thai cửu tương đồ” và thu hồi ngón tay Sukuna. Nhờ đó họ đã được đề cử lên làm thuật sư cấp 1. Ý đồ của Gojo khi chọn cách đi đường vòng là gì…!?\n\nTrong tập này, câu chuyện sẽ lội ngược dòng thời gian về sự kiện khi Gojo và Geto còn là học sinh năm Hai của trường chuyên chú thuật!!', 1, 1, '2026-03-04 07:25:22', '2026-03-17 12:22:54', 0),
(25, 'Chú Thuật Hồi Chiến - Tập 15: Biến Cố Shibuya - Biến Thân', 'Gege', 65000.00, NULL, 50, 'jjk15.jpg', 'Vô số người đã bỏ mạng dưới tay Sukuna, Nanami Kento ngã xuống... Cả Kugisaki cũng bị Mahito sát hại...!! Khoảnh khắc mặc cảm tội lỗi trong tim vượt ngưỡng chịu đựng, Itadori chạy tới nơi bạn bè đang gặp nạn. Và kết cục của Itadori, Mahito, 2 kẻ nguyền rủa lẫn nhau là...!?\n\nSiêu bom tấn JUJUTSU KAISEN tiếp tục bùng nổ tại Việt Nam!!!\n\nManga bán chạy nhất Nhà xuất bản Kim Đồng năm 2022!!!\n\n“Chú thuật hồi chiến” – Tác phẩm được kì vọng của dòng truyện SHONEN JUMP!\n\nSẽ được phát hành với 2 ấn bản song song cho mỗi kì!', 1, 1, '2026-03-06 05:56:02', '2026-03-17 12:23:22', 0),
(26, 'Chú Thuật Hồi Chiến - Tập 14', 'Gege', 65000.00, NULL, 13, 'jjk14.jpg', 'Ngay khi lấy lại tự do, hành động cuồng nộ của Sukuna khiến Shibuya phải hứng chịu tổn thất nặng nề. Trong lúc đó, sau khi bị chú nguyền sư tấn công bất ngờ và trọng thương, Fushiguro quyết định sử dụng con bài cuối cùng. Sukuna phát hiện ra Fushiguro đã bắt đầu “nghi thức thanh tẩy”— —!?\n\nSiêu bom tấn JUJUTSU KAISEN tiếp tục bùng nổ tại Việt Nam!!!\n\nManga bán chạy nhất Nhà xuất bản Kim Đồng năm 2022!!!\n\n“Chú thuật hồi chiến” – Tác phẩm được kì vọng của dòng truyện SHONEN JUMP!\n\nSẽ được phát hành với 2 ấn bản song song cho mỗi kì!', 1, 1, '2026-03-06 05:58:25', '2026-03-17 12:25:45', 0),
(27, 'Chú Thuật Hồi Chiến - Tập 13', 'Gege', 65000.00, NULL, 13, 'jjk13.jpg', 'Dagon đã biến thành một chú linh đáng sợ…! Dòng nước chảy xiết mang chú lực vô hạn dồn dập tấn công Naobito, Maki, Nanami!! Mặt khác, nhằm lấy lại thể xác Geto, nhóm chú nguyền sư sùng bái anh ta đã đánh thức kẻ không nên dây dưa nhất!?\n\nSiêu bom tấn JUJUTSU KAISEN tiếp tục bùng nổ tại Việt Nam!!!\n\nManga bán chạy nhất Nhà xuất bản Kim Đồng năm 2022!!!\n\n“Chú thuật hồi chiến” – Tác phẩm được kì vọng của dòng truyện SHONEN JUMP!\n\nSẽ được phát hành với 2 ấn bản song song cho mỗi kì!', 1, 1, '2026-03-06 05:59:11', '2026-03-17 12:26:04', 0),
(28, 'Chú Thuật Hồi Chiến - Tập 12', 'Gege', 65000.00, NULL, 13, 'jjk12.jpg', 'Biến cố Shibuya càng trở nên hỗn loạn khi Zennin Toji bất ngờ được triệu hồi! Lúc này Meimei đang trên đường tới sân ga để tiếp cận Geto. Chứng kiến cảnh tượng các trợ lí giám sát bị thương nặng khiến Nanami không khỏi giận dữ. Trong lúc các thuật sư cấp 1 chuẩn bị xuất chiến, Itadori chạm trán Choso, anh cả Cửu tương đồ...!?', 1, 1, '2026-03-06 06:00:33', '2026-03-17 12:26:19', 0),
(29, 'Chú Thuật Hồi Chiến - Tập 10', 'Gege', 65000.00, NULL, 13, 'jjk10.jpg', 'Để có được cơ thể hoàn chỉnh, Muta Kokichi, cũng chính là “Mechamaru”, đã cấu kết với phe chú linh... Song đàm phán thất bại, buộc cậu phải đối đầu Mahito. Liệu Muta có thoát khỏi cửa tử bằng kế sách bí mật...!? Và vào ngày 31 tháng 10, màn được hạ xuống phố, “biến cố Shibuya” chính thức bắt đầu!!', 1, 1, '2026-03-06 06:01:26', '2026-03-17 12:26:40', 0),
(30, 'Chú Thuật Hồi Chiến - Tập 9', 'Gege', 45000.00, NULL, 13, 'jjk9.jpg', 'Bị “kẻ săn thuật sư” tự xưng là Fushiguro đột kích, nhiệm vụ bảo vệ “Tinh Tương Thể” của Gojo và Suguru rơi vào tình trạng nguy hiểm. Liệu cả nhóm có thể sống sót...!? Sự kiện ngày hôm đó trở thành bước ngoặt thôi thúc Gojo trở thành kẻ mạnh nhất, song lại dẫn dắt Geto tới bước đường tạo phản. Và kết cục là...!?', 1, 1, '2026-03-06 06:01:58', '2026-03-17 12:26:59', 0),
(31, 'Chú Thuật Hồi Chiến - Tập 7', 'Gege', 65000.00, NULL, 13, 'jjk7.jpg', 'Giao lưu trường kết nghĩa Kyoto đã bắt đầu. Trong trận chiến đội ở ngày thứ nhất, bên nào thanh tẩy được chú linh cấp 2 trong khu vực thi đấu trước sẽ thắng. Với bản tính hiếu chiến, Todo đã lập tức tấn công bên Tokyo nhưng bị Itadori phục kích. Những thành viên khác của đội Kyoto cũng tham chiến hòng ám sát Itadori, khiến cậu rơi vào tình thế tiến thoái lưỡng nan!!', 1, 1, '2026-03-06 06:04:08', '2026-03-17 12:27:14', 0),
(32, 'Thanh Gươm Diệt Quỷ - Tập 1', 'Koyoharu Gotouge', 25000.00, NULL, 26, 'thanhguomdietquy1.jpg', 'Vào thời Taisho, có một cậu bé bán than với tấm lòng nhân hậu tên Tanjiro. Những ngày yên bình đã chẳng còn khi Quỷ đến tàn sát cả gia đình cậu, chỉ duy nhất người em gái Nezuko còn sống sót nhưng lại bị biến thành Quỷ. Mang trong mình quyết tâm chữa cho em gái, Tanjiro đã cùng Nezuko bắt đầu cuộc hành trình tìm kiếm tung tích con quỷ đã ra tay với gia đình cậu!!\n\nCuộc phiêu lưu trên con đường kiếm sĩ đã bắt đầu!!', 1, 1, '2026-03-24 10:05:08', '2026-03-24 10:20:35', 0),
(33, 'Thanh Gươm Diệt Quỷ - Tập 2', 'Koyoharu Gotouge', 25000.00, NULL, 35, 'thanhguomdietquy2.jpg', 'Trong bài tuyển chọn cuối cùng để vào đội Diệt quỷ, Tanjiro đã dùng những chiêu học được từ thầy Urokodaki để đối đầu với một con quỷ đột biến!!\n\nCuối cùng cậu có vượt qua cuộc tuyển chọn không!? Và khi cậu trở về với Urokodaki, Nezuko đã tỉnh dậy!! Tanjiro cùng em gái hướng đến một con phố, nơi đang xảy ra hàng loạt những vụ án các cô gái bị mất tích mỗi đêm...!', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:50:19', 0),
(34, 'Thanh Gươm Diệt Quỷ - Tập 3', 'Koyoharu Gotouge', 25000.00, NULL, 63, 'thanhguomdietquy3.jpg', 'Tanjiro và Nezuko phải đối đầu với 2 con quỷ sử dụng quả cầu vải và mũi tên. Chúng là thuộc cấp của Kibutsuji. Với sự giúp đỡ của Tamayo và Yushiro, Tanjiro đã chiến đấu lại với những con quỷ mang tên Thập Nhị Quỷ Nguyệt!! Sau khi giành chiến thắng, liệu cậu có lần ra được tung tích của Kibutsuji!?', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:50:37', 0),
(35, 'Thanh Gươm Diệt Quỷ - Tập 6', 'Koyoharu Gotouge', 25000.00, NULL, 22, 'thanhguomdietquy6.jpg', 'Tanjiro giành chiến thắng đầy khó khăn trước quỷ nhện… Nhưng Nezuko lại bị Kocho Shinobu nhắm đến, kết cuộc cả Tanjiro lẫn Nezuko đều bị bắt. Khi mở mắt ra, Tanjiro thấy mình đang ở trụ sở của đội Diệt quỷ, bị bao vây bởi những kiếm sĩ mạnh nhất - các “Trụ cột”! Họ đã tự ý phán xét và trừng phạt Tanjiro vì đã che chở cho quỷ Nezuko. Nhưng, người mới xuất hiện ở đó là…!!', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:50:56', 0),
(36, 'Thanh Gươm Diệt Quỷ - Tập 7', 'Koyoharu Gotouge', 25000.00, NULL, 33, 'thanhguomdietquy7.jpg', 'Với quyết định của Trụ cột Shinobu, nhóm Tanjiro được dưỡng thương và học thêm kĩ thuật Tập trung toàn bộ - Thường trung. Tiếp nhận mệnh lệnh mới, cả nhóm đã lên chuyến tàu vô tận với Viêm trụ Rengoku, cùng đối phó với con quỷ trên tàu! Nhưng nhóm Tanjiro lại bị nhốt trong giấc mơ do quỷ tạo ra!! Liệu có cách nào giúp họ thoát khỏi tình cảnh nguy hiểm này không…!?', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:57:36', 0),
(37, 'Thanh Gươm Diệt Quỷ - Tập 8', 'Koyoharu Gotouge', 25000.00, NULL, 12, 'thanhguomdietquy8.jpg', 'Tanjiro đã sử dụng Hỏa thần thần lạc - Bích La Thiên để chiến đấu với quỷ giấc mơ Enmu. Liệu trận chiến đã đến hồi kết!? Và bản chất của thứ xuất hiện trên cơ thể Tanjiro là gì? Cuối cùng, Viêm trụ Rengoku Kyojuro cũng đã hành động. Trước những lời từ một người mạnh, thứ mà Tanjiro thấy là….!?', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:58:52', 0),
(38, 'Thanh Gươm Diệt Quỷ - Tập 9', 'Koyoharu Gotouge', 25000.00, NULL, 5, 'thanhguomdietquy9.jpg', 'Asta phải đương đầu với Mars, pháp sư của vương quốc Diamond đang lăm le xâm lược họ. Trong cuộc chiến với đại cường địch mà ngay cả Yuno cũng không dễ gì đối phó nổi, tính mạng Asta lâm vào tình trạng ngàn cân treo sợi tóc! Trận tử chiến ác liệt đương hồi gay cấn này sẽ có kết cục ra sao…!? Cuộc khám phá ma cung sẽ có cái kết vô cùng bất ngờ…!!', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:59:19', 0),
(39, 'Thanh Gươm Diệt Quỷ - Tập 10', 'Koyoharu Gotouge', 25000.00, NULL, 55, 'thanhguomdietquy10.jpg', 'Con quỷ oiran có tên Daki đang thống trị cả khu phố hoa! Sau khi thu hồi lại obi đang nắm giữ một phần sức mạnh, Daki quay ra tấn công Tanjiro với 100% sức lực!! Tanjiro cũng đáp lại bằng điệu Hỏa thần thần lạc, nhưng liệu đã quá giới hạn của cậu!? Nezuko và Uzui cũng tham chiến thay cho Tanjiro, trận chiến với quỷ Thượng huyền đã lên đến hồi cao trào và những diễn biến không thể đoán trước…!!\n\nKOYOHARU GOTOUGE', 1, 1, '2026-03-24 10:06:42', '2026-03-24 13:59:43', 0),
(40, 'Thanh Gươm Diệt Quỷ - Tập 12', 'Koyoharu Gotouge', 25000.00, NULL, 99, 'thanhguomdietquy12.jpg', '113 năm rồi mới để mất một Thượng huyền, Muzan nổi cơn thịnh nộ, ra mệnh lệnh tiếp theo với các Thượng huyền còn lại. Trong khi đó, Tanjiro làm mẻ gươm trong trận chiến với Gyutaro và giờ phải đối mặt với cơn giận dữ của Haganezuka. Cậu lên đường đến làng thợ rèn nơi Haganezuka sống để tìm kiếm thanh gươm mới cho mình, nhưng điều gì đang chờ đón cậu ở phía trước…!?', 1, 1, '2026-03-24 10:06:42', '2026-03-24 14:00:55', 0),
(41, 'Thanh Gươm Diệt Quỷ - Tập 13', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy13.jpg', 'Quỷ Thượng huyền Hantengu và Gyokko đã đến tấn công làng thợ rèn - nơi được ẩn giấu vô cùng tuyệt mật!! Tanjiro và Genya phải một phen khổ chiến với Hantengu có khả năng phân tách mỗi khi bị tấn công. Trong khi đó, với một người ít khi để tâm đến người khác như Hà trụ Tokito, khi thấy Kotetsu bị quỷ tấn công sẽ hành động như thế nào đây…!?', 1, 1, '2026-03-24 10:06:42', '2026-03-24 14:01:14', 0),
(42, 'Thanh Gươm Diệt Quỷ - Tập 14', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy14.jpg', 'Con quỷ phân tách thành các cảm xúc - Hantengu - đã bỏ bản thể chính, chỉ đem những phân thân đã hợp nhất quay sang tấn công Tanjiro! Bị Hantengu sỉ nhục là “yếu đuối”, Tanjiro đang chiến đấu liệu có thấy tức giận!? Mặt khác, Hà trụ Tokito dần lấy lại kí ức và tiếp tục đối đầu Gyokko. Lúc ấy, trong Tokito đã có điều gì bắt đầu thay đổi…', 1, 1, '2026-03-24 10:06:42', '2026-03-24 14:02:08', 0),
(44, 'Thanh Gươm Diệt Quỷ - Tập 17', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy17.jpg', 'Đội diệt quỷ ùa vào thành Vô hạn sau khi Muzan tấn công. Shinobu chật vật đối đầu Thượng huyền nhị Doma, bởi vì độc của cô không có tác dụng. Kết cục, cô có thể trả thù được cho chị mình không…!? Trong khi đó, một con quỷ đã xuất hiện trước mặt Zenitsu…', 1, 1, '2026-03-24 10:06:42', '2026-03-24 14:02:41', 0),
(45, 'Thanh Gươm Diệt Quỷ - Tập 20', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy20.jpg', 'Nham trụ Himejima và Phong trụ Shinazugawa cùng đối đầu với Thượng huyền nhất. Trận chiến càng lúc càng khốc liệt, hai người đều đã xuất hiện vết bớt trên cơ thể. Nhưng dù đã cùng phối hợp tấn công, họ vẫn bị áp đảo trước sức mạnh khủng khiếp của Thượng huyền nhất. Genya đã hồi phục nhờ hấp thu được một phần của Thượng huyền nhất, nhưng liệu kết quả trận chiến sẽ ra sao…!?', 1, 1, '2026-03-24 10:07:27', '2026-03-24 14:03:14', 0),
(46, 'Thanh Gươm Diệt Quỷ - Tập 21', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy21.jpg', 'Cuộc chiến cam go với Thượng huyền nhất cuối cùng cũng đi đến hồi kết!! Sau chiến thắng một cách chật vật, cái giá phải trả là quá lớn… Mặt khác, sâu bên trong thành Vô hạn, thủy tổ của loài quỷ -Kibutsuji Muzan - đã bắt đầu hành động…! Tanjiro sẽ làm gì…!?', 1, 1, '2026-03-24 10:07:27', '2026-03-24 14:03:32', 0),
(47, 'Thanh Gươm Diệt Quỷ - Tập 22', 'Koyoharu Gotouge', 25000.00, NULL, 36, 'thanhguomdietquy22.jpg', 'Còn 1 tiếng đến khi trời sáng, trận khổ chiến với Muzan càng lúc càng cam go. Tất cả các Trụ cột còn lại đều dồn hết sức chiến đấu, nhưng liệu lưỡi gươm của họ có chạm được đến hắn!?\n\nVà Tanjiro đã trúng một đòn của Muzan sẽ ra sao…?\n\nCái chết đang đến rất gần, trận chiến đã lên đến đỉnh điểm…!!\n\n', 1, 1, '2026-03-24 10:07:27', '2026-03-24 14:03:51', 0),
(48, 'Thanh Gươm Diệt Quỷ - Tập 23 (Tập Cuối)', 'Koyoharu Gotouge', 25000.00, NULL, 15, 'thanhguomdietquy23.jpg', 'Trận chiến giữa nhóm Tanjiro và thủy tổ của loài quỷ - Kibutsuji Muzan đang dần ngã ngũ…!! Bốn loại thuốc của Tamayo đã làm Muzan suy yếu và dồn hắn vào đường cùng. Số phận của Tanjiro và Nezuko, cũng như toàn đội Diệt quỷ sẽ ra sao!? Trận chiến tưởng chừng vĩnh viễn cuối cùng cũng đi đến hồi kết!!\n\nSeries Thanh gươm Diệt quỷ - Siêu bom tấn đình đám nhất năm 2020 sắp khép lại chặng đường với tập truyện cuối cùng!', 1, 1, '2026-03-24 14:15:10', '2026-03-24 14:15:51', 0),
(49, 'Chú Thuật Hồi Chiến - Tập 2', 'Gege Akutami', 65000.00, NULL, 39, 'jjk2.jpg', 'Chú thai bất ngờ xuất hiện tại trại cải tạo thanh thiếu niên. Nhóm Itadori, học sinh năm Nhất trường chuyên chú thuật, được cử đi cứu những người đang mắc kẹt bên trong. Nhưng chú thai sau khi hóa thành chú linh đã tấn công cả nhóm. Trước tình thế hiểm nghèo, Itadori đã trao quyền kiểm soát cơ thể cho Sukuna với hi vọng sẽ hạ gục chú linh, song...!?', 1, 1, '2026-03-24 14:22:53', '2026-03-24 14:22:53', 0),
(50, 'Chú Thuật Hồi Chiến - Tập 3', 'Gege Akutami', 30000.00, NULL, 31, 'jjk3.jpg', 'Todo Aoi và Zen’in Mai của trường chuyên chú thuật Kyoto xuất hiện trước mặt Fushiguro và Kugisaki! Todo hỏi Fushiguro thích kiểu con gái như thế nào và câu trả lời của cậu là... Mặt khác, Itadori vẫn đang trong quá trình rèn luyện, để nâng cao kĩ năng thực chiến, cậu đã đến hiện trường án mạng do chú linh gây', 1, 1, '2026-03-24 14:25:38', '2026-03-24 14:25:38', 0),
(51, 'Chú Thuật Hồi Chiến - Tập 4', 'Gege Akutami', 30000.00, NULL, 31, 'jjk4.jpg', 'Tại hiện trường án mạng do chú linh gây ra, Itadori đã gặp gỡ Junpei, cả hai tâm đầu ý hợp. Nhưng Junpei lại tôn sùng chú linh Mahito, thủ phạm của vụ án. Mahito lợi dụng Junpei, hòng li gián cậu và Itadori. Junpei rơi vào cạm bẫy của hắn và..', 1, 1, '2026-03-24 14:26:49', '2026-03-24 14:26:49', 0),
(52, 'Chú Thuật Hồi Chiến - Tập 5', 'Gege Akutami', 30000.00, NULL, 22, 'jjk5.jpg', 'Giao lưu trường kết nghĩa Kyoto đã bắt đầu. Trong trận chiến đội ở ngày thứ nhất, bên nào thanh tẩy được chú linh cấp 2 trong khu vực thi đấu trước sẽ thắng. Với bản tính hiếu chiến, Todo đã lập tức tấn công bên Tokyo nhưng bị Itadori phục kích. Những thành viên khác của đội Kyoto cũng tham chiến hòng ám sát Itadori, khiến cậu rơi vào tình thế tiến thoái lưỡng nan!!', 1, 1, '2026-03-24 14:27:49', '2026-03-24 14:27:49', 0),
(53, 'Chú Thuật Hồi Chiến - Tập 6', 'Gege Akutami', 30000.00, NULL, 16, 'jjk6.jpg', 'Giao lưu trường kết nghĩa Kyoto đã bắt đầu. Trong trận chiến đội ở ngày thứ nhất, bên nào thanh tẩy được chú linh cấp 2 trong khu vực thi đấu trước sẽ thắng. Với bản tính hiếu chiến, Todo đã lập tức tấn công bên Tokyo nhưng bị Itadori phục kích. Những thành viên khác của đội Kyoto cũng tham chiến hòng ám sát Itadori, khiến cậu rơi vào tình thế tiến thoái lưỡng nan!!', 1, 1, '2026-03-24 14:29:12', '2026-03-24 14:29:12', 0),
(54, 'Chú Thuật Hồi Chiến - Tập 11', 'Gege Akutami', 30000.00, NULL, 11, 'jjk11.jpg', 'Khắp sân ga dưới tầng hầm Shibuya, đâu đâu cũng là dân thường và người bị biến dạng. Bất chấp thảm cảnh không lối thoát, Gojo vẫn áp đảo đám chú linh. Song phe địch lại tung ra đòn quyết định thắng bại, thứ có thể phong ấn Gojo!! Mặt khác, trong lúc đang gấp rút chạy đến sân ga, đồng minh bất ngờ xuất hiện!?', 1, 1, '2026-03-24 14:31:18', '2026-03-24 14:31:18', 0),
(55, 'Chú Thuật Hồi Chiến - Tập 16', 'Gege Akutami', 30000.00, NULL, 6, 'jjk16.jpg', ' Geto đã hấp thụ Mahito và tiết lộ một phần âm mưu của mình. Cục diện của biến cố Shibuya đã đi đến hồi kết, trong lúc các chú thuật sư tập hợp lại, liệu Choso có phát hiện ra chân tướng “kẻ chủ mưu” kí sinh trên thể xác của Geto!?\r\nSự diệt vong và hỗn độn đặt dấu chấm hết cho biến cố, thế giới đột ngột thay đổi!!', 1, 1, '2026-03-24 14:32:30', '2026-03-24 14:32:30', 0),
(56, 'Chú Thuật Hồi Chiến - Tập 17', 'Gege Akutami', 30000.00, NULL, 71, 'jjk17.jpg', 'Bị Okkotsu, kẻ thi hành án, đánh bại, đứng trước lằn ranh sự sống và cái chết, khung cảnh gia đình vào một ngày nào đó trong quá khứ bỗng ùa về trong tâm trí Itadori. Ở đó có hình dạng trước kia của Kamo Noritoshi. Trong lúc mọi người đang nhắm đến việc trấn áp “Tử Diệt Hồi Du”, nơi các thuật sư sát phạt nhau, Maki lại đến nhà Zen’in…!?', 1, 1, '2026-03-24 14:33:37', '2026-03-24 14:33:37', 0),
(57, 'Chú Thuật Hồi Chiến - Tập 20', 'Gege Akutami', 30000.00, NULL, 20, 'jjk20.jpg', 'Cả Fushiguro và Reggie đều rơi vào tình trạng nguy hiểm tới tính mạng do thuật thức của đối thủ. Reggie quyết định hành động để phá vỡ thế giằng co, cuộc tử chiến dần đi đến hồi kết!! Trong khi đó, Okkotsu đã đánh bại một trong bốn kẻ mạnh nhất ở kết giới Sendai, cuộc chiến với các thuật sư trong quá khứ và chú linh đặc cấp dần trở nên khốc liệt!!', 1, 1, '2026-03-24 14:34:53', '2026-03-24 14:34:53', 0),
(58, 'Chú Thuật Hồi Chiến - Tập 21', 'Gege Akutami', 30000.00, NULL, 21, 'jjk21.jpg', 'Hakari và Panda tới kết giới Tokyo số 2 với mục đích đánh bại Kashimo, người chơi sở hữu số điểm cao. Nhưng khi tiến vào kết giới, bọn họ đã bị chia rẽ và Hakari phải đối đầu với một người chơi có ước mơ trở thành hoạ sĩ truyện tranh tên là Charles!! Trong khi đó, Panda bất ngờ chạm trán Kashimo và bị áp đảo do chênh lệch thực lực giữa hai bên...!?', 1, 1, '2026-03-24 14:35:59', '2026-03-24 14:35:59', 0),
(59, 'Chú Thuật Hồi Chiến - Tập 22', 'Gege Akutami', 30000.00, NULL, 22, 'jjk22.jpg', 'Một chú linh bí ẩn đột nhiên xuất hiện tại kết giới Sakurajima! Nó chính là hình dạng sau khi chết và trở thành lời nguyền của kẻ có ân oán sâu nặng với Maki…!! Khi cả Maki và Noritoshi bị chú thai tiến hoá thành chú linh với tốc độ khủng khiếp dồn vào đường cùng, những kẻ xâm nhập mới lại xuất hiện…!?', 1, 1, '2026-03-24 14:37:02', '2026-03-24 14:37:02', 0),
(60, 'Assassination Classroom 21 - Thời Gian Dành Cho Sự Biết Ơn', 'Yusei Matsui', 22000.00, NULL, 29, 'ac21.jpg', ' Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:47:11', '2026-03-24 15:36:01', 0),
(61, 'Assassination Classroom 20 - Thời Gian Tốt Nghiệp', 'Yusei Matsui', 22000.00, NULL, 24, 'ac20.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:49:31', '2026-03-24 15:36:06', 0),
(62, 'Assassination Classroom 19 - Thời Gian Đến Trường', 'Yusei Matsui', 22000.00, NULL, 27, 'ac19.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:50:55', '2026-03-24 15:36:11', 0),
(63, 'Assassination Classroom 18 - Thời Gian Dành Cho', 'Yusei Matsui', 22000.00, NULL, 28, 'ac18.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:51:36', '2026-03-24 15:36:16', 0),
(64, 'Assassination Classroom 17 - Thời Gian Tan Rã', 'Yusei Matsui', 22000.00, NULL, 41, 'ac17.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:52:28', '2026-03-24 15:36:20', 0),
(65, 'Assassination Classroom 16 - Thời Gian Lội Dòng Quá Khứ', 'Yusei Matsui', 22000.00, NULL, 44, 'ac16.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:56:17', '2026-03-24 15:36:24', 0),
(66, 'Assassination Classroom 15 - Thời Gian Chìm Trong Bão Tố', 'Yusei Matsui', 22000.00, NULL, 17, 'ac15.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:56:17', '2026-03-24 15:36:29', 0),
(67, 'Assassination Classroom 14 - Thời Gian Cuối Kỳ', 'Yusei Matsui', 22000.00, NULL, 47, 'ac14.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 14:56:17', '2026-03-24 15:36:34', 0),
(69, 'Assassination Classroom 13 - Thời Gian Định Hướng Tương Lai', 'Yusei Matsui', 22000.00, NULL, 33, 'ac13.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:06:20', '2026-03-24 15:36:37', 0),
(70, 'Assassination Classroom 12 - Thời Gian Của \"Tử Thần\"', 'Yusei Matsui', 22000.00, NULL, 35, 'ac12.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:06:20', '2026-03-24 15:36:42', 0),
(71, 'Assassination Classroom 11 - Thời Gian Của Đại Hội Thể Thao', 'Yusei Matsui', 22000.00, NULL, 38, 'ac11.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:06:20', '2026-03-24 15:36:46', 0),
(72, 'Assassination Classroom 10 - Thời Gian Làm Trộm', 'Yusei Matsui', 22000.00, NULL, 39, 'ac10.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:06:20', '2026-03-24 15:36:50', 0),
(73, 'Assassination Classroom 09 - Thời Gian Gặp Chấn Động', 'Yusei Matsui', 22000.00, NULL, 99, 'ac9.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:17:58', '2026-03-24 15:36:54', 0),
(74, 'Assassination Classroom 08 - Thời Gian Dành Cho Cơ Hội', 'Yusei Matsui', 22000.00, NULL, 8, 'ac8.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:17:58', '2026-03-24 15:36:59', 0),
(75, 'Assassination Classroom 07 - Thời Gian Trên Đảo', 'Yusei Matsui', 22000.00, NULL, 11, 'ac7.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:17:58', '2026-03-24 15:37:03', 0),
(76, 'Assassination Classroom 06 - Thời Gian Bơi Lội', 'Yusei Matsui', 22000.00, NULL, 6, 'ac6.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:17:58', '2026-03-24 15:37:08', 0),
(77, 'Assassination Classroom 05 - Thời Gian Dành Cho Tài Năng', 'Yusei Matsui', 22000.00, NULL, 5, 'ac5.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:31:53', '2026-03-24 15:37:16', 0),
(78, 'Assassination Classroom 04 - Thời Gian Không Ngờ Tới', 'Yusei Matsui', 22000.00, NULL, 44, 'ac4.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:31:53', '2026-03-24 15:37:24', 0),
(79, 'Assassination Classroom 03 - Thời Gian Của Học Sinh Chuyển Trường', 'Yusei Matsui', 22000.00, NULL, 63, 'ac3.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:31:53', '2026-03-24 15:37:29', 0),
(80, 'Assassination Classroom 02 - Thời Gian Của Người Lớn', 'Yusei Matsui', 22000.00, NULL, 72, 'ac2.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:31:53', '2026-03-24 15:37:34', 0),
(81, 'Assassination Classroom 01 - Thời Gian Tác Chiến', 'Yusei Matsui', 22000.00, NULL, 1, 'ac1.jpg', 'Một sinh vật đặc biệt mang hình dáng bạch tuộc tuyên bố sẽ phá hủy Trái Đất, nhưng chẳng hiểu sao lại cho nhân loại một cơ hội. Đó là yêu cầu được dạy một lớp học siêu quậy, và tạo mọi điều kiện cho bọn học trò... ám sát mình!?', 4, 1, '2026-03-24 15:31:53', '2026-03-24 15:37:39', 0),
(82, 'Dáng Hình Thanh Âm - Tập 7 (Tập cuối)', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta7.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(83, 'Dáng Hình Thanh Âm - Tập 6', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta6.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(84, 'Dáng Hình Thanh Âm - Tập 5', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta5.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(85, 'Dáng Hình Thanh Âm - Tập 4', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta4.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(86, 'Dáng Hình Thanh Âm - Tập 3', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta3.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(87, 'Dáng Hình Thanh Âm - Tập 2', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta2.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0),
(88, 'Dáng Hình Thanh Âm - Tập 1', 'Kanoko Sakurakouji', 18000.00, NULL, 36, 'dhta1.jpg', 'Về nội dung, câu truyện xoay quanh hai nhân vật chính.  Shoyo Ishida từng là một cậu bé côn đồ, chuyên bắt nạt bạn học bị điếc là Shoko Nishimiya.\r\n\r\nSau một biến cố, Ishida bỗng trở nên bị cô lập, trầm cảm, và có ý nghĩa tự sát.\r\n\r\nRồi một ngày nọ, Ishida gặp lại Nishimiya, cả hai đều thống khổ mối quan hệ bắt nạt khi xưa.\r\n\r\nBộ truyện là hành trình tìm cách chuộc tội, tìm sự cứu rỗi bản thân và hòa nhập lại với cộng đồng, tìm một lý do để tin tưởng lại xã hội và con người đã ruồng bỏ và làm ngơ bạn.\r\n\r\n', 2, 1, '2026-03-24 16:06:06', '2026-03-24 16:06:06', 0);
INSERT INTO `san_pham` (`ma_sp`, `ten_sp`, `tac_gia`, `gia`, `gia_cu`, `so_luong_ton`, `anh_sp`, `mo_ta`, `ma_loai`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`, `ban_chay`) VALUES
(89, 'Những Ngôi Nhà Ma Ám - Tập 2', 'Nhị Thập Tam', 102000.00, NULL, 49, 'nnnma2.jpg', 'Buôn nhà ma! Mẹo làm giàu này mà cũng nghĩ ra, tinh khôn quá nhưng ngây ngô chẳng ngờ.\r\n\r\nNgười có thế giới của người, ma có thế giới của ma. Ma lởn vởn người liền bị trấn áp muôn đời. Người mon men ma lại không phải chịu cái giá tương đương sao?!\r\n\r\nNhưng thanh niên nọ bất chấp. Cậu ta bỏ vốn, đối tác cậu ta bỏ sức, cùng nhau đuổi ma lấy nhà, được một thời gian đã có vài cơ sở làm ăn nho nhỏ, xem chừng cơm áo cả đời không lo.\r\n\r\nThanh niên tuy đã nhiều phen hồn xiêu phách lạc hoặc mệt mỏi chán chường, nhưng chưa một lần muốn dừng, càng chưa một lần mắt nhìn mũi, mũi nhìn mồm, tự hỏi tại sao mình IQ thấp, vốn liếng hẻo, lại kiếm được đối tác tài ba kiên nhẫn đến thế.\r\n\r\nTập 2 này tiếp tục hành trình rong ruổi đuổi ma mua nhà rẻ mạt của Giang Thước. Và hậu quả là chẳng mấy chốc, đủ thứ quái lạ bám lên người cậu ta, còn Tần Nhất Hằng thì cứ rời xa một cách vô cùng bí hiểm. Lời hứa “tôi làm tất cả cũng là vì anh” ngày xưa bỗng nhiên nhớ mấy cho vừa.\r\n\r\nMù tịt phong thủy và ngơ ngác giữa ranh giới sống-chết, Giang Thước có lẽ đang đi dần đến giờ tử khắc trên tấm ván thiên dành cho cậu…', 3, 1, '2026-03-24 16:24:05', '2026-03-24 16:24:05', 0),
(90, 'Những Ngôi Nhà Ma Ám - Tập 1', 'Nhị Thập Tam', 102000.00, NULL, 49, 'nnnma1.jpg', 'Làm giàu thật (ra không) khó!\r\n\r\n\r\nChỉ cần phát hiện được lĩnh vực một bán vạn mua là dễ dàng xúc tiền thiên hạ.\r\n\r\n\r\nVí như, kinh doanh bất động sản có ma. \r\n\r\n\r\nNơi nào cũng có những căn nhà ế ẩm hoặc được rao bán với giá rẻ mạt. Chỉ vì từng có người chết không nhắm mắt rồi dai dẳng mãi chẳng chịu đầu thai, ở lại đấy quấy phá làm cho người sống kinh hoàng điêu đứng.\r\n\r\n\r\nNhận ra cơ hội, một thanh niên rủng rỉnh chút tiền và một thanh niên giỏi huyền thuật bèn hợp tác với nhau, đi khắp nơi thu mua những căn nhà ấy, dự định làm phép đuổi ma trừ tà cho nhà trở lại bình thường rồi bán giá cao, đặng thu lợi gấp bội.\r\n\r\n\r\nSau khi nhập cuộc, hai thanh niên mới choáng váng nhận ra, lĩnh vực ít cạnh tranh không có nghĩa là ít hung hiểm. Họ phải cầm nước bọt, ngậm phân dê, uống nước tiểu đồng nam… để tránh ma nhập ma đuổi. Tưởng thế là đã vất vả lắm rồi, nào ngờ còn mắc lừa suýt bị chôn sống làm thế thân, tống cổ được ma này thì ma khác lại bám vào người, thậm chí ngẫu nhiên nhặt được tấm ván thiên quan tài cũng thấy ghi sẵn tên họ mình và ngày giờ phải chết.\r\n\r\n\r\nRất muốn rút lui, đến lúc quay đầu mới biết, cả người lẫn ma đều đã không buông tha cho họ.\r\n\r\n\r\n\r\nSau đó ít lâu, trên mạng đăng tin, có người sẵn sàng tặng không ngôi nhà đắt tiền. Cho kẻ chịu nghe anh ta kể chuyện trọn một đêm thâu.\r\n\r\n\r\nChín người đến nghe nhưng sáng ra, chỉ còn một người…\r\n\r\n\r\n\r\nCâu chuyện làm giàu thật khó của hai thanh niên buôn bán nhà ma. Mê hoặc người đọc bởi nhiều yếu tố huyền bí phong thủy kết hợp với suy luận cổ điển. Tình tiết mới mẻ, vận dụng cách viết thịnh hành của tiểu thuyết Âu Mỹ: những mẩu chuyện riêng lẻ về 17 ngôi nhà ma ám xâu chuỗi lại sẽ hé lộ một bí mật kinh người, mức độ suy luận phá án cũng theo đó tăng dần, hồi hộp tăng dần. Một tiểu thuyết giàu nội hàm, độc đáo.\r\n- Báo sáng Vũ Hán\r\n\r\n\r\nKhông mấy người có dịp đi đào mộ. Nhưng mỗi người ít nhiều đều gặp hoặc biết về những ngôi nhà ma ám. Gần gũi như thế mà vẫn có thể ly kì như thế. Đó chính là điểm hấp dẫn tôi ở tiểu thuyết này.\r\n- Nam Phái Tam Thúc, tác giả Đạo mộ bút kí', 3, 1, '2026-03-24 16:24:05', '2026-03-24 16:24:05', 0),
(91, 'Mỗi Đêm Một Chuyện Kinh Dị - Tập 3', 'Vương Vũ Thần', 117000.00, NULL, 33, 'mdmtkd3.jpg', 'Cuộc sống thường nhật của chàng biên tập viên Âu Dương không hề nhàm chán, những trải nghiệm phong phú, nhữngtruyền thuyết bí ẩn ngàn xưa cùng những tri thức kì lạ về một thế giới khác, từ khắp bốn phương tám hướng theo bước Kỷ Nhan được đều đặn gửi đến anh. Mỗi bức thư là một câu chuyện, sinh động như hiển hiện ngay trước mắt, hóa ra phiêu lưu không chỉ có một con đường.\r\nĐọc truyện kinh dị đương buổi còn khuya, tựa như thanh tỉnh giữa cơn mơ, thần trí giãy giụa trong nỗi kích thích trí mạng, sợ hãi và tò mò đan xen cùng giăng lưới bủa vây chặt chẽ. Tỉnh giấc với câu chuyện tịch mịch ngàn năm, tiếng than thở khẽ khàng bắt nhịp cho vòng quay kì bí.\r\nĐể rồi bạn bất chợt nhận ra, thứ chờ đợi tiếp theo không chỉ còn là sự lạnh lẽo bò dọc sống lưng.\r\nNó náu mình trong bóng tối, ẩn nhẫn kích động và khát cầu tham lam, hau háu dõi theo từng tâm hồn lạc bước.\r\nMỗi đêm một truyện kinh dị, chất liêu trai thấm đẫm từng chương. Cùng tôi đêm nay, liệu rằng bạn có dám?', 3, 1, '2026-03-24 16:33:27', '2026-03-24 16:33:27', 0),
(92, 'Mỗi Đêm Một Chuyện Kinh Dị - Tập 2', 'Vương Vũ Thần', 117000.00, NULL, 33, 'mdmtkd2.jpg', 'Nửa đêm nghe chuyện kinh dị, tựa như tỉnh táo giữa cơn mộng. Nỗi sợ như mũi nhọn từ sau lưng bao lấy bạn, bạn trằn trọc trăn trở. Bạn nghe thấy tiếng than nhẹ đầu tiên của truyền thuyết xa xưa ngàn năm tĩnh mịch sau khi tỉnh dậy, bạn phát hiện những sự kiện ly kỳ ngày qua ngày phát sinh bên cạnh bạn! Biết tôi đang đợi bạn không? Tối nay câu chuyện của tôi sẽ bắt đầu, có can đảm xin mời vào, thể nghiệm đỉnh cao khoái cảm của một phen càng khủng bố càng vui sướng!\r\n\'\'Một biên tập viên quèn của tòa soạn luôn vất vả bôn ba vì cuộc sống và một kẻ quái dị không chịu làm việc lại thích du lịch khắp nơi, có người gọi họ là Holmes và Watson của Trung Quốc, có người lại nói những gì họ đã trải qua giống như Liêu trai chí dị vậy. Với sự gan dạ sáng suốt vượt trội, họ đã đi qua vùng nông thôn cổ kính tới chốn đô thị phồn hoa, qua thế giới kỳ lạ tuyệt diệu như những câu chuyện ngụ ngôn, dẫn dắt mọi người trải nghiệm từng câu chuyện “dị sự kỳ văn”, có chuyện thì lạnh tới tận xương tủy, nhưng có chuyện thì lại ấm áp tới tận tâm hồn. Có lẽ những câu chuyện này cũng không thể coi là đáng sợ quá mức, nhưng cũng đủ khiến cho trái tim độc giả đập dồn dập. Trong những câu chữ vẻ như rất là bình thản kia lại ẩn giấu huyền cơ…\'\'\r\nVương Vũ Thần sử dụng những câu truyện kinh dị để phản ánh một bộ mặt tối tăm khác của con người và xã hội.\r\n\r\n \r\n\r\nMỗi Đêm Một Truyện Kinh Dị, mỗi đêm lại đưa bạn tới với cảm giác trái tim loạn nhịp. Đêm nay, hãy chờ đợi tôi…', 3, 1, '2026-03-24 16:33:27', '2026-03-24 16:33:27', 0),
(93, 'Mỗi Đêm Một Chuyện Kinh Dị - Tập 1', 'Vương Vũ Thần', 117000.00, NULL, 33, 'mdmtkd1.jpg', 'Nửa đêm nghe chuyện kinh dị, tựa như tỉnh táo giữa cơn mộng. Nỗi sợ như mũi nhọn từ sau lưng bao lấy bạn, bạn trằn trọc trăn trở. Bạn nghe thấy tiếng than nhẹ đầu tiên của truyền thuyết xa xưa ngàn năm tĩnh mịch sau khi tỉnh dậy, bạn phát hiện những sự kiện ly kỳ ngày qua ngày phát sinh bên cạnh bạn! Biết tôi đang đợi bạn không? Tối nay câu chuyện của tôi sẽ bắt đầu, có can đảm xin mời vào, thể nghiệm đỉnh cao khoái cảm của một phen càng khủng bố càng vui sướng!\r\n\r\n \r\n\r\n\'\'Một biên tập viên quèn của tòa soạn luôn vất vả bôn ba vì cuộc sống và một kẻ quái dị không chịu làm việc lại thích du lịch khắp nơi, có người gọi họ là Holmes và Watson của Trung Quốc, có người lại nói những gì họ đã trải qua giống như Liêu trai chí dị vậy. Với sự gan dạ sáng suốt vượt trội, họ đã đi qua vùng nông thôn cổ kính tới chốn đô thị phồn hoa, qua thế giới kỳ lạ tuyệt diệu như những câu chuyện ngụ ngôn, dẫn dắt mọi người trải nghiệm từng câu chuyện “dị sự kỳ văn”, có chuyện thì lạnh tới tận xương tủy, nhưng có chuyện thì lại ấm áp tới tận tâm hồn. Có lẽ những câu chuyện này cũng không thể coi là đáng sợ quá mức, nhưng cũng đủ khiến cho trái tim độc giả đập dồn dập. Trong những câu chữ vẻ như rất là bình thản kia lại ẩn giấu huyền cơ…\'\'\r\n\r\n \r\n\r\nVương Vũ Thần sử dụng những câu truyện kinh dị để phản ánh một bộ mặt tối tăm khác của con người và xã hội.\r\n\r\n \r\n\r\nMỗi Đêm Một Truyện Kinh Dị, mỗi đêm lại đưa bạn tới với cảm giác trái tim loạn nhịp. Đêm nay, hãy chờ đợi tôi…', 3, 1, '2026-03-24 16:33:27', '2026-03-24 16:33:27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tai_khoan`
--

CREATE TABLE `tai_khoan` (
  `ma_tk` int(11) NOT NULL,
  `ten_dang_nhap` varchar(100) DEFAULT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `vai_tro` enum('admin','shipper','khach') DEFAULT 'khach',
  `trang_thai` tinyint(4) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tai_khoan`
--

INSERT INTO `tai_khoan` (`ma_tk`, `ten_dang_nhap`, `mat_khau`, `ho_ten`, `email`, `so_dien_thoai`, `dia_chi`, `vai_tro`, `trang_thai`, `ngay_tao`) VALUES
(1, 'admin', '123456', 'Admin', 'admin@gmail.com', '123456', 'cantho', 'admin', 1, '2026-03-05 16:20:18'),
(2, 'shipper1', '123456', 'Shipper 1', 'ship1@gmail.com', NULL, NULL, 'shipper', 1, '2026-03-05 16:20:18'),
(3, 'shipper2', '123456', 'Shipper 2', 'ship2@gmail.com', NULL, NULL, 'shipper', 1, '2026-03-05 16:20:18'),
(4, 'user1', '123456', 'User 1', 'user1@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(5, 'user2', '123456', 'User 2', 'user2@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(6, 'user3', '123456', 'User 3', 'user3@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(7, 'b2303758', '12345678', NULL, 'locb2303758@student.ctu.edu.vn', NULL, NULL, 'khach', 1, '2026-03-14 15:41:37'),
(8, 'anhloc', '123456', NULL, 'TVB@gmail.com', NULL, NULL, 'khach', 1, '2026-03-14 17:02:31'),
(9, 'loc', '202cb962ac59075b964b07152d234b70', NULL, 'loc@gmail.com', '012345678', 'cần thơ', 'khach', 1, '2026-03-24 08:02:59'),
(10, 'toi la nguoi co ten dai nhat the gioi', '202cb962ac59075b964b07152d234b70', NULL, 'a@gmail.com', '0123456789', 'cantho', 'khach', 1, '2026-03-24 08:26:16'),
(13, 'anh tên là Bằng', '202cb962ac59075b964b07152d234b70', NULL, 'bang@gmail.com', '0876543', 'ádf', 'khach', 1, '2026-03-24 08:30:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`ma_ct`),
  ADD KEY `ma_don` (`ma_don`),
  ADD KEY `ma_sp` (`ma_sp`);

--
-- Indexes for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD PRIMARY KEY (`ma_danh_gia`),
  ADD KEY `ma_sp` (`ma_sp`),
  ADD KEY `ma_kh` (`ma_kh`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`ma_don`),
  ADD KEY `ma_kh` (`ma_kh`);

--
-- Indexes for table `lich_su_trang_thai_don`
--
ALTER TABLE `lich_su_trang_thai_don`
  ADD PRIMARY KEY (`ma_lich_su`),
  ADD KEY `ma_don` (`ma_don`),
  ADD KEY `nguoi_cap_nhat` (`nguoi_cap_nhat`);

--
-- Indexes for table `loai_sp`
--
ALTER TABLE `loai_sp`
  ADD PRIMARY KEY (`ma_loai`);

--
-- Indexes for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`ma_sp`),
  ADD KEY `ma_loai` (`ma_loai`);

--
-- Indexes for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD PRIMARY KEY (`ma_tk`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `ma_ct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `lich_su_trang_thai_don`
--
ALTER TABLE `lich_su_trang_thai_don`
  MODIFY `ma_lich_su` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loai_sp`
--
ALTER TABLE `loai_sp`
  MODIFY `ma_loai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `ma_sp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `ma_tk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`ma_don`) REFERENCES `don_hang` (`ma_don`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`ma_sp`) REFERENCES `san_pham` (`ma_sp`);

--
-- Constraints for table `danh_gia`
--
ALTER TABLE `danh_gia`
  ADD CONSTRAINT `danh_gia_ibfk_1` FOREIGN KEY (`ma_sp`) REFERENCES `san_pham` (`ma_sp`) ON DELETE CASCADE,
  ADD CONSTRAINT `danh_gia_ibfk_2` FOREIGN KEY (`ma_kh`) REFERENCES `tai_khoan` (`ma_tk`) ON DELETE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_kh`) REFERENCES `tai_khoan` (`ma_tk`);

--
-- Constraints for table `lich_su_trang_thai_don`
--
ALTER TABLE `lich_su_trang_thai_don`
  ADD CONSTRAINT `lich_su_trang_thai_don_ibfk_1` FOREIGN KEY (`ma_don`) REFERENCES `don_hang` (`ma_don`) ON DELETE CASCADE,
  ADD CONSTRAINT `lich_su_trang_thai_don_ibfk_2` FOREIGN KEY (`nguoi_cap_nhat`) REFERENCES `tai_khoan` (`ma_tk`);

--
-- Constraints for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`ma_loai`) REFERENCES `loai_sp` (`ma_loai`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
