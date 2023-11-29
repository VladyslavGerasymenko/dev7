SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `myosbb` DEFAULT CHARACTER SET utf8 ;
USE `myosbb` ;

CREATE TABLE IF NOT EXISTS `myosbb`.`Будинки` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Адреса` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `myosbb`.`Квартири` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Квартира` INT NOT NULL,
  `Підїзд` TINYINT(1) NOT NULL,
  `Поверх` TINYINT(1) NOT NULL,
  `Площа` FLOAT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `myosbb`.`Будинки_до_Квартир` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Будинки_ИД` INT NOT NULL,
  `Квартири_ИД` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Будинки_idx` (`Будинки_ИД` ASC) VISIBLE,
  INDEX `Квартири_idx` (`Квартири_ИД` ASC) VISIBLE,
  CONSTRAINT `Будинки`
    FOREIGN KEY (`Будинки_ИД`)
    REFERENCES `myosbb`.`Будинки` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Квартири`
    FOREIGN KEY (`Квартири_ИД`)
    REFERENCES `myosbb`.`Квартири` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `myosbb`.`Учасники_ОСББ` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ФИО` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Телефон` VARCHAR(20) NOT NULL,
  `Дата_Народження` DATE NULL,
  PRIMARY KEY (`ID`),
  FULLTEXT INDEX `ФИО` (`ФИО`) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `myosbb`.`Ролі` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Учасник_ИД` INT NOT NULL,
  `Роль` ENUM('Учасник', 'Працівник', 'Член Правління', 'Голова') NOT NULL DEFAULT 'Учасник',
  INDEX `УчасникОСББ` (`УчасникОСББ_ИД` ASC) INVISIBLE,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Люди`
    FOREIGN KEY (`УчасникОСББ_ИД`)
    REFERENCES `myosbb`.`Учасники_ОСББ` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `myosbb`.`Мешканці` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Вїзд_на_ЖК` TINYINT NOT NULL DEFAULT 0,
  `Квартира_ИД` INT NULL,
  `Учасник_ИД` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_apartament_idx` (`Квартира_ИД` ASC) VISIBLE,
  INDEX `fk_participant_idx` (`Учасник_ИД` ASC) VISIBLE,
  CONSTRAINT `fk_apartament`
    FOREIGN KEY (`Квартира_ИД`)
    REFERENCES `myosbb`.`Квартири` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participant`
    FOREIGN KEY (`Учасник_ИД`)
    REFERENCES `myosbb`.`Учасники_ОСББ` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
