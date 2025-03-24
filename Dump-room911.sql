/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sigpuertomar
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `asunto` varchar(255) NOT NULL,
  `fecha_hora` datetime DEFAULT NULL,
  `state_id` bigint(20) unsigned NOT NULL COMMENT 'Creada para Estado de Cita',
  `client_id` bigint(20) unsigned NOT NULL COMMENT 'Creada para Cliente',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_state_id_foreign` (`state_id`),
  KEY `appointments_client_id_foreign` (`client_id`),
  CONSTRAINT `appointments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `appointments_state_id_foreign` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL COMMENT 'Cliente al que pertenece la sucursal',
  `branch_number` varchar(255) NOT NULL COMMENT 'Número único de la sucursal',
  `name` varchar(255) NOT NULL COMMENT 'Nombre de la sucursal',
  `address` varchar(255) NOT NULL COMMENT 'Dirección de la sucursal',
  `municipality_id` bigint(20) unsigned NOT NULL COMMENT 'Municipio de la sucursal',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1: Activo, 2: Inactivo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branches_client_id_foreign` (`client_id`),
  KEY `branches_municipality_id_foreign` (`municipality_id`),
  CONSTRAINT `branches_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `branches_municipality_id_foreign` FOREIGN KEY (`municipality_id`) REFERENCES `municipalities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_inventories`
--

DROP TABLE IF EXISTS `client_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_inventories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_inventories_client_id_foreign` (`client_id`),
  KEY `client_inventories_product_id_foreign` (`product_id`),
  CONSTRAINT `client_inventories_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `client_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_inventories`
--

LOCK TABLES `client_inventories` WRITE;
/*!40000 ALTER TABLE `client_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `identification` bigint(20) NOT NULL,
  `type_identification` varchar(255) NOT NULL,
  `name_contact` varchar(255) DEFAULT NULL,
  `phone_contact` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 6 COMMENT 'Usuario asignado al cliente',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_identification_unique` (`identification`),
  KEY `clients_user_id_foreign` (`user_id`),
  CONSTRAINT `clients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customs_guidelines`
--

DROP TABLE IF EXISTS `customs_guidelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customs_guidelines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `guideline_number` varchar(255) NOT NULL,
  `document` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customs_guidelines_nationalization_id_foreign` (`nationalization_id`),
  CONSTRAINT `customs_guidelines_nationalization_id_foreign` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customs_guidelines`
--

