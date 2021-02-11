-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblan3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblan3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblan3` DEFAULT CHARACTER SET utf8 ;
USE `biblan3` ;

-- -----------------------------------------------------
-- Table `biblan3`.`bibliotek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`bibliotek` (
  `bibliotekID` INT NOT NULL,
  `ort` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`bibliotekID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblan3`.`anstalld`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`anstalld` (
  `anstallningsNr` INT NOT NULL,
  `personNr` VARCHAR(12) NULL DEFAULT NULL,
  `fNamn` VARCHAR(45) NULL DEFAULT NULL,
  `eNamn` VARCHAR(45) NULL DEFAULT NULL,
  `telefonNr` VARCHAR(45) NULL DEFAULT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `postNr` VARCHAR(45) NULL DEFAULT NULL,
  `ort` VARCHAR(45) NULL DEFAULT NULL,
  `epost` VARCHAR(45) NULL DEFAULT NULL,
  `lon` VARCHAR(45) NULL DEFAULT NULL,
  `kon` VARCHAR(45) NULL DEFAULT NULL,
  `bibliotek_idbibliotek` INT NOT NULL,
  `chef` INT NULL DEFAULT NULL,
  PRIMARY KEY (`anstallningsNr`),
  UNIQUE INDEX `anstallningsNr_UNIQUE` (`anstallningsNr` ASC) VISIBLE,
  UNIQUE INDEX `personNr_UNIQUE` (`personNr` ASC) VISIBLE,
  INDEX `fk_Anstalld_bibliotek1_idx` (`bibliotek_idbibliotek` ASC) VISIBLE,
  INDEX `fk_Anstalld_Anstalld1_idx` (`chef` ASC) VISIBLE,
  CONSTRAINT `fk_Anstalld_Anstalld1`
    FOREIGN KEY (`chef`)
    REFERENCES `biblan3`.`anstalld` (`anstallningsNr`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Anstalld_bibliotek1`
    FOREIGN KEY (`bibliotek_idbibliotek`)
    REFERENCES `biblan3`.`bibliotek` (`bibliotekID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblan3`.`kundtyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`kundtyp` (
  `kundtypID` INT NOT NULL,
  `namn` VARCHAR(45) NULL DEFAULT NULL,
  `maxLan` INT NULL,
  PRIMARY KEY (`kundtypID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblan3`.`kund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`kund` (
  `kundID` INT NOT NULL,
  `personNr` VARCHAR(12) NULL DEFAULT NULL,
  `fNamn` VARCHAR(45) NULL DEFAULT NULL,
  `eNamn` VARCHAR(45) NULL DEFAULT NULL,
  `telefonNr` VARCHAR(45) NULL DEFAULT NULL,
  `epost` VARCHAR(45) NULL DEFAULT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `ort` VARCHAR(45) NULL DEFAULT NULL,
  `postNr` VARCHAR(45) NULL DEFAULT NULL,
  `kundtyp_kundtypID` INT NOT NULL,
  PRIMARY KEY (`kundID`),
  INDEX `fk_kund_kundtyp1_idx` (`kundtyp_kundtypID` ASC) VISIBLE,
  CONSTRAINT `fk_kund_kundtyp1`
    FOREIGN KEY (`kundtyp_kundtypID`)
    REFERENCES `biblan3`.`kundtyp` (`kundtypID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblan3`.`artikelTyp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`artikelTyp` (
  `artikelTypID` INT NOT NULL,
  `namn` VARCHAR(45) NULL,
  PRIMARY KEY (`artikelTypID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`artikel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`artikel` (
  `artikelID` INT NOT NULL,
  `ISBN` VARCHAR(20) NULL,
  `titel` VARCHAR(120) NOT NULL,
  `fysiskPlats` DOUBLE NULL,
  `artikelTyp_idartikelTyp` INT NOT NULL,
  `bibliotek_idbibliotek` INT NOT NULL,
  `ar` YEAR NULL,
  `antal` INT NULL,
  PRIMARY KEY (`artikelID`),
  INDEX `fk_artikel_artikelTyp1_idx` (`artikelTyp_idartikelTyp` ASC) VISIBLE,
  INDEX `fk_artikel_bibliotek1_idx` (`bibliotek_idbibliotek` ASC) VISIBLE,
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
  CONSTRAINT `fk_artikel_artikelTyp1`
    FOREIGN KEY (`artikelTyp_idartikelTyp`)
    REFERENCES `biblan3`.`artikelTyp` (`artikelTypID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artikel_bibliotek1`
    FOREIGN KEY (`bibliotek_idbibliotek`)
    REFERENCES `biblan3`.`bibliotek` (`bibliotekID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`lan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`lan` (
  `lanID` INT NOT NULL,
  `landatum` DATETIME NULL DEFAULT NULL,
  `returdatum` DATETIME NULL DEFAULT NULL,
  `kund_kundID` INT NOT NULL,
  `returnerad` TINYINT NULL,
  `artikel_ID` INT NOT NULL,
  PRIMARY KEY (`lanID`),
  INDEX `fk_lan_kund1_idx` (`kund_kundID` ASC) VISIBLE,
  INDEX `fk_lan_artikel1_idx` (`artikel_ID` ASC) VISIBLE,
  CONSTRAINT `fk_lan_kund1`
    FOREIGN KEY (`kund_kundID`)
    REFERENCES `biblan3`.`kund` (`kundID`)
    ON DELETE NO ACTION,
  CONSTRAINT `fk_lan_artikel1`
    FOREIGN KEY (`artikel_ID`)
    REFERENCES `biblan3`.`artikel` (`artikelID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblan3`.`forfattare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`forfattare` (
  `forfattareID` INT NOT NULL,
  `namn` VARCHAR(45) NULL,
  PRIMARY KEY (`forfattareID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`genre` (
  `genreID` INT NOT NULL,
  `namn` VARCHAR(45) NULL,
  PRIMARY KEY (`genreID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`artikel_forfattare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`artikel_forfattare` (
  `artikelID` INT NOT NULL,
  `forfattareID` INT NOT NULL,
  PRIMARY KEY (`artikelID`, `forfattareID`),
  INDEX `fk_artikel_has_forfattare_forfattare1_idx` (`forfattareID` ASC) VISIBLE,
  INDEX `fk_artikel_has_forfattare_artikel1_idx` (`artikelID` ASC) VISIBLE,
  CONSTRAINT `fk_artikel_has_forfattare_artikel1`
    FOREIGN KEY (`artikelID`)
    REFERENCES `biblan3`.`artikel` (`artikelID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artikel_has_forfattare_forfattare1`
    FOREIGN KEY (`forfattareID`)
    REFERENCES `biblan3`.`forfattare` (`forfattareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`artikel_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`artikel_genre` (
  `artikelID` INT NOT NULL,
  `genreID` INT NOT NULL,
  PRIMARY KEY (`artikelID`, `genreID`),
  INDEX `fk_artikel_has_genre_genre1_idx` (`genreID` ASC) VISIBLE,
  INDEX `fk_artikel_has_genre_artikel1_idx` (`artikelID` ASC) VISIBLE,
  CONSTRAINT `fk_artikel_has_genre_artikel1`
    FOREIGN KEY (`artikelID`)
    REFERENCES `biblan3`.`artikel` (`artikelID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_artikel_has_genre_genre1`
    FOREIGN KEY (`genreID`)
    REFERENCES `biblan3`.`genre` (`genreID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblan3`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblan3`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
