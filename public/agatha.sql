-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 09, 2025 at 09:58 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agatha_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_10_095825_create_stories_table', 1),
(5, '2025_10_19_162629_add_two_factor_columns_to_users_table', 1),
(6, '2025_10_29_072952_create_personal_access_tokens_table', 1),
(7, '2025_11_12_132255_create_random_words_table', 1),
(8, '2025_11_26_184153_create_user_inactivity_status_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 3, 'api-token', '6c46f680935db3ad89e0eca214528f9dd744fc9d013c0aa6d8294a1e9b531f44', '[\"*\"]', '2025-11-13 08:21:36', NULL, '2025-11-12 17:10:50', '2025-11-13 08:21:36'),
(2, 'App\\Models\\User', 3, 'api-token', '36accc7787416bf232de12c8c5e120f7f24cd58d01deba2f1c5a14224dce10a5', '[\"*\"]', '2025-11-14 09:19:45', NULL, '2025-11-12 19:15:37', '2025-11-14 09:19:45'),
(3, 'App\\Models\\User', 3, 'api-token', 'f545a0da95198f15880c7c112fed05293d9853be54a360dbb4517de0c33ddac6', '[\"*\"]', '2025-11-13 09:12:05', '2025-11-13 20:22:07', '2025-11-13 08:22:08', '2025-11-13 09:12:05'),
(4, 'App\\Models\\User', 3, 'api-token', '1048b23e770bdd678ff77ade850e03a28731d3242ba211c04a9a2d649581333f', '[\"*\"]', '2025-11-13 13:09:34', '2025-11-13 21:13:02', '2025-11-13 09:13:02', '2025-11-13 13:09:34'),
(5, 'App\\Models\\User', 3, 'api-token', '5bdf02ad91ed3001bca06f14a2efd2dbbb1333c5b175930810cffac142dc802f', '[\"*\"]', '2025-11-14 17:40:40', '2025-11-14 19:36:31', '2025-11-14 07:36:31', '2025-11-14 17:40:40'),
(6, 'App\\Models\\User', 3, 'api-token', 'f0fddcf04ac580d8c876e7bf86bbdce1ffc6b540fdae727a24bc36ff3e2eb87b', '[\"*\"]', '2025-11-14 15:19:59', '2025-11-14 21:30:48', '2025-11-14 09:30:48', '2025-11-14 15:19:59'),
(7, 'App\\Models\\User', 3, 'api-token', '49915e40bcd99d6888d44b4f1dccd4228055df2b563133ba711febee51f9b992', '[\"*\"]', '2025-11-15 18:43:02', '2025-11-16 04:30:12', '2025-11-15 16:30:12', '2025-11-15 18:43:02'),
(8, 'App\\Models\\User', 1, 'api-token', '454f6e57dc696009f827d25084b89798281720275dd9d2b9b58aaeb919ad5e9e', '[\"*\"]', '2025-11-16 16:33:36', '2025-11-16 19:31:02', '2025-11-16 07:31:02', '2025-11-16 16:33:36'),
(9, 'App\\Models\\User', 3, 'api-token', '26bc2996bbdb46c316531297931f6b7c8eb23e85f92357b2d2bf0810dabe5374', '[\"*\"]', '2025-11-16 09:32:58', '2025-11-16 21:11:27', '2025-11-16 09:11:27', '2025-11-16 09:32:58'),
(10, 'App\\Models\\User', 1, 'api-token', '92c76cadc20963fc13669959f34f92a008d01e266641f6fd87c2d25928ee26f6', '[\"*\"]', '2025-11-16 16:34:05', '2025-11-17 04:34:03', '2025-11-16 16:34:03', '2025-11-16 16:34:05'),
(11, 'App\\Models\\User', 3, 'api-token', '9d42ac0e28d66cd80f3088939d498291b9382286b3c8f31e80e3ad99b1bf1a88', '[\"*\"]', '2025-11-18 17:30:28', '2025-11-19 05:24:01', '2025-11-18 17:24:01', '2025-11-18 17:30:28'),
(12, 'App\\Models\\User', 3, 'api-token', '59b46252bcd93411c466ff53c5b074250566f252d1938b557df0a3c0c234038a', '[\"*\"]', '2025-11-18 17:32:43', '2025-11-19 05:32:12', '2025-11-18 17:32:12', '2025-11-18 17:32:43'),
(13, 'App\\Models\\User', 3, 'api-token', '9c9775f93e65b4d0e39a65cff04ff8c4fafa33c53e9f90424ff892ab93c8b187', '[\"*\"]', '2025-11-18 17:45:34', '2025-11-19 05:43:31', '2025-11-18 17:43:31', '2025-11-18 17:45:34'),
(14, 'App\\Models\\User', 9, 'api-token', '49bb04cc065d9d2a72f35f6ec8a84e54c7ba665d284c9780bf42e0cb14e8c7df', '[\"*\"]', '2025-11-19 19:32:49', '2025-11-20 04:08:43', '2025-11-19 16:08:43', '2025-11-19 19:32:49'),
(15, 'App\\Models\\User', 3, 'api-token', 'f630b851d3932cd5a3f7ada0fef5c792cd1fda37c6a3546dbdb58b93dac1d942', '[\"*\"]', '2025-11-20 07:30:17', '2025-11-20 18:11:44', '2025-11-20 06:11:45', '2025-11-20 07:30:17'),
(16, 'App\\Models\\User', 3, 'api-token', 'bc356a5b99cca97e223ad81695d1ec4432360f9467f5e8ca088a41e768c713cf', '[\"*\"]', '2025-11-20 07:33:14', '2025-11-20 19:31:25', '2025-11-20 07:31:25', '2025-11-20 07:33:14'),
(17, 'App\\Models\\User', 3, 'api-token', 'addb58b2f5389f48c776ed344231c9949b729e526f01080c1c8c714239415140', '[\"*\"]', '2025-11-20 07:39:35', '2025-11-20 19:39:19', '2025-11-20 07:39:19', '2025-11-20 07:39:35'),
(18, 'App\\Models\\User', 3, 'api-token', 'ec43d6a2fe3d5328a3f5cc2eb81a8b9ec29adc3864b85f827d538eae3212e620', '[\"*\"]', '2025-11-20 07:40:21', '2025-11-20 19:40:19', '2025-11-20 07:40:19', '2025-11-20 07:40:21'),
(19, 'App\\Models\\User', 3, 'api-token', '16200f24eeefe1b935a74059bafa929ada8f697a088b38865d589e986153bc26', '[\"*\"]', '2025-11-24 18:03:03', '2025-11-25 04:05:08', '2025-11-24 16:05:08', '2025-11-24 18:03:03'),
(20, 'App\\Models\\User', 1, 'api-token', '41e91521e98b05ac915648bd613d9add9a2425b624fbe623ab587bf8c31869ae', '[\"*\"]', '2025-11-28 11:52:49', '2025-11-28 23:25:54', '2025-11-28 11:25:54', '2025-11-28 11:52:49'),
(21, 'App\\Models\\User', 10, 'api-token', '0ed78b324b001732e06a43c4775a71995d74b17085409f025588ae1603da50dd', '[\"*\"]', '2025-11-30 10:06:26', '2025-11-30 22:06:24', '2025-11-30 10:06:24', '2025-11-30 10:06:26'),
(22, 'App\\Models\\User', 10, 'api-token', 'acd215a5e76494a60409ced73c31bac3d844f4a7f2a231a233345e03f426b0e3', '[\"*\"]', '2025-11-30 10:09:02', '2025-11-30 22:09:00', '2025-11-30 10:09:00', '2025-11-30 10:09:02'),
(23, 'App\\Models\\User', 9, 'api-token', '50444ab7cc3e9aa17e47fda40c7f63074802d5924eb2c973ab8f79088544464f', '[\"*\"]', '2025-11-30 10:19:40', '2025-11-30 22:19:39', '2025-11-30 10:19:39', '2025-11-30 10:19:40'),
(24, 'App\\Models\\User', 9, 'api-token', '1ac9342aef97e4813f7afd71590d5b68577a46e4544118040ea9a3020e2cd03d', '[\"*\"]', '2025-11-30 21:02:39', '2025-12-01 08:52:31', '2025-11-30 20:52:31', '2025-11-30 21:02:39'),
(25, 'App\\Models\\User', 5, 'api-token', '53b9846db62f4e1ab18a188c97fcca18860295fa2898a2ee4dd3f79750d94a63', '[\"*\"]', '2025-12-07 13:12:51', '2025-12-08 01:11:03', '2025-12-07 13:11:04', '2025-12-07 13:12:51'),
(26, 'App\\Models\\User', 12, 'api-token', '39490a44d217cca3d72a0770b80c8f2c210b8fe1544a70c214ce09c18e45819d', '[\"*\"]', '2025-12-07 18:16:14', '2025-12-08 05:30:51', '2025-12-07 17:30:51', '2025-12-07 18:16:14'),
(27, 'App\\Models\\User', 12, 'api-token', '203b87a9324b230bcc5b1a8b9fe1947dd6c7a35fcbdc66ab85192e69ca8a5efc', '[\"*\"]', '2025-12-07 20:15:08', '2025-12-08 06:40:55', '2025-12-07 18:40:55', '2025-12-07 20:15:08'),
(28, 'App\\Models\\User', 12, 'api-token', '4df6b30e4927cb159252256a9d76dcfa2523f960005878306ded40f5603e336c', '[\"*\"]', '2025-12-08 18:13:09', '2025-12-09 04:10:55', '2025-12-08 16:10:55', '2025-12-08 18:13:09'),
(29, 'App\\Models\\User', 12, 'api-token', '1eec26922bfe1acd4ac98cd291539962251e1b26612636da27ee2fb7c147479b', '[\"*\"]', '2025-12-08 18:15:29', '2025-12-09 06:13:29', '2025-12-08 18:13:29', '2025-12-08 18:15:29');

-- --------------------------------------------------------

--
-- Table structure for table `random_words`
--

CREATE TABLE `random_words` (
  `id` bigint UNSIGNED NOT NULL,
  `type` enum('word','place') COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `random_words`
--

INSERT INTO `random_words` (`id`, `type`, `value`, `created_at`, `updated_at`) VALUES
(1, 'word', 'llave', NULL, NULL),
(2, 'word', 'reloj', NULL, NULL),
(3, 'word', 'diario', NULL, NULL),
(4, 'word', 'espada', NULL, NULL),
(5, 'word', 'botella', NULL, NULL),
(6, 'word', 'pluma', NULL, NULL),
(7, 'word', 'libro', NULL, NULL),
(8, 'word', 'vela', NULL, NULL),
(9, 'word', 'sombrero', NULL, NULL),
(10, 'word', 'anillo', NULL, NULL),
(11, 'word', 'caja', NULL, NULL),
(12, 'word', 'puerta', NULL, NULL),
(13, 'word', 'espejo', NULL, NULL),
(14, 'word', 'carta', NULL, NULL),
(15, 'word', 'mapa', NULL, NULL),
(16, 'word', 'piedra', NULL, NULL),
(17, 'word', 'linterna', NULL, NULL),
(18, 'word', 'bolsillo', NULL, NULL),
(19, 'word', 'cámara', NULL, NULL),
(20, 'word', 'brújula', NULL, NULL),
(21, 'word', 'cristal', NULL, NULL),
(22, 'word', 'retrato', NULL, NULL),
(23, 'word', 'baraja', NULL, NULL),
(24, 'word', 'frasco', NULL, NULL),
(25, 'word', 'bolígrafo', NULL, NULL),
(26, 'word', 'cuerda', NULL, NULL),
(27, 'word', 'escudo', NULL, NULL),
(28, 'word', 'telescopio', NULL, NULL),
(29, 'word', 'vara', NULL, NULL),
(30, 'word', 'moneda', NULL, NULL),
(31, 'word', 'flores', NULL, NULL),
(32, 'word', 'frasco', NULL, NULL),
(33, 'word', 'llavero', NULL, NULL),
(34, 'word', 'pergamino', NULL, NULL),
(35, 'word', 'retrato', NULL, NULL),
(36, 'word', 'bastón', NULL, NULL),
(37, 'word', 'maleta', NULL, NULL),
(38, 'word', 'collar', NULL, NULL),
(39, 'word', 'cuaderno', NULL, NULL),
(40, 'word', 'botón', NULL, NULL),
(41, 'word', 'ventana', NULL, NULL),
(42, 'word', 'candado', NULL, NULL),
(43, 'word', 'caracola', NULL, NULL),
(44, 'word', 'reloj de arena', NULL, NULL),
(45, 'word', 'pañuelo', NULL, NULL),
(46, 'word', 'figura', NULL, NULL),
(47, 'word', 'globo', NULL, NULL),
(48, 'word', 'paraguas', NULL, NULL),
(49, 'word', 'pincel', NULL, NULL),
(50, 'word', 'ancla', NULL, NULL),
(51, 'place', 'París', NULL, NULL),
(52, 'place', 'Londres', NULL, NULL),
(53, 'place', 'Roma', NULL, NULL),
(54, 'place', 'Tokio', NULL, NULL),
(55, 'place', 'Madrid', NULL, NULL),
(56, 'place', 'Berlín', NULL, NULL),
(57, 'place', 'Lisboa', NULL, NULL),
(58, 'place', 'Nueva York', NULL, NULL),
(59, 'place', 'Buenos Aires', NULL, NULL),
(60, 'place', 'Lima', NULL, NULL),
(61, 'place', 'Sídney', NULL, NULL),
(62, 'place', 'Toronto', NULL, NULL),
(63, 'place', 'Ámsterdam', NULL, NULL),
(64, 'place', 'Oslo', NULL, NULL),
(65, 'place', 'Dublín', NULL, NULL),
(66, 'place', 'El Cairo', NULL, NULL),
(67, 'place', 'Estambul', NULL, NULL),
(68, 'place', 'Praga', NULL, NULL),
(69, 'place', 'Venecia', NULL, NULL),
(70, 'place', 'Sevilla', NULL, NULL),
(71, 'place', 'Granada', NULL, NULL),
(72, 'place', 'Barcelona', NULL, NULL),
(73, 'place', 'Valencia', NULL, NULL),
(74, 'place', 'Bilbao', NULL, NULL),
(75, 'place', 'Marrakech', NULL, NULL),
(76, 'place', 'Kioto', NULL, NULL),
(77, 'place', 'Nápoles', NULL, NULL),
(78, 'place', 'Florencia', NULL, NULL),
(79, 'place', 'Copenhague', NULL, NULL),
(80, 'place', 'Reikiavik', NULL, NULL),
(81, 'place', 'Zúrich', NULL, NULL),
(82, 'place', 'Dubái', NULL, NULL),
(83, 'place', 'Chicago', NULL, NULL),
(84, 'place', 'San Francisco', NULL, NULL),
(85, 'place', 'Los Ángeles', NULL, NULL),
(86, 'place', 'Río de Janeiro', NULL, NULL),
(87, 'place', 'Bogotá', NULL, NULL),
(88, 'place', 'Montevideo', NULL, NULL),
(89, 'place', 'Santiago', NULL, NULL),
(90, 'place', 'Quito', NULL, NULL),
(91, 'place', 'Edimburgo', NULL, NULL),
(92, 'place', 'Bruselas', NULL, NULL),
(93, 'place', 'Budapest', NULL, NULL),
(94, 'place', 'Varsovia', NULL, NULL),
(95, 'place', 'Helsinki', NULL, NULL),
(96, 'place', 'Estocolmo', NULL, NULL),
(97, 'place', 'Ginebra', NULL, NULL),
(98, 'place', 'Casablanca', NULL, NULL),
(99, 'place', 'Manila', NULL, NULL),
(100, 'place', 'Singapur', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE `stories` (
  `id` bigint UNSIGNED NOT NULL,
  `story_token` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `random_word` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `random_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `word_count` int NOT NULL DEFAULT '0',
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`id`, `story_token`, `random_word`, `random_place`, `title`, `content`, `word_count`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '79439177-6a28-40f0-98ac-28ace532b6de', 'pan', 'viena', 'dsaf', 'pan  viena vara vara', 4, 3, '2025-11-14 14:30:38', '2025-11-20 06:54:01'),
(2, '7303a586-fe07-41ae-b622-1defcda755e8', 'pan', 'viena', 'updated', 'pan  viena vara', 3, 3, '2025-11-14 15:20:02', '2025-11-16 09:32:58'),
(4, '44ae6c4a-f524-413b-b301-60f2101473db', 'reloj de arena', 'Montevideo', 'wqerwte', 'wdefrgh reloj de arena\' y el lugar \'Montevideo', 8, 3, '2025-11-15 16:31:11', '2025-11-15 16:31:11'),
(5, '22c72b74-cbe6-45ea-ab65-d1dd654b5a7e', 'retrato', 'Helsinki', 'Autodescubrimiento', 'Encontré mi ser mirándome directamente a los ojos en un mercadillo de Helsinki. Era mi propio retrato.', 18, 3, '2025-11-15 16:37:53', '2025-11-15 16:37:53'),
(6, '834fc1be-492a-420e-84b7-df2690945646', 'espejo', 'Reikiavik', 'Revisar validacion titulo, no deja enviarlo vacion', 'cfgvhb espejo Reikiavik', 3, 3, '2025-11-15 17:18:28', '2025-11-15 17:18:28'),
(8, '0ce9e1fb-ebdd-4f63-88c3-001776e02ad4', 'ancla', 'San Francisco', 'Ancla', 'ancla San Francisco', 3, 1, '2025-11-16 10:43:11', '2025-11-16 16:32:32'),
(10, 'c284a873-7c85-4720-8f50-a448ce1a501c', 'ancla', 'Bilbao', 'Bilbao', 'Bilbao ancla', 2, 1, '2025-11-16 14:01:36', '2025-11-16 14:01:36'),
(14, '07842e22-da5a-440f-924f-104a17782f41', 'vela', 'Tokio', 'Prueba', 'La vela de Tokio', 4, 9, '2025-11-30 20:54:07', '2025-11-30 20:54:07'),
(15, 'cc86e70c-30c8-44e4-8e4c-86455549d63e', 'globo', 'Sevilla', 'Primera', 'El globo de la Expo de Sevilla.', 7, 5, '2025-12-07 13:12:23', '2025-12-07 13:12:23'),
(16, '8f1b7eca-0a16-4cf5-bdc1-8b44d163f9ff', 'espejo', 'Ámsterdam', 'Prueba nuevo usuario', 'espejo Ámsterdam', 2, 12, '2025-12-07 17:32:33', '2025-12-07 17:32:33'),
(17, 'd7c61c26-0115-49c0-9142-f675bc615f6a', 'candado', 'Bruselas', 'prueba reenvio aviso primer email', 'candado Bruselas', 2, 12, '2025-12-08 18:15:18', '2025-12-08 18:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Abigail Stokes', 'kiehn.amira@example.com', '2025-11-12 17:10:23', '$2y$12$d5RP0qxGfDGzJ2OSKOxFreumdh4F8uA4HyX5seotoxMOchoBDnX9C', NULL, NULL, NULL, '0VDSuj9lNX', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(2, 'Prof. Leonardo Aufderhar DDS', 'lon.hettinger@example.net', '2025-11-12 17:10:23', '$2y$12$rCMtMfB4aDyBmqifW3pGvefWnn85X2veoh2LgSe9tXXNhg5.0CCHG', NULL, NULL, NULL, 'b4YQlqXirK', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(3, 'Keshawn Kovacek', 'heather68@example.org', '2025-11-12 17:10:23', '$2y$12$BG6NHOUWfpQRE8EBx5v.7O3BIMx8yzgOCrgzv8LJvw.yIAqjXPVFa', NULL, NULL, NULL, 'vmMkB8zpM0', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(4, 'Jermaine Smitham II', 'libbie44@example.com', '2025-11-12 17:10:23', '$2y$12$XZWHJsAWHptSMhzCIV/JHu/mKF8S.48LHhpXEtLJlJ2fp.SpA91pC', NULL, NULL, NULL, 'l5AhNoApHk', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(5, 'Miss Karlie Johnson MD', 'hilma.gerhold@example.com', '2025-11-12 17:10:24', '$2y$12$wGaX2QXk1JZOxIKspN7ZL.GJgU1F7gwVtuYRJyswnKefVqoYLOjyu', NULL, NULL, NULL, 'ckLrOKGRCZ', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(6, 'Leo Nolan', 'istracke@example.com', '2025-11-12 17:10:24', '$2y$12$GObxAIykfPtmoBZOIIhOt.3mL1/JBLawcy/LohNHO7vdmOmlL74qK', NULL, NULL, NULL, 'LuUx4dKJNs', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(7, 'Desmond Pollich IV', 'marcelle71@example.com', '2025-11-12 17:10:24', '$2y$12$MfRjDZEaHYPt3ZXfrzQ1ouJsyHnSMa9WCZ3xjoL6fFtdpQt6Zkdcu', NULL, NULL, NULL, 'C0OxcKsnVO', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(8, 'Dr. Larue Reilly', 'alf.bednar@example.com', '2025-11-12 17:10:24', '$2y$12$EZ2o6674WoxRFJPbmWnNYuK6lDkCS0xj/hafoFtqAstVNBBG2ihsG', NULL, NULL, NULL, 'qxDj7XWC7b', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(9, 'Burnice Reynolds', 'don.funk@example.net', '2025-11-12 17:10:24', '$2y$12$S9EITkq1fjs7EFJimafbWuhcSGdAjI0k.aRHT1qZ/nDSmlEWGLVpa', NULL, NULL, NULL, 'NrGbitI501', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(10, 'Bryce Watsica', 'cummerata.vincenza@example.com', '2025-11-12 17:10:25', '$2y$12$o1lmdTBn/bWugR0QIxPbnuf6lKOVMKTcrdGkw.KLyIIvb4FQML7w.', NULL, NULL, NULL, 'b9LjFpt4B3', '2025-11-12 17:10:25', '2025-11-12 17:10:25'),
(12, 'Ana', 'prueba@registro.com', NULL, '$2y$12$/aiWh0aShrTTTl6Qqh.0JuHfAeKYRalZqzJ2IyUTZZnKKvr5EB6vq', NULL, NULL, NULL, NULL, '2025-12-07 17:30:51', '2025-12-08 18:13:10');

-- --------------------------------------------------------

--
-- Table structure for table `user_inactivity_status`
--

CREATE TABLE `user_inactivity_status` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `first_email_sent_at` timestamp NULL DEFAULT NULL,
  `second_email_sent_at` timestamp NULL DEFAULT NULL,
  `last_story_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_inactivity_status`
--

INSERT INTO `user_inactivity_status` (`id`, `user_id`, `first_email_sent_at`, `second_email_sent_at`, `last_story_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, '2025-11-30 09:46:01', '2025-11-16 14:01:36', '2025-11-28 11:59:28', '2025-11-30 09:46:01'),
(2, 3, NULL, '2025-11-30 10:05:12', '2025-11-15 17:18:28', '2025-11-28 11:59:29', '2025-11-30 10:05:12'),
(3, 9, '2025-12-02 11:21:15', '2025-12-07 13:10:46', '2025-11-30 20:54:07', '2025-11-30 20:54:07', '2025-12-07 13:10:46'),
(4, 5, '2025-12-08 16:11:55', NULL, '2025-12-07 13:12:23', '2025-12-07 13:12:23', '2025-12-08 16:11:55'),
(5, 12, '2025-12-09 18:26:48', NULL, '2025-12-08 18:15:18', '2025-12-07 17:32:33', '2025-12-09 18:26:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `random_words`
--
ALTER TABLE `random_words`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stories`
--
ALTER TABLE `stories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stories_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_inactivity_status`
--
ALTER TABLE `user_inactivity_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_inactivity_status_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `random_words`
--
ALTER TABLE `random_words`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `stories`
--
ALTER TABLE `stories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_inactivity_status`
--
ALTER TABLE `user_inactivity_status`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `stories`
--
ALTER TABLE `stories`
  ADD CONSTRAINT `stories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_inactivity_status`
--
ALTER TABLE `user_inactivity_status`
  ADD CONSTRAINT `user_inactivity_status_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