LOCK TABLES `customs_guidelines` WRITE;
/*!40000 ALTER TABLE `customs_guidelines` DISABLE KEYS */;
/*!40000 ALTER TABLE `customs_guidelines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_signatures`
--

DROP TABLE IF EXISTS `delivery_signatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_signatures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `remission_id` bigint(20) unsigned NOT NULL,
  `signature_image` varchar(255) DEFAULT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `delivery_signatures_remission_id_foreign` (`remission_id`),
  CONSTRAINT `delivery_signatures_remission_id_foreign` FOREIGN KEY (`remission_id`) REFERENCES `remissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_signatures`
--

LOCK TABLES `delivery_signatures` WRITE;
/*!40000 ALTER TABLE `delivery_signatures` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_signatures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicators`
--

DROP TABLE IF EXISTS `indicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `indicator_name` varchar(255) NOT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicators`
--

LOCK TABLES `indicators` WRITE;
/*!40000 ALTER TABLE `indicators` DISABLE KEYS */;
/*!40000 ALTER TABLE `indicators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories`
--

DROP TABLE IF EXISTS `inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `levante` varchar(255) NOT NULL COMMENT 'Levante de Cantidad nacionalizada inicial',
  `batch_number` varchar(255) NOT NULL,
  `quantity` int(10) unsigned NOT NULL COMMENT 'Cantidad nacionalizada actual después de los movimientos',
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `expiration_date` date NOT NULL,
  `warehouse_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventories_nationalization_id_foreign` (`nationalization_id`),
  KEY `inventories_product_id_foreign` (`product_id`),
  KEY `inventories_vehicle_id_foreign` (`vehicle_id`),
  KEY `inventories_warehouse_id_foreign` (`warehouse_id`),
  CONSTRAINT `inventories_nationalization_id_foreign` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventories_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inventories_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories`
--

LOCK TABLES `inventories` WRITE;
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logistic_operators`
--

DROP TABLE IF EXISTS `logistic_operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logistic_operators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `logistic_operators_name_unique` (`name`),
  UNIQUE KEY `logistic_operators_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logistic_operators`
--

LOCK TABLES `logistic_operators` WRITE;
/*!40000 ALTER TABLE `logistic_operators` DISABLE KEYS */;
/*!40000 ALTER TABLE `logistic_operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_time` timestamp NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_user_id_foreign` (`user_id`),
  CONSTRAINT `logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2019_06_14_205413_create_municipalities_table',1),
(4,'2019_08_19_000000_create_failed_jobs_table',1),
(5,'2024_04_23_101019_create_states_table',1),
(6,'2024_07_25_234056_create_products_brands_table',1),
(7,'2024_07_25_234156_create_products_types_table',1),
(8,'2024_07_25_234256_create_products_liquids_table',1),
(9,'2024_07_25_234356_create_products_table',1),
(10,'2024_07_26_100818_create_clients_table',1),
(11,'2024_07_26_100820_create_branches_table',1),
(12,'2024_07_26_110819_create_appointments_table',1),
(13,'2024_07_27_222250_create_logistic_operators_table',1),
(14,'2024_07_27_222256_create_nationalizations_table',1),
(15,'2024_07_27_231117_create_office_notifications_table',1),
(16,'2024_07_27_232056_create_customs_guidelines_table',1),
(17,'2024_07_27_232107_create_payment_documents_table',1),
(18,'2024_07_27_232110_create_warehouses_table',1),
(19,'2024_07_27_232120_create_vehicles_table',1),
(20,'2024_07_27_232122_create_inventories_table',1),
(21,'2024_07_27_232127_create_routes_table',1),
(22,'2024_07_27_232133_create_order_of_loadings_table',1),
(23,'2024_07_27_232137_create_order_of_loading_nationalizations_table',1),
(24,'2024_07_27_232142_create_remissions_table',1),
(25,'2024_07_27_232153_create_delivery_signatures_table',1),
(26,'2024_07_27_232157_create_vehicle_trackings_table',1),
(27,'2024_07_27_232237_create_client_inventories_table',1),
(28,'2024_07_27_232251_create_movements_table',1),
(29,'2024_07_27_232255_create_reports_table',1),
(30,'2024_07_27_232258_create_indicators_table',1),
(31,'2024_08_03_063214_create_permission_table',1),
(32,'2024_08_07_211548_add_additional_fields_to_users_table',1),
(33,'2024_08_09_051548_create_logs_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES
(1,'App\\Models\\User',1),
(2,'App\\Models\\User',2),
(3,'App\\Models\\User',3),
(4,'App\\Models\\User',4),
(4,'App\\Models\\User',5),
(5,'App\\Models\\User',6),
(5,'App\\Models\\User',7),
(5,'App\\Models\\User',8),
(6,'App\\Models\\User',9);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movements`
--

DROP TABLE IF EXISTS `movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `inventory_id` bigint(20) unsigned NOT NULL,
  `order_of_loading_id` bigint(20) unsigned DEFAULT NULL,
  `movement_type` enum('in','out') NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Saldo de producto después del movimiento',
  `type_document` varchar(255) DEFAULT NULL COMMENT 'tipo de documento y operacion que realiza el movimiento',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `1` (`nationalization_id`),
  KEY `movements_inventory_id_foreign` (`inventory_id`),
  KEY `movements_order_of_loading_id_foreign` (`order_of_loading_id`),
  CONSTRAINT `1` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`),
  CONSTRAINT `movements_inventory_id_foreign` FOREIGN KEY (`inventory_id`) REFERENCES `inventories` (`id`),
  CONSTRAINT `movements_order_of_loading_id_foreign` FOREIGN KEY (`order_of_loading_id`) REFERENCES `order_of_loadings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movements`
--

LOCK TABLES `movements` WRITE;
/*!40000 ALTER TABLE `movements` DISABLE KEYS */;
/*!40000 ALTER TABLE `movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipalities`
--

DROP TABLE IF EXISTS `municipalities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipalities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL COMMENT 'Departamento al que pertenece el municipio',
  `name` varchar(255) NOT NULL,
  `code` char(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipalities`
--

LOCK TABLES `municipalities` WRITE;
/*!40000 ALTER TABLE `municipalities` DISABLE KEYS */;
INSERT INTO `municipalities` VALUES
(1,2,'Medellín','05001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(2,2,'Abejorral','05002','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(3,2,'Abriaquí','05004','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(4,2,'Alejandría','05021','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(5,2,'Amagá','05030','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(6,2,'Amalfi','05031','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(7,2,'Andes','05034','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(8,2,'Angelópolis','05036','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(9,2,'Angostura','05038','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(10,2,'Anorí','05040','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(11,2,'Santa Fé De Antioquia','05042','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(12,2,'Anzá','05044','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(13,2,'Apartadó','05045','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(14,2,'Arboletes','05051','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(15,2,'Argelia','05055','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(16,2,'Armenia','05059','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(17,2,'Barbosa','05079','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(18,2,'Belmira','05086','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(19,2,'Bello','05088','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(20,2,'Betania','05091','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(21,2,'Betulia','05093','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(22,2,'Ciudad Bolívar ','05101','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(23,2,'Briceño','05107','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(24,2,'Buriticá','05113','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(25,2,'Cáceres','05120','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(26,2,'Caicedo','05125','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(27,2,'Caldas','05129','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(28,2,'Campamento','05134','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(29,2,'Cañasgordas','05138','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(30,2,'Caracolí','05142','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(31,2,'Caramanta','05145','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(32,2,'Carepa','05147','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(33,2,'El Carmen De Viboral','05148','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(34,2,'Carolina','05150','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(35,2,'Caucasia','05154','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(36,2,'Chigorodó','05172','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(37,2,'Cisneros','05190','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(38,2,'Cocorná','05197','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(39,2,'Concepción','05206','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(40,2,'Concordia','05209','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(41,2,'Copacabana','05212','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(42,2,'Dabeiba','05234','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(43,2,'Donmatías','05237','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(44,2,'Ebéjico','05240','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(45,2,'El Bagre ','05250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(46,2,'Entrerríos','05264','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(47,2,'Envigado','05266','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(48,2,'Fredonia','05282','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(49,2,'Frontino','05284','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(50,2,'Giraldo','05306','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(51,2,'Girardota','05308','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(52,2,'Gómez Plata ','05310','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(53,2,'Granada','05313','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(54,2,'Guadalupe','05315','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(55,2,'Guarne','05318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(56,2,'Guatapé','05321','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(57,2,'Heliconia','05347','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(58,2,'Hispania','05353','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(59,2,'Itagüí','05360','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(60,2,'Ituango','05361','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(61,2,'Jardín','05364','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(62,2,'Jericó','05368','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(63,2,'La Ceja ','05376','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(64,2,'La Estrella ','05380','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(65,2,'La Pintada ','05390','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(66,2,'La Unión ','05400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(67,2,'Liborina','05411','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(68,2,'Maceo','05425','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(69,2,'Marinilla','05440','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(70,2,'Montebello','05467','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(71,2,'Murindó','05475','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(72,2,'Mutatá','05480','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(73,2,'Nariño','05483','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(74,2,'Necoclí','05490','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(75,2,'Nechí','05495','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(76,2,'Olaya','05501','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(77,2,'Peñol','05541','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(78,2,'Peque','05543','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(79,2,'Pueblorrico','05576','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(80,2,'Puerto Berrío ','05579','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(81,2,'Puerto Nare ','05585','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(82,2,'Puerto Triunfo ','05591','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(83,2,'Remedios','05604','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(84,2,'Retiro','05607','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(85,2,'Rionegro','05615','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(86,2,'Sabanalarga','05628','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(87,2,'Sabaneta','05631','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(88,2,'Salgar','05642','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(89,2,'San Andrés De Cuerquía','05647','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(90,2,'San Carlos ','05649','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(91,2,'San Francisco ','05652','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(92,2,'San Jerónimo ','05656','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(93,2,'San José De La Montaña ','05658','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(94,2,'San Juan De Urabá','05659','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(95,2,'San Luis ','05660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(96,2,'San Pedro De Los Milagros ','05664','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(97,2,'San Pedro De Urabá','05665','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(98,2,'San Rafael ','05667','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(99,2,'San Roque ','05670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(100,2,'San Vicente Ferrer','05674','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(101,2,'Santa Bárbara ','05679','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(102,2,'Santa Rosa De Osos','05686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(103,2,'Santo Domingo ','05690','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(104,2,'El Santuario ','05697','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(105,2,'Segovia','05736','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(106,2,'Sonsón','05756','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(107,2,'Sopetrán','05761','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(108,2,'Támesis','05789','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(109,2,'Tarazá','05790','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(110,2,'Tarso','05792','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(111,2,'Titiribí','05809','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(112,2,'Toledo','05819','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(113,2,'Turbo','05837','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(114,2,'Uramita','05842','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(115,2,'Urrao','05847','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(116,2,'Valdivia','05854','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(117,2,'Valparaíso','05856','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(118,2,'Vegachí','05858','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(119,2,'Venecia','05861','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(120,2,'Vigía Del Fuerte','05873','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(121,2,'Yalí','05885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(122,2,'Yarumal','05887','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(123,2,'Yolombó','05890','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(124,2,'Yondó','05893','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(125,2,'Zaragoza','05895','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(126,4,'Barranquilla','08001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(127,4,'Baranoa','08078','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(128,4,'Campo De La Cruz','08137','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(129,4,'Candelaria','08141','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(130,4,'Galapa','08296','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(131,4,'Juan De Acosta','08372','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(132,4,'Luruaco','08421','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(133,4,'Malambo','08433','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(134,4,'Manatí','08436','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(135,4,'Palmar De Varela','08520','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(136,4,'Piojó','08549','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(137,4,'Polonuevo','08558','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(138,4,'Ponedera','08560','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(139,4,'Puerto Colombia ','08573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(140,4,'Repelón','08606','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(141,4,'Sabanagrande','08634','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(142,4,'Sabanalarga','08638','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(143,4,'Santa Lucía ','08675','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(144,4,'Santo Tomás ','08685','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(145,4,'Soledad','08758','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(146,4,'Suan','08770','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(147,4,'Tubará','08832','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(148,4,'Usiacurí','08849','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(149,5,'Bogotá, D.c. ','11001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(150,6,'Cartagena De Indias','13001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(151,6,'Achí','13006','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(152,6,'Altos Del Rosario','13030','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(153,6,'Arenal','13042','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(154,6,'Arjona','13052','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(155,6,'Arroyohondo','13062','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(156,6,'Barranco De Loba','13074','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(157,6,'Calamar','13140','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(158,6,'Cantagallo','13160','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(159,6,'Cicuco','13188','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(160,6,'Córdoba','13212','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(161,6,'Clemencia','13222','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(162,6,'El Carmen De Bolívar','13244','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(163,6,'El Guamo ','13248','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(164,6,'El Peñón ','13268','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(165,6,'Hatillo De Loba','13300','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(166,6,'Magangué','13430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(167,6,'Mahates','13433','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(168,6,'Margarita','13440','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(169,6,'María La Baja','13442','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(170,6,'Montecristo','13458','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(171,6,'Mompós','13468','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(172,6,'Morales','13473','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(173,6,'Norosí','13490','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(174,6,'Pinillos','13549','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(175,6,'Regidor','13580','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(176,6,'Río Viejo ','13600','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(177,6,'San Cristóbal ','13620','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(178,6,'San Estanislao ','13647','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(179,6,'San Fernando ','13650','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(180,6,'San Jacinto ','13654','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(181,6,'San Jacinto Del Cauca','13655','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(182,6,'San Juan Nepomuceno','13657','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(183,6,'San Martín De Loba','13667','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(184,6,'San Pablo ','13670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(185,6,'Santa Catalina ','13673','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(186,6,'Santa Rosa ','13683','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(187,6,'Santa Rosa Del Sur','13688','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(188,6,'Simití','13744','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(189,6,'Soplaviento','13760','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(190,6,'Talaigua Nuevo ','13780','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(191,6,'Tiquisio','13810','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(192,6,'Turbaco','13836','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(193,6,'Turbaná','13838','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(194,6,'Villanueva','13873','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(195,6,'Zambrano','13894','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(196,7,'Tunja','15001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(197,7,'Almeida','15022','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(198,7,'Aquitania','15047','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(199,7,'Arcabuco','15051','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(200,7,'Belén','15087','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(201,7,'Berbeo','15090','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(202,7,'Betéitiva','15092','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(203,7,'Boavita','15097','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(204,7,'Boyacá','15104','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(205,7,'Briceño','15106','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(206,7,'Buenavista','15109','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(207,7,'Busbanzá','15114','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(208,7,'Caldas','15131','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(209,7,'Campohermoso','15135','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(210,7,'Cerinza','15162','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(211,7,'Chinavita','15172','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(212,7,'Chiquinquirá','15176','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(213,7,'Chiscas','15180','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(214,7,'Chita','15183','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(215,7,'Chitaraque','15185','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(216,7,'Chivatá','15187','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(217,7,'Ciénega','15189','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(218,7,'Cómbita','15204','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(219,7,'Coper','15212','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(220,7,'Corrales','15215','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(221,7,'Covarachía','15218','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(222,7,'Cubará','15223','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(223,7,'Cucaita','15224','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(224,7,'Cuítiva','15226','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(225,7,'Chíquiza','15232','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(226,7,'Chivor','15236','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(227,7,'Duitama','15238','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(228,7,'El Cocuy ','15244','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(229,7,'El Espino ','15248','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(230,7,'Firavitoba','15272','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(231,7,'Floresta','15276','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(232,7,'Gachantivá','15293','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(233,7,'Gámeza','15296','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(234,7,'Garagoa','15299','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(235,7,'Guacamayas','15317','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(236,7,'Guateque','15322','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(237,7,'Guayatá','15325','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(238,7,'Güicán De La Sierra','15332','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(239,7,'Iza','15362','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(240,7,'Jenesano','15367','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(241,7,'Jericó','15368','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(242,7,'Labranzagrande','15377','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(243,7,'La Capilla ','15380','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(244,7,'La Victoria ','15401','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(245,7,'La Uvita ','15403','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(246,7,'Villa De Leyva','15407','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(247,7,'Macanal','15425','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(248,7,'Maripí','15442','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(249,7,'Miraflores','15455','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(250,7,'Mongua','15464','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(251,7,'Monguí','15466','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(252,7,'Moniquirá','15469','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(253,7,'Motavita','15476','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(254,7,'Muzo','15480','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(255,7,'Nobsa','15491','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(256,7,'Nuevo Colón ','15494','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(257,7,'Oicatá','15500','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(258,7,'Otanche','15507','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(259,7,'Pachavita','15511','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(260,7,'Páez','15514','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(261,7,'Paipa','15516','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(262,7,'Pajarito','15518','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(263,7,'Panqueba','15522','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(264,7,'Pauna','15531','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(265,7,'Paya','15533','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(266,7,'Paz De Río','15537','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(267,7,'Pesca','15542','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(268,7,'Pisba','15550','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(269,7,'Puerto Boyacá ','15572','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(270,7,'Quípama','15580','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(271,7,'Ramiriquí','15599','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(272,7,'Ráquira','15600','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(273,7,'Rondón','15621','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(274,7,'Saboyá','15632','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(275,7,'Sáchica','15638','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(276,7,'Samacá','15646','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(277,7,'San Eduardo ','15660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(278,7,'San José De Pare','15664','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(279,7,'San Luis De Gaceno','15667','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(280,7,'San Mateo ','15673','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(281,7,'San Miguel De Sema','15676','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(282,7,'San Pablo De Borbur','15681','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(283,7,'Santana','15686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(284,7,'Santa María ','15690','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(285,7,'Santa Rosa De Viterbo','15693','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(286,7,'Santa Sofía ','15696','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(287,7,'Sativanorte','15720','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(288,7,'Sativasur','15723','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(289,7,'Siachoque','15740','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(290,7,'Soatá','15753','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(291,7,'Socotá','15755','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(292,7,'Socha','15757','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(293,7,'Sogamoso','15759','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(294,7,'Somondoco','15761','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(295,7,'Sora','15762','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(296,7,'Sotaquirá','15763','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(297,7,'Soracá','15764','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(298,7,'Susacón','15774','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(299,7,'Sutamarchán','15776','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(300,7,'Sutatenza','15778','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(301,7,'Tasco','15790','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(302,7,'Tenza','15798','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(303,7,'Tibaná','15804','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(304,7,'Tibasosa','15806','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(305,7,'Tinjacá','15808','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(306,7,'Tipacoque','15810','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(307,7,'Toca','15814','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(308,7,'Togüí','15816','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(309,7,'Tópaga','15820','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(310,7,'Tota','15822','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(311,7,'Tununguá','15832','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(312,7,'Turmequé','15835','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(313,7,'Tuta','15837','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(314,7,'Tutazá','15839','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(315,7,'Úmbita','15842','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(316,7,'Ventaquemada','15861','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(317,7,'Viracachá','15879','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(318,7,'Zetaquira','15897','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(319,8,'Manizales','17001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(320,8,'Aguadas','17013','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(321,8,'Anserma','17042','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(322,8,'Aranzazu','17050','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(323,8,'Belalcázar','17088','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(324,8,'Chinchiná','17174','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(325,8,'Filadelfia','17272','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(326,8,'La Dorada ','17380','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(327,8,'La Merced ','17388','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(328,8,'Manzanares','17433','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(329,8,'Marmato','17442','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(330,8,'Marquetalia','17444','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(331,8,'Marulanda','17446','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(332,8,'Neira','17486','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(333,8,'Norcasia','17495','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(334,8,'Pácora','17513','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(335,8,'Palestina','17524','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(336,8,'Pensilvania','17541','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(337,8,'Riosucio','17614','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(338,8,'Risaralda','17616','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(339,8,'Salamina','17653','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(340,8,'Samaná','17662','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(341,8,'San José ','17665','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(342,8,'Supía','17777','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(343,8,'Victoria','17867','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(344,8,'Villamaría','17873','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(345,8,'Viterbo','17877','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(346,9,'Florencia','18001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(347,9,'Albania','18029','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(348,9,'Belén De Los Andaquíes','18094','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(349,9,'Cartagena Del Chairá','18150','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(350,9,'Curillo','18205','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(351,9,'El Doncello ','18247','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(352,9,'El Paujíl ','18256','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(353,9,'La Montañita ','18410','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(354,9,'Milán','18460','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(355,9,'Morelia','18479','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(356,9,'Puerto Rico ','18592','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(357,9,'San José Del Fragua','18610','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(358,9,'San Vicente Del Caguán','18753','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(359,9,'Solano','18756','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(360,9,'Solita','18785','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(361,9,'Valparaíso','18860','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(362,11,'Popayán','19001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(363,11,'Almaguer','19022','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(364,11,'Argelia','19050','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(365,11,'Balboa','19075','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(366,11,'Bolívar','19100','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(367,11,'Buenos Aires ','19110','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(368,11,'Cajibío','19130','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(369,11,'Caldono','19137','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(370,11,'Caloto','19142','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(371,11,'Corinto','19212','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(372,11,'El Tambo ','19256','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(373,11,'Florencia','19290','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(374,11,'Guachené','19300','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(375,11,'Guapí','19318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(376,11,'Inzá','19355','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(377,11,'Jambaló','19364','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(378,11,'La Sierra ','19392','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(379,11,'La Vega ','19397','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(380,11,'López De Micay','19418','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(381,11,'Mercaderes','19450','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(382,11,'Miranda','19455','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(383,11,'Morales','19473','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(384,11,'Padilla','19513','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(385,11,'Páez','19517','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(386,11,'Patía','19532','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(387,11,'Piamonte','19533','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(388,11,'Piendamó - Tunía','19548','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(389,11,'Puerto Tejada ','19573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(390,11,'Puracé','19585','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(391,11,'Rosas','19622','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(392,11,'San Sebastián ','19693','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(393,11,'Santander De Quilichao','19698','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(394,11,'Santa Rosa ','19701','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(395,11,'Silvia','19743','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(396,11,'Sotara','19760','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(397,11,'Suárez','19780','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(398,11,'Sucre','19785','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(399,11,'Timbío','19807','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(400,11,'Timbiquí','19809','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(401,11,'Toribío','19821','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(402,11,'Totoró','19824','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(403,11,'Villa Rica ','19845','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(404,12,'Valledupar','20001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(405,12,'Aguachica','20011','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(406,12,'Agustín Codazzi ','20013','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(407,12,'Astrea','20032','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(408,12,'Becerril','20045','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(409,12,'Bosconia','20060','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(410,12,'Chimichagua','20175','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(411,12,'Chiriguaná','20178','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(412,12,'Curumaní','20228','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(413,12,'El Copey ','20238','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(414,12,'El Paso ','20250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(415,12,'Gamarra','20295','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(416,12,'González','20310','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(417,12,'La Gloria ','20383','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(418,12,'La Jagua De Ibirico','20400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(419,12,'Manaure Balcón Del Cesar','20443','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(420,12,'Pailitas','20517','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(421,12,'Pelaya','20550','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(422,12,'Pueblo Bello ','20570','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(423,12,'Río De Oro','20614','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(424,12,'La Paz ','20621','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(425,12,'San Alberto ','20710','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(426,12,'San Diego ','20750','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(427,12,'San Martín ','20770','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(428,12,'Tamalameque','20787','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(429,14,'Montería','23001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(430,14,'Ayapel','23068','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(431,14,'Buenavista','23079','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(432,14,'Canalete','23090','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(433,14,'Cereté','23162','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(434,14,'Chimá','23168','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(435,14,'Chinú','23182','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(436,14,'Ciénaga De Oro','23189','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(437,14,'Cotorra','23300','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(438,14,'La Apartada ','23350','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(439,14,'Lorica','23417','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(440,14,'Los Córdobas ','23419','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(441,14,'Momil','23464','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(442,14,'Montelíbano','23466','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(443,14,'Moñitos','23500','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(444,14,'Planeta Rica ','23555','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(445,14,'Pueblo Nuevo ','23570','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(446,14,'Puerto Escondido ','23574','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(447,14,'Puerto Libertador ','23580','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(448,14,'Purísima De La Concepción','23586','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(449,14,'Sahagún','23660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(450,14,'San Andrés De Sotavento','23670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(451,14,'San Antero ','23672','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(452,14,'San Bernardo Del Viento','23675','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(453,14,'San Carlos ','23678','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(454,14,'San José De Uré','23682','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(455,14,'San Pelayo ','23686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(456,14,'Tierralta','23807','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(457,14,'Tuchín','23815','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(458,14,'Valencia','23855','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(459,15,'Agua De Dios','25001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(460,15,'Albán','25019','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(461,15,'Anapoima','25035','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(462,15,'Anolaima','25040','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(463,15,'Arbeláez','25053','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(464,15,'Beltrán','25086','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(465,15,'Bituima','25095','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(466,15,'Bojacá','25099','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(467,15,'Cabrera','25120','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(468,15,'Cachipay','25123','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(469,15,'Cajicá','25126','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(470,15,'Caparrapí','25148','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(471,15,'Cáqueza','25151','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(472,15,'Carmen De Carupa','25154','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(473,15,'Chaguaní','25168','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(474,15,'Chía','25175','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(475,15,'Chipaque','25178','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(476,15,'Choachí','25181','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(477,15,'Chocontá','25183','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(478,15,'Cogua','25200','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(479,15,'Cota','25214','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(480,15,'Cucunubá','25224','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(481,15,'El Colegio ','25245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(482,15,'El Peñón ','25258','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(483,15,'El Rosal ','25260','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(484,15,'Facatativá','25269','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(485,15,'Fómeque','25279','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(486,15,'Fosca','25281','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(487,15,'Funza','25286','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(488,15,'Fúquene','25288','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(489,15,'Fusagasugá','25290','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(490,15,'Gachalá','25293','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(491,15,'Gachancipá','25295','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(492,15,'Gachetá','25297','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(493,15,'Gama','25299','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(494,15,'Girardot','25307','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(495,15,'Granada','25312','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(496,15,'Guachetá','25317','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(497,15,'Guaduas','25320','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(498,15,'Guasca','25322','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(499,15,'Guataquí','25324','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(500,15,'Guatavita','25326','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(501,15,'Guayabal De Síquima','25328','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(502,15,'Guayabetal','25335','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(503,15,'Gutiérrez','25339','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(504,15,'Jerusalén','25368','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(505,15,'Junín','25372','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(506,15,'La Calera ','25377','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(507,15,'La Mesa ','25386','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(508,15,'La Palma ','25394','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(509,15,'La Peña ','25398','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(510,15,'La Vega ','25402','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(511,15,'Lenguazaque','25407','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(512,15,'Machetá','25426','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(513,15,'Madrid','25430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(514,15,'Manta','25436','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(515,15,'Medina','25438','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(516,15,'Mosquera','25473','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(517,15,'Nariño','25483','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(518,15,'Nemocón','25486','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(519,15,'Nilo','25488','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(520,15,'Nimaima','25489','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(521,15,'Nocaima','25491','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(522,15,'Venecia','25506','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(523,15,'Pacho','25513','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(524,15,'Paime','25518','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(525,15,'Pandi','25524','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(526,15,'Paratebueno','25530','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(527,15,'Pasca','25535','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(528,15,'Puerto Salgar ','25572','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(529,15,'Pulí','25580','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(530,15,'Quebradanegra','25592','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(531,15,'Quetame','25594','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(532,15,'Quipile','25596','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(533,15,'Apulo','25599','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(534,15,'Ricaurte','25612','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(535,15,'San Antonio Del Tequendama','25645','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(536,15,'San Bernardo ','25649','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(537,15,'San Cayetano ','25653','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(538,15,'San Francisco ','25658','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(539,15,'San Juan De Rioseco','25662','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(540,15,'Sasaima','25718','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(541,15,'Sesquilé','25736','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(542,15,'Sibaté','25740','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(543,15,'Silvania','25743','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(544,15,'Simijaca','25745','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(545,15,'Soacha','25754','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(546,15,'Sopó','25758','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(547,15,'Subachoque','25769','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(548,15,'Suesca','25772','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(549,15,'Supatá','25777','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(550,15,'Susa','25779','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(551,15,'Sutatausa','25781','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(552,15,'Tabio','25785','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(553,15,'Tausa','25793','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(554,15,'Tena','25797','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(555,15,'Tenjo','25799','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(556,15,'Tibacuy','25805','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(557,15,'Tibirita','25807','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(558,15,'Tocaima','25815','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(559,15,'Tocancipá','25817','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(560,15,'Topaipí','25823','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(561,15,'Ubalá','25839','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(562,15,'Ubaque','25841','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(563,15,'Villa De San Diego De Ubaté','25843','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(564,15,'Une','25845','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(565,15,'Útica','25851','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(566,15,'Vergara','25862','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(567,15,'Vianí','25867','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(568,15,'Villagómez','25871','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(569,15,'Villapinzón','25873','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(570,15,'Villeta','25875','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(571,15,'Viotá','25878','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(572,15,'Yacopí','25885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(573,15,'Zipacón','25898','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(574,15,'Zipaquirá','25899','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(575,13,'Quibdó','27001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(576,13,'Acandí','27006','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(577,13,'Alto Baudó ','27025','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(578,13,'Atrato','27050','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(579,13,'Bagadó','27073','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(580,13,'Bahía Solano ','27075','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(581,13,'Bajo Baudó ','27077','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(582,13,'Bojayá','27099','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(583,13,'El Cantón Del San Pablo ','27135','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(584,13,'Carmen Del Darién','27150','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(585,13,'Cértegui','27160','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(586,13,'Condoto','27205','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(587,13,'El Carmen De Atrato','27245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(588,13,'El Litoral Del San Juan ','27250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(589,13,'Istmina','27361','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(590,13,'Juradó','27372','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(591,13,'Lloró','27413','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(592,13,'Medio Atrato ','27425','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(593,13,'Medio Baudó ','27430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(594,13,'Medio San Juan','27450','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(595,13,'Nóvita','27491','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(596,13,'Nuquí','27495','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(597,13,'Río Iró ','27580','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(598,13,'Río Quito ','27600','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(599,13,'Riosucio','27615','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(600,13,'San José Del Palmar','27660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(601,13,'Sipí','27745','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(602,13,'Tadó','27787','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(603,13,'Unguía','27800','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(604,13,'Unión Panamericana ','27810','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(605,18,'Neiva','41001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(606,18,'Acevedo','41006','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(607,18,'Agrado','41013','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(608,18,'Aipe','41016','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(609,18,'Algeciras','41020','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(610,18,'Altamira','41026','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(611,18,'Baraya','41078','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(612,18,'Campoalegre','41132','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(613,18,'Colombia','41206','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(614,18,'Elías','41244','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(615,18,'Garzón','41298','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(616,18,'Gigante','41306','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(617,18,'Guadalupe','41319','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(618,18,'Hobo','41349','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(619,18,'Íquira','41357','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(620,18,'Isnos','41359','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(621,18,'La Argentina ','41378','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(622,18,'La Plata ','41396','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(623,18,'Nátaga','41483','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(624,18,'Oporapa','41503','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(625,18,'Paicol','41518','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(626,18,'Palermo','41524','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(627,18,'Palestina','41530','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(628,18,'Pital','41548','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(629,18,'Pitalito','41551','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(630,18,'Rivera','41615','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(631,18,'Saladoblanco','41660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(632,18,'San Agustín ','41668','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(633,18,'Santa María ','41676','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(634,18,'Suaza','41770','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(635,18,'Tarqui','41791','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(636,18,'Tesalia','41797','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(637,18,'Tello','41799','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(638,18,'Teruel','41801','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(639,18,'Timaná','41807','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(640,18,'Villavieja','41872','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(641,18,'Yaguará','41885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(642,19,'Riohacha','44001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(643,19,'Albania','44035','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(644,19,'Barrancas','44078','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(645,19,'Dibulla','44090','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(646,19,'Distracción','44098','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(647,19,'El Molino ','44110','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(648,19,'Fonseca','44279','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(649,19,'Hatonuevo','44378','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(650,19,'La Jagua Del Pilar','44420','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(651,19,'Maicao','44430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(652,19,'Manaure','44560','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(653,19,'San Juan Del Cesar','44650','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(654,19,'Uribia','44847','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(655,19,'Urumita','44855','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(656,19,'Villanueva','44874','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(657,20,'Santa Marta ','47001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(658,20,'Algarrobo','47030','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(659,20,'Aracataca','47053','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(660,20,'Ariguaní','47058','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(661,20,'Cerro De San Antonio','47161','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(662,20,'Chivolo','47170','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(663,20,'Ciénaga','47189','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(664,20,'Concordia','47205','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(665,20,'El Banco ','47245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(666,20,'El Piñón ','47258','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(667,20,'El Retén ','47268','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(668,20,'Fundación','47288','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(669,20,'Guamal','47318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(670,20,'Nueva Granada ','47460','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(671,20,'Pedraza','47541','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(672,20,'Pijiño Del Carmen','47545','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(673,20,'Pivijay','47551','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(674,20,'Plato','47555','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(675,20,'Puebloviejo','47570','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(676,20,'Remolino','47605','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(677,20,'Sabanas De San Ángel','47660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(678,20,'Salamina','47675','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(679,20,'San Sebastián De Buenavista','47692','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(680,20,'San Zenón ','47703','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(681,20,'Santa Ana ','47707','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(682,20,'Santa Bárbara De Pinto','47720','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(683,20,'Sitionuevo','47745','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(684,20,'Tenerife','47798','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(685,20,'Zapayán','47960','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(686,20,'Zona Bananera ','47980','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(687,21,'Villavicencio','50001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(688,21,'Acacías','50006','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(689,21,'Barranca De Upía','50110','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(690,21,'Cabuyaro','50124','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(691,21,'Castilla La Nueva','50150','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(692,21,'Cubarral','50223','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(693,21,'Cumaral','50226','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(694,21,'El Calvario ','50245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(695,21,'El Castillo ','50251','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(696,21,'El Dorado ','50270','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(697,21,'Fuente De Oro','50287','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(698,21,'Granada','50313','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(699,21,'Guamal','50318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(700,21,'Mapiripán','50325','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(701,21,'Mesetas','50330','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(702,21,'La Macarena ','50350','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(703,21,'Uribe','50370','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(704,21,'Lejanías','50400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(705,21,'Puerto Concordia ','50450','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(706,21,'Puerto Gaitán ','50568','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(707,21,'Puerto López ','50573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(708,21,'Puerto Lleras ','50577','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(709,21,'Puerto Rico ','50590','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(710,21,'Restrepo','50606','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(711,21,'San Carlos De Guaroa','50680','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(712,21,'San Juan De Arama','50683','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(713,21,'San Juanito ','50686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(714,21,'San Martín ','50689','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(715,21,'Vistahermosa','50711','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(716,22,'Pasto','52001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(717,22,'Albán','52019','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(718,22,'Aldana','52022','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(719,22,'Ancuyá','52036','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(720,22,'Arboleda','52051','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(721,22,'Barbacoas','52079','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(722,22,'Belén','52083','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(723,22,'Buesaco','52110','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(724,22,'Colón','52203','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(725,22,'Consacá','52207','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(726,22,'Contadero','52210','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(727,22,'Córdoba','52215','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(728,22,'Cuaspúd','52224','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(729,22,'Cumbal','52227','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(730,22,'Cumbitara','52233','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(731,22,'Chachagüí','52240','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(732,22,'El Charco ','52250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(733,22,'El Peñol ','52254','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(734,22,'El Rosario ','52256','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(735,22,'El Tablón De Gómez','52258','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(736,22,'El Tambo ','52260','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(737,22,'Funes','52287','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(738,22,'Guachucal','52317','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(739,22,'Guaitarilla','52320','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(740,22,'Gualmatán','52323','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(741,22,'Iles','52352','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(742,22,'Imués','52354','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(743,22,'Ipiales','52356','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(744,22,'La Cruz ','52378','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(745,22,'La Florida ','52381','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(746,22,'La Llanada ','52385','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(747,22,'La Tola ','52390','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(748,22,'La Unión ','52399','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(749,22,'Leiva','52405','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(750,22,'Linares','52411','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(751,22,'Los Andes ','52418','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(752,22,'Magüí','52427','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(753,22,'Mallama','52435','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(754,22,'Mosquera','52473','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(755,22,'Nariño','52480','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(756,22,'Olaya Herrera ','52490','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(757,22,'Ospina','52506','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(758,22,'Francisco Pizarro ','52520','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(759,22,'Policarpa','52540','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(760,22,'Potosí','52560','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(761,22,'Providencia','52565','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(762,22,'Puerres','52573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(763,22,'Pupiales','52585','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(764,22,'Ricaurte','52612','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(765,22,'Roberto Payán ','52621','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(766,22,'Samaniego','52678','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(767,22,'Sandoná','52683','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(768,22,'San Bernardo ','52685','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(769,22,'San Lorenzo ','52687','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(770,22,'San Pablo ','52693','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(771,22,'San Pedro De Cartago','52694','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(772,22,'Santa Bárbara ','52696','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(773,22,'Santacruz','52699','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(774,22,'Sapuyes','52720','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(775,22,'Taminango','52786','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(776,22,'Tangua','52788','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(777,22,'San Andrés De Tumaco','52835','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(778,22,'Túquerres','52838','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(779,22,'Yacuanquer','52885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(780,23,'San José De Cúcuta','54001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(781,23,'Ábrego','54003','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(782,23,'Arboledas','54051','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(783,23,'Bochalema','54099','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(784,23,'Bucarasica','54109','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(785,23,'Cácota','54125','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(786,23,'Cáchira','54128','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(787,23,'Chinácota','54172','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(788,23,'Chitagá','54174','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(789,23,'Convención','54206','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(790,23,'Cucutilla','54223','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(791,23,'Durania','54239','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(792,23,'El Carmen ','54245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(793,23,'El Tarra ','54250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(794,23,'El Zulia ','54261','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(795,23,'Gramalote','54313','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(796,23,'Hacarí','54344','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(797,23,'Herrán','54347','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(798,23,'Labateca','54377','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(799,23,'La Esperanza ','54385','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(800,23,'La Playa ','54398','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(801,23,'Los Patios ','54405','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(802,23,'Lourdes','54418','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(803,23,'Mutiscua','54480','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(804,23,'Ocaña','54498','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(805,23,'Pamplona','54518','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(806,23,'Pamplonita','54520','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(807,23,'Puerto Santander ','54553','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(808,23,'Ragonvalia','54599','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(809,23,'Salazar','54660','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(810,23,'San Calixto ','54670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(811,23,'San Cayetano ','54673','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(812,23,'Santiago','54680','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(813,23,'Sardinata','54720','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(814,23,'Silos','54743','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(815,23,'Teorama','54800','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(816,23,'Tibú','54810','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(817,23,'Toledo','54820','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(818,23,'Villa Caro ','54871','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(819,23,'Villa Del Rosario','54874','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(820,25,'Armenia','63001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(821,25,'Buenavista','63111','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(822,25,'Calarcá','63130','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(823,25,'Circasia','63190','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(824,25,'Córdoba','63212','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(825,25,'Filandia','63272','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(826,25,'Génova','63302','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(827,25,'La Tebaida ','63401','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(828,25,'Montenegro','63470','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(829,25,'Pijao','63548','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(830,25,'Quimbaya','63594','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(831,25,'Salento','63690','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(832,26,'Pereira','66001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(833,26,'Apía','66045','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(834,26,'Balboa','66075','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(835,26,'Belén De Umbría','66088','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(836,26,'Dosquebradas','66170','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(837,26,'Guática','66318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(838,26,'La Celia ','66383','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(839,26,'La Virginia ','66400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(840,26,'Marsella','66440','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(841,26,'Mistrató','66456','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(842,26,'Pueblo Rico ','66572','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(843,26,'Quinchía','66594','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(844,26,'Santa Rosa De Cabal','66682','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(845,26,'Santuario','66687','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(846,28,'Bucaramanga','68001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(847,28,'Aguada','68013','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(848,28,'Albania','68020','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(849,28,'Aratoca','68051','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(850,28,'Barbosa','68077','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(851,28,'Barichara','68079','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(852,28,'Barrancabermeja','68081','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(853,28,'Betulia','68092','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(854,28,'Bolívar','68101','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(855,28,'Cabrera','68121','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(856,28,'California','68132','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(857,28,'Capitanejo','68147','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(858,28,'Carcasí','68152','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(859,28,'Cepitá','68160','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(860,28,'Cerrito','68162','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(861,28,'Charalá','68167','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(862,28,'Charta','68169','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(863,28,'Chima','68176','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(864,28,'Chipatá','68179','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(865,28,'Cimitarra','68190','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(866,28,'Concepción','68207','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(867,28,'Confines','68209','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(868,28,'Contratación','68211','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(869,28,'Coromoro','68217','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(870,28,'Curití','68229','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(871,28,'El Carmen De Chucurí','68235','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(872,28,'El Guacamayo ','68245','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(873,28,'El Peñón ','68250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(874,28,'El Playón ','68255','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(875,28,'Encino','68264','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(876,28,'Enciso','68266','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(877,28,'Florián','68271','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(878,28,'Floridablanca','68276','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(879,28,'Galán','68296','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(880,28,'Gámbita','68298','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(881,28,'Girón','68307','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(882,28,'Guaca','68318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(883,28,'Guadalupe','68320','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(884,28,'Guapotá','68322','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(885,28,'Guavatá','68324','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(886,28,'Güepsa','68327','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(887,28,'Hato','68344','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(888,28,'Jesús María ','68368','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(889,28,'Jordán','68370','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(890,28,'La Belleza ','68377','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(891,28,'Landázuri','68385','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(892,28,'La Paz ','68397','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(893,28,'Lebrija','68406','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(894,28,'Los Santos ','68418','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(895,28,'Macaravita','68425','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(896,28,'Málaga','68432','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(897,28,'Matanza','68444','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(898,28,'Mogotes','68464','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(899,28,'Molagavita','68468','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(900,28,'Ocamonte','68498','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(901,28,'Oiba','68500','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(902,28,'Onzaga','68502','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(903,28,'Palmar','68522','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(904,28,'Palmas Del Socorro','68524','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(905,28,'Páramo','68533','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(906,28,'Piedecuesta','68547','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(907,28,'Pinchote','68549','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(908,28,'Puente Nacional ','68572','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(909,28,'Puerto Parra ','68573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(910,28,'Puerto Wilches ','68575','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(911,28,'Rionegro','68615','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(912,28,'Sabana De Torres','68655','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(913,28,'San Andrés ','68669','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(914,28,'San Benito ','68673','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(915,28,'San Gil ','68679','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(916,28,'San Joaquín ','68682','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(917,28,'San José De Miranda','68684','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(918,28,'San Miguel ','68686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(919,28,'San Vicente De Chucurí','68689','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(920,28,'Santa Bárbara ','68705','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(921,28,'Santa Helena Del Opón','68720','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(922,28,'Simacota','68745','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(923,28,'Socorro','68755','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(924,28,'Suaita','68770','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(925,28,'Sucre','68773','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(926,28,'Suratá','68780','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(927,28,'Tona','68820','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(928,28,'Valle De San José','68855','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(929,28,'Vélez','68861','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(930,28,'Vetas','68867','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(931,28,'Villanueva','68872','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(932,28,'Zapatoca','68895','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(933,29,'Sincelejo','70001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(934,29,'Buenavista','70110','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(935,29,'Caimito','70124','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(936,29,'Colosó','70204','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(937,29,'Corozal','70215','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(938,29,'Coveñas','70221','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(939,29,'Chalán','70230','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(940,29,'El Roble ','70233','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(941,29,'Galeras','70235','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(942,29,'Guaranda','70265','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(943,29,'La Unión ','70400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(944,29,'Los Palmitos ','70418','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(945,29,'Majagual','70429','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(946,29,'Morroa','70473','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(947,29,'Ovejas','70508','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(948,29,'Palmito','70523','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(949,29,'Sampués','70670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(950,29,'San Benito Abad','70678','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(951,29,'San Juan De Betulia','70702','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(952,29,'San Marcos ','70708','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(953,29,'San Onofre ','70713','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(954,29,'San Pedro ','70717','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(955,29,'San Luis De Sincé','70742','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(956,29,'Sucre','70771','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(957,29,'Santiago De Tolú','70820','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(958,29,'Tolú Viejo ','70823','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(959,30,'Ibagué','73001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(960,30,'Alpujarra','73024','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(961,30,'Alvarado','73026','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(962,30,'Ambalema','73030','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(963,30,'Anzoátegui','73043','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(964,30,'Armero','73055','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(965,30,'Ataco','73067','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(966,30,'Cajamarca','73124','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(967,30,'Carmen De Apicalá','73148','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(968,30,'Casabianca','73152','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(969,30,'Chaparral','73168','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(970,30,'Coello','73200','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(971,30,'Coyaima','73217','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(972,30,'Cunday','73226','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(973,30,'Dolores','73236','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(974,30,'Espinal','73268','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(975,30,'Falan','73270','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(976,30,'Flandes','73275','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(977,30,'Fresno','73283','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(978,30,'Guamo','73319','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(979,30,'Herveo','73347','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(980,30,'Honda','73349','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(981,30,'Icononzo','73352','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(982,30,'Lérida','73408','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(983,30,'Líbano','73411','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(984,30,'San Sebastián De Mariquita','73443','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(985,30,'Melgar','73449','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(986,30,'Murillo','73461','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(987,30,'Natagaima','73483','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(988,30,'Ortega','73504','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(989,30,'Palocabildo','73520','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(990,30,'Piedras','73547','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(991,30,'Planadas','73555','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(992,30,'Prado','73563','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(993,30,'Purificación','73585','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(994,30,'Rioblanco','73616','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(995,30,'Roncesvalles','73622','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(996,30,'Rovira','73624','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(997,30,'Saldaña','73671','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(998,30,'San Antonio ','73675','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(999,30,'San Luis ','73678','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1000,30,'Santa Isabel ','73686','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1001,30,'Suárez','73770','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1002,30,'Valle De San Juan','73854','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1003,30,'Venadillo','73861','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1004,30,'Villahermosa','73870','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1005,30,'Villarrica','73873','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1006,31,'Cali','76001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1007,31,'Alcalá','76020','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1008,31,'Andalucía','76036','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1009,31,'Ansermanuevo','76041','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1010,31,'Argelia','76054','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1011,31,'Bolívar','76100','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1012,31,'Buenaventura','76109','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1013,31,'Guadalajara De Buga','76111','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1014,31,'Bugalagrande','76113','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1015,31,'Caicedonia','76122','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1016,31,'Calima','76126','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1017,31,'Candelaria','76130','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1018,31,'Cartago','76147','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1019,31,'Dagua','76233','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1020,31,'El Águila ','76243','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1021,31,'El Cairo ','76246','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1022,31,'El Cerrito ','76248','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1023,31,'El Dovio ','76250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1024,31,'Florida','76275','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1025,31,'Ginebra','76306','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1026,31,'Guacarí','76318','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1027,31,'Jamundí','76364','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1028,31,'La Cumbre ','76377','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1029,31,'La Unión ','76400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1030,31,'La Victoria ','76403','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1031,31,'Obando','76497','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1032,31,'Palmira','76520','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1033,31,'Pradera','76563','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1034,31,'Restrepo','76606','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1035,31,'Riofrío','76616','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1036,31,'Roldanillo','76622','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1037,31,'San Pedro ','76670','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1038,31,'Sevilla','76736','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1039,31,'Toro','76823','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1040,31,'Trujillo','76828','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1041,31,'Tuluá','76834','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1042,31,'Ulloa','76845','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1043,31,'Versalles','76863','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1044,31,'Vijes','76869','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1045,31,'Yotoco','76890','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1046,31,'Yumbo','76892','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1047,31,'Zarzal','76895','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1048,3,'Arauca','81001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1049,3,'Arauquita','81065','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1050,3,'Cravo Norte ','81220','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1051,3,'Fortul','81300','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1052,3,'Puerto Rondón ','81591','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1053,3,'Saravena','81736','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1054,3,'Tame','81794','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1055,10,'Yopal','85001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1056,10,'Aguazul','85010','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1057,10,'Chámeza','85015','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1058,10,'Hato Corozal ','85125','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1059,10,'La Salina ','85136','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1060,10,'Maní','85139','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1061,10,'Monterrey','85162','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1062,10,'Nunchía','85225','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1063,10,'Orocué','85230','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1064,10,'Paz De Ariporo','85250','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1065,10,'Pore','85263','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1066,10,'Recetor','85279','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1067,10,'Sabanalarga','85300','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1068,10,'Sácama','85315','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1069,10,'San Luis De Palenque','85325','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1070,10,'Támara','85400','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1071,10,'Tauramena','85410','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1072,10,'Trinidad','85430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1073,10,'Villanueva','85440','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1074,24,'Mocoa','86001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1075,24,'Colón','86219','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1076,24,'Orito','86320','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1077,24,'Puerto Asís ','86568','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1078,24,'Puerto Caicedo ','86569','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1079,24,'Puerto Guzmán ','86571','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1080,24,'Puerto Leguízamo ','86573','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1081,24,'Sibundoy','86749','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1082,24,'San Francisco ','86755','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1083,24,'San Miguel ','86757','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1084,24,'Santiago','86760','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1085,24,'Valle Del Guamuez','86865','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1086,24,'Villagarzón','86885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1087,27,'San Andrés ','88001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1088,27,'Providencia','88564','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1089,1,'Leticia','91001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1090,1,'El Encanto ','91263','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1091,1,'La Chorrera ','91405','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1092,1,'La Pedrera ','91407','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1093,1,'La Victoria ','91430','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1094,1,'Mirití - Paraná','91460','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1095,1,'Puerto Alegría ','91530','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1096,1,'Puerto Arica ','91536','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1097,1,'Puerto Nariño ','91540','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1098,1,'Puerto Santander ','91669','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1099,1,'Tarapacá','91798','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1100,16,'Inírida','94001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1101,16,'Barranco Minas ','94343','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1102,16,'Mapiripana','94663','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1103,16,'San Felipe ','94883','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1104,16,'Puerto Colombia ','94884','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1105,16,'La Guadalupe ','94885','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1106,16,'Cacahual','94886','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1107,16,'Pana Pana ','94887','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1108,16,'Morichal','94888','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1109,17,'San José Del Guaviare','95001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1110,17,'Calamar','95015','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1111,17,'El Retorno ','95025','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1112,17,'Miraflores','95200','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1113,32,'Mitú','97001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1114,32,'Carurú','97161','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1115,32,'Pacoa','97511','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1116,32,'Taraira','97666','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1117,32,'Papunahua','97777','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1118,32,'Yavaraté','97889','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1119,33,'Puerto Carreño ','99001','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1120,33,'La Primavera ','99524','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1121,33,'Santa Rosalía ','99624','2025-03-24 01:26:56','2025-03-24 01:26:56'),
(1122,33,'Cumaribo','99773','2025-03-24 01:26:56','2025-03-24 01:26:56');
/*!40000 ALTER TABLE `municipalities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nationalizations`
--

DROP TABLE IF EXISTS `nationalizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nationalizations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(255) NOT NULL,
  `logistic_operator_id` bigint(20) unsigned NOT NULL,
  `total_amount` decimal(10,2) NOT NULL COMMENT 'Cantidad total a nacionalizar',
  `mci_number` varchar(255) DEFAULT NULL,
  `carta_porte` varchar(255) DEFAULT NULL,
  `health_inspection` varchar(255) DEFAULT NULL COMMENT 'certificado de inspección sanitaria',
  `levantes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`levantes`)),
  `additional_data` text DEFAULT NULL,
  `status` enum('pending','approved','completed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nationalizations_logistic_operator_id_foreign` (`logistic_operator_id`),
  CONSTRAINT `nationalizations_logistic_operator_id_foreign` FOREIGN KEY (`logistic_operator_id`) REFERENCES `logistic_operators` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nationalizations`
--

LOCK TABLES `nationalizations` WRITE;
/*!40000 ALTER TABLE `nationalizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `nationalizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_notifications`
--

DROP TABLE IF EXISTS `office_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `office` varchar(255) NOT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `whatsapp_sent` tinyint(1) NOT NULL DEFAULT 0,
  `response_status` enum('none','ok','not_ok') NOT NULL DEFAULT 'none',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `office_notifications_nationalization_id_foreign` (`nationalization_id`),
  CONSTRAINT `office_notifications_nationalization_id_foreign` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_notifications`
--

LOCK TABLES `office_notifications` WRITE;
/*!40000 ALTER TABLE `office_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_of_loading_nationalizations`
--

DROP TABLE IF EXISTS `order_of_loading_nationalizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_of_loading_nationalizations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_of_loading_id` bigint(20) unsigned NOT NULL,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `inventory_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `route_id` bigint(20) unsigned NOT NULL,
  `type` enum('is_invoice','is_transfer') NOT NULL COMMENT 'is_invoice: Factura, is_transfer: Traslado',
  `type_number` varchar(255) DEFAULT NULL COMMENT 'Número de factura o traslado',
  `previous_balance` int(11) NOT NULL COMMENT 'Saldo anterior del inventario',
  `dispatched_quantity` int(11) NOT NULL COMMENT 'Cantidad despachada del producto',
  `new_balance` int(11) NOT NULL COMMENT 'Saldo restante en el inventario',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_of_loading_nationalizations_order_of_loading_id_foreign` (`order_of_loading_id`),
  KEY `order_of_loading_nationalizations_nationalization_id_foreign` (`nationalization_id`),
  KEY `order_of_loading_nationalizations_inventory_id_foreign` (`inventory_id`),
  KEY `order_of_loading_nationalizations_client_id_foreign` (`client_id`),
  KEY `order_of_loading_nationalizations_branch_id_foreign` (`branch_id`),
  KEY `order_of_loading_nationalizations_route_id_foreign` (`route_id`),
  CONSTRAINT `order_of_loading_nationalizations_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `order_of_loading_nationalizations_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `order_of_loading_nationalizations_inventory_id_foreign` FOREIGN KEY (`inventory_id`) REFERENCES `inventories` (`id`),
  CONSTRAINT `order_of_loading_nationalizations_nationalization_id_foreign` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`),
  CONSTRAINT `order_of_loading_nationalizations_order_of_loading_id_foreign` FOREIGN KEY (`order_of_loading_id`) REFERENCES `order_of_loadings` (`id`),
  CONSTRAINT `order_of_loading_nationalizations_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_of_loading_nationalizations`
--

LOCK TABLES `order_of_loading_nationalizations` WRITE;
/*!40000 ALTER TABLE `order_of_loading_nationalizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_of_loading_nationalizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_of_loadings`
--

DROP TABLE IF EXISTS `order_of_loadings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_of_loadings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL COMMENT 'Fecha de la orden',
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `logistic_operator_id` bigint(20) unsigned NOT NULL,
  `total_quantity` decimal(10,2) NOT NULL COMMENT 'Cantidad total de productos a cargar',
  `total_weight` decimal(10,2) NOT NULL COMMENT 'Peso total de la carga',
  `status` enum('pending','completed') NOT NULL DEFAULT 'pending',
  `compliment` enum('pending','completed') NOT NULL DEFAULT 'pending',
  `document_path` varchar(255) DEFAULT NULL COMMENT 'Ruta del documento cumplido de la orden de carga',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_of_loadings_vehicle_id_foreign` (`vehicle_id`),
  KEY `order_of_loadings_logistic_operator_id_foreign` (`logistic_operator_id`),
  CONSTRAINT `order_of_loadings_logistic_operator_id_foreign` FOREIGN KEY (`logistic_operator_id`) REFERENCES `logistic_operators` (`id`),
  CONSTRAINT `order_of_loadings_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_of_loadings`
--

LOCK TABLES `order_of_loadings` WRITE;
/*!40000 ALTER TABLE `order_of_loadings` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_of_loadings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_documents`
--

DROP TABLE IF EXISTS `payment_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nationalization_id` bigint(20) unsigned NOT NULL,
  `document` varchar(255) NOT NULL,
  `payment_status` enum('pending','paid') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_documents_nationalization_id_foreign` (`nationalization_id`),
  CONSTRAINT `payment_documents_nationalization_id_foreign` FOREIGN KEY (`nationalization_id`) REFERENCES `nationalizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_documents`
--

LOCK TABLES `payment_documents` WRITE;
/*!40000 ALTER TABLE `payment_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'view_rol','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(2,'create_rol','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(3,'edit_rol','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(4,'delete_rol','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(5,'view_users','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(6,'create_users','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(7,'edit_users','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(8,'delete_users','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(9,'view_products','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(10,'create_products','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(11,'edit_products','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(12,'delete_products','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(13,'view_products_brands','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(14,'create_products_brands','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(15,'edit_products_brands','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(16,'delete_products_brands','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(17,'view_products_types','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(18,'create_products_types','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(19,'edit_products_types','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(20,'delete_products_types','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(21,'view_products_liquids','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(22,'create_products_liquids','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(23,'edit_products_liquids','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(24,'delete_products_liquids','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(25,'view_orders','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(26,'create_orders','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(27,'edit_orders','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(28,'delete_orders','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(29,'view_vehicles','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(30,'create_vehicles','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(31,'edit_vehicles','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(32,'delete_vehicles','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(33,'view_vehicle_tracking','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(34,'create_vehicle_tracking','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(35,'edit_vehicle_tracking','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(36,'delete_vehicle_tracking','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(37,'view_reports','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(38,'create_reports','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(39,'edit_reports','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(40,'delete_reports','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(41,'view_logistics','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(42,'create_logistics','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(43,'edit_logistics','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(44,'delete_logistics','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(45,'view_clients','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(46,'create_clients','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(47,'edit_clients','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(48,'delete_clients','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(49,'view_routes','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(50,'create_routes','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(51,'edit_routes','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(52,'delete_routes','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(53,'view_inventory','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(54,'create_inventory','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(55,'edit_inventory','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(56,'delete_inventory','api','2025-03-24 01:26:45','2025-03-24 01:26:45'),
(57,'view_kardex','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(58,'view_remissions','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(59,'create_remissions','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(60,'edit_remissions','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(61,'delete_remissions','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(62,'view_client_inventory','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(63,'create_client_inventory','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(64,'edit_client_inventory','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(65,'delete_client_inventory','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(66,'view_delivery_signature','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(67,'create_delivery_signature','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(68,'view_nationalization','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(69,'create_nationalization','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(70,'edit_nationalization','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(71,'delete_nationalization','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(72,'view_warehouse','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(73,'create_warehouse','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(74,'edit_warehouse','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(75,'delete_warehouse','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(76,'view_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(77,'create_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(78,'edit_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(79,'delete_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(80,'print_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(81,'view_more_inventory','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(82,'view_more_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(83,'status_order_of_loading','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(84,'view_branches','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(85,'create_branches','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(86,'edit_branches','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(87,'delete_branches','api','2025-03-24 01:26:46','2025-03-24 01:26:46');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `quality` varchar(255) DEFAULT NULL,
  `brand_id` bigint(20) unsigned NOT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `liquid_id` bigint(20) unsigned NOT NULL,
  `bar_code` varchar(255) NOT NULL,
  `presentation` varchar(255) NOT NULL,
  `net_weight` decimal(10,2) NOT NULL,
  `drained_weight` decimal(10,2) NOT NULL,
  `weight` decimal(10,2) NOT NULL,
  `current_stock` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_bar_code_unique` (`bar_code`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_type_id_foreign` (`type_id`),
  KEY `products_liquid_id_foreign` (`liquid_id`),
  KEY `products_user_id_foreign` (`user_id`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `products_brands` (`id`),
  CONSTRAINT `products_liquid_id_foreign` FOREIGN KEY (`liquid_id`) REFERENCES `products_liquids` (`id`),
  CONSTRAINT `products_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `products_types` (`id`),
  CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_brands`
--

DROP TABLE IF EXISTS `products_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_brands` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_brands_user_id_foreign` (`user_id`),
  CONSTRAINT `products_brands_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_brands`
--

LOCK TABLES `products_brands` WRITE;
/*!40000 ALTER TABLE `products_brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_liquids`
--

DROP TABLE IF EXISTS `products_liquids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_liquids` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(135) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_liquids_user_id_foreign` (`user_id`),
  CONSTRAINT `products_liquids_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_liquids`
--

LOCK TABLES `products_liquids` WRITE;
/*!40000 ALTER TABLE `products_liquids` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_liquids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_types`
--

DROP TABLE IF EXISTS `products_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(155) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_types_user_id_foreign` (`user_id`),
  CONSTRAINT `products_types_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_types`
--

LOCK TABLES `products_types` WRITE;
/*!40000 ALTER TABLE `products_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remissions`
--

DROP TABLE IF EXISTS `remissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_of_loading_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `route_id` bigint(20) unsigned NOT NULL,
  `transport_cost` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `remissions_order_of_loading_id_foreign` (`order_of_loading_id`),
  KEY `remissions_client_id_foreign` (`client_id`),
  KEY `remissions_vehicle_id_foreign` (`vehicle_id`),
  KEY `remissions_route_id_foreign` (`route_id`),
  CONSTRAINT `remissions_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `remissions_order_of_loading_id_foreign` FOREIGN KEY (`order_of_loading_id`) REFERENCES `order_of_loadings` (`id`),
  CONSTRAINT `remissions_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`),
  CONSTRAINT `remissions_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remissions`
--

LOCK TABLES `remissions` WRITE;
/*!40000 ALTER TABLE `remissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `remissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_type` enum('income','outgoing','loading_order','remission','client','product','vehicle','route') NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(5,2),
(6,1),
(6,2),
(7,1),
(7,2),
(8,1),
(9,1),
(9,2),
(9,3),
(10,1),
(10,3),
(11,1),
(11,3),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(25,2),
(25,3),
(25,4),
(25,5),
(25,6),
(26,1),
(26,3),
(26,5),
(27,1),
(27,3),
(27,5),
(28,1),
(29,1),
(29,2),
(29,3),
(29,4),
(30,1),
(30,3),
(31,1),
(31,3),
(32,1),
(33,1),
(33,2),
(33,3),
(34,1),
(35,1),
(36,1),
(37,1),
(37,2),
(37,3),
(38,1),
(38,3),
(39,1),
(39,3),
(40,1),
(41,1),
(41,2),
(41,3),
(42,1),
(42,3),
(43,1),
(43,3),
(44,1),
(45,1),
(45,2),
(45,3),
(46,1),
(46,3),
(47,1),
(47,3),
(48,1),
(49,1),
(49,2),
(49,3),
(49,4),
(50,1),
(50,3),
(51,1),
(51,3),
(52,1),
(53,1),
(53,2),
(53,3),
(54,1),
(54,3),
(55,1),
(55,3),
(56,1),
(57,1),
(57,3),
(58,1),
(58,2),
(58,3),
(58,4),
(58,5),
(59,1),
(59,3),
(59,5),
(60,1),
(60,3),
(61,1),
(62,1),
(62,5),
(63,1),
(64,1),
(65,1),
(66,1),
(66,4),
(66,5),
(67,1),
(67,4),
(68,1),
(69,1),
(70,1),
(71,1),
(72,1),
(72,3),
(73,1),
(73,3),
(74,1),
(74,3),
(75,1),
(75,3),
(76,1),
(76,3),
(77,1),
(77,3),
(78,1),
(78,3),
(79,1),
(79,3),
(80,1),
(80,3),
(81,1),
(81,3),
(82,1),
(82,3),
(83,1),
(83,3),
(84,1),
(84,3),
(85,1),
(85,3),
(86,1),
(86,3),
(87,1),
(87,3);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'Administrador','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(2,'Gerente','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(3,'Logistica','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(4,'Conductor','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(5,'Cliente','api','2025-03-24 01:26:46','2025-03-24 01:26:46'),
(6,'Invitado','api','2025-03-24 01:26:46','2025-03-24 01:26:46');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `start_point` varchar(255) NOT NULL,
  `end_point` varchar(255) NOT NULL,
  `departament` varchar(255) NOT NULL,
  `municipality` varchar(255) NOT NULL,
  `type_vehicle` enum('is_single','is_double','is_tractortruck','is_piaggio') NOT NULL COMMENT 'is_single: Sencillo, is_double: Doble, is_tractortruck: Tractomula',
  `distance` decimal(8,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `routes_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
INSERT INTO `routes` VALUES
(1,'IPIALES - CAUCASIA - SENCILLO - ALMACENES ÉXITO','Ipiales','Caucasia','ANTIOQUÍA','CAUCASIA','is_single',1162.00,2400000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(2,'IPIALES - CAUCASIA - DOBLE','Ipiales','Caucasia','ANTIOQUÍA','CAUCASIA','is_double',1162.00,3700000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(3,'IPIALES - CAUCASIA - TRACTOMULA','Ipiales','Caucasia','ANTIOQUÍA','CAUCASIA','is_tractortruck',1162.00,5500000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(4,'IPIALES - TARAZá - SENCILLO','Ipiales','Tarazá','ANTIOQUÍA','TARAZÁ','is_single',1100.00,2400000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(5,'IPIALES - TARAZá - DOBLE','Ipiales','Tarazá','ANTIOQUÍA','TARAZÁ','is_double',1100.00,3700000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(6,'IPIALES - TARAZá - TRACTOMULA','Ipiales','Tarazá','ANTIOQUÍA','TARAZÁ','is_tractortruck',1100.00,5500000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(7,'IPIALES - VALDIVIA - SENCILLO','Ipiales','Valdivia','ANTIOQUÍA','VALDIVIA','is_single',1039.00,2400000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(8,'IPIALES - VALDIVIA - DOBLE','Ipiales','Valdivia','ANTIOQUÍA','VALDIVIA','is_double',1039.00,3700000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(9,'IPIALES - VALDIVIA - TRACTOMULA','Ipiales','Valdivia','ANTIOQUÍA','VALDIVIA','is_tractortruck',1039.00,5500000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(10,'IPIALES - PASTO - SENCILLO','Ipiales','Pasto','NARIÑO','PASTO','is_single',91.00,800000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(11,'IPIALES - PASTO - DOBLE','Ipiales','Pasto','NARIÑO','PASTO','is_double',91.00,1300000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL),
(12,'IPIALES - PASTO - TRACTOMULA','Ipiales','Pasto','NARIÑO','PASTO','is_tractortruck',91.00,2000000.00,1,'2025-03-24 01:26:50','2025-03-24 01:26:50',NULL);
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `estado` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `birth_date` timestamp NULL DEFAULT NULL,
  `gender` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '1 es masculino 2 es femenino',
  `education` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Diego Fernando','Yama Andrade','admin@itdyaingenieria.com','3145062191','1979-12-24 05:00:00',1,'Ingeniero de Sistemas','Desarrollador de Software',NULL,NULL,'2025-03-24 01:26:46','$2y$10$.0Mfw7/jNNIYF.yV/K4hQuyIbHFjQy5oyTnPSqDuCBICT1H5lPGD2','iwhULnoMzQ','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(2,'Example Gerente','User','gerente@example.com','3145000000','1970-11-01 05:00:00',1,'Administrador de Empresas','Gerente General','Calle 123 # 123-123',NULL,'2025-03-24 01:26:46','$2y$10$VWY3MusGARFJ0HHbGSCqyu7ACo1BOhKjMuiA997/mZT8xxqxYYWli','BPuH41Hrhr','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(3,'Example Logistica','User','logistica@example.com','3145000001','1974-07-25 05:00:00',1,'Ingeniero Industrial','Jefe de Logistica','Calle 123 # 123-124',NULL,'2025-03-24 01:26:46','$2y$10$LquD37I0R/fgi3Ee720eJuH8JKllkmNDz9upPrTfuRlrpjF5XrfB.','Ex7dXZSYTJ','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(4,'Asignado Empresa','Transporte','conductor@example.com','3145000002','1985-05-15 05:00:00',1,'Bachiller','Conductor de Vehículos','Calle 123 # 123-125',NULL,'2025-03-24 01:26:46','$2y$10$0IfBTjhUIbMTzc5lnGM7PuEpdK5bEXIeeDnkwIfivlDg.9lFJ2rVS','GzCxEBVlqI','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(5,'Mario Conductor','Sánchez','mario_conductor@example.com','3145000002','1974-05-15 05:00:00',1,'Bachiller','Conductor de Vehículos','Ipiales Calle 123 # 123-125',NULL,'2025-03-24 01:26:46','$2y$10$JD4mQa2aNYhuE5zgmoLgMe393lrh8fjkXFm4I.OmSoaNpWRqTHv1u','i3ubTAbCaa','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(6,'Consumidor Final','Final','consumidorfinal@itdyaingenieria.com','3145000007','1979-12-31 05:00:00',2,'Bachiller','Cliente','Bogota Dc Calle 123 # 123-126',NULL,'2025-03-24 01:26:46','$2y$10$uNRoX8RjnVOty7NWProavOFeDoOiVyUxAJf5AWo6un9MjaVdXo6bC','YVe5bOHSiL','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(7,'Juan Diego','Mora','juandi@example.com','3145000017','1979-12-24 05:00:00',2,'Ingeniero Industrial','Cliente','Bogota Dc Calle 127 # 56-126',NULL,'2025-03-24 01:26:46','$2y$10$KarV07hGl.1zUs/ufNHMFu72s5Qj1.553YOIWMsPxeZJ4VZUTDVFO','YKRxc1vqw0','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(8,'Arianna','Mora Huertas','ari1978@example.com','3145230007','1978-04-19 05:00:00',2,'Administrador de Empresas','Cliente','Manizales Dc Calle 123 # 123-126',NULL,'2025-03-24 01:26:46','$2y$10$Fc1ZNYYvq98lRyn9aCE4nu9c3m9O3y0B2WtGps5KVDP74zk3JOzYe','XOVXVam0DJ','2025-03-24 01:26:46','2025-03-24 01:26:46',NULL),
(9,'Example Invitado User',NULL,'invitado@example.com','3145000003',NULL,1,NULL,NULL,NULL,NULL,'2025-03-24 01:26:47','$2y$10$JsBU/2KRAbn3La9Ju3h2aupWQf9u1W2Kh3hDiy5AGgCZlutKLffxq','RV0uTqKoLL','2025-03-24 01:26:47','2025-03-24 01:26:47',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_trackings`
--

DROP TABLE IF EXISTS `vehicle_trackings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_trackings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `remission_id` bigint(20) unsigned NOT NULL,
  `tracking_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle_trackings_remission_id_foreign` (`remission_id`),
  CONSTRAINT `vehicle_trackings_remission_id_foreign` FOREIGN KEY (`remission_id`) REFERENCES `remissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_trackings`
--

LOCK TABLES `vehicle_trackings` WRITE;
/*!40000 ALTER TABLE `vehicle_trackings` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_trackings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(255) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `engine_number` varchar(255) DEFAULT NULL,
  `chassis_number` varchar(255) DEFAULT NULL,
  `soat_expiration` timestamp NULL DEFAULT NULL,
  `techno_mechanical_expiration` timestamp NULL DEFAULT NULL,
  `affiliated_company` varchar(255) DEFAULT NULL,
  `trailer_number` varchar(255) DEFAULT NULL,
  `satellite_tracking` varchar(255) DEFAULT NULL,
  `satellite_user` varchar(255) DEFAULT NULL,
  `satellite_password` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `type` enum('is_single','is_double','is_tractortruck','is_piaggio') NOT NULL DEFAULT 'is_tractortruck' COMMENT 'is_single: Sencillo, is_double: Doble, is_tractortruck: Tractomula',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '2: Inactivo, 1: Activo',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicles_license_plate_unique` (`license_plate`),
  KEY `vehicles_user_id_foreign` (`user_id`),
  CONSTRAINT `vehicles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES
(1,'XEJ500',NULL,NULL,NULL,NULL,NULL,NULL,'2025-03-18 05:00:00','2025-03-18 05:00:00',NULL,NULL,NULL,NULL,NULL,4,'is_tractortruck',1,'2025-03-24 01:39:20','2025-03-24 01:39:20',NULL);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `capacity` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `warehouses_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sigpuertomar'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-23 20:56:14
