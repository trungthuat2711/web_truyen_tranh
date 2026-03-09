-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2026 at 05:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ctu_comic`
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
(1, 1, 1, 1, 25000.00),
(2, 1, 2, 1, 23000.00),
(3, 2, 4, 1, 30000.00);

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
  `ngay_hoan_tat` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Dumping data for table `lich_su_trang_thai_don`
--

INSERT INTO `lich_su_trang_thai_don` (`ma_lich_su`, `ma_don`, `trang_thai`, `nguoi_cap_nhat`, `thoi_gian_cap_nhat`) VALUES
(1, 1, 'cho_xac_nhan', 1, '2026-03-05 23:20:18'),
(2, 1, 'dang_giao', 2, '2026-03-05 23:20:18'),
(3, 2, 'cho_xac_nhan', 1, '2026-03-05 23:20:18'),
(4, 2, 'da_giao', 3, '2026-03-05 23:20:18');

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
(1, 'Thám Tử Lừng Danh Conan - Tập 87', 'Gosho Aoyama', 25000.00, NULL, 100, 'conan87.jpg', 'Truyện Thám Tử Conan', 3, 1, '2026-02-26 04:40:06', '2026-03-06 13:30:08', 1),
(2, 'Thám Tử Lừng Danh Conan - Tập 71', 'Gosho Aoyama', 23000.00, NULL, 50, 'conan71.jpg', 'Truyện Thám Tử Conan', 3, 1, '2026-02-26 04:40:06', '2026-03-06 13:30:08', 1),
(3, 'Thám Tử Lừng Danh Conan - Tập 70', 'Gosho Aoyama', 45000.00, NULL, 30, 'conan70.jpg', 'Truyện thám tử Conan', 3, 1, '2026-02-26 04:40:06', '2026-03-06 13:30:08', 1),
(4, 'Thám Tử Lừng Danh Conan - Tập 67', 'Gosho Aoyama', 30000.00, NULL, 200, 'conan67.jpg', 'Truyện thám tử conan', 3, 1, '2026-02-26 13:22:12', '2026-03-06 13:30:08', 1),
(5, 'Chú Thuật Hồi Chiến - Tập 19', 'Gege', 28000.00, NULL, 150, 'jjk19.jpg', 'Tử diệt hồi du', 1, 1, '2026-02-26 13:22:12', '2026-03-02 04:37:13', 1),
(6, 'Chú Thuật Hồi Chiến - Tập 18', 'Gege', 35000.00, NULL, 70, 'jjk18.jpg', 'Tử diệt hồi du', 1, 1, '2026-02-26 13:22:12', '2026-03-02 04:37:55', 1),
(7, 'Shin Cậu Bé Bút Chì - Tập 52', 'Yoshito Usui', 50000.00, NULL, 50, 'shin52.jpg', 'Cậu bé bút chì', 4, 1, '2026-02-26 04:40:06', '2026-03-02 04:34:02', 1),
(8, 'Shin Cậu Bé Bút Chì - Tập 46', 'Yoshito Usui', 50000.00, NULL, 50, 'shin46.jpg', 'Cậu bé bút chì', 4, 1, '2026-02-26 04:40:06', '2026-03-02 04:34:02', 1),
(9, 'Shin Cậu Bé Bút Chì - Tập 21', 'Yoshito Usui', 50000.00, NULL, 50, 'shin21.jpg', 'Cậu bé bút chì', 4, 1, '2026-02-26 04:40:06', '2026-03-02 04:34:02', 1),
(10, 'Shin Cậu Bé Bút Chì - Tập 11', 'Yoshito Usui', 50000.00, NULL, 50, 'shin11.jpg', 'Cậu bé bút chì', 4, 1, '2026-02-26 04:40:06', '2026-03-02 04:34:02', 1),
(11, 'Thanh Gươm Diệt Quỷ - Tập 18', 'Koyoharu Gotouge', 25000.00, NULL, 15, 'thanhguomdietquy18.jpg', 'Thanh gươm diệt quỷ', 1, 1, '2026-03-04 04:50:15', '2026-03-04 04:50:15', 0),
(12, 'Doraemon Tập 23: Nobita Và Những Pháp Sư Gió Bí Ẩn', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon23.jpg', 'Truyện Doraemon', 4, 1, '2026-03-04 04:54:46', '2026-03-04 04:54:46', 0),
(13, 'Doraemon Tập 22: Nobita Và Vương Quốc Robot', 'Fujiko F Fujio', 22000.00, NULL, 30, 'doraemon22.jpg', 'Truyện Doraemon', 4, 1, '2026-03-04 05:35:52', '2026-03-04 05:35:52', 0),
(14, 'Chú Thuật Hồi Chiến - Tập 1', 'Gege', 30000.00, NULL, 20, 'jjk1.png', 'Chú Thuật Hồi Chiến', 1, 1, '2026-03-04 05:38:35', '2026-03-04 05:40:05', 0),
(15, 'Thanh Gươm Diệt Quỷ - Tập 15', 'Koyoharu Gotouge', 25000.00, NULL, 15, 'thanhguomdietquy15.jpg', 'Thanh gươm diệt quỷ', 1, 1, '2026-03-04 05:46:30', '2026-03-04 05:46:30', 0),
(16, 'Thám Tử Lừng Danh Conan - Tập 83', 'Gosho Aoyama', 25000.00, NULL, 12, 'conan83.jpg', NULL, 3, 1, '2026-03-04 05:51:16', '2026-03-06 13:30:08', 0),
(17, 'Chú Thuật Hồi Chiến: Trường Chuyên Chú Thuật Tokyo - Tập 0', 'Gege', 30000.00, NULL, 20, 'jjk0.jpg', 'Chú Thuật Hồi Chiến', 1, 1, '2026-03-04 05:57:49', '2026-03-04 05:57:49', 0),
(18, 'Dragon Ball Super - Tập 2 (Tái Bản 2023)', 'Akira Toriyama Toyotarou', 25000.00, NULL, 50, 'dragonballsuper2.jpg', 'Ngọc rồng siêu cấp', 1, 1, '2026-03-04 06:04:13', '2026-03-04 06:06:21', 0),
(19, 'Spy X Family - Tập 3', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy3.jpg', 'Spy X Family', 2, 1, '2026-03-04 06:20:30', '2026-03-04 06:39:43', 0),
(20, 'Spy X Family - Tập 2', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy2.jpg', 'Spy X Family', 2, 1, '2026-03-04 06:35:42', '2026-03-04 06:35:42', 0),
(21, 'Spy X Family - Tập 1', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy1.jpg', 'Spy X Family', 2, 1, '2026-03-04 06:38:04', '2026-03-04 06:38:04', 0),
(22, 'Spy X Family - Tập 4', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy4.jpg', 'Spy X Family', 2, 1, '2026-03-04 06:40:16', '2026-03-04 06:40:16', 0),
(23, 'Spy X Family - Tập 5', 'Tatsuya Endo', 150000.00, NULL, 20, 'spy5.jpg', 'Spy X Family', 2, 1, '2026-03-04 06:40:24', '2026-03-04 06:40:24', 0),
(24, 'Chú Thuật Hồi Chiến - Tập 8', 'Gege', 30000.00, NULL, 20, 'jjk8.jpg', 'Chú Thuật Hồi Chiến', 1, 1, '2026-03-04 07:25:22', '2026-03-04 07:25:22', 0),
(25, 'Chú Thuật Hồi Chiến - Tập 15: Biến Cố Shibuya - Biến Thân', 'Gege', 65000.00, NULL, 50, 'jjk15.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 05:56:02', '2026-03-06 05:56:02', 0),
(26, 'Chú Thuật Hồi Chiến - Tập 14', 'Gege', 65000.00, NULL, 13, 'jjk14.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 05:58:25', '2026-03-06 05:58:25', 0),
(27, 'Chú Thuật Hồi Chiến - Tập 13', 'Gege', 65000.00, NULL, 13, 'jjk13.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 05:59:11', '2026-03-06 05:59:11', 0),
(28, 'Chú Thuật Hồi Chiến - Tập 12', 'Gege', 65000.00, NULL, 13, 'jjk12.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 06:00:33', '2026-03-06 06:00:33', 0),
(29, 'Chú Thuật Hồi Chiến - Tập 10', 'Gege', 65000.00, NULL, 13, 'jjk10.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 06:01:26', '2026-03-06 06:01:26', 0),
(30, 'Chú Thuật Hồi Chiến - Tập 9', 'Gege', 45000.00, NULL, 13, 'jjk9.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 06:01:58', '2026-03-06 06:03:16', 0),
(31, 'Chú Thuật Hồi Chiến - Tập 7', 'Gege', 65000.00, NULL, 13, 'jjk7.jpg', 'Chú thuật hồi chiến', 1, 1, '2026-03-06 06:04:08', '2026-03-06 06:04:08', 0);

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
(6, 'user3', '123456', 'User 3', 'user3@gmail.com', NULL, NULL, 'khach', 1, '2026-03-05 16:20:18');

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
  MODIFY `ma_ct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `danh_gia`
--
ALTER TABLE `danh_gia`
  MODIFY `ma_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `ma_don` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
  MODIFY `ma_tk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`ma_kh`) REFERENCES `tai_khoan` (`ma_tk`) ON DELETE CASCADE;

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