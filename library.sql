/*
create database library;

CREATE TABLE IF NOT EXISTS `library`.`borrower` (
  `uID` CHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `bPassword` VARCHAR(64) NOT NULL,
  `register_data` DATETIME NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `limit` INT(4) NOT NULL,
  `credit_value` INT(2) NULL,
  PRIMARY KEY (`uID`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`librarian` (
  `lID` CHAR(10) NOT NULL ,
  `name` VARCHAR(45) NOT NULL,
  `lPassword` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`lID`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `library`.`author` (
  `aID` INT(10) NOT NULL auto_increment,
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`aID`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`book` (
  `ISBN` CHAR(13) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `quantity` INT(4) NOT NULL,
  PRIMARY KEY (`ISBN`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`tag` (
  `tagID` INT(20) NOT NULL auto_increment,
  `tag` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tagID`))
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`is_author` (
  `author_ID` INT(10) NOT NULL,
  `book_ISBN` CHAR(13) NOT NULL,
  PRIMARY KEY (`author_ID`, `book_ISBN`),
  INDEX `fk_is_author_book1_idx` (`book_ISBN` ASC),
  CONSTRAINT `fk_is_author_book1`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_is_author_author1`
    FOREIGN KEY (`author_ID`)
    REFERENCES `library`.`author` (`aID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`book_tag` (
  `book_ISBN` CHAR(13) NOT NULL,
  `tag_ID` INT(20) NOT NULL,
  PRIMARY KEY (`book_ISBN`, `tag_ID`),
  INDEX `fk_book_tag_tag1_idx` (`tag_ID` ASC),
  CONSTRAINT `fk_book_tag_tag1`
    FOREIGN KEY (`tag_ID`)
    REFERENCES `library`.`tag` (`tagID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_tag_book1`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `library`.`book_copy` (
  `book_ISBN` CHAR(13) NOT NULL,
  `bID` INT(20) NOT NULL auto_increment,
  `location` VARCHAR(45) NOT NULL,
  `is_borrowed` INT(1) NOT NULL,
  PRIMARY KEY (`bID`),
  CONSTRAINT `fk_book_copy_book1`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `library`.`book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
*/
CREATE TABLE IF NOT EXISTS `library`.`borrow` (
  `uID` CHAR(10) NOT NULL,
  `lID` CHAR(10) NOT NULL,
  `book_ISBN` CHAR(13) NOT NULL,
  `book_ID` INT(20) NOT NULL,
  `start_date` DATE NOT NULL,
  `last_time` DATE NULL,
  `fine` DECIMAL(6,2) NOT NULL,
  `renewed` INT(1) NOT NULL,
  PRIMARY KEY (`uID`, `lID`, `book_ISBN`, `book_ID`),
  INDEX `fk_borrow_book_copy1_idx` (`book_ISBN` ASC, `book_ID` ASC),
  INDEX `fk_borrow_librarian1_idx` (`lID` ASC),
  CONSTRAINT `fk_borrow_book_copy1`
    FOREIGN KEY (`book_ISBN` , `book_ID`)
    REFERENCES `library`.`book_copy` (`book_ISBN` , `bID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;