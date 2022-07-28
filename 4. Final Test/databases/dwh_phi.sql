-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2018 at 02:58 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dwh_phi`
--

-- --------------------------------------------------------

--
-- Table structure for table `ms_customer`
--

CREATE TABLE `ms_customer` (
  `kode_customer` varchar(200) DEFAULT NULL,
  `nama_customer` varchar(200) DEFAULT NULL,
  `kota_customer` varchar(200) DEFAULT NULL,
  `ongkos_kirim` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ms_customer`
--

INSERT INTO `ms_customer` (`kode_customer`, `nama_customer`, `kota_customer`, `ongkos_kirim`) VALUES
('C001', 'Warung bu Indah', 'Jakarta', 25000),
('C002', 'Toko Budi', 'Medan', 65000),
('C003', 'Toko Pak Imin', 'Bandung', 35000),
('C004', 'Toko Bu Endah', 'Jakarta', 25000);

-- --------------------------------------------------------

--
-- Table structure for table `ms_pegawai`
--

CREATE TABLE `ms_pegawai` (
  `kode_pegawai` varchar(200) DEFAULT NULL,
  `nama_pegawai` varchar(200) DEFAULT NULL,
  `jabatan` varchar(200) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  `tanggal_masuk` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ms_pegawai`
--

INSERT INTO `ms_pegawai` (`kode_pegawai`, `nama_pegawai`, `jabatan`, `target`, `tanggal_masuk`) VALUES
('S001', 'Budi', 'sales', 2, NULL),
('S002', 'Ayu', 'sales', 2, NULL),
('S003', 'Andi', 'supervisor', 5, NULL),
('S004', 'Susi', 'sales', 2, NULL),
('S005', 'Joko', 'sales', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ms_product`
--

CREATE TABLE `ms_product` (
  `kode_produk` varchar(200) DEFAULT NULL,
  `nama_product` varchar(200) DEFAULT NULL,
  `jenis` varchar(200) DEFAULT NULL,
  `harga_satuan` int(11) DEFAULT NULL,
  `kode_vendor` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ms_product`
--

INSERT INTO `ms_product` (`kode_produk`, `nama_product`, `jenis`, `harga_satuan`, `kode_vendor`) VALUES
('A001', 'Susu soda gembira', 'Soda', 5000, 'V001'),
('A002', 'Soda Segar', 'Soda', 5500, 'V001'),
('A003', 'Teh Celup', 'Teh', 4200, 'V002'),
('A004', 'Teh 500', 'Teh', 3500, 'V003'),
('A005', 'Ice Soda', 'Soda', 6000, 'V003'),
('A006', 'Air kemasan', 'Air Minum', 7500, 'V004'),
('A007', 'Air Cap Jernih', 'Air Minum', 6000, 'V005'),
('A008', 'Teh daun pucuk', 'Teh', 4500, 'V006'),
('A009', 'Jus Segar Murni', 'Jus', 7000, 'V004'),
('A010', 'Soda gembira ria', 'Soda', 12000, 'V001');

-- --------------------------------------------------------

--
-- Table structure for table `ms_vendor`
--

CREATE TABLE `ms_vendor` (
  `vendor` varchar(100) DEFAULT NULL,
  `kode_vendor` varchar(100) DEFAULT NULL,
  `kota_vendor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ms_vendor`
--

INSERT INTO `ms_vendor` (`vendor`, `kode_vendor`, `kota_vendor`) VALUES
('PT Alam Maju', 'V001', 'Jakarta'),
('PT Suka Sari', 'V002', 'Bandung'),
('PT Maju Berkarya', 'V003', 'Jakarta'),
('PT Berjaya', 'V004', 'Bogor'),
('PT Alam Maju', 'V005', 'Malang'),
('PT Cita Bangsa', 'V006', 'Tangerang');

-- --------------------------------------------------------

--
-- Table structure for table `tr_do`
--

CREATE TABLE `tr_do` (
  `no_entry_do` int(11) DEFAULT NULL,
  `no_entry_so` int(11) DEFAULT NULL,
  `no_do` varchar(200) DEFAULT NULL,
  `tgl_do` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_do`
--

INSERT INTO `tr_do` (`no_entry_do`, `no_entry_so`, `no_do`, `tgl_do`) VALUES
(1, 3, 'DO001', '2018-01-03'),
(2, 4, 'DO002', '2018-01-08'),
(3, 6, 'DO003', '2018-01-09'),
(4, 8, 'DO004', '2018-01-10'),
(5, 7, 'DO005', '2018-01-15'),
(6, 9, 'DO006', '2018-01-15'),
(7, 2, 'DO007', '2018-01-08'),
(8, 1, 'DO008', '2018-01-08'),
(9, 5, 'DO009', '2018-01-12'),
(10, 12, 'DO010', '2018-01-20'),
(11, 16, 'DO011', '2018-01-27'),
(12, 19, 'DO012', '2018-01-30'),
(13, 10, 'DO013', '2018-01-20');

-- --------------------------------------------------------

--
-- Table structure for table `tr_inv`
--

CREATE TABLE `tr_inv` (
  `no_entry_inv` int(11) DEFAULT NULL,
  `no_entry_do` int(11) DEFAULT NULL,
  `no_inv` varchar(200) DEFAULT NULL,
  `tgl_inv` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_inv`
--

INSERT INTO `tr_inv` (`no_entry_inv`, `no_entry_do`, `no_inv`, `tgl_inv`) VALUES
(1, 4, 'INV001', '2018-01-12'),
(2, 3, 'INV002', '2018-01-10'),
(3, 7, 'INV003', '2018-01-20'),
(4, 6, 'INV004', '2018-01-19'),
(5, 5, 'INV005', '2018-01-17'),
(6, 2, 'INV006', '2018-01-10'),
(7, 12, 'INV007', '2018-01-31');

-- --------------------------------------------------------

--
-- Table structure for table `tr_so`
--

CREATE TABLE `tr_so` (
  `no_entry_so` int(11) DEFAULT NULL,
  `no_so` varchar(200) DEFAULT NULL,
  `kode_barang` varchar(200) DEFAULT NULL,
  `kode_sales` varchar(200) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `satuan` varchar(200) DEFAULT NULL,
  `tgl_so` date DEFAULT NULL,
  `kode_customer` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_so`
--

INSERT INTO `tr_so` (`no_entry_so`, `no_so`, `kode_barang`, `kode_sales`, `qty`, `satuan`, `tgl_so`, `kode_customer`) VALUES
(1, 'SO001', 'A001', 'S001', 10, 'krat', '2018-01-01', 'C001'),
(2, 'SO001 ', 'A002', 'S001', 21, 'botol', '2018-01-01', 'C001'),
(3, 'SO001', 'A010', 'S001', 36, 'botol', '2018-01-01', 'C001'),
(4, 'SO002', 'A003', 'S001', 25, 'dus', '2018-01-04', 'C002'),
(5, 'SO002', 'A001', 'S001', 2, 'krat', '2018-01-04', 'C002'),
(6, 'SO003', 'A003', 'S004', 18, 'botol', '2018-01-05', 'C001'),
(7, 'SO004', 'A010', 'S004', 52, 'dus', '2018-01-10', 'C003'),
(8, 'SO004 ', 'A004', 'S004', 31, 'dus', '2018-01-10', 'C003'),
(9, 'SO005 ', 'A009', 'S002', 21, 'dus', '2018-01-11', 'C002'),
(10, 'SO005', 'A007', 'S002', 8, 'krat', '2018-01-11', 'C002'),
(11, 'SO005', 'A003', 'S002', 39, 'botol', '2018-01-11', 'C002'),
(12, 'SO006', 'A008', 'S001', 51, 'krat', '2018-01-11', 'C004'),
(13, 'SO006', 'A010', 'S001', 75, 'dus', '2018-01-11', 'C004'),
(14, 'SO007', 'A002', 'S002', 92, 'dus', '2018-01-22', 'C001'),
(15, 'SO008', 'A002', 'S003', 75, 'krat', '2018-01-23', 'C003'),
(16, 'SO008', 'A001', 'S003', 76, 'botol', '2018-01-23', 'C003'),
(17, 'SO009', 'A005', 'S004', 8, 'krat', '2018-01-27', 'C002'),
(18, 'SO010', 'A001', 'S005', 19, 'dus', '2018-01-30', 'C004'),
(19, 'SO010', 'A002', 'S005', 82, 'botol', '2018-01-30', 'C004'),
(20, 'SO011', 'A005', 'S003', 11, 'krat', '2018-01-31', 'C003');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
