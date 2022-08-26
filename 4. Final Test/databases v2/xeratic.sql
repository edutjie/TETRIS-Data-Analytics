/*
SQLyog Community
MySQL - 10.4.19-MariaDB : Database - xeratic
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`xeratic` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `xeratic`;

/*Table structure for table `nodes` */

DROP TABLE IF EXISTS `nodes`;

CREATE TABLE `nodes` (
  `node` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `nodes` */

insert  into `nodes`(`node`,`parent`) values 
(1,2),
(3,2),
(6,8),
(9,8),
(2,5),
(8,5),
(5,NULL);

/*Table structure for table `people` */

DROP TABLE IF EXISTS `people`;

CREATE TABLE `people` (
  `nama` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `tanggal_registrasi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `people` */

insert  into `people`(`nama`,`tanggal_lahir`,`tanggal_registrasi`) values 
('Kasih','1997-07-29','2018-04-16'),
('Fadhil','1999-05-28','2018-06-06'),
('Citra','2002-01-20','2019-08-15'),
('Nirman','1995-12-24','2021-04-16'),
('Chandra','1998-11-14','2018-05-24'),
('Laras','1994-11-23','2021-07-19'),
('Ganda','1997-01-09','2019-10-21'),
('Irawan','1999-10-07','2021-09-28'),
('Tisna','1995-03-09','2021-02-21'),
('Hayu','2000-04-22','2018-05-27');

/*Table structure for table `strdata` */

DROP TABLE IF EXISTS `strdata`;

CREATE TABLE `strdata` (
  `strdata` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `strdata` */

insert  into `strdata`(`strdata`) values 
('2022-01-01 telah terjual 1 lusin seharga Rp 12000'),
('Tanggal 2022-01-02 terjual 1 buah seharga Rp 1000'),
('2 hari kemudian yaitu tanggal 2022-01-04 kembali terjual 6 buah seharga Rp 6000'),
('Pada hari berikutnya, yaitu pada tanggal 2022-01-05 terjual 10 buah seharga Rp 10000');

/*Table structure for table `xy` */

DROP TABLE IF EXISTS `xy`;

CREATE TABLE `xy` (
  `X` int(11) DEFAULT NULL,
  `Y` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `xy` */

insert  into `xy`(`X`,`Y`) values 
(30,40),
(40,30),
(20,21),
(23,22),
(22,23),
(21,20),
(25,24),
(88,77),
(44,55),
(55,44);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
