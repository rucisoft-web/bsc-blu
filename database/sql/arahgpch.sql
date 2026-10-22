-- Arah GPCH — dump MySQL/MariaDB
-- Dibuat: 2026-10-18 00:25:20 (Asia/Jakarta) dari data awal Grand Pasundan Convention Hotel
-- Impor: buat database `arahgpch` (utf8mb4_unicode_ci) lalu jalankan file ini (HeidiSQL / phpMyAdmin / mysql CLI).

SET NAMES utf8mb4;
SET time_zone = '+07:00';
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `user_contexts`;
DROP TABLE IF EXISTS `tows_strategy_issue`;
DROP TABLE IF EXISTS `tows_strategies`;
DROP TABLE IF EXISTS `swot_items`;
DROP TABLE IF EXISTS `strategic_themes`;
DROP TABLE IF EXISTS `strategic_objectives`;
DROP TABLE IF EXISTS `strategic_issues`;
DROP TABLE IF EXISTS `strategic_issue_stakeholder`;
DROP TABLE IF EXISTS `strategic_initiatives`;
DROP TABLE IF EXISTS `strategic_dependencies`;
DROP TABLE IF EXISTS `strategic_choices`;
DROP TABLE IF EXISTS `stakeholders`;
DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `role_user`;
DROP TABLE IF EXISTS `review_notes`;
DROP TABLE IF EXISTS `regulations`;
DROP TABLE IF EXISTS `pestel_analyses`;
DROP TABLE IF EXISTS `permissions`;
DROP TABLE IF EXISTS `permission_role`;
DROP TABLE IF EXISTS `performance_reviews`;
DROP TABLE IF EXISTS `objective_relations`;
DROP TABLE IF EXISTS `notifications`;
DROP TABLE IF EXISTS `migrations`;
DROP TABLE IF EXISTS `maturity_questions`;
DROP TABLE IF EXISTS `maturity_assessments`;
DROP TABLE IF EXISTS `maturity_answers`;
DROP TABLE IF EXISTS `market_analyses`;
DROP TABLE IF EXISTS `kpis`;
DROP TABLE IF EXISTS `kpi_targets`;
DROP TABLE IF EXISTS `kpi_actuals`;
DROP TABLE IF EXISTS `institutionalizations`;
DROP TABLE IF EXISTS `initiative_objective`;
DROP TABLE IF EXISTS `initiative_milestones`;
DROP TABLE IF EXISTS `initiative_budgets`;
DROP TABLE IF EXISTS `initiative_activities`;
DROP TABLE IF EXISTS `industry_forces`;
DROP TABLE IF EXISTS `findings`;
DROP TABLE IF EXISTS `environment_scans`;
DROP TABLE IF EXISTS `dhastram_sequences`;
DROP TABLE IF EXISTS `corrective_actions`;
DROP TABLE IF EXISTS `core_values`;
DROP TABLE IF EXISTS `competitors`;
DROP TABLE IF EXISTS `company_user`;
DROP TABLE IF EXISTS `companies`;
DROP TABLE IF EXISTS `capabilities`;
DROP TABLE IF EXISTS `audit_logs`;
DROP TABLE IF EXISTS `atman_profiles`;
DROP TABLE IF EXISTS `analysis_periods`;
DROP TABLE IF EXISTS `cache`;
DROP TABLE IF EXISTS `cache_locks`;
DROP TABLE IF EXISTS `sessions`;
DROP TABLE IF EXISTS `jobs`;
DROP TABLE IF EXISTS `job_batches`;
DROP TABLE IF EXISTS `failed_jobs`;
DROP TABLE IF EXISTS `password_reset_tokens`;

