CREATE DATABASE IF NOT EXISTS `tasks`
/*!40100 DEFAULT CHARACTER SET utf8mb3 */
/*!80016 DEFAULT ENCRYPTION='N' */
;
USE `tasks`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tasks
-- ------------------------------------------------------
-- Server version	8.0.34
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!50503 SET NAMES utf8 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `labels`
--
DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `labels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `labels`
--
LOCK TABLES `labels` WRITE;
/*!40000 ALTER TABLE `labels` DISABLE KEYS */
;
INSERT INTO `labels`
VALUES (1, 'срочно и быстро'),
(2, 'желательно'),
(3, 'фо фан');
/*!40000 ALTER TABLE `labels` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `tasks`
--
DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opened` time DEFAULT NULL,
  `closed` time DEFAULT NULL,
  `author_id` int NOT NULL,
  `assigned_id` int NOT NULL,
  `title` tinytext,
  `content` text,
  PRIMARY KEY (`id`, `author_id`, `assigned_id`),
  KEY `id` (`author_id`)
  /*!80000 INVISIBLE */
,
  KEY `users2_idx` (`assigned_id`)
  /*!80000 INVISIBLE */
,
  CONSTRAINT `users` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users2` FOREIGN KEY (`assigned_id`) REFERENCES `users` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `tasks`
--
LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */
;
INSERT INTO `tasks`
VALUES (
    2,
    '08:00:00',
    '19:00:00',
    1,
    2,
    'html',
    'дизайн главной страницы'
  ),
(
    3,
    '08:00:00',
    '21:00:00',
    1,
    2,
    'htmx',
    'внедрение golang в html'
  ),
(
    4,
    '11:00:00',
    '13:00:00',
    1,
    2,
    'sql',
    'создание архитектуры БД'
  ),
(
    5,
    '11:00:00',
    '16:00:00',
    1,
    3,
    'backend',
    'создание сервера'
  ),
(
    6,
    '16:00:00',
    '20:00:00',
    3,
    3,
    'тесты',
    'тестирование кода'
  ),
(
    7,
    '11:00:00',
    '16:00:00',
    3,
    1,
    'CHANGE TITLE',
    'soon'
  );
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `tasks_labels`
--
DROP TABLE IF EXISTS `tasks_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `tasks_labels` (
  `label_id` int NOT NULL,
  `tasks_id` int NOT NULL,
  PRIMARY KEY (`tasks_id`, `label_id`),
  KEY `labels` (`label_id`),
  CONSTRAINT `labels` FOREIGN KEY (`label_id`) REFERENCES `labels` (`id`),
  CONSTRAINT `tasks` FOREIGN KEY (`tasks_id`) REFERENCES `tasks` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `tasks_labels`
--
LOCK TABLES `tasks_labels` WRITE;
/*!40000 ALTER TABLE `tasks_labels` DISABLE KEYS */
;
INSERT INTO `tasks_labels`
VALUES (1, 3),
(2, 2),
(2, 3),
(3, 4);
/*!40000 ALTER TABLE `tasks_labels` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `users`
--
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */
;
INSERT INTO `users`
VALUES (1, 'Alexander'),
(2, 'Vasiliy'),
(3, 'Slava'),
(4, 'Pavel'),
(5, 'Alex');
/*!40000 ALTER TABLE `users` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2023-09-02 16:10:34