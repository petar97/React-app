/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `aplikacija`;
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aplikacija`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'petar', '87E5262B6994CD166687DFF075EFCBBD77AADBF24726BB6F7894413A42392651218D5CA780376F0B896E519FC6969AF9745DE1B4E2899CB21D34562284DA61AF'),
	(2, 'test_user', '283175aklgjha62akjgl09'),
	(3, 'pperic', '6A4C0DC4FCC43BDEA28963DF73E4F8351BCDAE08FDA1516234E8D764AF8178A610BCCA2813D204DFF92A43F0511EB0016C7682CCF7B343D99E01739FC26EF104'),
	(5, 'nnikolic', '24BF4BB84103191BE8FB3967820433C40399EA3780D0BFDF4CED1C001988E67D4059A3F2ED4FAF18C189F95C1D763412F264C5CEEAA25A810985BCC5CCDFBC19'),
	(7, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC'),
	(8, 'test', 'EE26B0DD4AF7E749AA1A8EE3C10AE9923F618980772E473F8819A5D4940E0DB27AC185F8A0E1D5F84F88BC887FD67B143732C304CC5FA9AD8E6F57F50028A8FF');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `excerpt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('available','visible','hidden') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'available',
  `is_promoted` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
	(1, 'ACME HDD 256GB', 5, 'Kratak opis', 'Duzi Opis', 'available', 0, '2021-04-15 18:11:40'),
	(2, 'ACME HD11 1024GB', 5, 'Neki kratak tekst 2...', 'Neki malo duzi tekst o proizvodu 2...', 'visible', 1, '2021-04-17 17:51:33');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(1, 1, 1, '256GB'),
	(2, 1, 2, 'SATA3'),
	(3, 1, 3, 'SSD'),
	(6, 2, 1, '1024GB'),
	(7, 2, 2, 'SATA 3.0');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `article_price`;
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
	(1, 1, 45.00, '2021-04-15 18:24:14'),
	(2, 1, 43.56, '2021-04-15 18:24:31'),
	(3, 2, 56.89, '2021-04-17 17:51:33'),
	(4, 2, 57.11, '2021-04-25 17:56:07');
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Racunarske komponente', 'assets/pc.jpg', NULL),
	(2, 'Kucna elektronika', 'assets/home.jpg', NULL),
	(3, 'Laptop racunari', 'assets/pc/laptop.jpg', 1),
	(4, 'Memorijski mediji', 'assets/pc/memory.jpg', 1),
	(5, 'Hard diskovi', 'assets/pc/memory/hdd.jpg', 4);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(1, 'Kapacitet', 5),
	(4, 'Napon', 2),
	(6, 'Proizvodjač', 2),
	(5, 'Snaga', 2),
	(3, 'Tehnologija', 5),
	(2, 'Tip', 5);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL DEFAULT '0',
  `status` enum('rejected','accepted','shipped','pending') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `FK_order_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(6, 2, '2021425-6468419188-hard-disk-slika-2.jpg'),
	(7, 2, '2021425-7354644897-hard-disk-slika-2.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `password_hash` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `forename` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `phone_number` varchar(24) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `postal_adress` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`),
  UNIQUE KEY `uq_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_adress`) VALUES
	(1, 'test@test.com', 'DDAF35A193617ABACC417349AE20413112E6FA4E89A97EA20A9EEEE64B55D39A2192992A274FC1A836BA3C23A3FEEBBD454D4423643CE80E2A9AC94FA54CA49F', 'Pera', 'Peric', '+3816392085', 'Random adresa 11');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
