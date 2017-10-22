-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `material` VARCHAR(255) NOT NULL,
  `price` DECIMAL(6,2) GENERATED ALWAYS AS () VIRTUAL,
  `purchases` INT NULL,
  `views` INT NULL,
  `categories_id` INT NOT NULL,
  `SKU` VARCHAR(50) NULL,
  `weight` FLOAT NULL,
  `cartDesc` VARCHAR(250) NULL,
  `longDesc` TEXT NULL,
  `thumb` VARCHAR(100) NULL,
  `image` VARCHAR(100) NULL,
  `productscol` VARCHAR(45) NULL,
  `lastUpdate` DATETIME NULL,
  `stock` INT NULL,
  `live` TINYINT NULL,
  `inStock` TINYINT NULL,
  PRIMARY KEY (`id`, `categories_id`),
  INDEX `fk_products_categories_idx` (`categories_id` ASC),
  CONSTRAINT `fk_products_categories`
    FOREIGN KEY (`categories_id`)
    REFERENCES `mydb`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first-name` VARCHAR(45) NOT NULL,
  `last-name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(40) NOT NULL,
  `last-active` DATETIME NULL,
  `password` VARCHAR(45) NOT NULL,
  `city` VARCHAR(90) NULL,
  `state` VARCHAR(20) NULL,
  `zip` VARCHAR(12) NULL,
  `emailVerified` TINYINT NULL,
  `registrationDate` TIMESTAMP NULL,
  `verificationCode` VARCHAR(20) NULL,
  `IP` VARCHAR(50) NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(100) NULL,
  `address2` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdDate` DATE NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `fk_cart_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_cart_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cartItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cartItems` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productId` INT NOT NULL,
  `quantity` INT NOT NULL,
  `createdDate` DATE NOT NULL,
  `cart_id` INT NOT NULL,
  `cart_users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cart_id`, `cart_users_id`),
  INDEX `fk_cartItems_cart1_idx` (`cart_id` ASC, `cart_users_id` ASC),
  CONSTRAINT `fk_cartItems_cart1`
    FOREIGN KEY (`cart_id` , `cart_users_id`)
    REFERENCES `mydb`.`cart` (`id` , `users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `total` DECIMAL(6,2) NULL,
  `shipName` VARCHAR(100) NULL,
  `shipAddress` VARCHAR(100) NULL,
  `shipAddress2` VARCHAR(100) NULL,
  `shipCity` VARCHAR(50) NULL,
  `shipState` VARCHAR(45) NULL,
  `shipZip` VARCHAR(20) NULL,
  `shipCountry` VARCHAR(50) NULL,
  `phone` VARCHAR(20) NULL,
  `shippingCost` DECIMAL(16,2) NULL,
  `email` VARCHAR(100) NULL,
  `date` TIMESTAMP NULL,
  `shipped` TINYINT NULL DEFAULT 0,
  `trackingNum` VARCHAR(80) NULL,
  `orderscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `fk_orders_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ordersToProducts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ordersToProducts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `orders_id` INT NOT NULL,
  `orders_users_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  `products_categories_id` INT NOT NULL,
  `product_name` VARCHAR(250) NULL,
  `product_price` DECIMAL(16,2) NULL,
  `product_SKU` VARCHAR(50) NULL,
  `quantity` INT(11) NULL,
  PRIMARY KEY (`id`, `orders_id`, `orders_users_id`, `products_id`, `products_categories_id`),
  INDEX `fk_orderDetails_orders1_idx` (`orders_id` ASC, `orders_users_id` ASC),
  INDEX `fk_orderDetails_products1_idx` (`products_id` ASC, `products_categories_id` ASC),
  CONSTRAINT `fk_orderDetails_orders1`
    FOREIGN KEY (`orders_id` , `orders_users_id`)
    REFERENCES `mydb`.`orders` (`id` , `users_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderDetails_products1`
    FOREIGN KEY (`products_id` , `products_categories_id`)
    REFERENCES `mydb`.`products` (`id` , `categories_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`optionGroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`optionGroups` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`options` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `optionGroups_id` INT NOT NULL,
  PRIMARY KEY (`id`, `optionGroups_id`),
  INDEX `fk_options_optionGroups1_idx` (`optionGroups_id` ASC),
  CONSTRAINT `fk_options_optionGroups1`
    FOREIGN KEY (`optionGroups_id`)
    REFERENCES `mydb`.`optionGroups` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productsToOptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productsToOptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `products_id` INT NOT NULL,
  `products_categories_id` INT NOT NULL,
  `options_id` INT NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `products_categories_id`, `options_id`),
  INDEX `fk_options_products1_idx` (`products_id` ASC, `products_categories_id` ASC),
  INDEX `fk_productsToOptions_options1_idx` (`options_id` ASC),
  CONSTRAINT `fk_options_products1`
    FOREIGN KEY (`products_id` , `products_categories_id`)
    REFERENCES `mydb`.`products` (`id` , `categories_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productsToOptions_options1`
    FOREIGN KEY (`options_id`)
    REFERENCES `mydb`.`options` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
