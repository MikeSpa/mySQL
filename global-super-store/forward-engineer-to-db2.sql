-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema global-super-store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema global-super-store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `global-super-store` ;
USE `global-super-store` ;

-- -----------------------------------------------------
-- Table `global-super-store`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `global-super-store`.`Customers` ;

CREATE TABLE IF NOT EXISTS `global-super-store`.`Customers` (
  `CustomersID` VARCHAR(100) NOT NULL,
  `Name` VARCHAR(255) NULL,
  `Segment` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomersID`))
ENGINE = MRG_MyISAM;


-- -----------------------------------------------------
-- Table `global-super-store`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `global-super-store`.`Products` ;

CREATE TABLE IF NOT EXISTS `global-super-store`.`Products` (
  `ProductID` VARCHAR(100) NOT NULL,
  `Catagory` VARCHAR(255) NULL,
  `Subcategory` VARCHAR(255) NULL,
  `ProductName` VARCHAR(255) NULL,
  PRIMARY KEY (`ProductID`));


-- -----------------------------------------------------
-- Table `global-super-store`.`Adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `global-super-store`.`Adresses` ;

CREATE TABLE IF NOT EXISTS `global-super-store`.`Adresses` (
  `CustomersID` VARCHAR(100) NOT NULL,
  `City` VARCHAR(255) NULL,
  `State` VARCHAR(255) NULL,
  `Country` VARCHAR(255) NULL,
  `PostalCode` VARCHAR(255) NULL,
  `Market` VARCHAR(255) NULL,
  `Region` VARCHAR(255) NULL,
  INDEX `CustomerID_idx` (`CustomersID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomersID`)
    REFERENCES `global-super-store`.`Customers` (`CustomersID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `global-super-store`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `global-super-store`.`Orders` ;

CREATE TABLE IF NOT EXISTS `global-super-store`.`Orders` (
  `OrderID` VARCHAR(100) NOT NULL,
  `Customers_CustomersID` VARCHAR(100) NOT NULL,
  `Products_ProductID` VARCHAR(100) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `Sales` DECIMAL NULL,
  `Quantity` INT NULL,
  `Profit` DECIMAL NULL,
  `OrderPriority` VARCHAR(255) NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Products1_idx` (`Products_ProductID` ASC) VISIBLE,
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomersID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Products1`
    FOREIGN KEY (`Products_ProductID`)
    REFERENCES `global-super-store`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomersID`)
    REFERENCES `global-super-store`.`Customers` (`CustomersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `global-super-store`.`Shippings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `global-super-store`.`Shippings` ;

CREATE TABLE IF NOT EXISTS `global-super-store`.`Shippings` (
  `OrderID` VARCHAR(100) NOT NULL,
  `ShipDate` DATE NULL,
  `ShipMode` VARCHAR(255) NULL,
  `ShippingCost` DECIMAL NULL,
  INDEX `OrderId_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `OrderId`
    FOREIGN KEY (`OrderID`)
    REFERENCES `global-super-store`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
