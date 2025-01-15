-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2021-06-03 07:17:14
-- 伺服器版本： 10.4.18-MariaDB
-- PHP 版本： 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `hw3`
--

-- --------------------------------------------------------

--
-- 資料表結構 `income`
--

CREATE TABLE `income` (
  `id` varchar(15) NOT NULL,
  `y_m` date NOT NULL,
  `active_income` int(11) NOT NULL,
  `passive_income` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `income`
--

INSERT INTO `income` (`id`, `y_m`, `active_income`, `passive_income`) VALUES
('410785056', '2020-05-01', 5000, 1000),
('410785056', '2021-03-01', 10000, 0),
('410785056', '2021-04-01', 8000, 2000),
('410785056', '2021-05-01', 10000, 2000);

-- --------------------------------------------------------

--
-- 資料表結構 `living expenses`
--

CREATE TABLE `living expenses` (
  `user_id` varchar(15) NOT NULL,
  `date` date NOT NULL,
  `item` varchar(8) NOT NULL,
  `species` varchar(2) NOT NULL,
  `cost` int(11) NOT NULL DEFAULT 0,
  `remark` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `living expenses`
--

INSERT INTO `living expenses` (`user_id`, `date`, `item`, `species`, `cost`, `remark`) VALUES
('410785056', '2021-05-01', '5月交通費', '行', 1280, '捷運月票'),
('410785056', '2021-05-01', '午餐', '食', 100, NULL),
('410785056', '2021-05-01', '早餐', '食', 70, NULL),
('410785056', '2021-05-09', '早餐', '食', 60, NULL),
('410785056', '2021-05-01', '晚餐', '食', 95, NULL),
('410785056', '2021-05-09', '晚餐', '食', 1000, '母親節大餐'),
('410785056', '2021-05-15', '衣服', '衣', 880, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `stock`
--

CREATE TABLE `stock` (
  `buyer_id` varchar(20) NOT NULL,
  `company_name` varchar(5) NOT NULL,
  `number_of_shares` int(11) NOT NULL DEFAULT 0,
  `purchase_share_price` float NOT NULL DEFAULT 0,
  `sell_share_price` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `stock`
--

INSERT INTO `stock` (`buyer_id`, `company_name`, `number_of_shares`, `purchase_share_price`, `sell_share_price`) VALUES
('410785056', '台泥', 200, 40, 45),
('410785056', '台灣高鐵', 500, 32, 30.7),
('410785056', '台積電', 1000, 307, 310),
('410785056', '聯電', 300, 52, 52);

-- --------------------------------------------------------

--
-- 資料表結構 `user`
--

CREATE TABLE `user` (
  `id` varchar(15) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `user`
--

INSERT INTO `user` (`id`, `name`) VALUES
('410785056', 'Nancy');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`y_m`),
  ADD KEY `id` (`id`);

--
-- 資料表索引 `living expenses`
--
ALTER TABLE `living expenses`
  ADD PRIMARY KEY (`item`,`date`) USING BTREE,
  ADD KEY `user_id` (`user_id`);

--
-- 資料表索引 `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`company_name`),
  ADD KEY `buyer_id` (`buyer_id`);

--
-- 資料表索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `income`
--
ALTER TABLE `income`
  ADD CONSTRAINT `income_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`);

--
-- 資料表的限制式 `living expenses`
--
ALTER TABLE `living expenses`
  ADD CONSTRAINT `living expenses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- 資料表的限制式 `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
