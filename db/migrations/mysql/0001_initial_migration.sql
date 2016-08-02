-- +migrate Up

CREATE TABLE IF NOT EXISTS `authd_user` (
  `id` longtext NOT NULL,
  `email` longtext,
  `email_verified` tinyint(4) DEFAULT NULL,
  `display_name` longtext,
  `admin` tinyint(4) DEFAULT NULL,
  `created_at` bigint(20) DEFAULT NULL,
  `disabled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`(255)),
  UNIQUE KEY `authd_user_email_key` (`email`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `client_identity` (
  `id` longtext NOT NULL,
  `secret` longblob,
  `metadata` longtext,
  `dex_admin` tinyint(4) DEFAULT NULL,
  `public` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `connector_config` (
  `id` longtext NOT NULL,
  `type` longtext,
  `config` longtext,
  PRIMARY KEY (`id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `dex_migrations` (
  `id` longtext NOT NULL,
  `applied_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `key` (
  `value` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `password_info` (
  `user_id` longtext NOT NULL,
  `password` longtext,
  `password_expires` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `refresh_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payload_hash` longblob,
  `user_id` longtext,
  `client_id` longtext,
  `scopes` longtext,
  `connector_id` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `remote_identity_mapping` (
  `connector_id` longtext NOT NULL,
  `user_id` longtext,
  `remote_id` longtext NOT NULL,
  PRIMARY KEY (`connector_id`(255),`remote_id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `session` (
  `id` longtext NOT NULL,
  `state` longtext,
  `created_at` bigint(20) DEFAULT NULL,
  `expires_at` bigint(20) DEFAULT NULL,
  `client_id` longtext,
  `client_state` longtext,
  `redirect_url` longtext,
  `identity` longtext,
  `connector_id` longtext,
  `user_id` longtext,
  `register` tinyint(4) DEFAULT NULL,
  `nonce` longtext,
  `scope` longtext,
  `groups` longtext,
  PRIMARY KEY (`id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `session_key` (
  `key` longtext NOT NULL,
  `session_id` longtext,
  `expires_at` bigint(20) DEFAULT NULL,
  `stale` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`key`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `trusted_peers` (
  `client_id` longtext NOT NULL,
  `trusted_client_id` longtext NOT NULL,
  PRIMARY KEY (`client_id`(255),`trusted_client_id`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
