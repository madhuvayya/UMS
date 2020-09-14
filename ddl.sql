-- query to create ums data base
CREATE DATABASE `ums`;

-- query to create user_info table
CREATE TABLE `user_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `email` varchar(70) NOT NULL,
  `country` varchar(45) DEFAULT NULL,
  `phone_number` varchar(10) NOT NULL,
  `alternate_number` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `user_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `user_image` blob,
  `role` varchar(15) NOT NULL,
  `status` varchar(45) NOT NULL,
  `creator_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator_user` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);

-- query to create user_login_history table

CREATE TABLE `ums`.`user_login_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `login_stamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ums`.`user_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- query to create pages table

CREATE TABLE `pages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `page_name` varchar(45) NOT NULL,
  `page_url` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

-- query to add creator_stamp and creator coloumns in pages table

ALTER TABLE `ums`.`pages` 
ADD COLUMN `creator_stamp` DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER `page_url`,
ADD COLUMN `creator` VARCHAR(45) NULL AFTER `creator_stamp`;

-- query to create permissions table  

CREATE TABLE ums.permissions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  page_id INT UNSIGNED NOT NULL,
  `add` BOOLEAN NOT NULL,
  `delete` BOOLEAN NOT NULL,
  `modify` BOOLEAN NOT NULL,
  `read` BOOLEAN NOT NULL, 
  creator_stamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  creator_user VARCHAR(45),
  PRIMARY KEY (`id`),
	CONSTRAINT `permissions_fk_1` FOREIGN KEY (user_id) REFERENCES user_info(id),
	CONSTRAINT `permissions_fk_2` FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- query to create table country

CREATE TABLE `ums`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));