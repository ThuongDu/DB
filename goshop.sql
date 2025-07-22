-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th7 22, 2025 lúc 03:03 AM
-- Phiên bản máy phục vụ: 9.1.0
-- Phiên bản PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `goshop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `warehouse_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_ibfk_3` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `warehouse_id`, `created_at`) VALUES
(21, 'Máy Tính', 9, '2025-07-15 15:45:11'),
(22, 'Điện Thoại', 9, '2025-07-15 15:45:18'),
(23, 'LapTop', 9, '2025-07-15 15:45:25'),
(24, 'LapTop', 10, '2025-07-15 15:58:47'),
(25, 'Ipad', 10, '2025-07-15 15:58:52'),
(26, 'Đồ điện tử', 10, '2025-07-15 15:59:10'),
(27, 'Điện thoai', 11, '2025-07-15 15:59:20');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`id`, `name`, `phone`, `created_at`) VALUES
(3, 'Anh Dũ nè', '0588888888', '2025-07-03 19:05:25'),
(4, ' ABC', '0353190026', '2025-07-04 10:33:43'),
(10, 'gagagd', '0984574752', '2025-07-13 02:58:23'),
(11, 'sgsdg', '0359845657', '2025-07-13 03:27:53'),
(12, 'thuong03', '0258963147', '2025-07-13 07:57:25'),
(13, ' No name', '0999999999', '2025-07-15 19:27:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `tax` decimal(12,2) NOT NULL,
  `status` enum('đang xử lý','chờ lấy hàng','thành công') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'đang xử lý',
  `shop_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` enum('tiền mặt','chuyển khoản') DEFAULT 'tiền mặt',
  PRIMARY KEY (`id`),
  UNIQUE KEY `CODE` (`code`),
  KEY `customer_id` (`customer_id`),
  KEY `shop_id` (`shop_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `code`, `customer_id`, `total_price`, `tax`, `status`, `shop_id`, `created_by`, `created_at`, `payment_method`) VALUES