-- ---------------- Struktur tabel
create table `migrations` (`id` int unsigned not null auto_increment primary key, `migration` varchar(255) not null, `batch` int not null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
create table `users` (`id` bigint unsigned not null auto_increment primary key, `name` varchar(255) not null, `email` varchar(255) not null, `email_verified_at` timestamp null, `password` varchar(255) not null, `remember_token` varchar(100) null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `users` add unique `users_email_unique`(`email`);
create table `password_reset_tokens` (`email` varchar(255) not null, `token` varchar(255) not null, `created_at` timestamp null, primary key (`email`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
create table `sessions` (`id` varchar(255) not null, `user_id` bigint unsigned null, `ip_address` varchar(45) null, `user_agent` text null, `payload` longtext not null, `last_activity` int not null, primary key (`id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `sessions` add index `sessions_user_id_index`(`user_id`);
alter table `sessions` add index `sessions_last_activity_index`(`last_activity`);
create table `cache` (`key` varchar(255) not null, `value` mediumtext not null, `expiration` bigint not null, primary key (`key`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `cache` add index `cache_expiration_index`(`expiration`);
create table `cache_locks` (`key` varchar(255) not null, `owner` varchar(255) not null, `expiration` bigint not null, primary key (`key`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `cache_locks` add index `cache_locks_expiration_index`(`expiration`);
create table `jobs` (`id` bigint unsigned not null auto_increment primary key, `queue` varchar(255) not null, `payload` longtext not null, `attempts` smallint unsigned not null, `reserved_at` int unsigned null, `available_at` int unsigned not null, `created_at` int unsigned not null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `jobs` add index `jobs_queue_index`(`queue`);
create table `job_batches` (`id` varchar(255) not null, `name` varchar(255) not null, `total_jobs` int not null, `pending_jobs` int not null, `failed_jobs` int not null, `failed_job_ids` longtext not null, `options` mediumtext null, `cancelled_at` int null, `created_at` int not null, `finished_at` int null, primary key (`id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
create table `failed_jobs` (`id` bigint unsigned not null auto_increment primary key, `uuid` varchar(255) not null, `connection` varchar(255) not null, `queue` varchar(255) not null, `payload` longtext not null, `exception` longtext not null, `failed_at` timestamp not null default CURRENT_TIMESTAMP) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `failed_jobs` add index `failed_jobs_connection_queue_failed_at_index`(`connection`, `queue`, `failed_at`);
alter table `failed_jobs` add unique `failed_jobs_uuid_unique`(`uuid`);
create table `companies` (`id` bigint unsigned not null auto_increment primary key, `code` varchar(30) not null, `name` varchar(255) not null, `legal_name` varchar(255) null, `industry` varchar(100) null, `address` varchar(255) null, `city` varchar(100) null, `phone` varchar(50) null, `email` varchar(255) null, `website` varchar(255) null, `room_count` int unsigned null, `description` text null, `is_active` tinyint(1) not null default '1', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `companies` add unique `companies_code_unique`(`code`);
create table `analysis_periods` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `code` varchar(30) not null, `name` varchar(255) not null, `year` smallint unsigned not null, `start_date` date not null, `end_date` date not null, `status` varchar(20) not null default 'perencanaan', `is_active` tinyint(1) not null default '0', `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `analysis_periods` add constraint `analysis_periods_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `analysis_periods` add unique `analysis_periods_company_id_code_unique`(`company_id`, `code`);
alter table `users` add `job_title` varchar(255) null after `email`;
alter table `users` add `department` varchar(60) null after `job_title`;
alter table `users` add `phone` varchar(50) null after `department`;
alter table `users` add `is_active` tinyint(1) not null default '1' after `phone`;
alter table `users` add `must_change_password` tinyint(1) not null default '1' after `is_active`;
alter table `users` add `password_changed_at` timestamp null after `must_change_password`;
alter table `users` add `last_login_at` timestamp null after `password_changed_at`;
alter table `users` add `app_authentication_secret` text null;
alter table `users` add `app_authentication_recovery_codes` text null;
create table `company_user` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `user_id` bigint unsigned not null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `company_user` add constraint `company_user_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `company_user` add constraint `company_user_user_id_foreign` foreign key (`user_id`) references `users` (`id`) on delete cascade;
alter table `company_user` add unique `company_user_company_id_user_id_unique`(`company_id`, `user_id`);
create table `user_contexts` (`id` bigint unsigned not null auto_increment primary key, `user_id` bigint unsigned not null, `company_id` bigint unsigned null, `analysis_period_id` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `user_contexts` add constraint `user_contexts_user_id_foreign` foreign key (`user_id`) references `users` (`id`) on delete cascade;
alter table `user_contexts` add constraint `user_contexts_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete set null;
alter table `user_contexts` add constraint `user_contexts_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete set null;
alter table `user_contexts` add unique `user_contexts_user_id_unique`(`user_id`);
create table `roles` (`id` bigint unsigned not null auto_increment primary key, `slug` varchar(60) not null, `name` varchar(255) not null, `description` text null, `is_system` tinyint(1) not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `roles` add unique `roles_slug_unique`(`slug`);
create table `permissions` (`id` bigint unsigned not null auto_increment primary key, `slug` varchar(60) not null, `name` varchar(255) not null, `group` varchar(40) not null, `description` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `permissions` add unique `permissions_slug_unique`(`slug`);
create table `permission_role` (`permission_id` bigint unsigned not null, `role_id` bigint unsigned not null, primary key (`permission_id`, `role_id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `permission_role` add constraint `permission_role_permission_id_foreign` foreign key (`permission_id`) references `permissions` (`id`) on delete cascade;
alter table `permission_role` add constraint `permission_role_role_id_foreign` foreign key (`role_id`) references `roles` (`id`) on delete cascade;
create table `role_user` (`id` bigint unsigned not null auto_increment primary key, `role_id` bigint unsigned not null, `user_id` bigint unsigned not null, `company_id` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `role_user` add constraint `role_user_role_id_foreign` foreign key (`role_id`) references `roles` (`id`) on delete cascade;
alter table `role_user` add constraint `role_user_user_id_foreign` foreign key (`user_id`) references `users` (`id`) on delete cascade;
alter table `role_user` add constraint `role_user_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `role_user` add unique `role_user_role_id_user_id_company_id_unique`(`role_id`, `user_id`, `company_id`);
create table `audit_logs` (`id` bigint unsigned not null auto_increment primary key, `user_id` bigint unsigned null, `company_id` bigint unsigned null, `event` varchar(30) not null, `auditable_type` varchar(255) not null, `auditable_id` bigint unsigned null, `auditable_label` varchar(255) null, `old_values` json null, `new_values` json null, `url` varchar(500) null, `ip_address` varchar(45) null, `user_agent` varchar(500) null, `created_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `audit_logs` add constraint `audit_logs_user_id_foreign` foreign key (`user_id`) references `users` (`id`) on delete set null;
alter table `audit_logs` add constraint `audit_logs_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete set null;
alter table `audit_logs` add index `audit_logs_auditable_type_auditable_id_index`(`auditable_type`, `auditable_id`);
create table `dhastram_sequences` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned null, `prefix` varchar(20) not null, `year` smallint unsigned not null, `last_number` int unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `dhastram_sequences` add constraint `dhastram_sequences_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `dhastram_sequences` add constraint `dhastram_sequences_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `dhastram_sequences` add unique `dhastram_seq_unique`(`company_id`, `analysis_period_id`, `prefix`, `year`);
create table `environment_scans` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `scan_date` date not null, `scope` varchar(20) not null default 'eksternal', `source` varchar(255) null, `summary` text null, `implications` text null, `status` varchar(20) not null default 'aktif', `created_by` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `environment_scans` add constraint `environment_scans_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `environment_scans` add constraint `environment_scans_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `environment_scans` add constraint `environment_scans_created_by_foreign` foreign key (`created_by`) references `users` (`id`) on delete set null;
create table `pestel_analyses` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `factor` varchar(20) not null, `title` varchar(255) not null, `description` text null, `impact_type` varchar(20) not null default 'ancaman', `impact_level` tinyint unsigned not null default '3', `likelihood` tinyint unsigned not null default '3', `trend` varchar(20) not null default 'stabil', `response` text null, `source` varchar(255) null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `pestel_analyses` add constraint `pestel_analyses_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `pestel_analyses` add constraint `pestel_analyses_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `industry_forces` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `force` varchar(30) not null, `title` varchar(255) not null, `description` text null, `intensity` tinyint unsigned not null default '3', `implication` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `industry_forces` add constraint `industry_forces_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `industry_forces` add constraint `industry_forces_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `market_analyses` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `segment` varchar(255) not null, `segment_group` varchar(30) null, `description` text null, `share_percent` decimal(6, 2) null, `revenue_contribution` decimal(15, 2) null, `growth` varchar(20) not null default 'stabil', `is_target` tinyint(1) not null default '1', `needs` text null, `strategy` text null, `source` varchar(255) null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `market_analyses` add constraint `market_analyses_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `market_analyses` add constraint `market_analyses_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `competitors` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `name` varchar(255) not null, `category` varchar(50) null, `room_count` int unsigned null, `distance_km` decimal(6, 2) null, `data_period` varchar(50) null, `rank` tinyint unsigned null, `room_available` int unsigned null, `room_sold` int unsigned null, `occupancy` decimal(6, 2) null, `arr` decimal(15, 2) null, `revpar` decimal(15, 2) null, `rgi` decimal(6, 2) null, `mpi` decimal(6, 2) null, `ari` decimal(6, 2) null, `rating_google` decimal(4, 1) null, `rating_tripadvisor` decimal(4, 1) null, `rating_traveloka` decimal(4, 1) null, `rating_booking` decimal(4, 1) null, `rating_tiket` decimal(4, 1) null, `is_self` tinyint(1) not null default '0', `strengths` text null, `weaknesses` text null, `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `competitors` add constraint `competitors_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `competitors` add constraint `competitors_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `regulations` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `title` varchar(255) not null, `issuer` varchar(255) null, `reference_no` varchar(255) null, `category` varchar(40) null, `effective_date` date null, `description` text null, `impact` text null, `compliance_status` varchar(20) not null default 'dipantau', `owner_id` bigint unsigned null, `due_date` date null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `regulations` add constraint `regulations_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `regulations` add constraint `regulations_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `regulations` add constraint `regulations_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `stakeholders` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `name` varchar(255) not null, `type` varchar(20) not null default 'eksternal', `category` varchar(50) null, `interest` tinyint unsigned not null default '3', `influence` tinyint unsigned not null default '3', `expectations` text null, `engagement_strategy` text null, `contact_person` varchar(255) null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `stakeholders` add constraint `stakeholders_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `stakeholders` add constraint `stakeholders_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `strategic_issues` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `description` text null, `perspective` varchar(20) null, `urgency` tinyint unsigned not null default '3', `impact` tinyint unsigned not null default '3', `status` varchar(20) not null default 'terbuka', `source` varchar(255) null, `owner_id` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_issues` add constraint `strategic_issues_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_issues` add constraint `strategic_issues_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `strategic_issues` add constraint `strategic_issues_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `strategic_issue_stakeholder` (`strategic_issue_id` bigint unsigned not null, `stakeholder_id` bigint unsigned not null, primary key (`strategic_issue_id`, `stakeholder_id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_issue_stakeholder` add constraint `strategic_issue_stakeholder_strategic_issue_id_foreign` foreign key (`strategic_issue_id`) references `strategic_issues` (`id`) on delete cascade;
alter table `strategic_issue_stakeholder` add constraint `strategic_issue_stakeholder_stakeholder_id_foreign` foreign key (`stakeholder_id`) references `stakeholders` (`id`) on delete cascade;
create table `swot_items` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `type` varchar(1) not null, `title` varchar(255) not null, `description` text null, `weight` decimal(5, 2) null, `rating` tinyint unsigned null, `source` varchar(255) null, `sort` smallint unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `swot_items` add constraint `swot_items_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `swot_items` add constraint `swot_items_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `tows_strategies` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `type` varchar(2) not null, `title` varchar(255) not null, `description` text null, `priority` tinyint unsigned not null default '3', `status` varchar(20) not null default 'diusulkan', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `tows_strategies` add constraint `tows_strategies_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `tows_strategies` add constraint `tows_strategies_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `tows_strategy_issue` (`tows_strategy_id` bigint unsigned not null, `strategic_issue_id` bigint unsigned not null, primary key (`tows_strategy_id`, `strategic_issue_id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `tows_strategy_issue` add constraint `tows_strategy_issue_tows_strategy_id_foreign` foreign key (`tows_strategy_id`) references `tows_strategies` (`id`) on delete cascade;
alter table `tows_strategy_issue` add constraint `tows_strategy_issue_strategic_issue_id_foreign` foreign key (`strategic_issue_id`) references `strategic_issues` (`id`) on delete cascade;
create table `atman_profiles` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `vision` text null, `mission` text null, `purpose` text null, `tagline` varchar(255) null, `brand_promise` text null, `value_proposition` text null, `culture_statement` text null, `history` text null, `approved_by` bigint unsigned null, `approved_at` timestamp null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `atman_profiles` add constraint `atman_profiles_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `atman_profiles` add constraint `atman_profiles_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `atman_profiles` add constraint `atman_profiles_approved_by_foreign` foreign key (`approved_by`) references `users` (`id`) on delete set null;
alter table `atman_profiles` add unique `atman_profiles_company_id_analysis_period_id_unique`(`company_id`, `analysis_period_id`);
create table `core_values` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `name` varchar(255) not null, `local_name` varchar(255) null, `description` text null, `behaviors` text null, `sort` smallint unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `core_values` add constraint `core_values_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `core_values` add constraint `core_values_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `capabilities` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `name` varchar(255) not null, `category` varchar(40) null, `description` text null, `current_level` tinyint unsigned not null default '3', `target_level` tinyint unsigned not null default '4', `is_core` tinyint(1) not null default '0', `gap_action` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `capabilities` add constraint `capabilities_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `capabilities` add constraint `capabilities_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `strategic_themes` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `name` varchar(255) not null, `description` text null, `color` varchar(20) null, `sort` smallint unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_themes` add constraint `strategic_themes_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_themes` add constraint `strategic_themes_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
create table `strategic_choices` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `strategic_theme_id` bigint unsigned null, `title` varchar(255) not null, `choice_type` varchar(30) null, `description` text null, `rationale` text null, `status` varchar(20) not null default 'dipilih', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_choices` add constraint `strategic_choices_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_choices` add constraint `strategic_choices_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `strategic_choices` add constraint `strategic_choices_strategic_theme_id_foreign` foreign key (`strategic_theme_id`) references `strategic_themes` (`id`) on delete set null;
create table `strategic_objectives` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `perspective` varchar(20) not null, `strategic_theme_id` bigint unsigned null, `title` varchar(255) not null, `description` text null, `owner_id` bigint unsigned null, `weight` decimal(6, 2) not null default '1', `sort` smallint unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_objectives` add constraint `strategic_objectives_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_objectives` add constraint `strategic_objectives_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `strategic_objectives` add constraint `strategic_objectives_strategic_theme_id_foreign` foreign key (`strategic_theme_id`) references `strategic_themes` (`id`) on delete set null;
alter table `strategic_objectives` add constraint `strategic_objectives_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `objective_relations` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `source_objective_id` bigint unsigned not null, `target_objective_id` bigint unsigned not null, `strength` tinyint unsigned not null default '2', `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `objective_relations` add constraint `objective_relations_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `objective_relations` add constraint `objective_relations_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `objective_relations` add constraint `objective_relations_source_objective_id_foreign` foreign key (`source_objective_id`) references `strategic_objectives` (`id`) on delete cascade;
alter table `objective_relations` add constraint `objective_relations_target_objective_id_foreign` foreign key (`target_objective_id`) references `strategic_objectives` (`id`) on delete cascade;
create table `kpis` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `strategic_objective_id` bigint unsigned not null, `name` varchar(255) not null, `description` text null, `unit` varchar(30) not null, `direction` varchar(10) not null default 'higher', `frequency` varchar(20) not null default 'bulanan', `aggregation` varchar(10) not null default 'sum', `formula` text null, `data_source` varchar(255) null, `owner_id` bigint unsigned null, `weight` decimal(6, 2) not null default '1', `baseline` decimal(18, 4) null, `annual_target` decimal(18, 4) null, `decimals` tinyint unsigned not null default '0', `is_financial` tinyint(1) not null default '0', `is_critical` tinyint(1) not null default '0', `is_active` tinyint(1) not null default '1', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `kpis` add constraint `kpis_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `kpis` add constraint `kpis_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `kpis` add constraint `kpis_strategic_objective_id_foreign` foreign key (`strategic_objective_id`) references `strategic_objectives` (`id`) on delete cascade;
alter table `kpis` add constraint `kpis_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `kpi_targets` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `kpi_id` bigint unsigned not null, `month` tinyint unsigned not null, `target` decimal(18, 4) not null, `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `kpi_targets` add constraint `kpi_targets_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `kpi_targets` add constraint `kpi_targets_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `kpi_targets` add constraint `kpi_targets_kpi_id_foreign` foreign key (`kpi_id`) references `kpis` (`id`) on delete cascade;
alter table `kpi_targets` add unique `kpi_targets_kpi_id_month_unique`(`kpi_id`, `month`);
create table `kpi_actuals` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `kpi_id` bigint unsigned not null, `month` tinyint unsigned not null, `actual` decimal(18, 4) not null, `evidence` text null, `evidence_path` varchar(255) null, `notes` text null, `is_projection` tinyint(1) not null default '0', `status` varchar(20) not null default 'draf', `submitted_by` bigint unsigned null, `submitted_at` timestamp null, `verified_by` bigint unsigned null, `verified_at` timestamp null, `verification_note` text null, `approved_by` bigint unsigned null, `approved_at` timestamp null, `returned_by` bigint unsigned null, `returned_at` timestamp null, `return_note` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `kpi_actuals` add constraint `kpi_actuals_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `kpi_actuals` add constraint `kpi_actuals_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `kpi_actuals` add constraint `kpi_actuals_kpi_id_foreign` foreign key (`kpi_id`) references `kpis` (`id`) on delete cascade;
alter table `kpi_actuals` add constraint `kpi_actuals_submitted_by_foreign` foreign key (`submitted_by`) references `users` (`id`) on delete set null;
alter table `kpi_actuals` add constraint `kpi_actuals_verified_by_foreign` foreign key (`verified_by`) references `users` (`id`) on delete set null;
alter table `kpi_actuals` add constraint `kpi_actuals_approved_by_foreign` foreign key (`approved_by`) references `users` (`id`) on delete set null;
alter table `kpi_actuals` add constraint `kpi_actuals_returned_by_foreign` foreign key (`returned_by`) references `users` (`id`) on delete set null;
alter table `kpi_actuals` add unique `kpi_actuals_kpi_id_month_unique`(`kpi_id`, `month`);
alter table `kpi_actuals` add index `kpi_actuals_status_index`(`status`);
create table `performance_reviews` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `review_type` varchar(30) not null, `review_date` date not null, `period_label` varchar(255) null, `chair` varchar(255) null, `participants` text null, `venue` varchar(255) null, `summary` text null, `decisions` text null, `follow_up` text null, `status` varchar(20) not null default 'final', `recorded_by` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `performance_reviews` add constraint `performance_reviews_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `performance_reviews` add constraint `performance_reviews_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `performance_reviews` add constraint `performance_reviews_recorded_by_foreign` foreign key (`recorded_by`) references `users` (`id`) on delete set null;
create table `review_notes` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `performance_review_id` bigint unsigned not null, `user_id` bigint unsigned null, `note` text not null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `review_notes` add constraint `review_notes_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `review_notes` add constraint `review_notes_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `review_notes` add constraint `review_notes_performance_review_id_foreign` foreign key (`performance_review_id`) references `performance_reviews` (`id`) on delete cascade;
alter table `review_notes` add constraint `review_notes_user_id_foreign` foreign key (`user_id`) references `users` (`id`) on delete set null;
create table `strategic_initiatives` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `description` text null, `strategic_theme_id` bigint unsigned null, `owner_id` bigint unsigned null, `start_date` date null, `end_date` date null, `status` varchar(20) not null default 'direncanakan', `impact` tinyint unsigned not null default '3', `urgency` tinyint unsigned not null default '3', `risk` tinyint unsigned not null default '3', `budget_level` tinyint unsigned not null default '3', `budget_planned` decimal(18, 2) not null default '0', `progress` decimal(5, 2) not null default '0', `expected_outcome` text null, `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_initiatives` add constraint `strategic_initiatives_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_initiatives` add constraint `strategic_initiatives_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `strategic_initiatives` add constraint `strategic_initiatives_strategic_theme_id_foreign` foreign key (`strategic_theme_id`) references `strategic_themes` (`id`) on delete set null;
alter table `strategic_initiatives` add constraint `strategic_initiatives_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `initiative_objective` (`strategic_initiative_id` bigint unsigned not null, `strategic_objective_id` bigint unsigned not null, primary key (`strategic_initiative_id`, `strategic_objective_id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `initiative_objective` add constraint `initiative_objective_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete cascade;
alter table `initiative_objective` add constraint `initiative_objective_strategic_objective_id_foreign` foreign key (`strategic_objective_id`) references `strategic_objectives` (`id`) on delete cascade;
create table `initiative_activities` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `strategic_initiative_id` bigint unsigned not null, `name` varchar(255) not null, `description` text null, `owner_id` bigint unsigned null, `start_date` date null, `due_date` date null, `weight` decimal(6, 2) not null default '1', `progress` decimal(5, 2) not null default '0', `status` varchar(20) not null default 'belum', `completed_at` date null, `last_update_note` text null, `progress_updated_at` timestamp null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `initiative_activities` add constraint `initiative_activities_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `initiative_activities` add constraint `initiative_activities_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `initiative_activities` add constraint `initiative_activities_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete cascade;
alter table `initiative_activities` add constraint `initiative_activities_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `initiative_milestones` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `strategic_initiative_id` bigint unsigned not null, `name` varchar(255) not null, `due_date` date not null, `weight` decimal(6, 2) not null default '1', `is_achieved` tinyint(1) not null default '0', `achieved_at` date null, `evidence` text null, `owner_id` bigint unsigned null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `initiative_milestones` add constraint `initiative_milestones_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `initiative_milestones` add constraint `initiative_milestones_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `initiative_milestones` add constraint `initiative_milestones_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete cascade;
alter table `initiative_milestones` add constraint `initiative_milestones_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `initiative_budgets` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `strategic_initiative_id` bigint unsigned not null, `item` varchar(255) not null, `category` varchar(20) not null default 'opex', `planned_amount` decimal(18, 2) not null default '0', `realized_amount` decimal(18, 2) not null default '0', `realization_date` date null, `funding_source` varchar(255) null, `notes` text null, `verified_by` bigint unsigned null, `verified_at` timestamp null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `initiative_budgets` add constraint `initiative_budgets_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `initiative_budgets` add constraint `initiative_budgets_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `initiative_budgets` add constraint `initiative_budgets_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete cascade;
alter table `initiative_budgets` add constraint `initiative_budgets_verified_by_foreign` foreign key (`verified_by`) references `users` (`id`) on delete set null;
create table `findings` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `description` text null, `source` varchar(20) not null default 'tinjauan', `performance_review_id` bigint unsigned null, `perspective` varchar(20) null, `severity` varchar(20) not null default 'sedang', `amount` decimal(18, 2) null, `kpi_id` bigint unsigned null, `strategic_initiative_id` bigint unsigned null, `status` varchar(30) not null default 'terbuka', `raised_by` bigint unsigned null, `raised_at` date null, `closed_by` bigint unsigned null, `closed_at` timestamp null, `closure_note` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `findings` add constraint `findings_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `findings` add constraint `findings_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `findings` add constraint `findings_performance_review_id_foreign` foreign key (`performance_review_id`) references `performance_reviews` (`id`) on delete set null;
alter table `findings` add constraint `findings_kpi_id_foreign` foreign key (`kpi_id`) references `kpis` (`id`) on delete set null;
alter table `findings` add constraint `findings_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete set null;
alter table `findings` add constraint `findings_raised_by_foreign` foreign key (`raised_by`) references `users` (`id`) on delete set null;
alter table `findings` add constraint `findings_closed_by_foreign` foreign key (`closed_by`) references `users` (`id`) on delete set null;
create table `corrective_actions` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `finding_id` bigint unsigned not null, `title` varchar(255) not null, `description` text null, `owner_id` bigint unsigned null, `due_date` date null, `status` varchar(20) not null default 'belum', `progress` tinyint unsigned not null default '0', `completed_at` date null, `result_note` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `corrective_actions` add constraint `corrective_actions_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `corrective_actions` add constraint `corrective_actions_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `corrective_actions` add constraint `corrective_actions_finding_id_foreign` foreign key (`finding_id`) references `findings` (`id`) on delete cascade;
alter table `corrective_actions` add constraint `corrective_actions_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `maturity_questions` (`id` bigint unsigned not null auto_increment primary key, `phase` varchar(20) not null, `dimension` varchar(255) not null, `question` text not null, `guidance` text null, `weight` decimal(5, 2) not null default '1', `sort` smallint unsigned not null default '0', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
create table `maturity_assessments` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `code` varchar(40) null, `title` varchar(255) not null, `assessment_date` date not null, `assessor_id` bigint unsigned null, `overall_score` decimal(4, 2) null, `level` tinyint unsigned null, `status` varchar(20) not null default 'draf', `notes` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `maturity_assessments` add constraint `maturity_assessments_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `maturity_assessments` add constraint `maturity_assessments_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `maturity_assessments` add constraint `maturity_assessments_assessor_id_foreign` foreign key (`assessor_id`) references `users` (`id`) on delete set null;
create table `maturity_answers` (`id` bigint unsigned not null auto_increment primary key, `maturity_assessment_id` bigint unsigned not null, `maturity_question_id` bigint unsigned not null, `score` tinyint unsigned not null default '1', `evidence` text null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `maturity_answers` add constraint `maturity_answers_maturity_assessment_id_foreign` foreign key (`maturity_assessment_id`) references `maturity_assessments` (`id`) on delete cascade;
alter table `maturity_answers` add constraint `maturity_answers_maturity_question_id_foreign` foreign key (`maturity_question_id`) references `maturity_questions` (`id`) on delete cascade;
alter table `maturity_answers` add unique `maturity_answer_unique`(`maturity_assessment_id`, `maturity_question_id`);
create table `strategic_dependencies` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `title` varchar(255) not null, `dependency_type` varchar(20) not null default 'internal', `strategic_initiative_id` bigint unsigned null, `strategic_objective_id` bigint unsigned null, `depends_on` varchar(255) not null, `description` text null, `owner_id` bigint unsigned null, `risk_level` varchar(20) not null default 'sedang', `mitigation` text null, `status` varchar(20) not null default 'aktif', `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `strategic_dependencies` add constraint `strategic_dependencies_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `strategic_dependencies` add constraint `strategic_dependencies_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `strategic_dependencies` add constraint `strategic_dependencies_strategic_initiative_id_foreign` foreign key (`strategic_initiative_id`) references `strategic_initiatives` (`id`) on delete set null;
alter table `strategic_dependencies` add constraint `strategic_dependencies_strategic_objective_id_foreign` foreign key (`strategic_objective_id`) references `strategic_objectives` (`id`) on delete set null;
alter table `strategic_dependencies` add constraint `strategic_dependencies_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `institutionalizations` (`id` bigint unsigned not null auto_increment primary key, `company_id` bigint unsigned not null, `analysis_period_id` bigint unsigned not null, `title` varchar(255) not null, `mechanism_type` varchar(30) not null, `description` text null, `frequency` varchar(30) null, `owner_id` bigint unsigned null, `status` varchar(20) not null default 'rencana', `evidence` text null, `started_at` date null, `next_review_date` date null, `created_at` timestamp null, `updated_at` timestamp null) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `institutionalizations` add constraint `institutionalizations_company_id_foreign` foreign key (`company_id`) references `companies` (`id`) on delete cascade;
alter table `institutionalizations` add constraint `institutionalizations_analysis_period_id_foreign` foreign key (`analysis_period_id`) references `analysis_periods` (`id`) on delete cascade;
alter table `institutionalizations` add constraint `institutionalizations_owner_id_foreign` foreign key (`owner_id`) references `users` (`id`) on delete set null;
create table `notifications` (`id` char(36) not null, `type` varchar(255) not null, `notifiable_type` varchar(255) not null, `notifiable_id` bigint unsigned not null, `data` text not null, `read_at` timestamp null, `created_at` timestamp null, `updated_at` timestamp null, primary key (`id`)) default character set utf8mb4 collate 'utf8mb4_unicode_ci' engine = InnoDB;
alter table `notifications` add index `notifications_notifiable_type_notifiable_id_index`(`notifiable_type`, `notifiable_id`);

-- ---------------- Data

-- analysis_periods (2 baris)
INSERT INTO `analysis_periods` (`id`, `company_id`, `code`, `name`, `year`, `start_date`, `end_date`, `status`, `is_active`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, '2026', 'Perioda 2026', 2026, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 'berjalan', 1, 'Realisasi Jan–Sep 2026 dimuat dari Review Keuangan & GM Weekly Report; wajib divalidasi Chief Accountant sebelum dikunci.', '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(2, 1, '2027', 'Perioda 2027', 2027, '2027-01-01 00:00:00', '2027-12-31 00:00:00', 'perencanaan', 0, 'Disiapkan untuk penyusunan rencana & budgeting 2027 (Nov–Des 2026).', '2026-10-18 00:25:06', '2026-10-18 00:25:06');

-- atman_profiles (2 baris)
INSERT INTO `atman_profiles` (`id`, `company_id`, `analysis_period_id`, `vision`, `mission`, `purpose`, `tagline`, `brand_promise`, `value_proposition`, `culture_statement`, `history`, `approved_by`, `approved_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Menjadi hotel dan pusat konvensi serbaguna berbasis pengalaman Pasundan yang menjadi kebanggaan Bandung dan pilihan utama korporasi, instansi, komunitas, dan keluarga.', '1. Menghadirkan pengalaman menginap dan berkegiatan yang autentik bernuansa Sunda melalui pelayanan someah, kuliner, dan cerita.\n2. Menyediakan venue MICE, wedding, dan acara sosial yang layak, fleksibel, dan bernilai bagi pelanggan.\n3. Mengelola keuangan secara disiplin dan transparan dengan laporan bulanan yang lengkap (laba rugi, arus kas, neraca).\n4. Merawat aset dan fasilitas secara terencana agar nilai properti terus meningkat.\n5. Membangun SDM multitasking yang kompeten, sejahtera, dan bangga bekerja di Grand Pasundan.', 'Mengembalikan kejayaan Grand Pasundan sebagai landmark hotel & convention Bandung yang melestarikan tradisi Pasundan.', 'Preserve Pasundan Tradition', 'Kamar luas, venue besar, dan keramahan Sunda — setiap kunjungan meninggalkan cerita.', 'Satu-satunya hotel bintang 4 di koridor Pasir Koja dengan convention hall 1.200 pax, 13 ruang rapat, kamar berukuran luas, kolam renang besar, dan pengalaman kuliner & budaya Sunda dengan harga terjangkau.', 'Kita bekerja sebagai satu tim: bersepakat dalam rapat berarti bersepakat dalam tindakan. Ketegasan pimpinan adalah bentuk menegakkan aturan, bukan tekanan. Sistem adalah alat operasional, bukan sekadar laporan.', 'Didirikan sebagai landmark hotel & convention utama Bandung dengan lahan luas dan bangunan kokoh. Assessment Des 2024 mencatat aura kejayaan mulai pudar; Konsep Kerja Maret 2025 menetapkan arah hotel serbaguna berbasis pengalaman; VHP Cloud live April 2025; Tim Pengawas aktif mengawasi sejak 2026; GM baru bergabung 1 Oktober 2026.', 4, '2026-10-12 10:00:00', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 2, 'Menjadi hotel dan pusat konvensi serbaguna berbasis pengalaman Pasundan yang menjadi kebanggaan Bandung dan pilihan utama korporasi, instansi, komunitas, dan keluarga.', '1. Menghadirkan pengalaman menginap dan berkegiatan yang autentik bernuansa Sunda melalui pelayanan someah, kuliner, dan cerita.\n2. Menyediakan venue MICE, wedding, dan acara sosial yang layak, fleksibel, dan bernilai bagi pelanggan.\n3. Mengelola keuangan secara disiplin dan transparan dengan laporan bulanan yang lengkap (laba rugi, arus kas, neraca).\n4. Merawat aset dan fasilitas secara terencana agar nilai properti terus meningkat.\n5. Membangun SDM multitasking yang kompeten, sejahtera, dan bangga bekerja di Grand Pasundan.', 'Mengembalikan kejayaan Grand Pasundan sebagai landmark hotel & convention Bandung yang melestarikan tradisi Pasundan.', 'Preserve Pasundan Tradition', 'Kamar luas, venue besar, dan keramahan Sunda — setiap kunjungan meninggalkan cerita.', 'Satu-satunya hotel bintang 4 di koridor Pasir Koja dengan convention hall 1.200 pax, 13 ruang rapat, kamar berukuran luas, kolam renang besar, dan pengalaman kuliner & budaya Sunda dengan harga terjangkau.', 'Kita bekerja sebagai satu tim: bersepakat dalam rapat berarti bersepakat dalam tindakan. Ketegasan pimpinan adalah bentuk menegakkan aturan, bukan tekanan. Sistem adalah alat operasional, bukan sekadar laporan.', 'Didirikan sebagai landmark hotel & convention utama Bandung dengan lahan luas dan bangunan kokoh. Assessment Des 2024 mencatat aura kejayaan mulai pudar; Konsep Kerja Maret 2025 menetapkan arah hotel serbaguna berbasis pengalaman; VHP Cloud live April 2025; Tim Pengawas aktif mengawasi sejak 2026; GM baru bergabung 1 Oktober 2026.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- capabilities (10 baris)
INSERT INTO `capabilities` (`id`, `company_id`, `analysis_period_id`, `name`, `category`, `description`, `current_level`, `target_level`, `is_core`, `gap_action`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Malibu Dome & 13 ruang rapat', 'Sumber daya fisik', 'Convention hall 48×24 m (1.152 m²) untuk 1.200 pax theater; Half Malibu 500 pax; Jayagiri 272 m²; Wastukantjana, Niskala, Citraganda, Sri Baduga, Sangkuriang, Arimbi, Linggabumi, Linggawarman, Dayang Sumbi, Raga Suci, Layungwangi.', 4, 5, 1, 'Perbaiki plafon Jayagiri, karpet, screen & AV (smartboard).', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'Kamar luas & variasi suite', 'Sumber daya fisik', '155 kamar + 7 suite + 3-Bedroom Pasundan Suite; Standard 3×5 m, Deluxe/Executive 4×8 m, Grand Family Suite, President Suite (lt. 11).', 4, 4, 1, 'Refresh kamar bertahap (20 kamar/periode), pencahayaan kerja & amenities.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'Lahan, parkir & kolam renang', 'Sumber daya fisik', 'Parkir ±200 kendaraan, kolam renang besar, kids corner, D\'Linda Poolside Cafetaria.', 4, 4, 1, 'Redesign area kolam agar lebih berkelas; perbaiki sand filter.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'Kuliner Sunda & breakfast', 'Kompetensi', 'Nasi Timbel Empal, nampan nasi liwet & tutug oncom, peyeum goreng; breakfast melampaui budget.', 3, 4, 1, 'Standard recipe di VHP, menu bercerita, kelas memasak Sunda.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'Penjualan MICE & pemerintahan', 'Kompetensi', 'Relasi dengan instansi Kota/Kab. Bandung & Jabar; tim sales (Irina, Rika, Arsy, Lisma).', 3, 4, 0, 'Daily pipeline report, pitching korporasi & EO.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'Pemasaran digital & e-commerce', 'Kompetensi', 'WA blast, OTA campaign, booking engine, metasearch Google (Alaric).', 2, 4, 0, 'Konten storytelling, influencer, promo code website.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'Manajemen keuangan & pelaporan', 'Sistem', 'Laporan keuangan bulanan belum lengkap; neraca baru disusun; disiplin persediaan.', 2, 4, 0, 'Tiga laporan wajib tiap bulan; proyeksi kas mingguan.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'Sistem informasi (VHP Cloud & Arah GPCH)', 'Sistem', 'VHP live Apr 2025 (FO, POS, NA, IA, AR, Banquet); back office menunggu data master.', 2, 4, 0, 'Lengkapi saldo awal, artikel, supplier; dashboard VHP; Arah GPCH untuk KPI.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'Pemeliharaan preventif', 'Kompetensi', 'Tim engineering terbatas (4 teknisi pada 2024); CE masih Plt.', 2, 4, 0, 'Rekrut CE, jadwal preventif, dokumentasi & pelaporan maintenance.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'SDM pelayanan multitasking', 'Kompetensi', '72 karyawan (PKWT 34, daily worker 38) + 17 trainee; rasio 0,44/kamar.', 3, 4, 0, 'Pelatihan silang, evaluasi kinerja bulanan, program PKL.', '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- companies (1 baris)
INSERT INTO `companies` (`id`, `code`, `name`, `legal_name`, `industry`, `address`, `city`, `phone`, `email`, `website`, `room_count`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'GPCH', 'Grand Pasundan Convention Hotel', 'Grand Pasundan Convention Hotel', 'Hotel & Convention (bintang 4)', 'Jl. Peta No. 147–149, Suka Asih, Kec. Bojongloa Kaler', 'Bandung, Jawa Barat 40232', '022 6043135 / WA 0811 2266 959', 'reservation@grandpasundanhotel.com', 'https://grandpasundanhotel.com', 164, 'Hotel bintang 4 dengan 164 kamar (155 kamar, 7 suite, 3-Bedroom Pasundan Suite), Malibu Dome Convention Hall 1.152 m² (1.200 pax theater), 13 ruang rapat, coffee shop (Cafe Delapan), D\'Linda Poolside Cafetaria, lobby lounge, kolam renang, fitness & spa, family karaoke, kids corner, Pustaka Pasundan, parkir ±200 kendaraan. Konsep: "Preserve Pasundan Tradition".', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06');

-- company_user (24 baris)
INSERT INTO `company_user` (`id`, `company_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 1, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 1, 9, NULL, NULL),
(10, 1, 10, NULL, NULL),
(11, 1, 11, NULL, NULL),
(12, 1, 12, NULL, NULL),
(13, 1, 13, NULL, NULL),
(14, 1, 14, NULL, NULL),
(15, 1, 15, NULL, NULL),
(16, 1, 16, NULL, NULL),
(17, 1, 17, NULL, NULL),
(18, 1, 18, NULL, NULL),
(19, 1, 19, NULL, NULL),
(20, 1, 20, NULL, NULL),
(21, 1, 21, NULL, NULL),
(22, 1, 22, NULL, NULL),
(23, 1, 23, NULL, NULL),
(24, 1, 24, NULL, NULL);

-- competitors (5 baris)
INSERT INTO `competitors` (`id`, `company_id`, `analysis_period_id`, `name`, `category`, `room_count`, `distance_km`, `data_period`, `rank`, `room_available`, `room_sold`, `occupancy`, `arr`, `revpar`, `rgi`, `mpi`, `ari`, `rating_google`, `rating_tripadvisor`, `rating_traveloka`, `rating_booking`, `rating_tiket`, `is_self`, `strengths`, `weaknesses`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Grand Pasundan Convention Hotel', 'Bintang 4', 164, NULL, 'Sep 2026 (GM Weekly Report)', 3, 4733, 2619, 55.33, 330913, 183110, 0.92, 0.96, 0.96, 4.4, 4.4, 8.3, 9.3, 4.1, 1, 'Malibu Dome 1.200 pax, kamar luas, lahan & parkir luas, kolam besar.', 'Bangunan terkesan jadul, ruang rapat & dapur perlu revitalisasi, ARR di bawah pesaing.', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'Harris Hotel Festival Citylink', 'Bintang 4', NULL, NULL, 'Sep 2026 (GM Weekly Report)', 2, 5020, 2697, 53.72, 392520, 210880, 1.19, 1.06, 1.12, 4.6, 4.6, 8.4, 8.3, 4.5, 0, 'Terhubung mal Festival Citylink, brand jaringan nasional.', 'Kapasitas ballroom lebih kecil dari Malibu Dome.', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'Santika Hotel Pasir Koja', 'Bintang 3', NULL, NULL, 'Sep 2026 (GM Weekly Report)', 1, 2520, 1672, 66.34, 360517, 239200, 1.35, 1.31, 1.03, 4.7, 4.9, 8.6, 8.3, 4.5, 0, 'Okupansi & RevPAR tertinggi, rating Google 4,7; memenangkan event yang pindah dari GPCH (Puratos).', 'Jumlah kamar lebih sedikit.', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'Horison Hotel Bandung', 'Bintang 4', NULL, NULL, 'Sep 2026 (GM Weekly Report)', 4, 5656, 2916, 51.55, 377955, 194850, 1.1, 1.01, 1.08, 4.2, 4.4, 7.9, 7.2, 4, 0, 'Jaringan Horison, aktif di reuni & instansi (Reuni BNI, Kowad).', 'Rating OTA lebih rendah.', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'Grand Asrilia Hotel', 'Bintang 4', NULL, NULL, 'Sep 2026 (GM Weekly Report)', 5, 5860, 2450, 41.8, 322078, 134650, 0.76, 0.82, 0.92, 4.3, 3, 8.3, NULL, 4.2, 0, 'Convention & exhibition, dekat pusat kota.', 'Okupansi & RevPAR terendah di competitive set.', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- core_values (12 baris)
INSERT INTO `core_values` (`id`, `company_id`, `analysis_period_id`, `name`, `local_name`, `description`, `behaviors`, `sort`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Someah', 'Someah hade ka semah', 'Ramah, hangat, dan melayani sepenuh hati seperti menyambut tamu di rumah sendiri.', 'Menyapa tamu dengan senyum dan salam\nMenyampaikan cerita singkat tentang Pasundan kepada tamu\nMembalas setiap ulasan tamu dalam 24 jam', 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'Sabilulungan', 'Gotong royong', 'Bekerja sama lintas departemen; tim yang kuat lebih penting dari bintang perorangan.', 'Membantu departemen lain saat peak (multitasking)\nMelaporkan kerusakan yang ditemukan meski bukan tugasnya\nTidak saling menyalahkan dalam rapat', 2, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'Jujur & Amanah', 'Jujur', 'Mencatat dan melaporkan apa adanya, termasuk biaya dan persediaan.', 'Tidak menangguhkan beban di data persediaan\nBukti pendukung untuk setiap realisasi KPI\nMenjaga dana deposit tamu sesuai peruntukannya', 3, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'Disiplin', 'Taat kana aturan', 'Taat pada SOP, jadwal, dan keputusan rapat.', 'Input realisasi KPI paling lambat tanggal 5\nTindak lanjut MoM sesuai timeline & PIC\nMenegur sesuai peraturan, bukan menekan', 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'Berorientasi Hasil', 'Hasil', 'Tujuan pemilik hanya satu: hasil. Setiap kegiatan harus berdampak pada pendapatan, biaya, atau kepuasan tamu.', 'Mengukur dampak setiap promo\nMencari peluang event yang sedang tren\nMengurangi pemborosan', 5, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'Silih Asah', 'Silih asah, silih asih, silih asuh', 'Terus belajar dan saling mengajari agar kompeten dan berkembang.', 'Mengikuti refresh training departemen\nMembimbing siswa PKL & trainee\nBerbagi praktik baik dalam briefing', 6, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 2, 'Someah', 'Someah hade ka semah', 'Ramah, hangat, dan melayani sepenuh hati seperti menyambut tamu di rumah sendiri.', 'Menyapa tamu dengan senyum dan salam\nMenyampaikan cerita singkat tentang Pasundan kepada tamu\nMembalas setiap ulasan tamu dalam 24 jam', 1, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 2, 'Sabilulungan', 'Gotong royong', 'Bekerja sama lintas departemen; tim yang kuat lebih penting dari bintang perorangan.', 'Membantu departemen lain saat peak (multitasking)\nMelaporkan kerusakan yang ditemukan meski bukan tugasnya\nTidak saling menyalahkan dalam rapat', 2, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 2, 'Jujur & Amanah', 'Jujur', 'Mencatat dan melaporkan apa adanya, termasuk biaya dan persediaan.', 'Tidak menangguhkan beban di data persediaan\nBukti pendukung untuk setiap realisasi KPI\nMenjaga dana deposit tamu sesuai peruntukannya', 3, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 2, 'Disiplin', 'Taat kana aturan', 'Taat pada SOP, jadwal, dan keputusan rapat.', 'Input realisasi KPI paling lambat tanggal 5\nTindak lanjut MoM sesuai timeline & PIC\nMenegur sesuai peraturan, bukan menekan', 4, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 2, 'Berorientasi Hasil', 'Hasil', 'Tujuan pemilik hanya satu: hasil. Setiap kegiatan harus berdampak pada pendapatan, biaya, atau kepuasan tamu.', 'Mengukur dampak setiap promo\nMencari peluang event yang sedang tren\nMengurangi pemborosan', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 2, 'Silih Asah', 'Silih asah, silih asih, silih asuh', 'Terus belajar dan saling mengajari agar kompeten dan berkembang.', 'Mengikuti refresh training departemen\nMembimbing siswa PKL & trainee\nBerbagi praktik baik dalam briefing', 6, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- corrective_actions (20 baris)
INSERT INTO `corrective_actions` (`id`, `company_id`, `analysis_period_id`, `finding_id`, `title`, `description`, `owner_id`, `due_date`, `status`, `progress`, `completed_at`, `result_note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Daily pipeline report banquet (inquiry–confirmed) dikirim ke GM', NULL, 7, '2026-09-30 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 1, 'Tactical promotion untuk tanggal low occupancy Okt 2026', NULL, 8, '2026-10-05 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 1, 'Follow up Piala Gubernur & PORPROV sampai confirmed', NULL, 7, '2026-10-20 00:00:00', 'berjalan', 50, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 1, 'Evaluasi target banquet Q4 terhadap kondisi permintaan', NULL, 4, '2026-10-31 00:00:00', 'belum', 0, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 2, 'SOP cek konflik venue & opsi venue alternatif sebelum quotation', NULL, 7, '2026-10-15 00:00:00', 'berjalan', 60, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 2, 'Kajian teknis peningkatan plafon / penataan Jayagiri', NULL, 10, '2026-11-15 00:00:00', 'belum', 0, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 2, 'Analisis penyebab kalah pitching vs kompetitor', NULL, 7, '2026-10-10 00:00:00', 'berjalan', 40, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 3, 'Perbaikan kebocoran sand filter & uji tekanan', NULL, 10, '2026-10-10 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 4, 'Laporkan akun palsu ke Google & verifikasi ulang profil resmi', NULL, 8, '2026-10-12 00:00:00', 'berjalan', 50, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 4, 'Pantau & balas ulasan harian (≤ 24 jam)', NULL, 8, '2026-10-31 00:00:00', 'berjalan', 70, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 5, 'Standar 2 botol air mineral per kamar per malam di semua kamar', NULL, 11, '2026-10-05 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 1, 5, 'Proposal depo air minum (Purchasing)', NULL, 13, '2026-10-15 00:00:00', 'berjalan', 60, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 1, 6, 'Pendataan cost yang ditangguhkan vs riil', NULL, 6, '2026-06-30 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(14, 1, 1, 6, 'Pembebanan riil di closing Juni & seterusnya', NULL, 6, '2026-07-10 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(15, 1, 1, 7, 'Proyeksi kas mingguan dipresentasikan setiap Senin', NULL, 6, '2026-07-31 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(16, 1, 1, 7, 'Penagihan piutang lama > 60 hari', NULL, 6, '2026-09-30 00:00:00', 'berjalan', 55, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(17, 1, 1, 7, 'Buka rekening khusus deposit TA/OTA', NULL, 6, '2026-09-30 00:00:00', 'berjalan', 20, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(18, 1, 1, 7, 'Jadwal cicilan PBB 2025 disepakati Bapenda', NULL, 6, '2026-08-31 00:00:00', 'berjalan', 25, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(19, 1, 1, 8, 'Surat kuasa penutupan rekening BRI', NULL, 6, '2026-06-20 00:00:00', 'selesai', 100, '2026-10-18 00:00:00', 'Selesai — bukti di laporan departemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(20, 1, 1, 8, 'Laporan kehilangan cek & penutupan rekening BJB', NULL, 6, '2026-08-31 00:00:00', 'berjalan', 30, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- dhastram_sequences (13 baris)
INSERT INTO `dhastram_sequences` (`id`, `company_id`, `analysis_period_id`, `prefix`, `year`, `last_number`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'SCAN', 2026, 6, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'ISU', 2026, 12, '2026-10-18 00:25:12', '2026-10-18 00:25:13'),
(3, 1, 1, 'TOWS', 2026, 10, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'TEMA', 2026, 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'PIL', 2026, 10, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'OBJ', 2026, 13, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'KPI', 2026, 28, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'REV', 2026, 6, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 'INI', 2026, 11, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 'TMN', 2026, 9, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 'MAT', 2026, 1, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 2, 'TEMA', 2027, 4, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 2, 'SCAN', 2027, 2, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- environment_scans (8 baris)
INSERT INTO `environment_scans` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `scan_date`, `scope`, `source`, `summary`, `implications`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'SCAN/GPCH/2026/001', 'Assessment awal operasional & fasilitas', '2024-12-08 00:00:00', 'internal', 'The Grand Pasundan: Sebuah Assessment Awal — I.G. Wiwin Suyasa (Visi Perencana Indonesia), 7–8 Des 2024', 'Fasilitas mulai kusam (marmer lobby, toilet lobby, karpet & screen ruang rapat robek, dapur & pastry tidak layak, kolam tanpa style). SDM: motivasi rendah (mayoritas karyawan tetap usia 50+), teknisi hanya 4 orang, belum ada program pelatihan, gaji & service charge sering terlambat (service sempat tertunda 5 bulan). Keuangan: tidak ada Balance Sheet, PnL tidak selalu ada tiap bulan. Keunggulan: ukuran kamar luas, lahan luas, executive floor & lounge berpotensi.', 'Prioritas perbaikan bertahap: dapur & pastry (epoxy 3–5 mm), ruang rapat (karpet, screen, smartboard co-branding), lobby & toilet. Wajib tiga laporan keuangan bulanan. Upgrade PMS (VHP/OmniH) yang terhubung OTA.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'SCAN/GPCH/2026/002', 'Konsep Kerja Manajemen Baru 2025 — Hotel Serbaguna Berbasis Pengalaman', '2025-03-13 00:00:00', 'eksternal', 'Konsep Kerja GPCH 2025 — GM Fery Ferdiansyah & Pengawas Umum Sonny L. Halim', 'Pasar bergeser ke pengalaman yang fleksibel & personal; persaingan hotel bertema; MICE pemerintah berkurang akibat pemangkasan anggaran. Peluang coworking/WFH, family staycation, wedding experience, komunitas.', 'Konsep hotel serbaguna & storytelling Sunda, pemasaran digital (IG, TikTok, SEO, influencer, kode promo GRANDPASUNDAN10), kerja sama TA/EO Jateng–Jatim, QRIS di semua outlet, SDM multitasking, opsi outsourcing supporting department.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'SCAN/GPCH/2026/003', 'Implementasi VHP Cloud (PMS & back office)', '2025-04-04 00:00:00', 'internal', 'Weekly Implementation Checklist VHP — Mukti & Yohanes (Mar–Apr 2025)', 'Setup FO, POS (4 outlet), Night Audit, Income Audit, AR, Banquet selesai Mar–Apr 2025. Tertunda di pihak hotel: saldo awal, aging AR/AP, supplier, artikel inventory, store, cost center, keycard, PABX, channel manager. Tidak ada modul fixed asset & engineering.', 'Lengkapi data master back office agar laporan BS & PnL bisa dihasilkan dari sistem; manfaatkan dashboard VHP Mobile.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'SCAN/GPCH/2026/004', 'Review keuangan Juni 2026 — likuiditas', '2026-06-30 00:00:00', 'internal', 'Analisis Singkat Keuangan GPCH — Juni 2026', 'Penerimaan Rp2.401.524.265 vs pengeluaran Rp2.379.705.393 (surplus Rp21,8 jt = 0,91%). Saldo bank Rp331,8 jt; aset lancar Rp754,9 jt hanya 45% dari kewajiban operasional Rp1.685,4 jt. Deposit TA/OTA Rp582,1 jt melebihi saldo bank. Pembelian F&B Rp464,4 jt (52% pendapatan F&B). Utang PBB 2025 Rp339,3 jt; utang CEO jangka panjang Rp30,91 M.', 'Proyeksi kas mingguan, percepatan penagihan piutang, kendali food cost, jaga deposit OTA, jadwalkan pemasok & PBB, restrukturisasi utang CEO.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'SCAN/GPCH/2026/005', 'Benchmark kompetitor & pasar — September 2026', '2026-09-28 00:00:00', 'eksternal', 'GM Weekly Report 21–27 Sep 2026', 'GPCH peringkat 3 dari 5 dalam competitive set: okupansi 55,33%, ARR Rp330.913, RGI 0,92, MPI 0,96, ARI 0,96. Santika Pasir Koja memimpin RevPAR (RGI 1,35). Rating Booking.com GPCH tertinggi (9,3) namun Google 4,4 dan Tiket.com 4,1. Lost business Rp192,5 jt dalam sepekan karena kalah pitching dan bentrok jadwal Malibu Dome.', 'Revenue recovery: tactical promotion pada tanggal low-demand, jaga ADR, push corporate/government/group/OTA; banquet sebagai prioritas utama.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'SCAN/GPCH/2026/006', 'Tren event & pameran: kendaraan listrik, olahraga daerah', '2026-09-23 00:00:00', 'eksternal', 'MoM Rapat Manajemen 23 Sep 2026', 'Pameran mobil listrik sedang tren; prospek PORPROV (Nov, est. Rp45 jt) & Piala Gubernur (Okt, est. Rp153,8 jt) dari pendekatan DISPORA/KONI Jabar; Malibu Dome dipromosikan sebagai venue exhibition (Tribun Jabar).', 'Sales mencari peluang event yang sedang booming; HOD ikut mencari peluang event.', 'aktif', 5, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 2, 'SCAN/GPCH/2027/001', 'Agenda budgeting 2027 — pameran & travel mart', '2026-10-02 00:00:00', 'eksternal', 'GM Weekly Report Sep 2026 — Sales & Marketing Plan', 'Heritage Wedding Bride Expo 2027 (Lintas Warna EO) 9–10 Jan 2027 di Grand Sudirman Ballroom, est. Rp13 jt; Superstar Wedding Exhibition (WA Wedding Planner) 26–27 Jun 2027, Rp15 jt; Lare Table Top Jogja Business Matching 19–21 Jan, Rp5,5 jt/delegate; ASITA West Java Travel Mart Bandung (TBA Sep 2027), Rp6 jt/delegate.', 'Masukkan ke anggaran marketing 2027 & inisiatif kemitraan TA/EO.', 'aktif', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 2, 'SCAN/GPCH/2027/002', 'Kerangka penyusunan rencana 2027', '2026-10-17 00:00:00', 'internal', 'Spesifikasi Arah GPCH', 'Urutan: Ekosistem → Jati Diri → sasaran, target, inisiatif. Data budgeting tiap departemen dikumpulkan (format streaming account, SWOT, expenses).', 'Penilaian kematangan Nov–Des 2026 menjadi masukan rencana 2027.', 'aktif', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- findings (9 baris)
INSERT INTO `findings` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `description`, `source`, `performance_review_id`, `perspective`, `severity`, `amount`, `kpi_id`, `strategic_initiative_id`, `status`, `raised_by`, `raised_at`, `closed_by`, `closed_at`, `closure_note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TMN/GPCH/2026/001', 'Revenue shortfall September 2026', 'Total revenue MTD 21–27 Sep Rp1,41 M = 51,6% budget (shortfall Rp988,9 jt); banquet shortfall Rp681,95 jt menjadi penyumbang terbesar.', 'tinjauan', 6, 'keuangan', 'kritis', 988895706, 1, 5, 'dalam_tindak_lanjut', 4, '2026-09-28 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 'TMN/GPCH/2026/002', 'Lost business Rp192,5 jt (21–27 Sep 2026)', 'Kalah pitching (Gadar Medik: room Rp29 jt + MICE Rp71 jt), bentrok jadwal Malibu Dome dengan event PSI (Ega Fam Gath Rp22,5 jt; Forum Muslimah Ukhuwah Rp20,3 jt + Rp49,7 jt). Puratos membatalkan dan pindah ke Santika Pasir Koja karena plafon Jayagiri rendah.', 'tinjauan', 6, 'pelanggan', 'tinggi', 192500000, 20, 5, 'dalam_tindak_lanjut', 4, '2026-09-28 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 'TMN/GPCH/2026/003', 'Kebocoran sand filter kolam renang', 'Setelah pompa Hayward 2HP terpasang (28 Sep 2026) ditemukan kebocoran pada sand filter.', 'tinjauan', 6, 'proses', 'sedang', NULL, 23, 8, 'siap_ditutup', 10, '2026-09-28 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 'TMN/GPCH/2026/004', 'Akun Google Business palsu & komentar spam', 'Ada akun palsu yang mengatasnamakan hotel dan fake comment di Google Business; berisiko menyesatkan tamu dan menurunkan rating.', 'pelanggan', 6, 'pelanggan', 'tinggi', NULL, 16, 3, 'dalam_tindak_lanjut', 4, '2026-09-28 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 'TMN/GPCH/2026/005', 'Kamar bintang 4 tanpa air mineral', 'Keluhan tamu Traveloka (skor 6,7): kamar tidak disediakan air mineral; ulasan lain menyinggung sarapan berbayar & bangunan jadul.', 'pelanggan', 6, 'pelanggan', 'sedang', NULL, 17, 7, 'dalam_tindak_lanjut', 4, '2026-09-28 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 'TMN/GPCH/2026/006', 'Penangguhan beban food cost pada data persediaan (Rp667,5 jt)', 'Feb–Mar 2026 dilakukan deferred cost untuk menjaga GOP; Timwas memutuskan beban dibebankan riil dan tidak ada lagi penangguhan.', 'timwas', 1, 'keuangan', 'tinggi', 667500000, 10, 7, 'ditutup', 3, '2026-06-03 00:00:00', 4, '2026-07-15 16:00:00', 'Ditutup pada Tinjauan Keuangan Q2 setelah pembebanan riil diverifikasi (dicatat saat migrasi data).', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 'TMN/GPCH/2026/007', 'Likuiditas lemah & deposit OTA terpakai operasional', 'Aset lancar hanya 45% kewajiban operasional; deposit TA/OTA Rp582,1 jt melebihi saldo bank Rp331,8 jt; kekurangan modal kerja ±Rp930 jt.', 'tinjauan', 2, 'keuangan', 'kritis', 930474298, 6, 2, 'dalam_tindak_lanjut', 4, '2026-07-15 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 'TMN/GPCH/2026/008', 'Penutupan rekening lama BJB & BRI belum tuntas', 'Rekening BRI menunggu surat kuasa; BJB tertunda karena 2 lembar cek hilang.', 'timwas', 1, 'proses', 'sedang', NULL, NULL, 2, 'dalam_tindak_lanjut', 3, '2026-06-03 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 'TMN/GPCH/2026/009', 'Analisis penyebab inefisiensi belum disampaikan', 'CEO meminta analisis penyebab inefisiensi di GP (rapat 23 Sep 2026); Timwas meminta hasilnya pada rapat manajemen Oktober.', 'timwas', 6, 'proses', 'sedang', NULL, NULL, NULL, 'terbuka', 3, '2026-10-05 00:00:00', NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- industry_forces (5 baris)
INSERT INTO `industry_forces` (`id`, `company_id`, `analysis_period_id`, `force`, `title`, `description`, `intensity`, `implication`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'persaingan', 'Persaingan ketat di koridor Pasir Koja – Bandung Barat', 'Santika Pasir Koja, Harris Festival Citylink, Horison Bandung, Grand Asrilia bersaing di segmen MICE & korporasi dengan produk lebih baru.', 5, 'Diferensiasi pengalaman Pasundan & kapasitas Malibu Dome; jaga ARR.', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'kekuatan_pembeli', 'Instansi & OTA menekan harga', 'Pembeli grup/instansi membandingkan harga lintas hotel saat pitching; OTA mengendalikan visibilitas.', 4, 'Paket bernilai tambah, bukan diskon menyeluruh; tingkatkan direct booking.', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'pendatang_baru', 'Hotel & venue baru di Bandung', 'Hotel baru dan venue konvensi alternatif terus bermunculan; hambatan masuk segmen budget rendah.', 3, 'Perkuat loyalitas akun korporat & pemerintah.', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'produk_pengganti', 'Rapat daring & venue non-hotel', 'Kegiatan dialihkan menjadi online (mis. MES Sep 2026); gedung serbaguna, kafe & coworking sebagai pengganti.', 3, 'Paket hybrid meeting, coworking/WFH, komunitas.', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'kekuatan_pemasok', 'Pemasok F&B, energi & PMS', 'Harga bahan pokok & energi naik; ketergantungan pada vendor PMS (VHP) dan vendor lift.', 3, 'Kontrak pemasok, hunting harga pasar DML, ticketing vendor terdokumentasi.', '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- initiative_activities (43 baris)
INSERT INTO `initiative_activities` (`id`, `company_id`, `analysis_period_id`, `strategic_initiative_id`, `name`, `description`, `owner_id`, `start_date`, `due_date`, `weight`, `progress`, `status`, `completed_at`, `last_update_note`, `progress_updated_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Follow up menu dashboard VHP Cloud (Ticket #181ADD)', NULL, 2, '2026-09-24 00:00:00', '2026-10-15 00:00:00', 1, 60, 'terlambat', NULL, 'Menunggu jadwal remote VHP.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 1, 'Notifikasi approval PR & approval sign pada form PR', NULL, 2, '2026-09-24 00:00:00', '2026-10-31 00:00:00', 1, 40, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 1, 'Buat supplier & artikel casual di VHP (tenaga kerja casual FB, HK, FO, Eng, Security)', NULL, 13, '2026-09-24 00:00:00', '2026-10-10 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', 'Selesai dibuat.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 1, 'Input saldo awal, aging AR/AP, artikel inventory, store & cost center', NULL, 6, '2026-07-01 00:00:00', '2026-11-30 00:00:00', 1, 45, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 1, 'PNP (panduan) VHP untuk seluruh HOD + akses penambahan item PR', NULL, 2, '2026-10-01 00:00:00', '2026-11-15 00:00:00', 1, 20, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 2, 'Proyeksi arus kas mingguan', NULL, 6, '2026-07-01 00:00:00', '2026-07-31 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', 'Rutin setiap Senin.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 2, 'Penagihan piutang lama Rp143 jt (korporasi, TA, EO)', NULL, 6, '2026-07-01 00:00:00', '2026-10-31 00:00:00', 1, 55, 'berjalan', NULL, 'Sisa piutang > 60 hari ±Rp126 jt.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 2, 'Rekening terpisah untuk deposit TA/OTA', NULL, 6, '2026-08-01 00:00:00', '2026-09-30 00:00:00', 1, 20, 'terlambat', NULL, 'Menunggu penutupan rekening lama BJB.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 2, 'Jadwal cicilan PBB 2025 dengan Bapenda', NULL, 6, '2026-07-01 00:00:00', '2026-12-31 00:00:00', 1, 25, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 2, 'Usulan restrukturisasi utang CEO Rp30,91 M ke pemilik', NULL, 6, '2026-09-01 00:00:00', '2026-11-30 00:00:00', 1, 15, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 3, 'Redesign website storytelling & booking engine (Alaric)', NULL, 7, '2026-03-01 00:00:00', '2026-06-30 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 1, 3, 'Konten rutin IG/TikTok & live IG house tour', NULL, 14, '2026-04-01 00:00:00', '2026-12-31 00:00:00', 1, 60, 'berjalan', NULL, 'Live IG house tour dijadwalkan Okt 2026.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 1, 3, 'Ornamen Sunda lobby & coffee shop (center piece, hiasan buffet)', NULL, 9, '2026-07-01 00:00:00', '2026-10-31 00:00:00', 1, 30, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(14, 1, 1, 3, 'Kristalisasi marmer lobby & area depan CS', NULL, 11, '2026-09-01 00:00:00', '2026-11-30 00:00:00', 1, 25, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(15, 1, 1, 4, 'Table top & business matching Jogja / ASITA travel mart (budgeting 2027)', NULL, 7, '2026-09-15 00:00:00', '2026-12-15 00:00:00', 1, 30, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(16, 1, 1, 4, 'Renew kontrak Trip.com & business review Traveloka', NULL, 8, '2026-09-28 00:00:00', '2026-10-31 00:00:00', 1, 50, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(17, 1, 1, 4, 'Database EO/WO Bandung & kerja sama wedding expo 2027', NULL, 15, '2026-09-01 00:00:00', '2026-11-30 00:00:00', 1, 40, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(18, 1, 1, 5, 'Daily pipeline report (inquiry → confirmed)', NULL, 7, '2026-09-23 00:00:00', '2026-09-30 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', 'Berjalan harian sejak 23 Sep.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(19, 1, 1, 5, 'Tactical promotion tanggal low-demand (walk-in 15%, last minute weekdays 10%, early bird)', NULL, 8, '2026-09-28 00:00:00', '2026-10-31 00:00:00', 1, 70, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(20, 1, 1, 5, 'Follow up Piala Gubernur (est. Rp153,8 jt) & PORPROV (est. Rp45 jt)', NULL, 7, '2026-09-24 00:00:00', '2026-10-20 00:00:00', 1, 50, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(21, 1, 1, 5, 'Konsep acara Tahun Baru 2027 dengan Marcom & F&B', NULL, 7, '2026-10-01 00:00:00', '2026-11-15 00:00:00', 1, 15, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(22, 1, 1, 5, 'Paket promosi spa & bundling outlet F&B', NULL, 9, '2026-10-01 00:00:00', '2026-10-31 00:00:00', 1, 30, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(23, 1, 1, 6, 'Desain ulang lounge & executive floor', NULL, 8, '2026-11-01 00:00:00', '2027-01-31 00:00:00', 1, 0, 'belum', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(24, 1, 1, 6, 'Paket amenities executive', NULL, 11, '2026-12-01 00:00:00', '2027-02-28 00:00:00', 1, 0, 'belum', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(25, 1, 1, 7, 'Input standard recipe menu ala carte di VHP', NULL, 9, '2026-07-01 00:00:00', '2026-10-15 00:00:00', 1, 70, 'terlambat', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(26, 1, 1, 7, 'Hunting harga pasar untuk DML & kontrak pemasok', NULL, 13, '2026-06-15 00:00:00', '2026-12-31 00:00:00', 1, 60, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(27, 1, 1, 7, 'Stock opname bulanan & stop penangguhan beban', NULL, 6, '2026-06-15 00:00:00', '2026-07-31 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', 'Sesuai keputusan Timwas 3 Jun 2026.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(28, 1, 1, 7, 'Proposal depo air minum & utensil kitchen', NULL, 13, '2026-09-01 00:00:00', '2026-10-15 00:00:00', 1, 60, 'terlambat', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(29, 1, 1, 7, 'Revisi harga & cetak menu ala carte', NULL, 9, '2026-09-15 00:00:00', '2026-10-31 00:00:00', 1, 40, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(30, 1, 1, 8, 'Penggantian panel lift 1 (vendor Elpa Global Techno)', NULL, 10, '2026-09-20 00:00:00', '2026-10-04 00:00:00', 1, 80, 'terlambat', NULL, 'Wiring & display HOP sesuai timeline; uji fungsi menyusul.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(31, 1, 1, 8, 'Install pompa kolam Hayward 2HP & perbaikan sand filter', NULL, 10, '2026-09-28 00:00:00', '2026-10-10 00:00:00', 1, 100, 'selesai', '2026-10-18 00:00:00', 'Pompa terpasang 28 Sep; sand filter selesai diperbaiki.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(32, 1, 1, 8, 'Repaint spot walls 20 kamar', NULL, 10, '2026-09-28 00:00:00', '2026-10-04 00:00:00', 1, 60, 'terlambat', NULL, '6 kamar selesai hari kedua.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(33, 1, 1, 8, 'Epoxy lantai dapur & pastry (3–5 mm)', NULL, 10, '2026-11-01 00:00:00', '2027-01-31 00:00:00', 1, 0, 'belum', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(34, 1, 1, 8, 'Karpet, screen & kajian plafon ruang Jayagiri', NULL, 10, '2026-10-15 00:00:00', '2027-03-31 00:00:00', 1, 10, 'berjalan', NULL, 'Screen baru sudah dibeli.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(35, 1, 1, 9, 'Tanda tangan CEO untuk mutasi LPG→CNG', NULL, 10, '2026-09-20 00:00:00', '2026-10-15 00:00:00', 1, 50, 'terlambat', NULL, 'Disetujui lisan, menunggu tanda tangan.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(36, 1, 1, 9, 'Koordinasi pemanfaatan limbah STP (Jayawiratama)', NULL, 10, '2026-09-20 00:00:00', '2026-11-30 00:00:00', 1, 20, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(37, 1, 1, 9, 'Penggantian lampu PLC → LED downlight (coffee shop, lobby, FO)', NULL, 18, '2026-09-23 00:00:00', '2026-10-31 00:00:00', 1, 55, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(38, 1, 1, 10, 'Jadwal pembayaran gaji & service charge tepat waktu', NULL, 12, '2026-04-01 00:00:00', '2026-12-31 00:00:00', 1, 75, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(39, 1, 1, 10, 'Kalender refresh training per departemen', NULL, 12, '2026-05-01 00:00:00', '2026-12-31 00:00:00', 1, 55, 'berjalan', NULL, 'Sep: F&B mise en place, engineering dokumentasi, FO reschedule OTA.', '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(40, 1, 1, 10, 'Rekrutmen Chief Engineer & Executive Housekeeper (LOI EHK)', NULL, 12, '2026-09-01 00:00:00', '2026-10-31 00:00:00', 1, 50, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(41, 1, 1, 10, 'Evaluasi kinerja bulanan per individu', NULL, 12, '2026-06-01 00:00:00', '2026-12-31 00:00:00', 1, 35, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(42, 1, 1, 11, 'General cleaning 20 kamar per minggu', NULL, 17, '2026-07-01 00:00:00', '2026-12-31 00:00:00', 1, 60, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(43, 1, 1, 11, 'Kajian layanan pressing & setrika tamu', NULL, 11, '2026-09-01 00:00:00', '2026-10-31 00:00:00', 1, 30, 'berjalan', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- initiative_budgets (28 baris)
INSERT INTO `initiative_budgets` (`id`, `company_id`, `analysis_period_id`, `strategic_initiative_id`, `item`, `category`, `planned_amount`, `realized_amount`, `realization_date`, `funding_source`, `notes`, `verified_by`, `verified_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Langganan VHP Cloud 2026', 'opex', 96000000, 72000000, '2026-09-30 00:00:00', 'Operasional', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 1, 'Tablet dashboard HOD', 'capex', 12000000, 0, NULL, 'Operasional', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 2, 'Pendampingan hukum restrukturisasi utang', 'opex', 25000000, 0, NULL, 'Operasional', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 3, 'Produksi video & foto profesional', 'opex', 35000000, 18500000, '2026-09-30 00:00:00', 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 3, 'Influencer & paid ads', 'opex', 20000000, 8000000, '2026-09-30 00:00:00', 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 3, 'Ornamen & artwork Sunda lobby', 'capex', 45000000, 12000000, '2026-09-30 00:00:00', 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 3, 'Kristalisasi marmer lobby', 'opex', 30000000, 0, NULL, 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 3, 'Redesign website', 'opex', 25000000, 25000000, '2026-09-30 00:00:00', 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 4, 'Table top Jogja (2 delegate × Rp5,5 jt)', 'opex', 11000000, 0, NULL, 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 4, 'ASITA West Java Travel Mart', 'opex', 6000000, 0, NULL, 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 5, 'WA blast & promo materials', 'opex', 8000000, 5200000, '2026-09-30 00:00:00', 'Marketing', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 1, 5, 'Talent & produksi acara Tahun Baru', 'opex', 40000000, 0, NULL, 'F&B', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 1, 6, 'Refurbish executive lounge', 'capex', 180000000, 0, NULL, 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(14, 1, 1, 6, 'Amenities executive floor', 'opex', 35000000, 0, NULL, 'Rooms', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(15, 1, 1, 7, 'Utensil kitchen', 'capex', 28000000, 0, NULL, 'F&B', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(16, 1, 1, 7, 'Depo air minum', 'capex', 18000000, 0, NULL, 'F&B', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(17, 1, 1, 7, 'Cetak menu ala carte', 'opex', 4500000, 0, NULL, 'F&B', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(18, 1, 1, 8, 'Panel lift 1 (Elpa Global Techno)', 'capex', 165000000, 99000000, '2026-09-30 00:00:00', 'Utang revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(19, 1, 1, 8, 'Pompa kolam Hayward 2HP', 'capex', 14500000, 14500000, '2026-09-30 00:00:00', 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(20, 1, 1, 8, 'Screen proyektor ruang rapat', 'capex', 9000000, 9000000, '2026-09-30 00:00:00', 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(21, 1, 1, 8, 'Repaint 20 kamar', 'opex', 16000000, 6000000, '2026-09-30 00:00:00', 'Engineering', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(22, 1, 1, 8, 'Epoxy dapur & pastry', 'capex', 85000000, 0, NULL, 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(23, 1, 1, 8, 'Karpet ruang rapat', 'capex', 120000000, 0, NULL, 'Revitalisasi', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(24, 1, 1, 9, 'Instalasi CNG', 'capex', 25000000, 0, NULL, 'Engineering', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(25, 1, 1, 9, 'Lampu LED downlight', 'capex', 12000000, 7800000, '2026-09-30 00:00:00', 'Engineering', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(26, 1, 1, 10, 'Program pelatihan & sertifikasi', 'opex', 15000000, 4500000, '2026-09-30 00:00:00', 'HRD', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(27, 1, 1, 11, 'Peralatan pressing & setrika', 'capex', 18000000, 0, NULL, 'Housekeeping', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(28, 1, 1, 11, 'Chemical general cleaning', 'opex', 6000000, 3200000, '2026-09-30 00:00:00', 'Housekeeping', 'PROYEKSI nilai anggaran — konfirmasi Chief Accountant.', 6, '2026-10-07 15:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- initiative_milestones (21 baris)
INSERT INTO `initiative_milestones` (`id`, `company_id`, `analysis_period_id`, `strategic_initiative_id`, `name`, `due_date`, `weight`, `is_achieved`, `achieved_at`, `evidence`, `owner_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'Modul back office VHP berjalan dengan saldo awal', '2026-11-30 00:00:00', 1, 0, NULL, NULL, 2, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 1, 'Neraca & laba rugi dihasilkan dari VHP', '2026-12-31 00:00:00', 1, 0, NULL, NULL, 2, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 2, 'Proyeksi kas mingguan rutin', '2026-07-31 00:00:00', 1, 1, '2026-07-31 00:00:00', NULL, 6, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 2, 'Rekening deposit OTA terpisah aktif', '2026-10-31 00:00:00', 1, 0, NULL, NULL, 6, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 2, 'Kesepakatan restrukturisasi utang CEO', '2027-03-31 00:00:00', 1, 0, NULL, NULL, 6, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 3, 'Website storytelling live', '2026-06-30 00:00:00', 1, 1, '2026-06-30 00:00:00', NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 3, 'Lobby bernuansa Sunda', '2026-11-30 00:00:00', 1, 0, NULL, NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 4, '5 kontrak TA/EO luar Bandung', '2026-12-31 00:00:00', 1, 0, NULL, NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 5, 'Pipeline report harian berjalan', '2026-09-30 00:00:00', 1, 1, '2026-09-30 00:00:00', NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 5, 'Event Piala Gubernur confirmed', '2026-10-20 00:00:00', 1, 0, NULL, NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 5, 'Paket Tahun Baru diluncurkan', '2026-11-15 00:00:00', 1, 0, NULL, NULL, 7, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 1, 6, 'Desain disetujui pemilik', '2027-01-31 00:00:00', 1, 0, NULL, NULL, 8, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 1, 7, 'Stop penangguhan beban di inventory', '2026-07-31 00:00:00', 1, 1, '2026-07-31 00:00:00', NULL, 9, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(14, 1, 1, 7, 'Standard recipe 100% menu ala carte', '2026-10-31 00:00:00', 1, 0, NULL, NULL, 9, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(15, 1, 1, 8, 'Lift 1 beroperasi dengan panel baru', '2026-10-10 00:00:00', 1, 0, NULL, NULL, 10, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(16, 1, 1, 8, 'Kolam beroperasi normal (pompa & sand filter)', '2026-10-10 00:00:00', 1, 1, '2026-10-10 00:00:00', NULL, 10, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(17, 1, 1, 8, 'Dapur epoxy selesai', '2027-01-31 00:00:00', 1, 0, NULL, NULL, 10, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(18, 1, 1, 9, 'CNG beroperasi', '2027-01-31 00:00:00', 1, 0, NULL, NULL, 10, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(19, 1, 1, 10, 'Gaji & service tepat waktu 3 bulan berturut-turut', '2026-09-30 00:00:00', 1, 1, '2026-09-30 00:00:00', NULL, 12, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(20, 1, 1, 10, 'CE & EHK definitif bergabung', '2026-11-30 00:00:00', 1, 0, NULL, NULL, 12, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(21, 1, 1, 11, 'Layanan pressing diluncurkan', '2026-11-30 00:00:00', 1, 0, NULL, NULL, 11, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- initiative_objective (24 baris)
INSERT INTO `initiative_objective` (`strategic_initiative_id`, `strategic_objective_id`) VALUES
(1, 7),
(1, 2),
(2, 2),
(3, 4),
(3, 5),
(3, 8),
(4, 4),
(4, 6),
(5, 1),
(5, 4),
(5, 6),
(6, 4),
(6, 5),
(7, 3),
(7, 7),
(8, 9),
(8, 6),
(8, 5),
(9, 3),
(10, 11),
(10, 12),
(10, 13),
(11, 10),
(11, 5);

-- institutionalizations (10 baris)
INSERT INTO `institutionalizations` (`id`, `company_id`, `analysis_period_id`, `title`, `mechanism_type`, `description`, `frequency`, `owner_id`, `status`, `evidence`, `started_at`, `next_review_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'GM Weekly Report setiap Senin', 'rapat', 'Laporan mingguan GM: revenue MTD vs budget, kompetitor, aktivitas & rencana tiap departemen, guest comments, energi, SDM.', 'Mingguan (Senin)', 4, 'melembaga', 'Arsip weekly report 2026.', '2026-01-05 00:00:00', '2026-12-28 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 'Rapat manajemen bulanan (tanggal 10)', 'rapat', 'Tinjau sasaran merah/kuning, tutup temuan selesai, ekspor laporan Arah GPCH.', 'Bulanan', 4, 'berjalan', 'Notulen rapat manajemen.', '2026-01-10 00:00:00', '2026-11-10 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 'Rapat Tim Pengawas', 'rapat', 'Pengawasan pemilik; catatan pengawasan & temuan Timwas dicatat di Arah GPCH.', 'Bulanan / kuartalan', 3, 'berjalan', 'Notulen GBK–GPCH 3 Jun 2026.', '2026-06-03 00:00:00', '2026-11-15 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 'Siklus realisasi KPI di Arah GPCH', 'sistem', 'Input tgl 5 → verifikasi keuangan tgl 7 → persetujuan GM tgl 8 → rapat tgl 10.', 'Bulanan', 5, 'rencana', NULL, '2026-11-01 00:00:00', '2026-12-10 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 'Tiga laporan keuangan wajib (PnL, arus kas, neraca)', 'kebijakan', 'Diterbitkan paling lambat 10 hari setelah tutup bulan.', 'Bulanan', 6, 'berjalan', 'Laporan keuangan Jun–Sep 2026.', '2026-06-01 00:00:00', '2026-11-10 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 'Daily pipeline report Sales', 'sop', 'Inquiry, quotation, follow-up, tentative, confirmed, revenue potential.', 'Harian', 7, 'berjalan', 'Sejak 23 Sep 2026.', '2026-09-23 00:00:00', '2026-12-31 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 'Tindak lanjut MoM dengan timeline & PIC', 'kebijakan', 'Setiap usulan di MoM ditindaklanjuti pada aktivitas minggu berikutnya.', 'Mingguan', 5, 'berjalan', NULL, '2026-09-23 00:00:00', '2026-12-31 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 'Refresh training per departemen', 'pelatihan', 'Jadwal berkala oleh Head of Department.', 'Bulanan', 12, 'berjalan', 'Training Sep 2026: F&B, engineering, FO.', '2026-05-01 00:00:00', '2026-12-31 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 'PNP VHP untuk HOD', 'sistem', 'Panduan penggunaan VHP agar HOD terbiasa membuka sistem.', 'Sekali + penyegaran', 2, 'rencana', NULL, NULL, '2026-11-15 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 'Budaya "bersepakat dalam tindakan"', 'budaya', 'Nilai Disiplin & Sabilulungan: keputusan rapat dijalankan bersama; teguran sesuai peraturan.', 'Berkelanjutan', 4, 'rencana', NULL, NULL, '2026-12-31 00:00:00', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- kpi_actuals (246 baris)
INSERT INTO `kpi_actuals` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `actual`, `evidence`, `evidence_path`, `notes`, `is_projection`, `status`, `submitted_by`, `submitted_at`, `verified_by`, `verified_at`, `verification_note`, `approved_by`, `approved_at`, `returned_by`, `returned_at`, `return_note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1510.45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 1, 2, 1233.89, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 1, 3, 1212.61, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 1, 4, 1786.14, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 1, 5, 1992.07, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 1, 6, 2088.05, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 1, 7, 2188.67, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 1, 8, 1981.17, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 1, 9, 1611.63, NULL, NULL, 'Sumber: GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 2, 1, 800.94, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 2, 2, 625.06, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 2, 3, 661.08, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 2, 4, 889.45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(14, 1, 1, 2, 5, 977.1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(15, 1, 1, 2, 6, 1103.84, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(16, 1, 1, 2, 7, 1087.16, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(17, 1, 1, 2, 8, 935.22, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(18, 1, 1, 2, 9, 806.53, NULL, NULL, 'Sumber: GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(19, 1, 1, 3, 1, 625.51, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(20, 1, 1, 3, 2, 529.83, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(21, 1, 1, 3, 3, 479.53, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(22, 1, 1, 3, 4, 808.69, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(23, 1, 1, 3, 5, 923.97, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(24, 1, 1, 3, 6, 892.21, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(25, 1, 1, 3, 7, 1006.51, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(26, 1, 1, 3, 8, 955.94, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(27, 1, 1, 3, 9, 724.1, NULL, NULL, 'Sumber: GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(28, 1, 1, 4, 1, 395, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(29, 1, 1, 4, 2, 340, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(30, 1, 1, 4, 3, 260, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(31, 1, 1, 4, 4, 560, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(32, 1, 1, 4, 5, 655, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(33, 1, 1, 4, 6, 603, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(34, 1, 1, 4, 7, 720, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(35, 1, 1, 4, 8, 700, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(36, 1, 1, 4, 9, 480, NULL, NULL, 'Sumber: GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(37, 1, 1, 5, 1, 1.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(38, 1, 1, 5, 2, -2.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(39, 1, 1, 5, 3, -3.1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(40, 1, 1, 5, 4, 0.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(41, 1, 1, 5, 5, 1.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(42, 1, 1, 5, 6, 0.91, NULL, NULL, 'Sumber: Analisis Singkat Keuangan Juni 2026: penerimaan Rp2.401.524.265, pengeluaran Rp2.379.705.393, surplus Rp21.818.872', 0, 'terverifikasi', 6, '2026-10-14 10:00:00', 6, '2026-10-07 15:00:00', 'Sesuai dokumen sumber.', NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(43, 1, 1, 5, 7, 1.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(44, 1, 1, 5, 8, 0.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(45, 1, 1, 5, 9, -1.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(46, 1, 1, 6, 1, 52, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(47, 1, 1, 6, 2, 49, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(48, 1, 1, 6, 3, 41, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(49, 1, 1, 6, 4, 43, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(50, 1, 1, 6, 5, 44, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(51, 1, 1, 6, 6, 44.8, NULL, NULL, 'Sumber: Analisis Keuangan Juni 2026: aset lancar Rp754.902.503 ÷ kewajiban operasional Rp1.685.376.801', 0, 'terverifikasi', 6, '2026-10-14 10:00:00', 6, '2026-10-07 15:00:00', 'Sesuai dokumen sumber.', NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(52, 1, 1, 6, 7, 46, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(53, 1, 1, 6, 8, 45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(54, 1, 1, 6, 9, 42, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(55, 1, 1, 7, 1, 168, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(56, 1, 1, 7, 2, 175, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(57, 1, 1, 7, 3, 181, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(58, 1, 1, 7, 4, 160, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(59, 1, 1, 7, 5, 150, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(60, 1, 1, 7, 6, 143.07, NULL, NULL, 'Sumber: Analisis Keuangan Juni 2026: piutang lama Rp143.065.998', 0, 'terverifikasi', 6, '2026-10-14 10:00:00', 6, '2026-10-07 15:00:00', 'Sesuai dokumen sumber.', NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(61, 1, 1, 7, 7, 138, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(62, 1, 1, 7, 8, 131, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(63, 1, 1, 7, 9, 126, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(64, 1, 1, 8, 7, 10, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(65, 1, 1, 8, 8, 20, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(66, 1, 1, 8, 9, 25, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(67, 1, 1, 9, 1, 47, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(68, 1, 1, 9, 2, 49, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(69, 1, 1, 9, 3, 58, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(70, 1, 1, 9, 4, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(71, 1, 1, 9, 5, 51, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(72, 1, 1, 9, 6, 52, NULL, NULL, 'Sumber: Analisis Keuangan Juni 2026: pembelian F&B Rp464.372.996 ≈ 52% pendapatan F&B', 0, 'terverifikasi', 9, '2026-10-14 10:00:00', 6, '2026-10-07 15:00:00', 'Sesuai dokumen sumber.', NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(73, 1, 1, 9, 7, 48, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(74, 1, 1, 9, 8, 46, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(75, 1, 1, 9, 9, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(76, 1, 1, 10, 1, 38.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(77, 1, 1, 10, 2, 40.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(78, 1, 1, 10, 3, 44, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'dikembalikan', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, 6, '2026-10-15 09:30:00', 'Food cost Maret masih memakai penangguhan beban (deferred cost). Hitung ulang dengan pemakaian riil sesuai keputusan Timwas 3 Jun 2026.', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(79, 1, 1, 10, 4, 39.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(80, 1, 1, 10, 5, 39.1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(81, 1, 1, 10, 6, 41.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(82, 1, 1, 10, 7, 38.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(83, 1, 1, 10, 8, 37.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(84, 1, 1, 10, 9, 39, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 9, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(85, 1, 1, 11, 1, 57, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(86, 1, 1, 11, 2, 58.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(87, 1, 1, 11, 3, 55.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(88, 1, 1, 11, 4, 56.1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(89, 1, 1, 11, 5, 57.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(90, 1, 1, 11, 6, 59.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(91, 1, 1, 11, 7, 60.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(92, 1, 1, 11, 8, 59, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(93, 1, 1, 11, 9, 53.39, NULL, NULL, 'Sumber: Engineering Energy Report Sep 2026: estimasi Rp213.345.308 ÷ budget Rp399.609.928', 0, 'terverifikasi', 10, '2026-10-14 10:00:00', 6, '2026-10-07 15:00:00', 'Sesuai dokumen sumber.', NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(94, 1, 1, 12, 1, 46.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(95, 1, 1, 12, 2, 41.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(96, 1, 1, 12, 3, 38.7, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(97, 1, 1, 12, 4, 51.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(98, 1, 1, 12, 5, 54.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(99, 1, 1, 12, 6, 61.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(100, 1, 1, 12, 7, 59.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');
INSERT INTO `kpi_actuals` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `actual`, `evidence`, `evidence_path`, `notes`, `is_projection`, `status`, `submitted_by`, `submitted_at`, `verified_by`, `verified_at`, `verification_note`, `approved_by`, `approved_at`, `returned_by`, `returned_at`, `return_note`, `created_at`, `updated_at`) VALUES
(101, 1, 1, 12, 8, 53.3, NULL, NULL, 'Sumber: GM Weekly Report: Last Month 53,30%', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(102, 1, 1, 12, 9, 49, NULL, NULL, 'Sumber: GM Weekly Report 21–27 Sep 2026: MTD 1–27 Sep diekstrapolasi ke 30 hari — cocokkan dengan DRR VHP (MTD 48,71%)', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(103, 1, 1, 13, 1, 341, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(104, 1, 1, 13, 2, 328, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(105, 1, 1, 13, 3, 336, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(106, 1, 1, 13, 4, 349, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(107, 1, 1, 13, 5, 352, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(108, 1, 1, 13, 6, 366, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(109, 1, 1, 13, 7, 360, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(110, 1, 1, 13, 8, 345.13, NULL, NULL, 'Sumber: GM Weekly Report: Last Month Rp345.130', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(111, 1, 1, 13, 9, 334.55, NULL, NULL, 'Sumber: GM Weekly Report MTD Rp334.547', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(112, 1, 1, 14, 1, 157.54, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(113, 1, 1, 14, 2, 136.12, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(114, 1, 1, 14, 3, 130.03, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(115, 1, 1, 14, 4, 180.78, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(116, 1, 1, 14, 5, 192.19, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(117, 1, 1, 14, 6, 224.36, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(118, 1, 1, 14, 7, 213.84, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(119, 1, 1, 14, 8, 183.95, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(120, 1, 1, 14, 9, 163.93, NULL, NULL, 'Sumber: GM Weekly Report MTD Rp162.967', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(121, 1, 1, 15, 1, 0.88, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(122, 1, 1, 15, 2, 0.86, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(123, 1, 1, 15, 3, 0.84, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(124, 1, 1, 15, 4, 0.9, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(125, 1, 1, 15, 5, 0.91, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(126, 1, 1, 15, 6, 0.95, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(127, 1, 1, 15, 7, 0.94, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(128, 1, 1, 15, 8, 0.94, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(129, 1, 1, 15, 9, 0.92, NULL, NULL, 'Sumber: GM Weekly Report Sep 2026: RGI 0,92 · MPI 0,96 · ARI 0,96', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(130, 1, 1, 16, 1, 4.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(131, 1, 1, 16, 2, 4.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(132, 1, 1, 16, 3, 4.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(133, 1, 1, 16, 4, 4.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(134, 1, 1, 16, 5, 4.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(135, 1, 1, 16, 6, 4.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(136, 1, 1, 16, 7, 4.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(137, 1, 1, 16, 8, 4.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(138, 1, 1, 16, 9, 4.4, NULL, NULL, 'Sumber: GM Weekly Report Sep 2026: Google 4,4/5 · Booking.com 9,3 · Traveloka 8,3', 0, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(139, 1, 1, 17, 1, 11, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(140, 1, 1, 17, 2, 9, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(141, 1, 1, 17, 3, 12, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(142, 1, 1, 17, 4, 8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(143, 1, 1, 17, 5, 7, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(144, 1, 1, 17, 6, 6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(145, 1, 1, 17, 7, 9, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(146, 1, 1, 17, 8, 8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(147, 1, 1, 17, 9, 7, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(148, 1, 1, 18, 1, 70, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(149, 1, 1, 18, 2, 72, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(150, 1, 1, 18, 3, 75, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(151, 1, 1, 18, 4, 80, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(152, 1, 1, 18, 5, 85, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(153, 1, 1, 18, 6, 88, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(154, 1, 1, 18, 7, 90, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(155, 1, 1, 18, 8, 92, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(156, 1, 1, 18, 9, 95, NULL, NULL, 'Sumber: GM Weekly Report Sep 2026: seluruh guest comment telah direply', 0, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(157, 1, 1, 19, 1, 22, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(158, 1, 1, 19, 2, 18, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(159, 1, 1, 19, 3, 9, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(160, 1, 1, 19, 4, 27, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(161, 1, 1, 19, 5, 31, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(162, 1, 1, 19, 6, 29, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(163, 1, 1, 19, 7, 33, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(164, 1, 1, 19, 8, 30, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(165, 1, 1, 19, 9, 24, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(166, 1, 1, 20, 1, 85, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(167, 1, 1, 20, 2, 60, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(168, 1, 1, 20, 3, 40, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(169, 1, 1, 20, 4, 110, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(170, 1, 1, 20, 5, 95, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(171, 1, 1, 20, 6, 70, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(172, 1, 1, 20, 7, 120, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(173, 1, 1, 20, 8, 105, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(174, 1, 1, 20, 9, 192.5, NULL, NULL, 'Sumber: GM Weekly Report: lost business 21–27 Sep Rp49,3 jt room + Rp143,2 jt MICE = Rp192,5 jt (lengkapi 1–20 Sep)', 0, 'draf', 7, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(175, 1, 1, 21, 1, 25, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(176, 1, 1, 21, 2, 22, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(177, 1, 1, 21, 3, 20, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(178, 1, 1, 21, 4, 18, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(179, 1, 1, 21, 5, 15, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(180, 1, 1, 21, 6, 14, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(181, 1, 1, 21, 7, 12, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(182, 1, 1, 21, 8, 12, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(183, 1, 1, 21, 9, 11, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 6, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(184, 1, 1, 22, 1, 6.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(185, 1, 1, 22, 2, 7, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(186, 1, 1, 22, 3, 7.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(187, 1, 1, 22, 4, 8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(188, 1, 1, 22, 5, 8.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(189, 1, 1, 22, 6, 9.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(190, 1, 1, 22, 7, 10.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(191, 1, 1, 22, 8, 10.6, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(192, 1, 1, 22, 9, 11, NULL, NULL, 'Sumber: GM Weekly Report: promo WA "Septembersama" 212 RN, Rp84.151.778, ARR Rp396.942 = 11% room revenue', 0, 'draf', 8, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(193, 1, 1, 23, 1, 55, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(194, 1, 1, 23, 2, 58, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(195, 1, 1, 23, 3, 60, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(196, 1, 1, 23, 4, 62, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(197, 1, 1, 23, 5, 65, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(198, 1, 1, 23, 6, 68, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(199, 1, 1, 23, 7, 70, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(200, 1, 1, 23, 8, 72, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');
INSERT INTO `kpi_actuals` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `actual`, `evidence`, `evidence_path`, `notes`, `is_projection`, `status`, `submitted_by`, `submitted_at`, `verified_by`, `verified_at`, `verification_note`, `approved_by`, `approved_at`, `returned_by`, `returned_at`, `return_note`, `created_at`, `updated_at`) VALUES
(201, 1, 1, 23, 9, 74, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 10, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(202, 1, 1, 24, 1, 40, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(203, 1, 1, 24, 2, 45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(204, 1, 1, 24, 3, 30, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(205, 1, 1, 24, 4, 60, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(206, 1, 1, 24, 5, 70, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(207, 1, 1, 24, 6, 72, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(208, 1, 1, 24, 7, 75, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(209, 1, 1, 24, 8, 78, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(210, 1, 1, 24, 9, 82, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(211, 1, 1, 25, 1, 82, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(212, 1, 1, 25, 2, 83, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(213, 1, 1, 25, 3, 81, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(214, 1, 1, 25, 4, 84, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(215, 1, 1, 25, 5, 85, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(216, 1, 1, 25, 6, 86, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(217, 1, 1, 25, 7, 86, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(218, 1, 1, 25, 8, 87, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(219, 1, 1, 25, 9, 88, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 11, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(220, 1, 1, 26, 1, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(221, 1, 1, 26, 2, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(222, 1, 1, 26, 3, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(223, 1, 1, 26, 4, 100, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(224, 1, 1, 26, 5, 50, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(225, 1, 1, 26, 6, 100, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(226, 1, 1, 26, 7, 100, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(227, 1, 1, 26, 8, 100, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(228, 1, 1, 26, 9, 100, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(229, 1, 1, 27, 1, 0.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(230, 1, 1, 27, 2, 0.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(231, 1, 1, 27, 3, 0.2, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(232, 1, 1, 27, 4, 0.8, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(233, 1, 1, 27, 5, 1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(234, 1, 1, 27, 6, 1.1, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(235, 1, 1, 27, 7, 1.3, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(236, 1, 1, 27, 8, 1.4, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(237, 1, 1, 27, 9, 1.5, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(238, 1, 1, 28, 1, 0.47, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(239, 1, 1, 28, 2, 0.47, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(240, 1, 1, 28, 3, 0.46, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(241, 1, 1, 28, 4, 0.46, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(242, 1, 1, 28, 5, 0.45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(243, 1, 1, 28, 6, 0.45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(244, 1, 1, 28, 7, 0.45, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(245, 1, 1, 28, 8, 0.44, NULL, NULL, 'PROYEKSI data awal — wajib dikonfirmasi pemilik KPI dengan laporan VHP/keuangan, ganti atau hapus bila tidak sesuai.', 1, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(246, 1, 1, 28, 9, 0.44, NULL, NULL, 'Sumber: GM Weekly Report Sep 2026: 72 karyawan (PKWT 34, daily worker 38) ÷ 164 kamar = 0,44; budget 0,55', 0, 'draf', 12, '2026-10-14 10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- kpi_targets (330 baris)
INSERT INTO `kpi_targets` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `target`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 2513.87, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 1, 2, 2228.27, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 1, 3, 2067.74, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 1, 4, 2698.69, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 1, 5, 2844.12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 1, 6, 2955.75, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 1, 7, 3059.88, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 1, 8, 2772.33, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 1, 9, 2711.28, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 1, 10, 2798.54, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 1, 11, 2858.82, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 1, 12, 3351.35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 2, 1, 1004.09, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(14, 1, 1, 2, 2, 846.03, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(15, 1, 1, 2, 3, 892.24, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(16, 1, 1, 2, 4, 1076.99, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(17, 1, 1, 2, 5, 1159.15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(18, 1, 1, 2, 6, 1235.41, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(19, 1, 1, 2, 7, 1297.18, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(20, 1, 1, 2, 8, 1138.82, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(21, 1, 1, 2, 9, 1031.04, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(22, 1, 1, 2, 10, 1118.48, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(23, 1, 1, 2, 11, 1127.37, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(24, 1, 1, 2, 12, 1409.28, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(25, 1, 1, 3, 1, 1417.78, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(26, 1, 1, 3, 2, 1294.24, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(27, 1, 1, 3, 3, 1090.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(28, 1, 1, 3, 4, 1528.7, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(29, 1, 1, 3, 5, 1589.97, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(30, 1, 1, 3, 6, 1622.33, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(31, 1, 1, 3, 7, 1662.7, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(32, 1, 1, 3, 8, 1537.51, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(33, 1, 1, 3, 9, 1586.28, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(34, 1, 1, 3, 10, 1585.06, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(35, 1, 1, 3, 11, 1635.45, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(36, 1, 1, 3, 12, 1837.07, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(37, 1, 1, 4, 1, 1150, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(38, 1, 1, 4, 2, 1050, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(39, 1, 1, 4, 3, 820, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(40, 1, 1, 4, 4, 1250, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(41, 1, 1, 4, 5, 1300, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(42, 1, 1, 4, 6, 1320, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(43, 1, 1, 4, 7, 1350, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(44, 1, 1, 4, 8, 1250, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(45, 1, 1, 4, 9, 1308.87, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(46, 1, 1, 4, 10, 1300, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(47, 1, 1, 4, 11, 1350, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(48, 1, 1, 4, 12, 1500, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(49, 1, 1, 5, 1, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(50, 1, 1, 5, 2, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(51, 1, 1, 5, 3, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(52, 1, 1, 5, 4, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(53, 1, 1, 5, 5, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(54, 1, 1, 5, 6, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(55, 1, 1, 5, 7, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(56, 1, 1, 5, 8, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(57, 1, 1, 5, 9, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(58, 1, 1, 5, 10, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(59, 1, 1, 5, 11, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(60, 1, 1, 5, 12, 5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(61, 1, 1, 6, 1, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(62, 1, 1, 6, 2, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(63, 1, 1, 6, 3, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(64, 1, 1, 6, 4, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(65, 1, 1, 6, 5, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(66, 1, 1, 6, 6, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(67, 1, 1, 6, 7, 60, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(68, 1, 1, 6, 8, 63, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(69, 1, 1, 6, 9, 66, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(70, 1, 1, 6, 10, 70, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(71, 1, 1, 6, 11, 75, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(72, 1, 1, 6, 12, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(73, 1, 1, 7, 1, 150, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(74, 1, 1, 7, 2, 150, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(75, 1, 1, 7, 3, 150, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(76, 1, 1, 7, 4, 140, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(77, 1, 1, 7, 5, 130, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(78, 1, 1, 7, 6, 120, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(79, 1, 1, 7, 7, 110, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(80, 1, 1, 7, 8, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(81, 1, 1, 7, 9, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(82, 1, 1, 7, 10, 75, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(83, 1, 1, 7, 11, 60, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(84, 1, 1, 7, 12, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(85, 1, 1, 8, 7, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(86, 1, 1, 8, 8, 30, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(87, 1, 1, 8, 9, 45, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(88, 1, 1, 8, 10, 60, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(89, 1, 1, 8, 11, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(90, 1, 1, 8, 12, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(91, 1, 1, 9, 1, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(92, 1, 1, 9, 2, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(93, 1, 1, 9, 3, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(94, 1, 1, 9, 4, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(95, 1, 1, 9, 5, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(96, 1, 1, 9, 6, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(97, 1, 1, 9, 7, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(98, 1, 1, 9, 8, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(99, 1, 1, 9, 9, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(100, 1, 1, 9, 10, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');
INSERT INTO `kpi_targets` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `target`, `notes`, `created_at`, `updated_at`) VALUES
(101, 1, 1, 9, 11, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(102, 1, 1, 9, 12, 40, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(103, 1, 1, 10, 1, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(104, 1, 1, 10, 2, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(105, 1, 1, 10, 3, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(106, 1, 1, 10, 4, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(107, 1, 1, 10, 5, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(108, 1, 1, 10, 6, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(109, 1, 1, 10, 7, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(110, 1, 1, 10, 8, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(111, 1, 1, 10, 9, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(112, 1, 1, 10, 10, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(113, 1, 1, 10, 11, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(114, 1, 1, 10, 12, 35, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(115, 1, 1, 11, 1, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(116, 1, 1, 11, 2, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(117, 1, 1, 11, 3, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(118, 1, 1, 11, 4, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(119, 1, 1, 11, 5, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(120, 1, 1, 11, 6, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(121, 1, 1, 11, 7, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(122, 1, 1, 11, 8, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(123, 1, 1, 11, 9, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(124, 1, 1, 11, 10, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(125, 1, 1, 11, 11, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(126, 1, 1, 11, 12, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(127, 1, 1, 12, 1, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(128, 1, 1, 12, 2, 47, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(129, 1, 1, 12, 3, 45, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(130, 1, 1, 12, 4, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(131, 1, 1, 12, 5, 57, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(132, 1, 1, 12, 6, 62, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(133, 1, 1, 12, 7, 63, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(134, 1, 1, 12, 8, 56, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(135, 1, 1, 12, 9, 52.54, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(136, 1, 1, 12, 10, 55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(137, 1, 1, 12, 11, 57, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(138, 1, 1, 12, 12, 66, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(139, 1, 1, 13, 1, 395, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(140, 1, 1, 13, 2, 392, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(141, 1, 1, 13, 3, 390, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(142, 1, 1, 13, 4, 398, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(143, 1, 1, 13, 5, 400, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(144, 1, 1, 13, 6, 405, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(145, 1, 1, 13, 7, 405, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(146, 1, 1, 13, 8, 400, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(147, 1, 1, 13, 9, 398.86, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(148, 1, 1, 13, 10, 400, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(149, 1, 1, 13, 11, 402, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(150, 1, 1, 13, 12, 420, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(151, 1, 1, 14, 1, 197.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(152, 1, 1, 14, 2, 184.24, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(153, 1, 1, 14, 3, 175.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(154, 1, 1, 14, 4, 218.9, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(155, 1, 1, 14, 5, 228, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(156, 1, 1, 14, 6, 251.1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(157, 1, 1, 14, 7, 255.15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(158, 1, 1, 14, 8, 224, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(159, 1, 1, 14, 9, 209.56, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(160, 1, 1, 14, 10, 220, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(161, 1, 1, 14, 11, 229.14, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(162, 1, 1, 14, 12, 277.2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(163, 1, 1, 15, 1, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(164, 1, 1, 15, 2, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(165, 1, 1, 15, 3, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(166, 1, 1, 15, 4, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(167, 1, 1, 15, 5, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(168, 1, 1, 15, 6, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(169, 1, 1, 15, 7, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(170, 1, 1, 15, 8, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(171, 1, 1, 15, 9, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(172, 1, 1, 15, 10, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(173, 1, 1, 15, 11, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(174, 1, 1, 15, 12, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(175, 1, 1, 16, 1, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(176, 1, 1, 16, 2, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(177, 1, 1, 16, 3, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(178, 1, 1, 16, 4, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(179, 1, 1, 16, 5, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(180, 1, 1, 16, 6, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(181, 1, 1, 16, 7, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(182, 1, 1, 16, 8, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(183, 1, 1, 16, 9, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(184, 1, 1, 16, 10, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(185, 1, 1, 16, 11, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(186, 1, 1, 16, 12, 4.5, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(187, 1, 1, 17, 1, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(188, 1, 1, 17, 2, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(189, 1, 1, 17, 3, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(190, 1, 1, 17, 4, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(191, 1, 1, 17, 5, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(192, 1, 1, 17, 6, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(193, 1, 1, 17, 7, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(194, 1, 1, 17, 8, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(195, 1, 1, 17, 9, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(196, 1, 1, 17, 10, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(197, 1, 1, 17, 11, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(198, 1, 1, 17, 12, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(199, 1, 1, 18, 1, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(200, 1, 1, 18, 2, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');
INSERT INTO `kpi_targets` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `target`, `notes`, `created_at`, `updated_at`) VALUES
(201, 1, 1, 18, 3, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(202, 1, 1, 18, 4, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(203, 1, 1, 18, 5, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(204, 1, 1, 18, 6, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(205, 1, 1, 18, 7, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(206, 1, 1, 18, 8, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(207, 1, 1, 18, 9, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(208, 1, 1, 18, 10, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(209, 1, 1, 18, 11, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(210, 1, 1, 18, 12, 95, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(211, 1, 1, 19, 1, 26, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(212, 1, 1, 19, 2, 24, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(213, 1, 1, 19, 3, 18, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(214, 1, 1, 19, 4, 30, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(215, 1, 1, 19, 5, 32, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(216, 1, 1, 19, 6, 33, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(217, 1, 1, 19, 7, 34, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(218, 1, 1, 19, 8, 30, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(219, 1, 1, 19, 9, 30, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(220, 1, 1, 19, 10, 32, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(221, 1, 1, 19, 11, 33, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(222, 1, 1, 19, 12, 38, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(223, 1, 1, 20, 1, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(224, 1, 1, 20, 2, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(225, 1, 1, 20, 3, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(226, 1, 1, 20, 4, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(227, 1, 1, 20, 5, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(228, 1, 1, 20, 6, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(229, 1, 1, 20, 7, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(230, 1, 1, 20, 8, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(231, 1, 1, 20, 9, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(232, 1, 1, 20, 10, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(233, 1, 1, 20, 11, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(234, 1, 1, 20, 12, 50, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(235, 1, 1, 21, 1, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(236, 1, 1, 21, 2, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(237, 1, 1, 21, 3, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(238, 1, 1, 21, 4, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(239, 1, 1, 21, 5, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(240, 1, 1, 21, 6, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(241, 1, 1, 21, 7, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(242, 1, 1, 21, 8, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(243, 1, 1, 21, 9, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(244, 1, 1, 21, 10, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(245, 1, 1, 21, 11, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(246, 1, 1, 21, 12, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(247, 1, 1, 22, 1, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(248, 1, 1, 22, 2, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(249, 1, 1, 22, 3, 8, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(250, 1, 1, 22, 4, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(251, 1, 1, 22, 5, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(252, 1, 1, 22, 6, 10, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(253, 1, 1, 22, 7, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(254, 1, 1, 22, 8, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(255, 1, 1, 22, 9, 12, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(256, 1, 1, 22, 10, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(257, 1, 1, 22, 11, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(258, 1, 1, 22, 12, 15, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(259, 1, 1, 23, 1, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(260, 1, 1, 23, 2, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(261, 1, 1, 23, 3, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(262, 1, 1, 23, 4, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(263, 1, 1, 23, 5, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(264, 1, 1, 23, 6, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(265, 1, 1, 23, 7, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(266, 1, 1, 23, 8, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(267, 1, 1, 23, 9, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(268, 1, 1, 23, 10, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(269, 1, 1, 23, 11, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(270, 1, 1, 23, 12, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(271, 1, 1, 24, 1, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(272, 1, 1, 24, 2, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(273, 1, 1, 24, 3, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(274, 1, 1, 24, 4, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(275, 1, 1, 24, 5, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(276, 1, 1, 24, 6, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(277, 1, 1, 24, 7, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(278, 1, 1, 24, 8, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(279, 1, 1, 24, 9, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(280, 1, 1, 24, 10, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(281, 1, 1, 24, 11, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(282, 1, 1, 24, 12, 80, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(283, 1, 1, 25, 1, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(284, 1, 1, 25, 2, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(285, 1, 1, 25, 3, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(286, 1, 1, 25, 4, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(287, 1, 1, 25, 5, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(288, 1, 1, 25, 6, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(289, 1, 1, 25, 7, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(290, 1, 1, 25, 8, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(291, 1, 1, 25, 9, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(292, 1, 1, 25, 10, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(293, 1, 1, 25, 11, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(294, 1, 1, 25, 12, 90, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(295, 1, 1, 26, 1, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(296, 1, 1, 26, 2, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(297, 1, 1, 26, 3, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(298, 1, 1, 26, 4, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(299, 1, 1, 26, 5, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(300, 1, 1, 26, 6, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');
INSERT INTO `kpi_targets` (`id`, `company_id`, `analysis_period_id`, `kpi_id`, `month`, `target`, `notes`, `created_at`, `updated_at`) VALUES
(301, 1, 1, 26, 7, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(302, 1, 1, 26, 8, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(303, 1, 1, 26, 9, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(304, 1, 1, 26, 10, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(305, 1, 1, 26, 11, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(306, 1, 1, 26, 12, 100, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(307, 1, 1, 27, 1, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(308, 1, 1, 27, 2, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(309, 1, 1, 27, 3, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(310, 1, 1, 27, 4, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(311, 1, 1, 27, 5, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(312, 1, 1, 27, 6, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(313, 1, 1, 27, 7, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(314, 1, 1, 27, 8, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(315, 1, 1, 27, 9, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(316, 1, 1, 27, 10, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(317, 1, 1, 27, 11, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(318, 1, 1, 27, 12, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(319, 1, 1, 28, 1, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(320, 1, 1, 28, 2, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(321, 1, 1, 28, 3, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(322, 1, 1, 28, 4, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(323, 1, 1, 28, 5, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(324, 1, 1, 28, 6, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(325, 1, 1, 28, 7, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(326, 1, 1, 28, 8, 0.55, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(327, 1, 1, 28, 9, 0.55, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(328, 1, 1, 28, 10, 0.55, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(329, 1, 1, 28, 11, 0.55, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(330, 1, 1, 28, 12, 0.55, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- kpis (28 baris)
INSERT INTO `kpis` (`id`, `company_id`, `analysis_period_id`, `code`, `strategic_objective_id`, `name`, `description`, `unit`, `direction`, `frequency`, `aggregation`, `formula`, `data_source`, `owner_id`, `weight`, `baseline`, `annual_target`, `decimals`, `is_financial`, `is_critical`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'KPI/GPCH/2026/001', 1, 'Total pendapatan hotel', 'Kode referensi K01.', 'Rp juta', 'higher', 'bulanan', 'sum', 'Room + F&B (termasuk banquet & breakfast) + other revenue', 'VHP — Daily Revenue Report / Income Audit', 6, 3, 1510.45, 32860.64, 1, 1, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'KPI/GPCH/2026/002', 1, 'Pendapatan kamar', 'Kode referensi K02.', 'Rp juta', 'higher', 'bulanan', 'sum', 'Room revenue net', 'VHP — Room Revenue Breakdown', 7, 2, 800.94, 13336.08, 1, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'KPI/GPCH/2026/003', 1, 'Pendapatan F&B (termasuk banquet & breakfast)', 'Kode referensi K03.', 'Rp juta', 'higher', 'bulanan', 'sum', 'Breakfast + coffee shop + room service + lounge + cafetaria + banquet', 'VHP — Outlet Daily Sales Report', 9, 2, 625.51, 18387.59, 1, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'KPI/GPCH/2026/004', 1, 'Pendapatan banquet / MICE', 'Kode referensi K04.', 'Rp juta', 'higher', 'bulanan', 'sum', 'Revenue banquet (meeting package, wedding, social event)', 'VHP — Banquet module', 7, 2, 395, 14948.87, 1, 1, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'KPI/GPCH/2026/005', 2, 'Surplus arus kas operasional terhadap penerimaan', 'Kode referensi K05.', '%', 'higher', 'bulanan', 'average', '(Penerimaan kas − pengeluaran kas) ÷ penerimaan kas × 100', 'Laporan arus kas bulanan', 6, 3, 1.8, 4, 2, 1, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'KPI/GPCH/2026/006', 2, 'Rasio aset lancar terhadap kewajiban operasional', 'Kode referensi K06.', '%', 'higher', 'bulanan', 'last', '(Kas + piutang + persediaan) ÷ (utang usaha + utang revitalisasi + deposit TA + utang PBB) × 100', 'Neraca bulanan', 6, 2, 52, 80, 1, 1, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'KPI/GPCH/2026/007', 2, 'Piutang usia > 60 hari', 'Kode referensi K07.', 'Rp juta', 'lower', 'bulanan', 'last', 'Saldo AR aging > 60 hari', 'VHP — AR Aging', 6, 2, 168, 50, 1, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'KPI/GPCH/2026/008', 2, 'Pelunasan utang PBB 2025 (kumulatif)', 'Kode referensi K08.', '%', 'higher', 'bulanan', 'last', 'Pembayaran kumulatif ÷ Rp339.306.820 × 100 (diukur mulai Juli 2026)', 'Bukti setor PBB', 6, 1, 10, 100, 0, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'KPI/GPCH/2026/009', 3, 'Pembelian F&B terhadap pendapatan F&B', 'Kode referensi K09.', '%', 'lower', 'bulanan', 'average', 'Pembelian F&B ÷ pendapatan F&B × 100', 'VHP — Receiving report & outlet sales', 9, 1, 47, 40, 1, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'KPI/GPCH/2026/010', 3, 'Food cost', 'Kode referensi K10.', '%', 'lower', 'bulanan', 'average', '(Persediaan awal + pembelian − persediaan akhir) ÷ pendapatan food × 100', 'VHP — FB Reconciliation', 9, 2, 38.5, 35, 1, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 'KPI/GPCH/2026/011', 3, 'Biaya energi terhadap anggaran energi', 'Kode referensi K11.', '%', 'lower', 'bulanan', 'average', 'Biaya listrik + gas + solar + air tanah ÷ anggaran energi × 100', 'Laporan energi engineering', 10, 1, 57, 95, 2, 1, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 'KPI/GPCH/2026/012', 4, 'Okupansi kamar', 'Kode referensi K12.', '%', 'higher', 'bulanan', 'average', 'Room sold ÷ room available × 100', 'VHP — Statistic', 7, 3, 46.2, 55.4617, 2, 0, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 'KPI/GPCH/2026/013', 4, 'Average room rate (ARR)', 'Kode referensi K13.', 'Rp ribu', 'higher', 'bulanan', 'average', 'Room revenue ÷ room sold', 'VHP — Statistic', 7, 2, 341, 400.4883, 2, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(14, 1, 1, 'KPI/GPCH/2026/014', 4, 'RevPAR', 'Kode referensi K14.', 'Rp ribu', 'higher', 'bulanan', 'average', 'Room revenue ÷ room available', 'VHP — Statistic', 7, 2, 157.54, 222.5242, 2, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(15, 1, 1, 'KPI/GPCH/2026/015', 4, 'Revenue Generation Index (RGI)', 'Kode referensi K15.', 'indeks', 'higher', 'bulanan', 'last', 'RevPAR GPCH ÷ RevPAR competitive set', 'Benchmark kompetitor mingguan', 7, 2, 0.88, 1, 2, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(16, 1, 1, 'KPI/GPCH/2026/016', 5, 'Rating ulasan Google', 'Kode referensi K16.', 'skor', 'higher', 'bulanan', 'last', 'Rating rata-rata Google Business (skala 5)', 'Google Business Profile', 8, 2, 4.3, 4.5, 1, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(17, 1, 1, 'KPI/GPCH/2026/017', 5, 'Keluhan tamu tercatat', 'Kode referensi K17.', 'kasus', 'lower', 'bulanan', 'sum', 'Jumlah keluhan di guest comment, OTA & logbook FO', 'Logbook FO & ulasan OTA', 8, 1, 11, 96, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(18, 1, 1, 'KPI/GPCH/2026/018', 5, 'Ulasan direspons ≤ 24 jam', 'Kode referensi K18.', '%', 'higher', 'bulanan', 'average', 'Ulasan direspons ≤ 24 jam ÷ total ulasan × 100', 'OTA extranet & Google', 8, 1, 70, 95, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(19, 1, 1, 'KPI/GPCH/2026/019', 6, 'Jumlah event banquet terlaksana', 'Kode referensi K19.', 'event', 'higher', 'bulanan', 'sum', 'Jumlah event (meeting package, wedding, social) yang terlaksana', 'VHP — Banquet / BEO', 7, 2, 22, 360, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(20, 1, 1, 'KPI/GPCH/2026/020', 6, 'Nilai lost business', 'Kode referensi K20.', 'Rp juta', 'lower', 'bulanan', 'sum', 'Nilai potensi pendapatan yang hilang (loss), di luar postponed', 'Sales — lost business report', 7, 2, 85, 600, 1, 0, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(21, 1, 1, 'KPI/GPCH/2026/021', 7, 'Laporan keuangan bulanan lengkap (PnL, arus kas, neraca)', 'Kode referensi K21.', 'hari', 'lower', 'bulanan', 'average', 'Jumlah hari setelah tutup bulan sampai tiga laporan diterbitkan', 'Accounting', 6, 1, 25, 11.75, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(22, 1, 1, 'KPI/GPCH/2026/022', 8, 'Kontribusi direct booking terhadap room revenue', 'Kode referensi K22.', '%', 'higher', 'bulanan', 'average', 'Room revenue dari website, WhatsApp, walk-in ÷ total room revenue × 100', 'VHP — Source of Business', 8, 1, 6.5, 11.25, 1, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(23, 1, 1, 'KPI/GPCH/2026/023', 9, 'Kepatuhan jadwal pemeliharaan preventif', 'Kode referensi K23.', '%', 'higher', 'bulanan', 'average', 'Pekerjaan preventif terlaksana ÷ terjadwal × 100', 'Laporan engineering mingguan', 10, 2, 55, 90, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(24, 1, 1, 'KPI/GPCH/2026/024', 10, 'Kamar general cleaning / refresh', 'Kode referensi K24.', 'kamar', 'higher', 'bulanan', 'sum', 'Jumlah kamar selesai general cleaning (target 20 kamar/minggu)', 'Laporan housekeeping', 11, 1, 40, 960, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(25, 1, 1, 'KPI/GPCH/2026/025', 10, 'Skor inspeksi kebersihan kamar', 'Kode referensi K25.', '%', 'higher', 'bulanan', 'average', 'Rata-rata skor checklist inspeksi kamar (defect list)', 'Room inspection checklist', 11, 2, 82, 90, 0, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(26, 1, 1, 'KPI/GPCH/2026/026', 11, 'Ketepatan pembayaran gaji & service charge', 'Kode referensi K26.', '%', 'higher', 'bulanan', 'average', '100 = gaji & service tepat waktu; 50 = salah satu terlambat; 0 = keduanya terlambat', 'Payroll HRD', 12, 1, 50, 100, 0, 0, 1, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(27, 1, 1, 'KPI/GPCH/2026/027', 12, 'Jam pelatihan per karyawan', 'Kode referensi K27.', 'jam', 'higher', 'bulanan', 'average', 'Total jam pelatihan ÷ jumlah karyawan', 'Training record HRD', 12, 1, 0.3, 2, 1, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(28, 1, 1, 'KPI/GPCH/2026/028', 13, 'Rasio karyawan per kamar', 'Kode referensi K28.', 'rasio', 'lower', 'bulanan', 'last', 'Total karyawan ÷ jumlah kamar', 'HRD', 12, 1, 0.47, 0.55, 2, 0, 0, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- market_analyses (9 baris)
INSERT INTO `market_analyses` (`id`, `company_id`, `analysis_period_id`, `segment`, `segment_group`, `description`, `share_percent`, `revenue_contribution`, `growth`, `is_target`, `needs`, `strategy`, `source`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Instansi pemerintah (MICE pemerintahan)', 'MICE', 'DISPORA, DISBUDPAR, DISNAKER, BPJS, SATPOL PP Kota/Kab. Bandung — halfday & fullboard meeting.', 24, NULL, 'turun', 1, 'Paket meeting sesuai SBM, administrasi pembayaran rapi, ketersediaan ruang besar.', 'Jaga akun, paket fullboard, tagih tepat waktu.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'Korporasi', 'Korporasi', 'Perusahaan farmasi, perbankan, distributor (mis. Anugrah Pharmindo Lestari, Puratos) — meeting, training, gathering.', 14, NULL, 'naik', 1, 'Fasilitas ruang rapat layak (plafon, AV), harga fleksibel, layanan cepat.', 'Corporate rate, early booking, paket meeting per pax.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'Grup & travel agent / tour', 'Grup', 'WITA Tour, Shiddiq Tour, Mampuh Travel, NRA Travel, Smart Umroh — rombongan wisata & manasik.', 9, NULL, 'naik', 1, 'Harga grup, makan rombongan, parkir bus.', 'Kontrak TA Jateng–Jatim, komisi khusus.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'Online Travel Agent (individu)', 'OTA', 'Traveloka, Agoda, Tiket.com, Booking.com, Expedia, Trip.com.', 27, NULL, 'naik', 1, 'Harga kompetitif, ulasan baik, foto terbaru.', 'Campaign OTA (10.10, birthday sale), early bird, last minute deal.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'Direct (walk-in, website, WhatsApp)', 'Direct', 'Promo WA blast (Septembersama 212 RN), walk-in 15%, website & booking engine.', 11, NULL, 'naik', 1, 'Respons cepat, promo eksklusif, database tamu repeater.', 'WA blast bulanan, program ulang tahun, metasearch Google.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'Wedding & acara sosial', 'Sosial', 'Pernikahan, reuni, gathering keluarga, komunitas & keagamaan (GMAHK, IPARI, Forum Muslimah).', 9, NULL, 'stabil', 1, 'Venue indoor/outdoor, dekorasi, katering, paket all-in.', 'Paket wedding, wedding expo, kerja sama WO.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 1, 'Pendidikan & long stay group', 'Long stay', 'Universitas Teknologi Bandung (UTB) group longstay, PKL, institusi pendidikan.', 6, NULL, 'stabil', 1, 'Harga long stay, makan, laundry.', 'Pertahankan kontrak UTB; tawarkan ke kampus lain.', 'PROYEKSI porsi pendapatan Jan–Sep 2026 — konfirmasi Sales & Chief Accountant (laporan segmen VHP)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(8, 1, 1, 'Leisure keluarga & staycation', 'Leisure', 'Keluarga akhir pekan dan liburan sekolah: kolam renang, kids corner, family karaoke.', NULL, NULL, 'naik', 1, 'Kolam bersih & bergaya, aktivitas anak, kuliner.', 'Paket family staycation & Pasundan Experience (porsi tercakup di OTA/Direct).', 'Kualitatif', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(9, 1, 1, 'Digital nomad / Work From Hotel', 'WFH', 'Pekerja jarak jauh membutuhkan coworking & internet cepat (keluhan Wi-Fi lambat di ulasan).', NULL, NULL, 'naik', 0, 'Wi-Fi cepat, meja kerja & pencahayaan kamar.', 'Paket WFH setelah Wi-Fi & pencahayaan kamar diperbaiki.', 'Kualitatif', '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- maturity_answers (25 baris)
INSERT INTO `maturity_answers` (`id`, `maturity_assessment_id`, `maturity_question_id`, `score`, `evidence`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 2, 3, 'Benchmark kompetitor mingguan di GM Weekly Report.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 3, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 4, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 5, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 6, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 7, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 8, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 9, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 10, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 11, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(12, 1, 12, 3, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(13, 1, 13, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(14, 1, 14, 3, 'Weekly report GM tiap Senin & rapat manajemen.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(15, 1, 15, 2, 'Neraca belum rutin (assessment 2024); PnL & cash flow mulai rutin 2026.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(16, 1, 16, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(17, 1, 17, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(18, 1, 18, 1, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(19, 1, 19, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(20, 1, 20, 1, 'Belum ada mekanisme formal penutupan tindak lanjut MoM.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(21, 1, 21, 3, 'Weekly report, rapat manajemen, rapat Timwas berjalan.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(22, 1, 22, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(23, 1, 23, 2, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(24, 1, 24, 1, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(25, 1, 25, 1, NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- maturity_assessments (1 baris)
INSERT INTO `maturity_assessments` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `assessment_date`, `assessor_id`, `overall_score`, `level`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'MAT/GPCH/2026/001', 'Penilaian Awal Kematangan Manajemen Strategi 2026 (baseline)', '2026-10-14 00:00:00', 5, 2.04, 2, 'final', 'Baseline saat migrasi ke Arah GPCH, disusun dari assessment Des 2024, MoM 2026 dan GM Weekly Report. Ulangi penilaian bersama GM, HOD & Timwas pada Nov–Des 2026.', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- maturity_questions (25 baris)
INSERT INTO `maturity_questions` (`id`, `phase`, `dimension`, `question`, `guidance`, `weight`, `sort`, `created_at`, `updated_at`) VALUES
(1, 'brahman', 'Pemindaian lingkungan', 'Organisasi memindai lingkungan eksternal (PESTEL, industri, pasar) secara berkala dan terdokumentasi.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(2, 'brahman', 'Analisis pesaing', 'Data pesaing (okupansi, ARR, RevPAR, rating) dipantau rutin dan dipakai untuk keputusan harga & penjualan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 2, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(3, 'brahman', 'Pemahaman pelanggan', 'Segmen pelanggan, kebutuhan, dan kontribusinya dianalisis dengan data.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 3, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(4, 'brahman', 'Isu strategis', 'Isu strategis diprioritaskan (urgensi × dampak) dan memiliki penanggung jawab.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 4, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(5, 'brahman', 'Regulasi & pemangku kepentingan', 'Kewajiban regulasi dan harapan pemangku kepentingan dipetakan dan dipantau kepatuhannya.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 5, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(6, 'atman', 'Visi & misi', 'Visi dan misi tertulis, disetujui pemilik, dan dipahami kepala departemen.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 6, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(7, 'atman', 'Nilai inti', 'Nilai inti diterjemahkan menjadi perilaku kerja yang dapat diamati.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 7, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(8, 'atman', 'Kapabilitas', 'Kapabilitas inti dan kesenjangannya teridentifikasi beserta rencana penutupan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 8, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(9, 'atman', 'Proposisi nilai', 'Proposisi nilai hotel (pengalaman Pasundan) jelas dan konsisten dikomunikasikan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 9, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(10, 'atman', 'Keselarasan budaya', 'Budaya kerja mendukung strategi (komunikasi dua arah, disiplin, kerja tim).', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 10, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(11, 'karma_phala', 'Sasaran strategis', 'Sasaran strategis disusun dalam 4 perspektif dengan hubungan sebab-akibat (peta strategi).', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 11, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(12, 'karma_phala', 'KPI & target', 'Setiap sasaran memiliki KPI terukur dengan target bulanan dan pemilik.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 12, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(13, 'karma_phala', 'Realisasi tepat waktu', 'Realisasi KPI diinput tepat waktu dan diverifikasi dengan sumber data (VHP, laporan keuangan).', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 13, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(14, 'karma_phala', 'Tinjauan kinerja', 'Tinjauan kinerja rutin (mingguan/bulanan) menghasilkan keputusan dan tindak lanjut.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 14, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(15, 'karma_phala', 'Pelaporan keuangan', 'Laporan laba rugi, arus kas, dan neraca tersedia setiap bulan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 15, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(16, 'punarbhawa', 'Portofolio inisiatif', 'Inisiatif strategis dipilih berdasarkan nilai dan upaya, terkait dengan sasaran.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 16, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(17, 'punarbhawa', 'Pemantauan progres', 'Progres aktivitas dan milestone inisiatif diperbarui minimal mingguan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 17, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(18, 'punarbhawa', 'Anggaran inisiatif', 'Anggaran inisiatif direncanakan dan realisasinya dicatat.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 18, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(19, 'punarbhawa', 'Temuan & koreksi', 'Temuan dari tinjauan ditindaklanjuti dengan tindakan korektif bertenggat dan PIC.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 19, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(20, 'punarbhawa', 'Penutupan temuan', 'Temuan ditutup hanya setelah tindakan korektif selesai dan terbukti efektif.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 20, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(21, 'moksa', 'Pelembagaan ritme', 'Ritme manajemen (weekly report, rapat bulanan, rapat Timwas) berjalan konsisten.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 21, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(22, 'moksa', 'Kebijakan & SOP', 'Praktik baik dibakukan menjadi kebijakan/SOP dan disosialisasikan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 22, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(23, 'moksa', 'Sistem pendukung', 'Sistem (PMS VHP, Arah GPCH) dipakai sebagai alat operasional, bukan sekadar laporan.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 23, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(24, 'moksa', 'Pembelajaran organisasi', 'Pelajaran dari keberhasilan/kegagalan didokumentasikan dan dipakai untuk perioda berikutnya.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 24, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(25, 'moksa', 'Ketergantungan & risiko', 'Ketergantungan strategis (dana, vendor, pemilik) dipetakan beserta mitigasinya.', '1 = belum ada; 2 = ada tetapi tidak rutin; 3 = terdokumentasi & berjalan; 4 = terukur & dievaluasi; 5 = optimal & menjadi budaya', 1, 25, '2026-10-18 00:25:06', '2026-10-18 00:25:06');

-- migrations (51 baris)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_10_01_000001_create_companies_table', 1),
(5, '2026_10_01_000002_create_analysis_periods_table', 1),
(6, '2026_10_01_000003_add_profile_columns_to_users_table', 1),
(7, '2026_10_01_000004_create_company_user_table', 1),
(8, '2026_10_01_000005_create_user_contexts_table', 1),
(9, '2026_10_01_000006_create_roles_table', 1),
(10, '2026_10_01_000007_create_permissions_table', 1),
(11, '2026_10_01_000008_create_permission_role_table', 1),
(12, '2026_10_01_000009_create_role_user_table', 1),
(13, '2026_10_01_000010_create_audit_logs_table', 1),
(14, '2026_10_01_000011_create_dhastram_sequences_table', 1),
(15, '2026_10_01_000012_create_environment_scans_table', 1),
(16, '2026_10_01_000013_create_pestel_analyses_table', 1),
(17, '2026_10_01_000014_create_industry_forces_table', 1),
(18, '2026_10_01_000015_create_market_analyses_table', 1),
(19, '2026_10_01_000016_create_competitors_table', 1),
(20, '2026_10_01_000017_create_regulations_table', 1),
(21, '2026_10_01_000018_create_stakeholders_table', 1),
(22, '2026_10_01_000019_create_strategic_issues_table', 1),
(23, '2026_10_01_000020_create_strategic_issue_stakeholder_table', 1),
(24, '2026_10_01_000021_create_swot_items_table', 1),
(25, '2026_10_01_000022_create_tows_strategies_table', 1),
(26, '2026_10_01_000023_create_tows_strategy_issue_table', 1),
(27, '2026_10_01_000024_create_atman_profiles_table', 1),
(28, '2026_10_01_000025_create_core_values_table', 1),
(29, '2026_10_01_000026_create_capabilities_table', 1),
(30, '2026_10_01_000027_create_strategic_themes_table', 1),
(31, '2026_10_01_000028_create_strategic_choices_table', 1),
(32, '2026_10_01_000029_create_strategic_objectives_table', 1),
(33, '2026_10_01_000030_create_objective_relations_table', 1),
(34, '2026_10_01_000031_create_kpis_table', 1),
(35, '2026_10_01_000032_create_kpi_targets_table', 1),
(36, '2026_10_01_000033_create_kpi_actuals_table', 1),
(37, '2026_10_01_000034_create_performance_reviews_table', 1),
(38, '2026_10_01_000035_create_review_notes_table', 1),
(39, '2026_10_01_000036_create_strategic_initiatives_table', 1),
(40, '2026_10_01_000037_create_initiative_objective_table', 1),
(41, '2026_10_01_000038_create_initiative_activities_table', 1),
(42, '2026_10_01_000039_create_initiative_milestones_table', 1),
(43, '2026_10_01_000040_create_initiative_budgets_table', 1),
(44, '2026_10_01_000041_create_findings_table', 1),
(45, '2026_10_01_000042_create_corrective_actions_table', 1),
(46, '2026_10_01_000043_create_maturity_questions_table', 1),
(47, '2026_10_01_000044_create_maturity_assessments_table', 1),
(48, '2026_10_01_000045_create_maturity_answers_table', 1),
(49, '2026_10_01_000046_create_strategic_dependencies_table', 1),
(50, '2026_10_01_000047_create_institutionalizations_table', 1),
(51, '2026_10_01_000048_create_notifications_table', 1);

-- objective_relations (18 baris)
INSERT INTO `objective_relations` (`id`, `company_id`, `analysis_period_id`, `source_objective_id`, `target_objective_id`, `strength`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 3, 2, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 4, 1, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 6, 1, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 5, 4, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 5, 6, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 7, 2, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 7, 3, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 8, 4, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 9, 6, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 9, 5, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 10, 5, 3, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 11, 10, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(14, 1, 1, 11, 9, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(15, 1, 1, 12, 7, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(16, 1, 1, 12, 8, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(17, 1, 1, 12, 10, 2, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(18, 1, 1, 13, 3, 1, NULL, '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- performance_reviews (6 baris)
INSERT INTO `performance_reviews` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `review_type`, `review_date`, `period_label`, `chair`, `participants`, `venue`, `summary`, `decisions`, `follow_up`, `status`, `recorded_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'REV/GPCH/2026/001', 'Rapat GBK–GPCH: stok gudang, penangguhan beban & purchasing', 'rapat_timwas', '2026-06-03 00:00:00', 'Mei 2026', 'Bapak Wilfred', 'Ibu Lena, Pak Irawan, Pak Joice, Pak Miko, Pak Daniel, Bu Yuli, Pak Indra', 'Ruang Sangkuriang', '1. Penutupan rekening lama: surat kuasa penutupan rekening BRI diminta; BJB masih proses karena Ibu Lena kehilangan 2 lembar cek.\n2. Penjelasan stok gudang Rp667,5 jt (Bpk Irawan Trimulia): Feb–Mar dilakukan deferred cost (penangguhan pembebanan food cost) saat revenue rendah, program Iftar menaikkan food cost dan THR menaikkan payroll; dilakukan untuk menjaga GOP; dibebankan ke bulan berikutnya dan habis dalam 1 tahun fiskal.\n3. Potongan SP uang service dibagikan rata ke semua karyawan di bulan yang sama kecuali yang dikenakan SP.', 'A. Penangguhan beban hanya boleh bila dalam satu bulan revenue rendah dan fixed cost membesar.\nB. Timwas memutuskan cost yang ditangguhkan dibebankan secara riil; tidak ada lagi penangguhan beban pada data inventory.\nC. Pak Daniel ditugaskan menjadi Purchasing GPCH, didampingi & ditraining Pak Rustamadji; payroll, service, BPJS dibayarkan Manajemen GPCH.\nD. Administrasi HRM dilengkapi; job description disiapkan CA & GM; struktur direct report ke GM.', 'Accounting mendata cost yang ditangguhkan vs riil; penutupan rekening BJB & BRI.', 'final', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 'REV/GPCH/2026/002', 'Tinjauan Keuangan Juni 2026 (kuartal II)', 'kuartalan', '2026-07-15 00:00:00', 'Juni 2026 / Q2', 'General Manager', 'GM, Chief Accountant, kepala departemen', 'Ruang Niskala', 'Operasional masih menghasilkan arus kas positif namun sangat tipis: penerimaan Rp2.401.524.265, pengeluaran Rp2.379.705.393, surplus Rp21.818.872 (0,91%).\nAset lancar Rp754.902.503 (bank Rp331,8 jt, piutang Rp285,2 jt, persediaan Rp137,9 jt) hanya menutup 45% kewajiban operasional Rp1.685.376.801 (utang usaha Rp580,9 jt, utang revitalisasi Rp183,0 jt, deposit TA Rp582,1 jt, utang PBB 2025 Rp339,3 jt); kekurangan modal kerja ±Rp930 jt.\nPiutang lama Rp143,1 jt; pembelian F&B Rp464,4 jt (78% dari seluruh pembelian, ±52% pendapatan F&B); utang CEO jangka panjang Rp30.910.787.939.', '1. Susun proyeksi arus kas mingguan.\n2. Percepat penagihan piutang (korporasi, travel agent, penyelenggara kegiatan).\n3. Kendalikan pembelian & food cost (resep, porsi, harga jual, waste, konsumsi karyawan, complimentary, selisih stok, kontrak pemasok).\n4. Jaga penggunaan deposit OTA.\n5. Jadwalkan pembayaran pemasok dan PBB.\n6. Restrukturisasi utang CEO (tenor, subordinasi, konversi modal).', NULL, 'final', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 'REV/GPCH/2026/003', 'Rapat Manajemen Bulanan — Juli 2026', 'rapat_manajemen', '2026-08-10 00:00:00', 'Juli 2026', 'General Manager', 'GM & seluruh kepala departemen', 'Ruang Niskala', 'PROYEKSI — ringkasan disusun dari data realisasi Arah GPCH; lengkapi dengan notulen asli rapat Juli 2026.', 'Lengkapi dari notulen asli.', NULL, 'draf', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 'REV/GPCH/2026/004', 'Rapat Manajemen Bulanan — Agustus 2026', 'rapat_manajemen', '2026-09-10 00:00:00', 'Agustus 2026', 'General Manager', 'GM & seluruh kepala departemen', 'Ruang Niskala', 'PROYEKSI — ringkasan disusun dari data realisasi Arah GPCH; lengkapi dengan notulen asli rapat Agustus 2026.', 'Lengkapi dari notulen asli.', NULL, 'draf', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 'REV/GPCH/2026/005', 'Rapat Manajemen — Action Plan Revenue Recovery 21–30 Sep 2026', 'rapat_manajemen', '2026-09-23 00:00:00', 'September 2026', 'Bapak Yodi S. Ibrahim & Bapak I.G. Wiwin S.', 'Bpk. Indra, Bpk. Wahyudin, Bpk. Anto, Bpk. Rizki, Bpk. Ujang, Pak Asep Agus, Ibu Irina, Bpk. Daniel, Ibu Yuyun, Bpk. Dio', 'Ruang Niskala', 'Info 3P minggu ke-3 September 2026 oleh Management.\nA. Room revenue: tingkatkan occupancy sekaligus jaga ADR — review pickup harian & forecast, push corporate/local account & group, optimalkan OTA di tanggal okupansi rendah, tactical promotion (bukan diskon menyeluruh), daily review Occ/ADR/RevPAR.\nB. Banquet — prioritas utama: shortfall Rp681,95 jt; follow up database corporate & EO, review pipeline, paket meeting/wedding/gathering/social, daily pipeline report (inquiry, quotation, follow-up, tentative, confirmed, revenue potential).\nC. Outlet F&B (coffee shop, room service, lounge): bundle promo, upselling in-house guest, promo room service via kamar/channel, breakfast upselling untuk room-only, cross-selling, review jam operasional.\nD. Other revenue: pertahankan healthy club, laundry, parkir; buat paket promosi spa.', 'Usulan Bpk. Wimpy (MB), Bpk. Yodi & Bpk. Wiwin:\n• Biaya ke depan meningkat, tujuan owner hanya satu: hasil.\n• Kompetitor mencari pasar, bukan mencuri rejeki kita — manjakan pelanggan setia.\n• Jangan duduk bersepakat tapi action tidak bersepakat; perkuat teamwork.\n• Cari potensi revenue yang sedang booming (mis. pameran mobil listrik); semua HOD mencari peluang event.\n• CEO ingin melihat penyebab inefisiensi di GP — analisa & kaji; pemborosan dikurangi.\n• Ketegasan pimpinan = teguran sesuai peraturan, bukan pressure.\n• VHP: menu dashboard, notifikasi approval PR, supplier & artikel casual, approval sign form PR — follow up ke VHP (Ticket #181ADD).\n• Jumat 13.00: data budgeting & kendala operasional tiap departemen.\n• F&B wajib punya data perencanaan di sistem; semua HOD punya akses tambah item PR.\n• Sistem adalah alat operasional, bukan laporan; buat PNP VHP untuk HOD.\n• Buat timeline pekerjaan beserta PIC; usulan di MoM selalu ditindaklanjuti minggu berikutnya.', 'Timeline pekerjaan & PIC; tindak lanjut MoM pada weekly report berikutnya.', 'final', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 'REV/GPCH/2026/006', 'GM Weekly Report 21–27 September 2026', 'weekly_gm', '2026-09-28 00:00:00', '21–27 Sep 2026 (MTD)', 'General Manager', 'HR (Anto), Purchasing (Daniel), Accounting (Indra), Engineering (Wahyudin), FBP & FBS, Front Office (Rizki), Sales Marketing (Irina), Housekeeping (Wina)', 'Ruang Niskala', 'MTD: room sold 2.167 dari 4.428 (Occ 48,71% vs budget 52,54%), ADR Rp334.547 vs Rp398.860, RevPAR Rp162.967, room revenue Rp721,6 jt (77,6% budget).\nBreakfast Rp180,1 jt (164,8%), coffee shop Rp13,9 jt (28,2%), room service Rp11,4 jt (20,4%), lounge Rp7,5 jt (24,0%), cafetaria Rp7,1 jt (62,5%), banquet Rp430,7 jt (21,85% menurut laporan) — F&B Rp650,8 jt (33,4%).\nTotal hotel revenue Rp1.409.097.543 = 51,60% budget Rp2.397.993.249 (shortfall Rp988.895.706); −17,62% vs bulan lalu, +4,64% vs tahun lalu.\nKompetitor: GPCH peringkat 3 (RGI 0,92). Lost business Rp192,5 jt; postponed Rp15,75 jt; cancel Rp31,3 jt.\nEnergi Sep ±Rp213,3 jt (53,39% budget). Karyawan 72 (rasio 0,44). Engineering: panel lift 1 on progress, pompa kolam baru terpasang namun sand filter bocor, LPG→CNG menunggu tanda tangan CEO.', 'Fokus revenue recovery sisa September: tactical promotion tanggal low occupancy, jaga ADR, review pickup & cancellation harian, fokus corporate/government/group/OTA, monitoring Occ+ADR+RevPAR harian; banquet: review pipeline, sales call, tactical package, follow-up quotation, tarik event maju; outlet: review traffic, average check, jam operasional, promosi; pertahankan breakfast & healthy club.', 'FO: promo Oktober (walk-in 15%, last minute weekdays 10%, early bird 3/7/14 hari), business review Traveloka & Trip.com. Sales: telemarketing, IG live house tour, budgeting 2027. HR: GM baru Ibu Vivera join 1 Okt 2026; LOI EHK baru.', 'final', 5, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- permission_role (233 baris)
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(9, 1),
(8, 1),
(2, 1),
(7, 1),
(6, 1),
(3, 1),
(31, 1),
(32, 1),
(28, 1),
(26, 1),
(27, 1),
(25, 1),
(21, 1),
(19, 1),
(20, 1),
(18, 1),
(16, 1),
(14, 1),
(15, 1),
(17, 1),
(13, 1),
(30, 1),
(29, 1),
(5, 1),
(4, 1),
(23, 1),
(24, 1),
(22, 1),
(11, 1),
(12, 1),
(10, 1),
(1, 1),
(9, 2),
(8, 2),
(2, 2),
(7, 2),
(6, 2),
(3, 2),
(31, 2),
(32, 2),
(28, 2),
(26, 2),
(27, 2),
(25, 2),
(21, 2),
(19, 2),
(20, 2),
(18, 2),
(16, 2),
(14, 2),
(15, 2),
(17, 2),
(13, 2),
(30, 2),
(29, 2),
(5, 2),
(4, 2),
(23, 2),
(24, 2),
(22, 2),
(11, 2),
(12, 2),
(10, 2),
(9, 3),
(8, 3),
(2, 3),
(7, 3),
(6, 3),
(3, 3),
(31, 3),
(32, 3),
(28, 3),
(26, 3),
(27, 3),
(25, 3),
(21, 3),
(19, 3),
(20, 3),
(18, 3),
(14, 3),
(15, 3),
(13, 3),
(30, 3),
(29, 3),
(5, 3),
(4, 3),
(23, 3),
(24, 3),
(22, 3),
(11, 3),
(12, 3),
(10, 3),
(3, 4),
(31, 4),
(25, 4),
(18, 4),
(13, 4),
(29, 4),
(5, 4),
(4, 4);
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(22, 4),
(12, 4),
(10, 4),
(3, 5),
(31, 5),
(15, 5),
(13, 5),
(3, 6),
(31, 6),
(25, 6),
(20, 6),
(18, 6),
(3, 7),
(31, 7),
(25, 7),
(29, 7),
(23, 7),
(22, 7),
(8, 8),
(2, 8),
(6, 8),
(3, 8),
(31, 8),
(25, 8),
(18, 8),
(13, 8),
(29, 8),
(4, 8),
(22, 8),
(12, 8),
(10, 8),
(8, 9),
(2, 9),
(6, 9),
(3, 9),
(31, 9),
(25, 9),
(20, 9),
(18, 9),
(13, 9),
(29, 9),
(4, 9),
(22, 9),
(12, 9),
(10, 9),
(1, 9),
(8, 10),
(2, 10),
(6, 10),
(3, 10),
(31, 10),
(26, 10),
(25, 10),
(18, 10),
(13, 10),
(29, 10),
(5, 10),
(4, 10),
(24, 10),
(22, 10),
(12, 10),
(10, 10),
(9, 11),
(8, 11),
(2, 11),
(7, 11),
(6, 11),
(3, 11),
(31, 11),
(32, 11),
(28, 11),
(26, 11),
(27, 11),
(25, 11),
(21, 11),
(19, 11),
(20, 11),
(18, 11),
(16, 11),
(14, 11),
(15, 11),
(17, 11),
(13, 11),
(30, 11),
(29, 11),
(5, 11),
(4, 11),
(23, 11),
(24, 11),
(22, 11),
(11, 11),
(12, 11),
(10, 11),
(3, 12),
(31, 12),
(27, 12),
(25, 12),
(21, 12),
(20, 12),
(18, 12);
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(15, 12),
(17, 12),
(13, 12),
(5, 12),
(4, 12),
(22, 12),
(12, 12),
(10, 12),
(8, 13),
(6, 13),
(3, 13),
(31, 13),
(27, 13),
(25, 13),
(20, 13),
(18, 13),
(15, 13),
(13, 13),
(29, 13),
(4, 13),
(22, 13),
(12, 13),
(10, 13),
(7, 14),
(6, 14),
(9, 15),
(8, 15),
(3, 16),
(31, 16),
(20, 16),
(18, 16),
(15, 16),
(13, 16);

-- permissions (32 baris)
INSERT INTO `permissions` (`id`, `slug`, `name`, `group`, `description`, `created_at`, `updated_at`) VALUES
(1, 'system.admin', 'Administrasi sistem (perusahaan, pengguna, peran)', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(2, 'audit.view', 'Melihat log audit', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(3, 'context.switch', 'Memilih perusahaan & perioda', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(4, 'report.view', 'Melihat laporan', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(5, 'report.export', 'Mengunduh/ekspor laporan', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(6, 'brahman.view', 'Melihat Ekosistem', 'brahman', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(7, 'brahman.edit', 'Mengubah Ekosistem', 'brahman', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(8, 'atman.view', 'Melihat Jati Diri', 'atman', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(9, 'atman.edit', 'Mengubah Jati Diri', 'atman', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(10, 'strategy.view', 'Melihat tema, pilihan & sasaran strategis', 'strategy', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(11, 'strategy.edit', 'Mengubah tema, pilihan & sasaran strategis', 'strategy', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(12, 'strategy.map', 'Melihat peta strategi', 'strategy', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(13, 'kpi.view', 'Melihat KPI, target & realisasi', 'kpi', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(14, 'kpi.edit', 'Mengubah KPI & target', 'kpi', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(15, 'kpi.input_actual', 'Mengisi realisasi KPI (miliknya)', 'kpi', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(16, 'kpi.approve_actual', 'Menyetujui realisasi KPI', 'kpi', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(17, 'kpi.verify_finance', 'Memverifikasi realisasi KPI keuangan (baru)', 'kpi', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(18, 'initiative.view', 'Melihat inisiatif strategis', 'initiative', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(19, 'initiative.edit', 'Mengubah inisiatif strategis', 'initiative', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(20, 'initiative.update_progress', 'Memperbarui progres aktivitas & milestone (miliknya)', 'initiative', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(21, 'initiative.budget', 'Mencatat realisasi anggaran inisiatif (baru)', 'initiative', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(22, 'review.view', 'Melihat tinjauan kinerja', 'review', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(23, 'review.edit', 'Mengubah tinjauan kinerja', 'review', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(24, 'review.note', 'Menambah catatan pengawasan pada tinjauan (baru)', 'review', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(25, 'finding.view', 'Melihat temuan', 'finding', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(26, 'finding.create', 'Membuat temuan baru (baru)', 'finding', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(27, 'finding.edit', 'Mengubah temuan & tindakan korektif (miliknya)', 'finding', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(28, 'finding.close', 'Menutup temuan', 'finding', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(29, 'maturity.view', 'Melihat Kesinambungan', 'maturity', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(30, 'maturity.assess', 'Menilai kematangan & mengubah Kesinambungan', 'maturity', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(31, 'dashboard.view', 'Melihat Beranda & Pusat Kendali', 'dashboard', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(32, 'data.manage_all', 'Mengelola semua data tanpa batas "miliknya" (pengelola)', 'system', NULL, '2026-10-18 00:25:06', '2026-10-18 00:25:06');

-- pestel_analyses (14 baris)
INSERT INTO `pestel_analyses` (`id`, `company_id`, `analysis_period_id`, `factor`, `title`, `description`, `impact_type`, `impact_level`, `likelihood`, `trend`, `response`, `source`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'politik', 'Efisiensi anggaran belanja pemerintah', 'Pemangkasan anggaran perjalanan dinas & rapat instansi menurunkan MICE pemerintahan yang selama ini menjadi tumpuan banquet GPCH.', 'ancaman', 5, 4, 'naik', 'Diversifikasi ke korporasi, sosial/wedding, komunitas, pendidikan; paket meeting fleksibel.', 'Konsep Kerja 2025', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'politik', 'Agenda event olahraga & kebudayaan daerah', 'PORPROV Jabar (Nov 2026) dan Piala Gubernur (Okt 2026); kegiatan Disbudpar & Dispora Kota Bandung rutin memakai hotel.', 'peluang', 3, 4, 'naik', 'Pendekatan DISPORA/KONI se-Jabar; paket akomodasi atlet & ofisial.', 'GM Weekly Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'ekonomi', 'Kenaikan harga energi', 'Solar Rp21.300/L (27 Sep 2026); LPG 50 kg naik menjadi Rp1.070.000/tabung dan 12 kg Rp235.000 (16 Sep 2026). Konsumsi energi Sep ±Rp213,3 jt.', 'ancaman', 4, 5, 'naik', 'Konversi LPG→CNG, lampu LED, monitoring energi mingguan.', 'Engineering Energy Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'ekonomi', 'Biaya tenaga kerja & bahan baku terus naik', 'UMK, listrik, bahan bakar, air dan bahan F&B cenderung naik sementara harga kamar stagnan.', 'ancaman', 4, 5, 'naik', 'Kendali food cost, struktur SDM multitasking, revenue per available room.', 'Assessment Awal Des 2024', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'ekonomi', 'Permintaan staycation keluarga & akhir pekan', 'Kolam renang besar dan kamar luas diminati keluarga (ulasan Google Sep 2026); healthy club & breakfast melampaui budget.', 'peluang', 3, 4, 'naik', 'Paket family staycation, cafetaria weekend, live music.', 'GM Weekly Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'sosial', 'Wisata pengalaman & budaya lokal', 'Tamu mencari pengalaman autentik: kuliner Sunda, cerita, desain lokal ("Staycation budaya di Bandung").', 'peluang', 4, 4, 'naik', 'Pasundan Experience: welcome ritual, menu bercerita, ornamen Sunda, kelas memasak.', 'Konsep Kerja 2025', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 1, 'sosial', 'Pasar wedding & acara sosial Bandung', 'Permintaan venue wedding & gathering keluarga tetap tinggi; pameran wedding (Heritage Wedding Bride Expo, Jan 2027).', 'peluang', 4, 3, 'stabil', 'Paket wedding Malibu Dome & outdoor; ikut wedding expo.', 'GM Weekly Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(8, 1, 1, 'teknologi', 'Dominasi OTA & metasearch', 'Sebagian besar reservasi individu lewat Traveloka, Agoda, Tiket.com, Booking.com, Expedia, Trip.com; komisi menekan ARR.', 'ancaman', 4, 5, 'naik', 'Aktifkan metasearch Google, booking engine, promo kode di website, WA booking.', 'GM Weekly Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(9, 1, 1, 'teknologi', 'Digitalisasi pembayaran & PMS cloud', 'QRIS, VHP Cloud & dashboard mobile memungkinkan rekonsiliasi otomatis dan data real-time.', 'peluang', 3, 4, 'naik', 'QRIS di semua outlet; manfaatkan dashboard VHP; Arah GPCH untuk KPI.', 'Konsep Kerja 2025', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(10, 1, 1, 'teknologi', 'Tren kendaraan listrik', 'Pameran mobil listrik sedang diminati; kebutuhan charger EV di hotel.', 'peluang', 2, 3, 'naik', 'Instalasi jalur kabel charger mobil listrik di basement; tawarkan Malibu Dome untuk pameran otomotif.', 'MoM 23 Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(11, 1, 1, 'lingkungan', 'Pengelolaan limbah & air tanah', 'Pajak air tanah (closing tiap tanggal 10), STP, TPS sampah yang meluap saat event besar dengan katering luar.', 'ancaman', 3, 4, 'stabil', 'Pemanfaatan limbah STP (vendor Jayawiratama), area khusus katering luar.', 'Engineering Report Sep 2026; Assessment Des 2024', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(12, 1, 1, 'hukum', 'Kepatuhan royalti hak cipta musik', 'Sosialisasi Kanwil Kementerian Hukum Jabar tentang kepatuhan hak cipta musik di hotel (1 Okt 2026); berlaku untuk musik lobby, live music & karaoke.', 'ancaman', 3, 4, 'naik', 'Inventarisasi pemakaian musik; lisensi/royalti melalui LMKN.', 'GM Weekly Report Sep 2026 (rencana HR)', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(13, 1, 1, 'hukum', 'Kewajiban PBB & pajak daerah', 'Utang PBB 2025 Rp339,3 jt belum diselesaikan; risiko denda & kepatuhan.', 'ancaman', 4, 5, 'stabil', 'Jadwal cicilan PBB, komunikasi dengan Bapenda.', 'Analisis Keuangan Juni 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(14, 1, 1, 'hukum', 'Penempatan tenaga kerja yang aman & legal', 'Transformasi sistem penempatan tenaga kerja (Disnaker Jabar); komposisi GPCH: PKWT 34, daily worker 38, trainee 17.', 'ancaman', 3, 3, 'naik', 'Tinjau status daily worker & casual; administrasi HRM lengkap.', 'GM Weekly Report Sep 2026', '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- regulations (9 baris)
INSERT INTO `regulations` (`id`, `company_id`, `analysis_period_id`, `title`, `issuer`, `reference_no`, `category`, `effective_date`, `description`, `impact`, `compliance_status`, `owner_id`, `due_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Pajak Bumi dan Bangunan (PBB-P2) 2025', 'Pemerintah Kota Bandung (Bapenda)', NULL, 'Pajak', '2025-01-01 00:00:00', 'Kewajiban PBB tahun 2025 sebesar Rp339.306.820 belum dilunasi per Juni 2026.', 'Denda & risiko kepatuhan; membebani arus kas.', 'belum', 6, '2026-12-31 00:00:00', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'Pajak Barang dan Jasa Tertentu (PBJT) jasa perhotelan & makanan-minuman', 'Pemerintah Kota Bandung', 'UU No. 1 Tahun 2022 (HKPD) & Perda Kota Bandung', 'Pajak', NULL, 'Pajak daerah atas jasa perhotelan dan makanan/minuman yang dipungut dari tamu dan disetor bulanan.', 'Harus tercermin benar di VHP (tax & service) dan disetor tepat waktu.', 'patuh', 6, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'Pajak air tanah', 'Pemerintah Provinsi/Kota (Bapenda)', NULL, 'Pajak', NULL, 'Pemakaian sumur 1 & 2 (±2.215 m³/bulan); closing setiap tanggal 10.', 'Biaya energi/utilitas; pencatatan meter wajib rutin.', 'patuh', 10, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'Royalti hak cipta lagu dan/atau musik', 'Kementerian Hukum — LMKN', 'PP No. 56 Tahun 2021', 'Hak cipta', NULL, 'Penggunaan musik di area publik hotel, live music, dan karaoke secara komersial wajib membayar royalti.', 'Sosialisasi Kanwil Jabar 1 Okt 2026; risiko teguran/tuntutan.', 'dipantau', 12, '2026-12-31 00:00:00', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'Perjanjian kerja waktu tertentu (PKWT) & alih daya', 'Kementerian Ketenagakerjaan / Disnaker Jabar', 'PP No. 35 Tahun 2021', 'Ketenagakerjaan', NULL, 'Ketentuan PKWT, alih daya, waktu kerja; komposisi karyawan GPCH banyak daily worker & trainee.', 'Status casual/daily worker perlu ditata; administrasi HRM.', 'sebagian', 12, '2026-12-31 00:00:00', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'BPJS Ketenagakerjaan & Kesehatan', 'BPJS', NULL, 'Ketenagakerjaan', NULL, 'Kepesertaan & iuran BPJS seluruh karyawan; Notulen 3 Jun 2026: payroll, service & BPJS dibayarkan Manajemen GPCH.', 'Keterlambatan berisiko denda & menurunkan motivasi.', 'patuh', 12, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 1, 'Jaminan produk halal F&B', 'BPJPH Kementerian Agama', 'UU No. 33 Tahun 2014 jo. PP No. 39 Tahun 2021', 'F&B', NULL, 'Kewajiban sertifikasi halal produk makanan & minuman yang dijual.', 'Penting untuk segmen pemerintah, umroh & keluarga muslim.', 'dipantau', 9, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(8, 1, 1, 'K3 elevator', 'Kementerian Ketenagakerjaan', 'Permenaker No. 6 Tahun 2017', 'Keselamatan', NULL, 'Pemeriksaan & pengujian berkala elevator; penggantian panel lift 1 (Sep–Okt 2026).', 'Lift tamu & karyawan wajib laik operasi.', 'sebagian', 10, '2026-11-30 00:00:00', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(9, 1, 1, 'Baku mutu air limbah domestik', 'Kementerian Lingkungan Hidup', 'Permen LHK No. P.68 Tahun 2016', 'Lingkungan', NULL, 'Pengolahan air limbah (STP) harus memenuhi baku mutu sebelum dibuang.', 'Rencana pemanfaatan limbah STP dengan vendor.', 'dipantau', 10, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- review_notes (2 baris)
INSERT INTO `review_notes` (`id`, `company_id`, `analysis_period_id`, `performance_review_id`, `user_id`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 3, 'Timwas akan memeriksa data inventory bulan Juli–Agustus untuk memastikan tidak ada lagi penangguhan beban.', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 6, 3, 'Catatan pengawasan: shortfall banquet harus disertai daftar pipeline per event dan alasan loss. Mohon analisis penyebab inefisiensi (permintaan CEO) disampaikan pada rapat manajemen Oktober.', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- role_user (26 baris)
INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL),
(2, 9, 2, 1, NULL, NULL),
(3, 10, 3, 1, NULL, NULL),
(4, 11, 4, 1, NULL, NULL),
(5, 3, 5, 1, NULL, NULL),
(6, 12, 6, 1, NULL, NULL),
(7, 13, 7, 1, NULL, NULL),
(8, 14, 7, 1, NULL, NULL),
(9, 13, 8, 1, NULL, NULL),
(10, 13, 9, 1, NULL, NULL),
(11, 13, 10, 1, NULL, NULL),
(12, 13, 11, 1, NULL, NULL),
(13, 13, 12, 1, NULL, NULL),
(14, 15, 12, 1, NULL, NULL),
(15, 13, 13, 1, NULL, NULL),
(16, 16, 14, 1, NULL, NULL),
(17, 16, 15, 1, NULL, NULL),
(18, 16, 16, 1, NULL, NULL),
(19, 16, 17, 1, NULL, NULL),
(20, 16, 18, 1, NULL, NULL),
(21, 8, 19, 1, NULL, NULL),
(22, 4, 20, 1, NULL, NULL),
(23, 8, 21, 1, NULL, NULL),
(24, 8, 22, 1, NULL, NULL),
(25, 8, 23, 1, NULL, NULL),
(26, 8, 24, 1, NULL, NULL);

-- roles (16 baris)
INSERT INTO `roles` (`id`, `slug`, `name`, `description`, `is_system`, `created_at`, `updated_at`) VALUES
(1, 'super-admin', 'Super Admin', 'Konsultan / vendor DHASTRAM — semua izin', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(2, 'company-admin', 'Company Admin', 'Semua kecuali system.admin', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(3, 'strategy-office', 'Strategy Office', 'Koordinator Manajemen Strategi: semua kecuali system.admin, kpi.approve_actual dan kpi.verify_finance', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(4, 'management', 'Management', 'Dasbor, laporan + ekspor, lihat strategi/peta/KPI/inisiatif/tinjauan/temuan/kematangan', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(5, 'kpi-owner', 'KPI Owner', 'Mengisi realisasi KPI miliknya', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(6, 'initiative-pic', 'Initiative PIC', 'Memperbarui progres inisiatif miliknya (+ melihat temuan)', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(7, 'reviewer', 'Reviewer', 'Tinjauan kinerja & temuan', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(8, 'viewer', 'Viewer', 'Baca-saja', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(9, 'gpch-admin-sistem', 'GPCH Admin Sistem', 'EDP / IT Manager: akun pengguna, peran, reset kata sandi', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(10, 'gpch-pengawas', 'GPCH Tim Pengawas', 'Ketua Tim Pengawas: baca semua, catatan pengawasan & membuat temuan', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(11, 'gpch-gm', 'GPCH General Manager', 'Semua kecuali system.admin; menyetujui realisasi & menutup temuan', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(12, 'gpch-keuangan', 'GPCH Keuangan', 'Chief Accountant: KPI keuangan, verifikasi, realisasi anggaran', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(13, 'gpch-kepala-dept', 'GPCH Kepala Departemen', 'Input realisasi KPI & progres inisiatif miliknya, tindakan korektif miliknya', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(14, 'gpch-editor-ekosistem', 'GPCH Editor Ekosistem', 'Tambahan: mengubah data Ekosistem (pasar, pesaing, isu)', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(15, 'gpch-editor-jatidiri', 'GPCH Editor Jati Diri', 'Tambahan: mengubah Jati Diri (kapabilitas, nilai inti)', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06'),
(16, 'gpch-pelaksana', 'GPCH Pelaksana', 'Supervisor/staf: input data atas nama departemen', 1, '2026-10-18 00:25:06', '2026-10-18 00:25:06');

-- stakeholders (13 baris)
INSERT INTO `stakeholders` (`id`, `company_id`, `analysis_period_id`, `name`, `type`, `category`, `interest`, `influence`, `expectations`, `engagement_strategy`, `contact_person`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Pemilik (Bapak Wimpy)', 'internal', 'Pemilik', 5, 5, 'Hasil: profit, nilai properti, nama baik Grand Pasundan.', 'Laporan bulanan ringkas, keputusan investasi bertahap.', 'Bapak Wimpy', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'Tim Pengawas (Ketua: Bapak Wilfred)', 'internal', 'Pengawas', 5, 5, 'Disiplin biaya, laporan keuangan real (tanpa penangguhan beban), tindak lanjut keputusan.', 'Laporan Arah GPCH setelah rapat manajemen; catatan pengawasan.', 'Bapak Wilfred', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'CEO — pemberi pinjaman jangka panjang', 'internal', 'Kreditur', 5, 4, 'Kepastian pengembalian utang Rp30,91 M; efisiensi (minta analisis penyebab inefisiensi).', 'Usulan restrukturisasi (perpanjang tenor, subordinasi, konversi modal).', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'Karyawan (PKWT, daily worker, trainee)', 'internal', 'SDM', 3, 5, 'Gaji & service charge tepat waktu, pelatihan, kejelasan aturan.', 'Komunikasi dua arah, forum bulanan, evaluasi kinerja.', 'HR Manager', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'Tamu korporat & instansi pemerintah', 'eksternal', 'Pelanggan', 4, 5, 'Ruang rapat layak, harga sesuai, layanan cepat, administrasi rapi.', 'Sales call, account management, paket meeting.', 'Sales & Marketing', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'OTA (Traveloka, Agoda, Tiket.com, Booking.com, Trip.com)', 'eksternal', 'Mitra distribusi', 4, 4, 'Paritas harga, ketersediaan, respons ulasan.', 'Business review berkala, campaign bersama.', 'FO / E-commerce', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 1, 'Travel agent & event organizer', 'eksternal', 'Mitra penjualan', 3, 4, 'Komisi, harga grup, kemudahan booking.', 'Kontrak & table top Jateng–Jatim.', 'Sales & Marketing', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(8, 1, 1, 'VHP (vendor PMS cloud)', 'eksternal', 'Vendor', 3, 3, 'Data master lengkap dari hotel, tiket permintaan jelas (#181ADD).', 'Daftar permintaan & timeline PIC.', 'EDP', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(9, 1, 1, 'Pemasok F&B & material', 'eksternal', 'Pemasok', 4, 3, 'Pembayaran tepat waktu (utang usaha Rp580,9 jt per Jun 2026).', 'Jadwal pembayaran berdasarkan prioritas & jatuh tempo.', 'Purchasing', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(10, 1, 1, 'Pemkot Bandung (Bapenda, Disbudpar, Dispora)', 'eksternal', 'Regulator & pelanggan', 4, 4, 'Kepatuhan pajak (PBB, PBJT), dukungan event kota.', 'Jadwal cicilan PBB; kemitraan event.', 'Chief Accountant / Sales', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(11, 1, 1, 'Masyarakat Kec. Bojongloa Kaler', 'eksternal', 'Komunitas', 3, 2, 'Kontribusi sosial (HUT Kota Bandung, Jumat berkah), lingkungan bersih.', 'CSR, flyering kerja sama kecamatan.', 'HR Manager', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(12, 1, 1, 'Media (Tribun Jabar, radio)', 'eksternal', 'Media', 3, 2, 'Konten menarik, barter exposure.', 'Rilis venue exhibition, video company profile.', 'Sales & Marketing', '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(13, 1, 1, 'Bank (BJB, BRI)', 'eksternal', 'Keuangan', 3, 3, 'Penutupan rekening lama tertib (cek hilang).', 'Surat kuasa & laporan kehilangan cek.', 'Chief Accountant', '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- strategic_choices (10 baris)
INSERT INTO `strategic_choices` (`id`, `company_id`, `analysis_period_id`, `code`, `strategic_theme_id`, `title`, `choice_type`, `description`, `rationale`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'PIL/GPCH/2026/001', 1, 'Fokus segmen korporasi, MICE swasta, sosial & grup; kurangi ketergantungan pada MICE pemerintah', 'pasar', NULL, 'MICE pemerintah turun akibat efisiensi anggaran; banquet shortfall terbesar.', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'PIL/GPCH/2026/002', 1, 'Tactical promotion pada tanggal low-demand, bukan diskon menyeluruh', 'harga', NULL, 'ADR Sep MTD Rp334.547 jauh di bawah budget Rp398.860 dan ARI 0,96.', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'PIL/GPCH/2026/003', 1, 'Perluas jaringan travel agent & event organizer Jawa Tengah – Jawa Timur', 'saluran', NULL, 'Konsep Kerja 2025: kota potensial Semarang, Surabaya, Solo, Yogyakarta.', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'PIL/GPCH/2026/004', 2, 'Diferensiasi "Pasundan Experience": storytelling, kuliner & ornamen Sunda', 'produk', NULL, 'Identitas Pasundan belum terasa di lobby, coffee shop, kamar (assessment 2024).', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'PIL/GPCH/2026/005', 2, 'Reposisi Executive Floor (lt. 10–11) & Executive Lounge sebagai kelas VIP', 'produk', NULL, 'Variasi tingkatan kamar sebagai keunggulan kompetitif; lounge sumber pendapatan tambahan.', 'diusulkan', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'PIL/GPCH/2026/006', 2, 'Revitalisasi bertahap: dapur & ruang rapat lebih dulu', 'operasi', NULL, 'Risiko food safety & kehilangan event (Jayagiri, karpet, screen).', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'PIL/GPCH/2026/007', 3, 'Tiga laporan keuangan wajib tiap bulan & VHP sebagai alat operasional', 'operasi', NULL, '"Sistem adalah alat operasional bukan laporan" (MoM 23 Sep 2026).', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'PIL/GPCH/2026/008', 3, 'Konversi LPG ke CNG & pemanfaatan limbah STP', 'operasi', NULL, 'Harga LPG naik; CEO menyetujui lisan, menunggu tanda tangan.', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'PIL/GPCH/2026/009', 4, 'Opsi alih daya supporting department (housekeeping, engineering, security, parkir)', 'organisasi', NULL, 'Konsep Kerja 2025; perlu kajian biaya-manfaat sebelum diputuskan.', 'diusulkan', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'PIL/GPCH/2026/010', 4, 'Pola kerja multitasking & shift berbasis okupansi', 'organisasi', NULL, 'Rasio karyawan 0,44/kamar di bawah budget 0,55; kualitas dijaga lewat pelatihan silang.', 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- strategic_dependencies (7 baris)
INSERT INTO `strategic_dependencies` (`id`, `company_id`, `analysis_period_id`, `title`, `dependency_type`, `strategic_initiative_id`, `strategic_objective_id`, `depends_on`, `description`, `owner_id`, `risk_level`, `mitigation`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Dana revitalisasi fasilitas', 'internal', 8, 9, 'Arus kas operasional & persetujuan pemilik', 'Revitalisasi dapur, ruang rapat dan lounge bergantung pada surplus kas yang saat ini sangat tipis.', 6, 'tinggi', 'Prioritaskan berdasarkan dampak pendapatan; skema co-branding AV (smartboard) & vendor pembiayaan.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 'Dukungan vendor VHP', 'eksternal', 1, 7, 'VHP (vendor PMS cloud)', 'Menu dashboard, notifikasi approval PR & artikel casual menunggu tindak lanjut vendor (Ticket #181ADD).', 2, 'sedang', 'Daftar permintaan bertimeline; eskalasi bulanan ke account manager VHP.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 'Tanda tangan CEO untuk konversi CNG', 'internal', 9, 3, 'CEO', 'Mutasi LPG ke CNG sudah disetujui lisan tetapi menunggu tanda tangan.', 10, 'sedang', 'GM menjadwalkan penandatanganan pada rapat Oktober.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 'Vendor panel lift (Elpa Global Techno)', 'eksternal', 8, 9, 'PT Elpa Global Techno', 'Penyelesaian panel lift 1 dan uji laik operasi.', 10, 'sedang', 'Pantau timeline harian; siapkan lift 2 sebagai cadangan.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 'Kalender event pemerintah daerah', 'eksternal', 5, 6, 'Dispora, Disbudpar, KONI Jabar', 'Event Piala Gubernur & PORPROV bergantung jadwal & anggaran instansi.', 7, 'sedang', 'Diversifikasi pipeline ke korporasi & sosial.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 'Keputusan pemilik atas restrukturisasi utang CEO', 'internal', 2, 2, 'Pemilik & CEO', 'Tenor, bunga, subordinasi atau konversi utang Rp30,91 M.', 6, 'tinggi', 'Siapkan 3 opsi beserta dampak arus kas.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 'Rekrutmen Chief Engineer & Executive Housekeeper', 'internal', 10, 13, 'HRD & GM', 'Posisi CE & EHK masih Plt.; pemeliharaan preventif & standar kebersihan bergantung pada kepemimpinan departemen.', 12, 'sedang', 'Finalisasi kandidat CE; tanda tangani LOI EHK.', 'aktif', '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- strategic_initiatives (11 baris)
INSERT INTO `strategic_initiatives` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `description`, `strategic_theme_id`, `owner_id`, `start_date`, `end_date`, `status`, `impact`, `urgency`, `risk`, `budget_level`, `budget_planned`, `progress`, `expected_outcome`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'INI/GPCH/2026/001', 'Integrasi & Optimalisasi VHP Cloud', 'Lengkapi data master back office (saldo awal, aging AR/AP, supplier, artikel, store, cost center) dan aktifkan dashboard, approval PR, artikel casual agar VHP menjadi alat operasional dan sumber laporan keuangan.', 3, 2, '2026-04-01 00:00:00', '2026-12-31 00:00:00', 'berjalan', 4, 4, 2, 2, 108000000, 37.1, 'Laporan BS & PnL dihasilkan dari VHP; semua HOD aktif memakai VHP.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(2, 1, 1, 'INI/GPCH/2026/002', 'Penyehatan Arus Kas & Restrukturisasi Kewajiban', 'Proyeksi kas mingguan, penagihan piutang lama, rekening deposit OTA terpisah, jadwal pemasok & cicilan PBB 2025, usulan restrukturisasi utang CEO.', 3, 6, '2026-07-01 00:00:00', '2027-03-31 00:00:00', 'berjalan', 5, 5, 4, 3, 25000000, 40.1, 'Surplus kas ≥ 5%, rasio aset lancar ≥ 80%, PBB 2025 lunas.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(3, 1, 1, 'INI/GPCH/2026/003', 'Re-branding "Pasundan Experience"', 'Storytelling Sunda di website (Alaric), konten IG/TikTok/YouTube, influencer staycation, ornamen Sunda lobby & coffee shop, kristalisasi marmer lobby.', 2, 7, '2026-03-01 00:00:00', '2026-12-31 00:00:00', 'berjalan', 4, 3, 3, 4, 155000000, 52.6, 'Rating Google 4,5; kontribusi direct booking 15%.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(4, 1, 1, 'INI/GPCH/2026/004', 'Kemitraan Travel Agent & Event Organizer Jateng–Jatim', 'Table top & travel mart, kontrak TA/EO di Semarang, Solo, Yogyakarta, Surabaya; komisi khusus & paket all-in.', 1, 7, '2026-05-01 00:00:00', '2027-06-30 00:00:00', 'berjalan', 4, 3, 2, 2, 17000000, 28, 'Minimal 10 kontrak TA/EO aktif dan 5 event grup per kuartal dari luar Bandung.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(5, 1, 1, 'INI/GPCH/2026/005', 'Revenue Recovery Q4 — Room & Banquet', 'Action plan rapat 23 Sep 2026: review pickup harian, tactical promotion low-demand dates, daily pipeline report, paket meeting/wedding/gathering, event olahraga & exhibition, konsep tahun baru.', 1, 7, '2026-09-21 00:00:00', '2026-12-31 00:00:00', 'berjalan', 5, 5, 2, 1, 48000000, 47.1, 'Pendapatan Q4 ≥ 85% anggaran; banquet ≥ Rp900 jt/bulan.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 1, 'INI/GPCH/2026/006', 'Revitalisasi Executive Floor & Executive Lounge', 'Kembalikan fungsi executive floor (lt. 10–11) dengan ornamen Pasundan, amenities lebih mewah; lounge untuk VIP: breakfast, afternoon tea & supper.', 2, 8, '2026-11-01 00:00:00', '2027-06-30 00:00:00', 'direncanakan', 3, 2, 3, 4, 215000000, 0, 'ARR executive naik ≥ 20%; pendapatan lounge baru.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 1, 'INI/GPCH/2026/007', 'Pengendalian Food Cost & Pembelian F&B', 'Standard recipe ala carte & event di VHP, hunting harga pasar untuk DML, stop deferred cost, stock opname bulanan, revisi harga menu, proposal depo air minum & utensil.', 3, 9, '2026-06-15 00:00:00', '2026-12-31 00:00:00', 'berjalan', 4, 5, 2, 1, 50500000, 61.2, 'Food cost ≤ 35%, pembelian F&B ≤ 40% pendapatan F&B.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 1, 'INI/GPCH/2026/008', 'Revitalisasi Fasilitas Prioritas', 'Epoxy dapur & pastry, karpet/screen/AV ruang rapat & kajian plafon Jayagiri, panel lift 1, repaint 20 kamar, pompa & sand filter kolam.', 2, 10, '2026-08-01 00:00:00', '2027-03-31 00:00:00', 'berjalan', 4, 4, 4, 5, 409500000, 45, 'Tidak ada lagi event pindah karena kondisi ruang; dapur memenuhi standar higiene.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(9, 1, 1, 'INI/GPCH/2026/009', 'Efisiensi Energi: Konversi LPG→CNG & Pemanfaatan Limbah STP', 'Konversi LPG ke CNG (menunggu tanda tangan CEO), pemanfaatan limbah STP (vendor Jayawiratama), lampu PLC→LED downlight, monitoring energi mingguan.', 3, 10, '2026-09-01 00:00:00', '2027-02-28 00:00:00', 'berjalan', 3, 3, 3, 3, 37000000, 29.2, 'Biaya energi turun ≥ 10% dibanding Sep 2026.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(10, 1, 1, 'INI/GPCH/2026/010', 'Pelatihan Terstruktur & Pemulihan Kesejahteraan Karyawan', 'Gaji & service charge tepat waktu, kalender refresh training per departemen, evaluasi kinerja bulanan, program PKL, rekrutmen CE & EHK.', 4, 12, '2026-04-01 00:00:00', '2026-12-31 00:00:00', 'berjalan', 4, 4, 2, 2, 15000000, 52.6, '100% pembayaran tepat waktu; 2 jam pelatihan/karyawan/bulan.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(11, 1, 1, 'INI/GPCH/2026/011', 'Layanan Laundry & Pressing Tamu + General Cleaning', 'Layanan setrika/pressing murah sebagai nilai tambah convention hotel; general cleaning 20 kamar/minggu & kristalisasi area publik.', 2, 11, '2026-07-01 00:00:00', '2026-12-31 00:00:00', 'berjalan', 2, 2, 2, 2, 24000000, 31.5, 'Pendapatan laundry naik; skor inspeksi kamar ≥ 90%.', NULL, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- strategic_issue_stakeholder (27 baris)
INSERT INTO `strategic_issue_stakeholder` (`strategic_issue_id`, `stakeholder_id`) VALUES
(1, 1),
(1, 2),
(1, 5),
(2, 5),
(2, 7),
(2, 10),
(3, 1),
(3, 2),
(3, 9),
(3, 6),
(4, 3),
(4, 1),
(4, 10),
(5, 2),
(5, 9),
(6, 5),
(6, 1),
(7, 6),
(7, 5),
(8, 6),
(8, 12),
(9, 8),
(9, 2),
(10, 4),
(11, 9),
(12, 2),
(12, 4);

-- strategic_issues (12 baris)
INSERT INTO `strategic_issues` (`id`, `company_id`, `analysis_period_id`, `code`, `title`, `description`, `perspective`, `urgency`, `impact`, `status`, `source`, `owner_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'ISU/GPCH/2026/001', 'Pendapatan jauh di bawah anggaran', 'Total revenue MTD 21–27 Sep 2026 Rp1,41 M = 51,6% budget (shortfall Rp988,9 jt); turun 17,6% dibanding bulan lalu.', 'keuangan', 5, 5, 'ditangani', 'GM Weekly Report Sep 2026', 4, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(2, 1, 1, 'ISU/GPCH/2026/002', 'Banquet/MICE tertinggal & ketergantungan pada instansi pemerintah', 'Banquet MTD Rp430,7 jt vs budget Rp1,18 M (shortfall Rp681,95 jt); MICE pemerintah turun karena efisiensi anggaran.', 'pelanggan', 5, 5, 'ditangani', 'MoM 23 Sep 2026', 7, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(3, 1, 1, 'ISU/GPCH/2026/003', 'Likuiditas lemah & deposit OTA terpakai operasional', 'Aset lancar hanya 45% kewajiban operasional; deposit TA/OTA Rp582 jt > saldo bank Rp332 jt; surplus kas hanya 0,91%.', 'keuangan', 5, 5, 'ditangani', 'Analisis Keuangan Juni 2026', 6, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(4, 1, 1, 'ISU/GPCH/2026/004', 'Utang CEO Rp30,91 M & utang PBB 2025 belum terjadwal', 'Utang jangka panjang CEO belum jelas bunga, tenor & jadwal; PBB 2025 Rp339,3 jt tertunggak.', 'keuangan', 4, 5, 'ditangani', 'Analisis Keuangan Juni 2026', 6, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(5, 1, 1, 'ISU/GPCH/2026/005', 'Food cost & pembelian F&B tinggi', 'Pembelian F&B 52% dari pendapatan F&B (Jun 2026); praktik penangguhan beban (deferred cost) stok gudang Rp667,5 jt dihentikan Timwas.', 'proses', 4, 4, 'ditangani', 'Notulen 3 Jun 2026; Analisis Keuangan Jun 2026', 9, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(6, 1, 1, 'ISU/GPCH/2026/006', 'Kondisi fasilitas menurun', 'Dapur & pastry tidak layak, karpet/screen ruang rapat lusuh, plafon Jayagiri rendah (event pindah ke Santika), kebocoran sand filter kolam, panel lift.', 'proses', 4, 5, 'ditangani', 'Assessment Des 2024; GM Weekly Report Sep 2026', 10, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(7, 1, 1, 'ISU/GPCH/2026/007', 'ARR di bawah kompetitor', 'ARR GPCH Rp330.913 (ARI 0,96) vs Harris Rp392.520 & Horison Rp377.955; diskon berlebihan menekan ADR (Sep MTD Rp334.547 vs budget Rp398.860).', 'pelanggan', 4, 4, 'ditangani', 'GM Weekly Report Sep 2026', 7, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'ISU/GPCH/2026/008', 'Reputasi digital & pengalaman tamu', 'Akun Google Business palsu & komentar spam; keluhan air mineral, bangunan jadul, sarapan berbayar; Wi-Fi lambat.', 'pelanggan', 4, 4, 'ditangani', 'GM Weekly Report Sep 2026', 8, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'ISU/GPCH/2026/009', 'Pelaporan keuangan & pemanfaatan VHP belum optimal', 'Neraca belum tersedia (assessment 2024), modul back office VHP menunggu data hotel, menu dashboard & approval PR belum aktif. "Sistem adalah alat operasional, bukan laporan."', 'proses', 4, 4, 'ditangani', 'MoM 23 Sep 2026; Checklist VHP 2025', 6, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'ISU/GPCH/2026/010', 'Motivasi SDM, kesejahteraan & kompetensi', 'Riwayat keterlambatan gaji & service charge, pelatihan belum terstruktur, teknisi kurang, CE & EHK masih kosong/Plt.', 'sdm', 4, 4, 'ditangani', 'Assessment Des 2024; GM Weekly Report Sep 2026', 12, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 'ISU/GPCH/2026/011', 'Kenaikan biaya energi', 'Kenaikan harga LPG & solar; konsumsi listrik ±88.758 kWh/bulan.', 'keuangan', 3, 4, 'ditangani', 'Engineering Energy Report Sep 2026', 10, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 'ISU/GPCH/2026/012', 'Pergantian GM & kesinambungan kepemimpinan', 'GM baru (Ibu Vivera) bergabung 1 Okt 2026; risiko putusnya tindak lanjut keputusan rapat ("jangan duduk bersepakat tapi action tidak bersepakat").', 'sdm', 3, 4, 'ditangani', 'GM Weekly Report Sep 2026 (rencana HR); MoM 23 Sep 2026', 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- strategic_objectives (13 baris)
INSERT INTO `strategic_objectives` (`id`, `company_id`, `analysis_period_id`, `code`, `perspective`, `strategic_theme_id`, `title`, `description`, `owner_id`, `weight`, `sort`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'OBJ/GPCH/2026/001', 'keuangan', 1, 'Meningkatkan total pendapatan hotel', 'Mencapai anggaran pendapatan kamar, F&B/banquet, dan lain-lain 2026.', 4, 40, 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'OBJ/GPCH/2026/002', 'keuangan', 3, 'Memulihkan likuiditas & kesehatan arus kas', 'Surplus kas positif, kewajiban terjadwal, piutang lama tertagih.', 6, 35, 2, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'OBJ/GPCH/2026/003', 'keuangan', 3, 'Mengendalikan biaya operasional', 'Food cost, pembelian F&B, dan energi sesuai standar.', 4, 25, 3, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'OBJ/GPCH/2026/004', 'pelanggan', 1, 'Meningkatkan okupansi, harga rata-rata & pangsa pasar', 'Okupansi, ARR, RevPAR, dan RGI ≥ kompetitor.', 7, 40, 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'OBJ/GPCH/2026/005', 'pelanggan', 2, 'Memperkuat reputasi & pengalaman tamu', 'Rating ulasan naik, keluhan turun, setiap ulasan direspons.', 8, 30, 5, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'OBJ/GPCH/2026/006', 'pelanggan', 1, 'Menumbuhkan bisnis MICE, wedding & acara sosial', 'Jumlah event naik, lost business turun.', 7, 30, 6, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'OBJ/GPCH/2026/007', 'proses', 3, 'Disiplin pelaporan keuangan & pemanfaatan VHP', 'Laporan laba rugi, arus kas, neraca tepat waktu dari sistem.', 6, 30, 7, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'OBJ/GPCH/2026/008', 'proses', 1, 'Mengoptimalkan saluran penjualan langsung & digital', 'Kontribusi direct booking (website, WA, walk-in) naik.', 8, 20, 8, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'OBJ/GPCH/2026/009', 'proses', 2, 'Menjaga kondisi fasilitas & pemeliharaan preventif', 'Jadwal preventif terlaksana; fasilitas prioritas direvitalisasi.', 10, 25, 9, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'OBJ/GPCH/2026/010', 'proses', 2, 'Standar kebersihan & kesiapan kamar', 'General cleaning terjadwal, skor inspeksi kamar tinggi.', 11, 25, 10, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 'OBJ/GPCH/2026/011', 'sdm', 4, 'Memulihkan kesejahteraan & kepercayaan karyawan', 'Gaji & service charge dibayar tepat waktu.', 12, 40, 11, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 'OBJ/GPCH/2026/012', 'sdm', 4, 'Meningkatkan kompetensi melalui pelatihan terstruktur', 'Program pelatihan terjadwal per departemen.', 12, 35, 12, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 'OBJ/GPCH/2026/013', 'sdm', 4, 'Struktur organisasi ramping & multitasking', 'Rasio karyawan per kamar efisien tanpa menurunkan layanan.', 4, 25, 13, '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- strategic_themes (8 baris)
INSERT INTO `strategic_themes` (`id`, `company_id`, `analysis_period_id`, `code`, `name`, `description`, `color`, `sort`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TEMA/GPCH/2026/001', 'Pemulihan Pendapatan', 'Revenue recovery kamar & banquet: tactical pricing, diversifikasi segmen, kemitraan TA/EO.', '#A8432A', 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'TEMA/GPCH/2026/002', 'Hotel Serbaguna Berbasis Pengalaman Pasundan', 'Storytelling Sunda, revitalisasi fasilitas prioritas, reputasi digital.', '#B8862B', 2, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'TEMA/GPCH/2026/003', 'Disiplin Keuangan & Sistem', 'Tiga laporan wajib, arus kas mingguan, food cost, VHP sebagai alat operasional.', '#34506E', 3, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'TEMA/GPCH/2026/004', 'SDM Multitasking yang Kompeten & Sejahtera', 'Gaji & service tepat waktu, pelatihan terstruktur, struktur ramping.', '#4F6B3A', 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 2, 'TEMA/GPCH/2027/001', 'Pemulihan Pendapatan', 'Revenue recovery kamar & banquet: tactical pricing, diversifikasi segmen, kemitraan TA/EO.', '#A8432A', 1, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(6, 1, 2, 'TEMA/GPCH/2027/002', 'Hotel Serbaguna Berbasis Pengalaman Pasundan', 'Storytelling Sunda, revitalisasi fasilitas prioritas, reputasi digital.', '#B8862B', 2, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(7, 1, 2, 'TEMA/GPCH/2027/003', 'Disiplin Keuangan & Sistem', 'Tiga laporan wajib, arus kas mingguan, food cost, VHP sebagai alat operasional.', '#34506E', 3, '2026-10-18 00:25:14', '2026-10-18 00:25:14'),
(8, 1, 2, 'TEMA/GPCH/2027/004', 'SDM Multitasking yang Kompeten & Sejahtera', 'Gaji & service tepat waktu, pelatihan terstruktur, struktur ramping.', '#4F6B3A', 4, '2026-10-18 00:25:14', '2026-10-18 00:25:14');

-- swot_items (18 baris)
INSERT INTO `swot_items` (`id`, `company_id`, `analysis_period_id`, `type`, `title`, `description`, `weight`, `rating`, `source`, `sort`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'S', 'Malibu Dome 1.152 m² berkapasitas 1.200 pax + 13 ruang rapat', 'Kapasitas convention terbesar di koridor Bandung barat; event PSI 1.200 pax (Sep 2026).', 0.15, 4, 'Analisis manajemen Sep 2026', 1, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'S', 'Ukuran kamar luas & 7 suite termasuk President & 3-Bedroom Pasundan Suite', 'Keunggulan yang tak terbantahkan (assessment 2024).', 0.1, 4, 'Analisis manajemen Sep 2026', 2, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'S', 'Lahan luas, parkir ±200 kendaraan, kolam renang besar', 'Cocok untuk keluarga, rombongan bus, dan event besar.', 0.1, 3, 'Analisis manajemen Sep 2026', 3, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'S', 'Rating Booking.com 9,3 dan pelayanan resepsionis ramah', 'Ulasan Sep 2026 memuji kebersihan & keramahan.', 0.05, 3, 'Analisis manajemen Sep 2026', 4, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'S', 'Breakfast & healthy club di atas budget', 'Breakfast Rp180 jt (165% budget), healthy club 426% budget MTD Sep 2026.', 0.05, 3, 'Analisis manajemen Sep 2026', 5, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'W', 'Fasilitas & interior menua', 'Dapur, ruang rapat, toilet lobby, kolam tanpa style, kesan "jadul".', 0.12, 2, 'Analisis manajemen Sep 2026', 6, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'W', 'Likuiditas tipis & beban utang besar', 'Surplus kas 0,91%, deposit OTA terpakai, utang CEO Rp30,91 M.', 0.12, 1, 'Analisis manajemen Sep 2026', 7, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'W', 'Food cost tinggi & disiplin persediaan lemah', 'Pembelian F&B 52% pendapatan F&B; praktik penangguhan beban.', 0.08, 2, 'Analisis manajemen Sep 2026', 8, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'W', 'Outlet F&B (coffee shop, room service, lounge) jauh di bawah target', 'Coffee shop 28% budget, room service 20%, lounge 24% (MTD Sep 2026).', 0.08, 2, 'Analisis manajemen Sep 2026', 9, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'W', 'Pelaporan & sistem belum optimal; SDM belum terlatih', 'Neraca belum rutin, modul VHP belum lengkap, pelatihan ad hoc.', 0.1, 2, 'Analisis manajemen Sep 2026', 10, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(11, 1, 1, 'O', 'Event olahraga & kebudayaan daerah', 'PORPROV & Piala Gubernur; Disbudpar/Dispora rutin.', 0.1, 3, 'Analisis manajemen Sep 2026', 11, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(12, 1, 1, 'O', 'Tren staycation budaya & keluarga', 'Pasundan Experience, kuliner Sunda (Nasi Timbel Empal, nampan liwet).', 0.1, 3, 'Analisis manajemen Sep 2026', 12, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(13, 1, 1, 'O', 'Pasar wedding & exhibition (mobil listrik, expo)', 'Malibu Dome ideal untuk pameran; wedding expo 2027.', 0.1, 3, 'Analisis manajemen Sep 2026', 13, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(14, 1, 1, 'O', 'Kemitraan TA/EO Jawa Tengah & Jawa Timur', 'Table top Jogja, ASITA travel mart.', 0.05, 2, 'Analisis manajemen Sep 2026', 14, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(15, 1, 1, 'T', 'Efisiensi anggaran pemerintah', 'MICE pemerintah dibatalkan/dialihkan online.', 0.15, 2, 'Analisis manajemen Sep 2026', 15, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(16, 1, 1, 'T', 'Kompetitor lebih baru & agresif', 'Santika Pasir Koja RGI 1,35; Harris ARR Rp392 rb.', 0.15, 2, 'Analisis manajemen Sep 2026', 16, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(17, 1, 1, 'T', 'Kenaikan biaya energi & bahan baku', 'LPG, solar, listrik naik.', 0.1, 2, 'Analisis manajemen Sep 2026', 17, '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(18, 1, 1, 'T', 'Serangan reputasi digital', 'Akun Google palsu, ulasan spam.', 0.05, 3, 'Analisis manajemen Sep 2026', 18, '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- tows_strategies (10 baris)
INSERT INTO `tows_strategies` (`id`, `company_id`, `analysis_period_id`, `code`, `type`, `title`, `description`, `priority`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TOWS/GPCH/2026/001', 'SO', 'Jual Malibu Dome untuk event olahraga, exhibition & wedding besar', 'Gunakan kapasitas 1.200 pax untuk PORPROV, Piala Gubernur, pameran mobil listrik, wedding expo.', 5, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(2, 1, 1, 'TOWS/GPCH/2026/002', 'SO', 'Paket "Pasundan Experience" untuk keluarga & staycation budaya', 'Kamar luas + kolam + kuliner Sunda + kids corner + Pustaka Pasundan.', 4, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(3, 1, 1, 'TOWS/GPCH/2026/003', 'WO', 'Revitalisasi bertahap berbasis prioritas pendapatan', 'Ruang rapat (karpet, screen, plafon Jayagiri) & dapur lebih dulu agar tidak kehilangan event.', 4, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(4, 1, 1, 'TOWS/GPCH/2026/004', 'WO', 'Disiplin food cost lewat standard recipe & DML', 'Input standard recipe di VHP, hunting harga pasar, stop deferred cost.', 4, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(5, 1, 1, 'TOWS/GPCH/2026/005', 'ST', 'Tactical pricing & revenue management harian', 'Promo hanya pada tanggal low-demand, jaga ADR, review pickup harian.', 5, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(6, 1, 1, 'TOWS/GPCH/2026/006', 'ST', 'Diversifikasi dari MICE pemerintah ke korporasi, sosial & TA', 'Daily pipeline report, sales call, kontrak TA/EO.', 5, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(7, 1, 1, 'TOWS/GPCH/2026/007', 'WT', 'Program penyehatan arus kas & restrukturisasi kewajiban', 'Proyeksi kas mingguan, penagihan piutang, rekening deposit OTA terpisah, cicilan PBB, restrukturisasi utang CEO.', 5, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(8, 1, 1, 'TOWS/GPCH/2026/008', 'WT', 'Efisiensi energi & SDM multitasking', 'Konversi LPG→CNG, LED, rasio karyawan 0,44 dijaga dengan pelatihan silang.', 3, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(9, 1, 1, 'TOWS/GPCH/2026/009', 'WT', 'Pemulihan reputasi digital', 'Bersihkan akun palsu, respons semua ulasan < 24 jam, perbaiki keluhan berulang (air mineral, Wi-Fi).', 4, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13'),
(10, 1, 1, 'TOWS/GPCH/2026/010', 'WO', 'VHP sebagai alat operasional & Arah GPCH untuk siklus KPI', 'Semua HOD mengakses VHP; realisasi KPI tiap tanggal 5; persetujuan tanggal 8.', 4, 'dipilih', '2026-10-18 00:25:13', '2026-10-18 00:25:13');

-- tows_strategy_issue (18 baris)
INSERT INTO `tows_strategy_issue` (`tows_strategy_id`, `strategic_issue_id`) VALUES
(1, 2),
(1, 1),
(2, 1),
(2, 7),
(3, 6),
(3, 2),
(4, 5),
(4, 9),
(5, 7),
(5, 1),
(6, 2),
(7, 3),
(7, 4),
(8, 11),
(8, 10),
(9, 8),
(10, 9),
(10, 12);

-- user_contexts (24 baris)
INSERT INTO `user_contexts` (`id`, `user_id`, `company_id`, `analysis_period_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07'),
(2, 2, 1, NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07'),
(3, 3, 1, NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07'),
(4, 4, 1, NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07'),
(5, 5, 1, NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08'),
(6, 6, 1, NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08'),
(7, 7, 1, NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08'),
(8, 8, 1, NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08'),
(9, 9, 1, NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09'),
(10, 10, 1, NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09'),
(11, 11, 1, NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09'),
(12, 12, 1, NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09'),
(13, 13, 1, NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10'),
(14, 14, 1, NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10'),
(15, 15, 1, NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10'),
(16, 16, 1, NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10'),
(17, 17, 1, NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11'),
(18, 18, 1, NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11'),
(19, 19, 1, NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11'),
(20, 20, 1, NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11'),
(21, 21, 1, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(22, 22, 1, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(23, 23, 1, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12'),
(24, 24, 1, NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12');

-- users (24 baris)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `job_title`, `department`, `phone`, `is_active`, `must_change_password`, `password_changed_at`, `last_login_at`, `app_authentication_secret`, `app_authentication_recovery_codes`) VALUES
(1, 'Konsultan DHASTRAM', 'admin@arahgpch.local', '2026-10-18 00:25:07', '$2y$12$5rE8/rAFHnEa3RnnVU1fHeN09llcj4.8neL6PGlpxDVkFP4sgEaNm', NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07', 'Konsultan / vendor DHASTRAM', 'Konsultan', NULL, 1, 0, NULL, NULL, NULL, NULL),
(2, 'Admin EDP GPCH (isi nama)', 'edp@grandpasundanhotel.com', '2026-10-18 00:25:07', '$2y$12$tJDAH26fr0g2PhRq8jwCZ.naDqGzFpTDCrmqFmUbPjgA8aLfP7spi', NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07', 'EDP / IT Manager', 'EDP', NULL, 1, 1, NULL, NULL, NULL, NULL),
(3, 'Bapak Wilfred', 'wilfred@grandpasundanhotel.com', '2026-10-18 00:25:07', '$2y$12$Pr7KBTH2bNyptK6ffpebFecvquWcTH7mrq5sJxorpvWR1fcJDmnmK', NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07', 'Ketua Tim Pengawas', 'Tim Pengawas', NULL, 1, 1, NULL, NULL, NULL, NULL),
(4, 'Ibu Vivera', 'gm@grandpasundanhotel.com', '2026-10-18 00:25:07', '$2y$12$a.IocbGkMnn5QzUlzMUduu.ny6oIZEumE9Ipvzb8Oaa/a8rkia.H6', NULL, '2026-10-18 00:25:07', '2026-10-18 00:25:07', 'General Manager', 'Executive Office', NULL, 1, 1, NULL, NULL, NULL, NULL),
(5, 'Koordinator Manajemen Strategi (isi nama)', 'strategi@grandpasundanhotel.com', '2026-10-18 00:25:08', '$2y$12$Omqb9OnymhCMCw6bNGQH3Omd5K1fZW563SFezovZmIHTcbgrWIjD2', NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08', 'Koordinator Manajemen Strategi (staf GM)', 'Executive Office', NULL, 1, 1, NULL, NULL, NULL, NULL),
(6, 'Bapak Indra', 'ca@grandpasundanhotel.com', '2026-10-18 00:25:08', '$2y$12$4dDraDq/mp1c6.KrC5gtZe6ZbBJFJkhsh5BI8HCPBh71AUAEXlE8a', NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08', 'Chief Accountant', 'Accounting', NULL, 1, 1, NULL, NULL, NULL, NULL),
(7, 'Ibu Irina', 'sales@grandpasundanhotel.com', '2026-10-18 00:25:08', '$2y$12$FS05mDjOuchlMAdY8dgCcOqQmOJzs6g0c.EeVs/a5f2W8SQq8TGM6', NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08', 'Sales & Marketing Manager', 'Sales & Marketing', NULL, 1, 1, NULL, NULL, NULL, NULL),
(8, 'Bapak Rizki', 'fom@grandpasundanhotel.com', '2026-10-18 00:25:08', '$2y$12$JqHT7Plvkh49SZ6ammIDTurwvZbQKFDJGpCNZ8PhgC3tYCVoDZV5q', NULL, '2026-10-18 00:25:08', '2026-10-18 00:25:08', 'Front Office Manager', 'Front Office', NULL, 1, 1, NULL, NULL, NULL, NULL),
(9, 'Bapak Asep Agus Damil Arifin', 'fbm@grandpasundanhotel.com', '2026-10-18 00:25:09', '$2y$12$ygOJarWPMIMNtEMu2TmfM.e08hOS5dLr80B/mOFXexlE545N6Ra5q', NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09', 'F&B Manager / Executive Chef', 'Food & Beverage', NULL, 1, 1, NULL, NULL, NULL, NULL),
(10, 'Bapak Wahyudin', 'engineering@grandpasundanhotel.com', '2026-10-18 00:25:09', '$2y$12$qzGIraqoV.DHnXAFbbBIPubPRz3G8EgHo8ZhoZ7twQ95iLgDPFfTi', NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09', 'Chief Engineer (Plt.)', 'Engineering', NULL, 1, 1, NULL, NULL, NULL, NULL),
(11, 'Ibu Wina', 'hk@grandpasundanhotel.com', '2026-10-18 00:25:09', '$2y$12$5FTk7fYL5Z0tfXDsZG3Y0utAavssJ/wamUejE7wQ07N2ZJX9Td/Y2', NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09', 'Executive Housekeeper (Plt.)', 'Housekeeping', NULL, 1, 1, NULL, NULL, NULL, NULL),
(12, 'Bapak Anto', 'hrd@grandpasundanhotel.com', '2026-10-18 00:25:09', '$2y$12$k/pt7nDP2dQqAJP7WyqyoOPp3SVhnO5nPWsuI.Rxz3WfJAJZs1WaS', NULL, '2026-10-18 00:25:09', '2026-10-18 00:25:09', 'HR Manager', 'Human Resources', NULL, 1, 1, NULL, NULL, NULL, NULL),
(13, 'Bapak Daniel', 'purchasing@grandpasundanhotel.com', '2026-10-18 00:25:10', '$2y$12$zTVkLUCzHGHUoMw3KEaNLOgyqTZ3IaFaNH0JtEL4.8IEbQgAmmJy2', NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10', 'Purchasing', 'Accounting', NULL, 1, 1, NULL, NULL, NULL, NULL),
(14, 'Ibu Rika', 'rika.sales@grandpasundanhotel.com', '2026-10-18 00:25:10', '$2y$12$ZPmWfgW78gRXydMWt8elw.ap50bFO738IuKGeduoVwdQ8OocRMqCW', NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10', 'Sales Executive', 'Sales & Marketing', NULL, 1, 1, NULL, NULL, NULL, NULL),
(15, 'Arsy', 'arsy.sales@grandpasundanhotel.com', '2026-10-18 00:25:10', '$2y$12$I/vhJAfsFfsW/4Vly7xPHeXSy6vLXTDcc5OM5R.pM1ryCsmsvnyJy', NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10', 'Sales Executive', 'Sales & Marketing', NULL, 1, 1, NULL, NULL, NULL, NULL),
(16, 'Muhamad Ihsan', 'fo.supervisor@grandpasundanhotel.com', '2026-10-18 00:25:10', '$2y$12$JZTFSoi6HvVcHRdtPZN.2.2dS4/eE/KDmiLvLprH/Ll5sPJEg6LLy', NULL, '2026-10-18 00:25:10', '2026-10-18 00:25:10', 'Front Office Supervisor', 'Front Office', NULL, 1, 1, NULL, NULL, NULL, NULL),
(17, 'Ujang Nur M', 'hk.supervisor@grandpasundanhotel.com', '2026-10-18 00:25:11', '$2y$12$xcyjEDZGDrYA0gh.4oZWIOmSufrxym2JJvtFnlF/pzU055y8PcAce', NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11', 'Housekeeping Supervisor', 'Housekeeping', NULL, 1, 1, NULL, NULL, NULL, NULL),
(18, 'Rara', 'eng.admin@grandpasundanhotel.com', '2026-10-18 00:25:11', '$2y$12$WFdUqYgoDlrHQA043xLAbuSYYtSDCJscPv3erasjYmq/O7rOeH/Bq', NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11', 'Engineering Admin', 'Engineering', NULL, 1, 1, NULL, NULL, NULL, NULL),
(19, 'Bapak Wimpy', 'owner@grandpasundanhotel.com', '2026-10-18 00:25:11', '$2y$12$jcqgxznf1.WOSkD5PeTUXOihQBqkBD.w9GYgHbfN9wkUrizvZ.YAu', NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11', 'Pemilik', 'Pemilik', NULL, 1, 1, NULL, NULL, NULL, NULL),
(20, 'Bapak Yodi S. Ibrahim', 'yodi@grandpasundanhotel.com', '2026-10-18 00:25:11', '$2y$12$7sjHuYyiTyPJfbwWVJfdyOa0Jc7q1L/wIgUz6RAyPMX01OaaPBs.K', NULL, '2026-10-18 00:25:11', '2026-10-18 00:25:11', 'Direksi', 'Direksi', NULL, 1, 1, NULL, NULL, NULL, NULL),
(21, 'Bapak Miko', 'miko@grandpasundanhotel.com', '2026-10-18 00:25:12', '$2y$12$tEbTZZvGJNGEuBG3gGgnEOYitE7iLv5Bh95SU8jrJ2Rk9UN.Ci9Gq', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12', 'Anggota Tim Pengawas', 'Tim Pengawas', NULL, 1, 1, NULL, NULL, NULL, NULL),
(22, 'Bapak Joice', 'joice@grandpasundanhotel.com', '2026-10-18 00:25:12', '$2y$12$Y8iahlWCqQbOpMpb7b0jGODHRJNwcwC3wSDLTzy82ZLp7t5z5bpYO', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12', 'Anggota Tim Pengawas', 'Tim Pengawas', NULL, 1, 1, NULL, NULL, NULL, NULL),
(23, 'Ibu Yuli', 'yuli@grandpasundanhotel.com', '2026-10-18 00:25:12', '$2y$12$yETPslIfkd/9gGxZMrtCG.SpqP7MiUs6muXV5ZT5AR0ZRi4b71Zhm', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12', 'Anggota Tim Pengawas', 'Tim Pengawas', NULL, 1, 1, NULL, NULL, NULL, NULL),
(24, 'Bapak I.G. Wiwin Suyasa', 'wiwin@visiperencana.id', '2026-10-18 00:25:12', '$2y$12$ut4fk7rNPHcNbnj7DX9lV./7Gl8Fb.3jn7nWCCYInPXdLKPyu5yIO', NULL, '2026-10-18 00:25:12', '2026-10-18 00:25:12', 'Auditor Operasional (Visi Perencana Indonesia)', 'Eksternal', NULL, 1, 1, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
