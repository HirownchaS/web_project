-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2021 at 03:20 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebillsystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `unitstoamount` (IN `units` INT(14), OUT `result` INT(14))  BEGIN
   
    DECLARE a INT(14) DEFAULT 0;
    DECLARE b INT(14) DEFAULT 0;
    DECLARE c INT(14) DEFAULT 0;

    SELECT twohundred FROM unitsRate INTO a ;
    SELECT fivehundred FROM unitsRate INTO b ;
    SELECT thousand FROM unitsRate INTO c  ;

    IF units<=90
    then
        SELECT a*units INTO result;
    
    ELSEIF units<=180
    then
        SELECT (a*90)+(b*(units-90)) INTO result;
    ELSEIF units > 500
    then
        SELECT (a*90)+(b*(90))+(c*(units-500)) INTO result;
    END IF;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `curdate1` () RETURNS INT(11) BEGIN
    DECLARE x INT;
    SET x = DAYOFMONTH(CURDATE());
    IF (x=1)
    THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(14) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `pass` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `pass`) VALUES
(1, 'Administrator One', 'admin@gmail.com', 'Password@123');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `id` int(14) NOT NULL,
  `aid` int(14) NOT NULL,
  `uid` int(14) NOT NULL,
  `units` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(10) NOT NULL,
  `bdate` date NOT NULL,
  `ddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`id`, `aid`, `uid`, `units`, `amount`, `status`, `bdate`, `ddate`) VALUES
(18, 1, 1, 61, '122.00', 'PROCESSED', '2021-07-10', '2021-08-09'),
(25, 1, 1, 14, '28.00', 'PROCESSED', '2021-12-04', '2022-01-03'),
(26, 1, 4, 14, '28.00', 'PROCESSED', '2021-12-04', '2022-01-03'),
(28, 1, 2, 100, '200.00', 'PROCESSED', '2021-12-04', '2022-01-03'),
(29, 1, 1, 100, '230.00', 'PROCESSED', '2021-12-05', '2022-01-04'),
(30, 1, 4, 1000, '5630.00', 'PENDING', '2021-12-05', '2022-01-04'),
(31, 1, 2, 125, '355.00', 'PROCESSED', '2021-12-05', '2022-01-04'),
(32, 1, 3, 110, '280.00', 'PENDING', '2021-12-05', '2022-01-04'),
(33, 1, 14, 150, '480.00', 'PROCESSED', '2021-12-05', '2022-01-04');

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `id` int(14) NOT NULL,
  `uid` int(14) NOT NULL,
  `aid` int(14) NOT NULL,
  `complaint` varchar(140) NOT NULL,
  `status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `complaint`
--

INSERT INTO `complaint` (`id`, `uid`, `aid`, `complaint`, `status`) VALUES
(1, 1, 1, 'Transaction Not Processed', 'PROCESSED'),
(16, 2, 1, 'Previous Complaint Not Processed', 'NOT PROCESSED'),
(17, 14, 1, 'Previous Complaint Not Processed', 'PROCESSED');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(14) NOT NULL,
  `bid` int(14) NOT NULL,
  `payable` decimal(10,2) NOT NULL,
  `pdate` date DEFAULT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `bid`, `payable`, `pdate`, `status`) VALUES
(25, 25, '28.00', '2021-12-04', 'PROCESSED'),
(26, 26, '28.00', '2021-12-04', 'PROCESSED'),
(28, 28, '200.00', '2021-12-04', 'PROCESSED'),
(29, 29, '230.00', '2021-12-05', 'PROCESSED'),
(30, 30, '5630.00', NULL, 'PENDING'),
(31, 31, '355.00', '2021-12-05', 'PROCESSED'),
(32, 32, '280.00', NULL, 'PENDING'),
(33, 33, '480.00', '2021-12-05', 'PROCESSED');

-- --------------------------------------------------------

--
-- Table structure for table `unitsrate`
--

CREATE TABLE `unitsrate` (
  `sno` int(1) DEFAULT NULL,
  `twohundred` int(14) NOT NULL,
  `fivehundred` int(14) NOT NULL,
  `thousand` int(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unitsrate`
--

INSERT INTO `unitsrate` (`sno`, `twohundred`, `fivehundred`, `thousand`) VALUES
(1, 2, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(14) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `phone`, `pass`, `address`) VALUES
(1, 'hirowncha\r\n', 'hirowncha@gmail.com', '7450002145', 'password', 'nelliady'),
(2, 'sp', 'loshansp@gmail.com', '0762481009', 'password', 'nelliady'),
(3, 'perumal', 'perumal@gmail.com', '7012569980', 'password', 'karaveddy'),
(4, 'Hirownch', 'hirowncha18@gmail.com', '0777123456', '123456', 'jaffna'),
(14, 'yoki', 'yokilan@gmail.com', '0777154782', 'password', 'jaffna');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aid` (`aid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aid` (`aid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bid` (`bid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(14) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
  ADD CONSTRAINT `complaint_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `complaint_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `bill` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