(7, 'ORD01', 12, 48816000.00, 3616000.00, 'thành công', 31, 1, '2025-07-15 19:20:42', 'tiền mặt'),
(8, 'ORD02', 13, 41946120.00, 3107120.00, 'thành công', 31, 1, '2025-07-15 19:27:12', 'tiền mặt'),
(9, 'ORD03', 11, 41946120.00, 3107120.00, 'thành công', 31, 4, '2025-07-15 21:18:03', 'tiền mặt'),
(10, 'ORD04', 3, 58618080.00, 4342080.00, 'chờ lấy hàng', 31, 4, '2025-07-15 21:23:54', 'tiền mặt'),
(11, 'ORD05', 13, 54583200.00, 4043200.00, 'thành công', 31, 4, '2025-07-16 03:54:02', 'tiền mặt'),
(14, 'ORD06', 4, 14654520.00, 1085520.00, 'đang xử lý', 31, 1, '2025-07-21 14:14:41', 'tiền mặt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE IF NOT EXISTS `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`id`, `order_id`, `product_id`, `product_code`, `product_name`, `quantity`, `total_price`, `created_by`, `created_at`) VALUES
(12, 7, 42, 'SP042', 'Đồng hồ ', 1, 45200000.00, 1, '2025-07-15 19:20:42'),
(13, 8, 46, 'SP046', 'Đồng hồ thông minh ', 1, 13569000.00, 1, '2025-07-15 19:27:12'),
(14, 8, 43, 'SP043', 'ASUS-VIVOBOOK laptop', 1, 25270000.00, 1, '2025-07-15 19:27:12'),
(15, 9, 43, 'SP043', 'ASUS-VIVOBOOK laptop', 1, 25270000.00, 4, '2025-07-15 21:18:03'),
(16, 9, 46, 'SP046', 'Đồng hồ thông minh ', 1, 13569000.00, 4, '2025-07-15 21:18:03'),
(17, 10, 46, 'SP046', 'Đồng hồ thông minh ', 4, 54276000.00, 4, '2025-07-15 21:23:54'),
(18, 11, 43, 'SP043', 'ASUS-VIVOBOOK laptop', 1, 25270000.00, 4, '2025-07-16 03:54:02'),
(19, 11, 43, 'SP043', 'ASUS-VIVOBOOK laptop', 1, 25270000.00, 4, '2025-07-16 03:54:02'),
(20, 14, 46, 'SP046', 'Đồng hồ thông minh ', 1, 13569000.00, 1, '2025-07-21 14:14:41');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `weight` decimal(10,2) DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CODE` (`code`),
  KEY `product_ibfk_1` (`created_by`),
  KEY `product_ibfk_2` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `code`, `created_at`, `created_by`, `updated_at`, `updated_by`, `description`, `weight`, `unit`, `sale_price`, `expiry_date`) VALUES
(42, 'Đồng hồ ', 45200000.00, 'SP042', '2025-07-15 15:54:44', 4, '2025-07-15 15:54:44', 4, NULL, NULL, NULL, NULL, NULL),
(43, 'ASUS-VIVOBOOK laptop', 25270000.00, 'SP043', '2025-07-15 15:55:32', 4, '2025-07-15 15:55:32', 4, NULL, NULL, NULL, NULL, NULL),
(44, 'Ipad 537GB', 35170000.00, 'SP044', '2025-07-15 15:56:00', 4, '2025-07-15 15:56:00', 4, NULL, NULL, NULL, NULL, NULL),
(45, 'Sạc iphone ERS', 6280000.00, 'SP045', '2025-07-15 15:56:28', 4, '2025-07-15 15:56:28', 4, NULL, NULL, NULL, NULL, NULL),
(46, 'Đồng hồ thông minh ', 13569000.00, 'SP046', '2025-07-15 15:57:21', 4, '2025-07-15 15:57:21', 4, NULL, NULL, NULL, NULL, NULL),
(48, 'Bút chì aaaa', 15000.00, 'SP048', '2025-07-21 06:28:28', 4, '2025-07-21 06:28:28', 4, 'bút chì á để viết vẽ...', 1.50, 'cái', 0.00, '2025-07-21'),
(49, 'Bút chì aaaa', 15000.00, 'SP049', '2025-07-21 07:09:41', 4, '2025-07-21 07:09:41', 4, NULL, 56.00, 'hộp', 0.00, '2025-07-31'),
(53, 'newww', 4649000.00, '00000000053', '2025-07-21 07:24:05', 4, '2025-07-21 07:24:05', 4, NULL, 1.50, NULL, 455800.00, '2025-08-02'),
(54, 'newww', 4649000.00, '00000000054', '2025-07-21 07:27:24', 4, '2025-07-21 07:27:24', 4, NULL, 1.50, 'g', 455800.00, '2025-08-02'),
(56, 'newww', 4649000.00, '47037132135', '2025-07-21 09:51:36', 4, '2025-07-21 09:51:36', 4, NULL, 1.50, NULL, 455800.00, '2025-07-20');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_category`
--

DROP TABLE IF EXISTS `product_category`;
CREATE TABLE IF NOT EXISTS `product_category` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  UNIQUE KEY `unique_product_category` (`product_id`,`category_id`),
  KEY `category_id` (`category_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_category`
--

INSERT INTO `product_category` (`product_id`, `category_id`, `created_at`, `created_by`) VALUES
(42, 23, '2025-07-15 16:22:54', 1),
(43, 23, '2025-07-15 16:22:54', 1),
(45, 22, '2025-07-15 16:34:23', 1),
(46, 21, '2025-07-15 16:24:07', 1),
(46, 22, '2025-07-15 16:24:07', 1),
(46, 23, '2025-07-15 16:24:07', 1),
(48, 21, '2025-07-21 06:41:10', 1),
(56, 22, '2025-07-21 10:02:00', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_image`
--

DROP TABLE IF EXISTS `product_image`;
CREATE TABLE IF NOT EXISTS `product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `product_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_image`
--

INSERT INTO `product_image` (`id`, `url`, `product_id`, `created_at`) VALUES
(35, 'uploads/1752594884599-766667064.jpg', 42, '2025-07-15 15:54:44'),
(36, 'uploads/1752594932394-576100494.jpg', 43, '2025-07-15 15:55:32'),
(37, 'uploads/1752594960679-333583952.jpeg', 44, '2025-07-15 15:56:00'),
(38, 'uploads/1752594988837-742037473.webp', 45, '2025-07-15 15:56:28'),
(39, 'uploads/1752595041081-920609714.jpg', 46, '2025-07-15 15:57:21'),
(41, 'uploads/1753079308984-379545330.jpg', 48, '2025-07-21 06:28:28'),
(42, 'uploads/1753081781280-407684069.jpg', 49, '2025-07-21 07:09:41'),
(46, 'uploads/1753082645901-231637251.webp', 53, '2025-07-21 07:24:05'),
(47, 'uploads/1753082844879-472746957.jpg', 54, '2025-07-21 07:27:24'),
(49, 'uploads/1753091496719-229583465.jpeg', 56, '2025-07-21 09:51:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_quantity`
--

DROP TABLE IF EXISTS `product_quantity`;
CREATE TABLE IF NOT EXISTS `product_quantity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_id` int NOT NULL,
  `category_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `shop_id` int NOT NULL,
  `quantity` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `image_id` (`image_id`),
  KEY `category_id` (`category_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  KEY `fk_pq_shop` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `product_quantity`
--

INSERT INTO `product_quantity` (`id`, `product_id`, `image_id`, `category_id`, `warehouse_id`, `shop_id`, `quantity`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(56, 46, 39, 21, 9, 31, 33, '2025-07-21 09:06:31', 1, '2025-07-21 14:14:41', 1),
(57, 46, 39, 22, 9, 31, 34, '2025-07-21 09:06:34', 1, '2025-07-21 09:06:34', 1),
(58, 46, 39, 23, 9, 31, 34, '2025-07-21 09:06:38', 1, '2025-07-21 09:06:38', 1),
(59, 48, 41, 21, 9, 31, 34, '2025-07-21 09:44:23', 1, '2025-07-21 09:44:23', 1),
(60, 56, 49, 22, 9, 31, 45, '2025-07-21 10:02:00', 1, '2025-07-21 10:02:12', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `shop`
--

DROP TABLE IF EXISTS `shop`;
CREATE TABLE IF NOT EXISTS `shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` text NOT NULL,
  `province` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `address_detail` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `region` enum('bac','trung','nam') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'nam',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `shop`
--

INSERT INTO `shop` (`id`, `name`, `address`, `province`, `district`, `ward`, `address_detail`, `phone`, `region`, `status`, `created_at`) VALUES
(28, 'svsa', 'ấdfsg, Thị trấn Phó Bảng, Huyện Đồng Văn, Tỉnh Hà Giang', 'Tỉnh Hà Giang', 'Huyện Đồng Văn', 'Thị trấn Phó Bảng', 'ấdfsg', '1415666576', '', 'active', '2025-07-11 08:09:45'),
(31, 'Store Nguyễn Khuyễn', '39/92 Nguyễn Khuyến, Phường Trảng Dài, Thành phố Biên Hòa, Tỉnh Đồng Nai', 'Tỉnh Đồng Nai', 'Thành phố Biên Hòa', 'Phường Trảng Dài', '39/92 Nguyễn Khuyến', '0369852147', 'nam', 'active', '2025-07-15 15:39:14'),
(32, 'Store Hàng Cân', '26 Hàng Cân, Phường Hàng Bồ, Quận Hoàn Kiếm, Thành phố Hà Nội', 'Thành phố Hà Nội', 'Quận Hoàn Kiếm', 'Phường Hàng Bồ', '26 Hàng Cân', '0147852369', 'bac', 'active', '2025-07-15 15:41:47'),
(33, 'Store Võ Nguyên Giáp', '24 Võ Nguyên Giáp, Phường Khuê Mỹ, Quận Ngũ Hành Sơn, Thành phố Đà Nẵng', 'Thành phố Đà Nẵng', 'Quận Ngũ Hành Sơn', 'Phường Khuê Mỹ', '24 Võ Nguyên Giáp', '0258741369', 'trung', 'active', '2025-07-15 15:43:19');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('admin','staff') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `shop_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `shop_id` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `password`, `role`, `shop_id`, `created_at`) VALUES
(1, 'ThuongAdmin', '0353190026', '$2b$10$BPTnLuzMZcIr.SJJoitJMuKRPl6vzB7vO2cweUp0WYuby5xZZthC2', 'admin', NULL, '2025-05-26 05:19:00'),
(4, 'ThuongStaff', '0995570145', '$2b$10$4QvOHSQ0xFHfR9gujnPwX.E7wlmc4aijlstjghODfEaLT2siiVIam', 'staff', 31, '2025-05-26 05:21:06');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE IF NOT EXISTS `warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `shop_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_warehouse_shop` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `warehouse`
--

INSERT INTO `warehouse` (`id`, `name`, `shop_id`, `created_at`) VALUES
(9, 'Kho Nguyễn Khuyến', 31, '2025-07-15 15:43:51'),
(10, 'Kho Hàng Cân', 32, '2025-07-15 15:44:01'),
(11, 'Kho Võ Nguyên Giáp', 33, '2025-07-15 15:44:14'),
(14, 'Kho NK Cũ', 31, '2025-07-21 08:14:12');

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_3` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Các ràng buộc cho bảng `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_category_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `product_quantity`
--
ALTER TABLE `product_quantity`
  ADD CONSTRAINT `fk_pq_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_quantity_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_quantity_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `product_image` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_quantity_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_quantity_ibfk_4` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_quantity_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `product_quantity_ibfk_6` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `warehouse`
--
ALTER TABLE `warehouse`
  ADD CONSTRAINT `fk_warehouse_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
