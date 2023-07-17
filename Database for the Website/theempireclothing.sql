-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2023 at 08:47 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `theempireclothing`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cartId` int(255) NOT NULL,
  `userId` int(50) NOT NULL,
  `cartQuantity` int(255) NOT NULL DEFAULT 1,
  `productId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cartId`, `userId`, `cartQuantity`, `productId`) VALUES
(9, 45, 2, 18),
(10, 45, 1, 21),
(35, 44, 3, 17);

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `orderQuantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`orderId`, `productId`, `userId`, `orderQuantity`) VALUES
(14, 17, 44, 2),
(15, 18, 44, 1),
(16, 20, 44, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productId` int(100) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productCategory` varchar(100) NOT NULL,
  `productBrand` varchar(50) NOT NULL,
  `productPrice` varchar(20) NOT NULL,
  `productStock` varchar(20) NOT NULL,
  `productRating` varchar(20) NOT NULL DEFAULT '5',
  `productPicture` varchar(255) NOT NULL,
  `productSearchTag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productId`, `productName`, `productCategory`, `productBrand`, `productPrice`, `productStock`, `productRating`, `productPicture`, `productSearchTag`) VALUES
(17, 'Buzz 19', 'Bags', 'Balmain', '50000', '5', '5', 'Balmain buzz 19 handbag.jpg', 'balmain,buzz19,buzz,bags,19'),
(18, 'Mini Lola Quilted Leather Crossbody Bag', 'Bags', 'Burberry', '12000', '20', '5', 'Burberry Mini Lola Quilted Leather Crossbody Bag.jpg', 'burberry, mini lola, qulted,leather, crossbody'),
(20, 'Medium College Shoulder Bag', 'Bags', 'Saint Laurent', '50000', '30', '5', 'Saint Laurent Medium College Shoulder Bag.png', 'saint,laurent,college,shoulder.bags,bag'),
(21, 'Love Diamants 18 Carets', 'Jewellery', 'Cartier', '100000', '2', '5', 'Cartier Love Diamants 18 Carats Yellow gold bracelet.webp', '18,love,diamands,carets,Jewellery,cartier'),
(22, 'Roman Arch', 'Jewellery', 'Lucy Willaims', '200000', '6', '5', 'lucy-williams-roman-arc-coin-necklace-18ct-gold-plated-necklaces-missoma-920009.webp', 'roman,Jewellery,arch, lucy,williams'),
(23, 'Roman Coin Malachite', 'Jewellery', 'Lucy Williams', '50000', '1', '5', 'lucy-williams-roman-coin-malachite-necklace-set-18ct-gold-plated-vermeilmalachite-necklaces-missoma-114856.webp', 'lucy,williams,roman,coin,malachite,Jewellery'),
(24, 'Black Hoodie', 'Mens', 'Adidas', '5000', '20', '5', '8bdf554d-03d9-4284-84bf-8f82123c092f.jpg', 'adidas,mens,black,hoodie'),
(25, 'Black Shorts', 'Mens', 'Puma', '50000', '6', '5', 'vuori-ko.jpeg', 'puma,mens,black,shorts'),
(26, 'Royal Oak Chronograph', 'Watches', 'Audemars Piguet', '55000', '3', '5', 'audemars-piguet-royal-oak-chronograph-2021-1-watches-news.jpg', 'Royal,Oak,Chronograph,Audemars,Piguet,Watches'),
(27, 'DateJust', 'Watches', 'Rolex', '200000', '1', '5', 'Rolex DateJust.jpeg', 'rolex,datejust,watches,watch'),
(28, 'Black Sleeveless Ruched Bodycon', 'Womens', 'Forever 21', '6000', '30', '5', 'Forever 21 Womens Black Sleeveless Ruched Bodycon Mini Dress.jpg', 'forever,21,black,sleeveless,ruched,bodycon,womens'),
(29, 'Forest Green Velvet Coat', 'Womens', 'Saint Larent', '10000', '5', '5', 'Yves Saint Laurent Rive Gauche Forest Green Velvet Coat.jpg', 'saint,laurent,womens,forest,green,coat,velvet');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int(20) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(70) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `password` varchar(200) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `userType` varchar(30) NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `firstName`, `lastName`, `username`, `email`, `phoneNumber`, `password`, `picture`, `userType`) VALUES
(23, 'Amit', 'Baniyaas', 'Admin', 'amitbaniya@gmail.com', '9841111111', '34EUCLuGar/vJsdS525VOCgMQWgJZo8ttLcq9VjFO1bsL4CEUO9FQUE3rC1zDKe5nQ==', 'v3_0729665.jpg', 'admin'),
(44, 'Sarah', 'Laurentt', 'sarah', 'sarah@gmail.com', '9841615203', 'xC6dIYP81teUpJIYanjpFv8RXHQgBo9GxCO1hhxIz8KzJhbqbk5qezbT2smaCSk85A==', 'v3_0161599.jpg', 'customer'),
(45, 'Naomi', 'Kai', 'naomi', 'naomi@gmail.com', '988456123', 'fXMZpALFpvueX90vG45fGoGPn7RGGq07qEVpBt5dc0RqfPMpcsTDe4JTFq+ivlq9xw==', 'v3_0258435.jpg', 'customer'),
(46, 'Veda', 'Jackson', 'veda', 'veda@gmail.com', '894653317', 'tzoprHAO9LxZBOWtksxu78h9qa6bZYka5mO1K5J23wJUJWGG3T/wFB5LRMOIHD5x', 'v3_0881290.jpg', 'customer'),
(47, 'Sam', 'Michael', 'sam', 'sam@gmail.com', '985431876', 'd5VEvTFc1c+uyEPdvzYz9i/I/bVTZr+n0YbuDjJVxZG36QH0xDCJsfkLAse4cWs=', 'v3_0939001.jpg', 'customer'),
(48, 'Supratik', 'Pradhan', 'smsp', 'SMSP@pro.com', '985642316', 'n93JLkgm4SOBNq663RWEzsnJhIQ78YFYSNybOWJCtqa4gEryXAOr73xFZz59e4CP', 'v3_0729665.jpg', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cartId`),
  ADD KEY `productId` (`productId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `productIdproductTable` (`productId`),
  ADD KEY `userIdproductTable` (`userId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cartId` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productId` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `productId` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  ADD CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);

--
-- Constraints for table `ordertable`
--
ALTER TABLE `ordertable`
  ADD CONSTRAINT `productIdproductTable` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  ADD CONSTRAINT `userIdproductTable` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
