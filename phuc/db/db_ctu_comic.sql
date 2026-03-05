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

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`ma_don`, `ma_kh`, `ten_khach`, `so_dien_thoai`, `dia_chi_giao`, `tong_tien`, `phuong_thuc_thanh_toan`, `trang_thai`, `ngay_dat`, `ngay_duyet_don`, `ngay_hoan_tat`) VALUES
(1, 4, 'User 1', '0900000001', 'Cần Thơ', 48000.00, 'COD', 'dang_giao', '2026-03-05 23:20:18', NULL, NULL),
(2, 5, 'User 2', '0900000002', 'Vĩnh Long', 30000.00, 'COD', 'da_giao', '2026-03-05 23:20:18', NULL, NULL);

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
(1, 'Shonen'),
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
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`ma_sp`, `ten_sp`, `tac_gia`, `gia`, `gia_cu`, `so_luong_ton`, `anh_sp`, `mo_ta`, `ma_loai`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'One Piece Tập 1', 'Oda', 25000.00, NULL, 100, 'onepiece1.jpg', 'Truyện hải tặc', 1, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18'),
(2, 'Naruto Tập 1', 'Kishimoto', 23000.00, NULL, 50, 'naruto1.jpg', 'Truyện ninja', 1, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18'),
(3, 'Your Name', 'Makoto Shinkai', 45000.00, NULL, 30, 'yourname.jpg', 'Truyện tình cảm', 2, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18'),
(4, 'One Piece Tập 105', 'Oda', 30000.00, NULL, 200, 'onepiece105.jpg', 'Cuộc phiêu lưu hải tặc', 1, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18'),
(5, 'Naruto Tập 72', 'Kishimoto', 28000.00, NULL, 150, 'naruto72.jpg', 'Kết thúc đại chiến ninja', 1, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18'),
(6, 'Tokyo Ghoul', 'Sui Ishida', 35000.00, NULL, 70, 'tokyoghoul.jpg', 'Thế giới bán nhân', 3, 1, '2026-03-05 16:20:18', '2026-03-05 16:20:18');

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
  MODIFY `ma_don` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `ma_sp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
