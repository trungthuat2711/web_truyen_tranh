-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 17, 2026 at 01:27 PM
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
(65, 38, 26, 999, 65000.00);

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
(38, 1, 'admin', '0123456789', 'adminhouse', 64935000.00, 'COD', 'cho_xac_nhan', '2026-03-15 00:11:50', NULL, NULL, '', 'admin@gmail.com');

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
(1, 'Shounen'),
(2, 'Romance'),
(3, 'Horror'),
(4, 'Comedy');

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
(1, 'Thám Tử Lừng Danh Conan - Tập 87', 'Gosho Aoyama', 25000.00, NULL, 100, 'conan87.jpg', 'Trong làn mưa anh đào… Ran hồi tưởng lại lần đầu gặp Shinichi ở nhà trẻ Beika! Câu chuyện gợi ra những sắc màu hoàn toàn khác lạ về Ran và Shinichi trong mắt của hai người…! Ở tập này các bạn sẽ có lời giải cho “Những vụ án mạng ở Kawanakajima” và đến với “Vụ giết hại ngôi sao blog”.', 3, 1, '2026-02-26 04:40:06', '2026-03-17 04:30:22', 1),
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
(12, 'Doraemon Tập 23: Nobita Và Những Pháp Sư Gió Bí Ẩn', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon23.jpg', 'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời! \n\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\n\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\n\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', 4, 1, '2026-03-04 04:54:46', '2026-03-17 12:17:26', 0),
(13, 'Doraemon Tập 22: Nobita Và Vương Quốc Robot', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon22.jpg', 'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời!\n\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\n\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\n\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', 4, 1, '2026-03-04 05:35:52', '2026-03-17 12:18:06', 0),
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
(31, 'Chú Thuật Hồi Chiến - Tập 7', 'Gege', 65000.00, NULL, 13, 'jjk7.jpg', 'Giao lưu trường kết nghĩa Kyoto đã bắt đầu. Trong trận chiến đội ở ngày thứ nhất, bên nào thanh tẩy được chú linh cấp 2 trong khu vực thi đấu trước sẽ thắng. Với bản tính hiếu chiến, Todo đã lập tức tấn công bên Tokyo nhưng bị Itadori phục kích. Những thành viên khác của đội Kyoto cũng tham chiến hòng ám sát Itadori, khiến cậu rơi vào tình thế tiến thoái lưỡng nan!!', 1, 1, '2026-03-06 06:04:08', '2026-03-17 12:27:14', 0);

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
(1, 'admin', '123456', 'Admin', 'admin@gmail.com', NULL, NULL, 'admin', 1, '2026-03-05 16:20:18'),
(2, 'shipper1', '123456', 'Shipper 1', 'ship1@gmail.com', NULL, NULL, 'shipper', 1, '2026-03-05 16:20:18'),
(3, 'shipper2', '123456', 'Shipper 2', 'ship2@gmail.com', NULL, NULL, 'shipper', 1, '2026-03-05 16:20:18'),
(4, 'user1', '123456', 'User 1', 'user1@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(5, 'user2', '123456', 'User 2', 'user2@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(6, 'user3', '123456', 'User 3', 'user3@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18'),
(7, 'b2303758', '12345678', NULL, 'locb2303758@student.ctu.edu.vn', NULL, NULL, 'khach', 1, '2026-03-14 15:41:37'),
(8, 'anhloc', '123456', NULL, 'TVB@gmail.com', NULL, NULL, 'khach', 1, '2026-03-14 17:02:31');

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
  MODIFY `ma_ct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `lich_su_trang_thai_don`
--
ALTER TABLE `lich_su_trang_thai_don`
  MODIFY `ma_lich_su` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loai_sp`
--
ALTER TABLE `loai_sp`
  MODIFY `ma_loai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `ma_sp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `ma_tk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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