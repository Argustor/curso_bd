-- MySQL Script generated by MySQL Workbench
-- Fri May 20 22:53:48 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema banco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `banco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `banco` ;

-- -----------------------------------------------------
-- Table `banco`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`estado` ;

CREATE TABLE IF NOT EXISTS `banco`.`estado` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `SIGLA` CHAR(2) NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ESTADO_NOME_U` (`NOME` ASC) ,
  UNIQUE INDEX `ESTADO_SIGLA_U` (`SIGLA` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`cidade` ;

CREATE TABLE IF NOT EXISTS `banco`.`cidade` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `ESTADO_ID` INT NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CIDADE_UNIQUE` (`NOME` ASC, `ESTADO_ID` ASC) ,
  INDEX `CIDADE_EST_FK` (`ESTADO_ID` ASC) ,
  CONSTRAINT `CIDADE_EST_FK`
    FOREIGN KEY (`ESTADO_ID`)
    REFERENCES `banco`.`estado` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`funcionario` ;

CREATE TABLE IF NOT EXISTS `banco`.`funcionario` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `CPF` CHAR(14) NOT NULL,
  `ENDERECO` VARCHAR(100) NOT NULL,
  `ENDERECO_NUMERO` VARCHAR(20) NOT NULL,
  `ENDERECO_BAIRRO` VARCHAR(100) NOT NULL,
  `CEP` VARCHAR(10) NOT NULL,
  `FONE` VARCHAR(15) NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_NASCIMENTO` DATE NULL DEFAULT NULL,
  `EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `CIDADE_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `FUNCIONARIO_CPF_U` (`CPF` ASC) ,
  INDEX `FUNCIONARIO_CID_FK` (`CIDADE_ID` ASC) ,
  CONSTRAINT `FUNCIONARIO_CID_FK`
    FOREIGN KEY (`CIDADE_ID`)
    REFERENCES `banco`.`cidade` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`marca` ;

CREATE TABLE IF NOT EXISTS `banco`.`marca` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DESCRICAO` VARCHAR(100) NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`unidade_medida`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`unidade_medida` ;

CREATE TABLE IF NOT EXISTS `banco`.`unidade_medida` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `SIGLA` VARCHAR(10) NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `SIGLA` (`SIGLA` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`produto` ;

CREATE TABLE IF NOT EXISTS `banco`.`produto` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DESCRICAO` VARCHAR(2000) NULL DEFAULT NULL,
  `CONTEUDO` DECIMAL(15,2) NULL DEFAULT NULL,
  `UNIDADE` INT NULL DEFAULT NULL,
  `PRECO_CUSTO` DECIMAL(12,2) NOT NULL,
  `PRECO_VENDA` DECIMAL(12,2) NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ESTOQUE` INT NOT NULL DEFAULT '0',
  `UNIDADE_MEDIDA_ID` INT NOT NULL,
  `MARCA_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `PROD_FK_UMEDIDA` (`UNIDADE_MEDIDA_ID` ASC) ,
  INDEX `PROD_FK_MARCA` (`MARCA_ID` ASC) ,
  CONSTRAINT `PROD_FK_MARCA`
    FOREIGN KEY (`MARCA_ID`)
    REFERENCES `banco`.`marca` (`ID`),
  CONSTRAINT `PROD_FK_UMEDIDA`
    FOREIGN KEY (`UNIDADE_MEDIDA_ID`)
    REFERENCES `banco`.`unidade_medida` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`baixa_produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`baixa_produto` ;

CREATE TABLE IF NOT EXISTS `banco`.`baixa_produto` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(100) NOT NULL,
  `QUANTIDADE` INT NOT NULL,
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FUNCIONARIO_ID` INT NOT NULL,
  `PRODUTO_ID` INT NOT NULL,
  `DATA_VENCIMENTO` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `BAIXAPROD_FUN_FK` (`FUNCIONARIO_ID` ASC) ,
  INDEX `BAIXAPROD_PROD_FK` (`PRODUTO_ID` ASC) ,
  CONSTRAINT `BAIXAPROD_FUN_FK`
    FOREIGN KEY (`FUNCIONARIO_ID`)
    REFERENCES `banco`.`funcionario` (`ID`),
  CONSTRAINT `BAIXAPROD_PROD_FK`
    FOREIGN KEY (`PRODUTO_ID`)
    REFERENCES `banco`.`produto` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`caixa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`caixa` ;

CREATE TABLE IF NOT EXISTS `banco`.`caixa` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATA_CADASTRO` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `SALDO` INT NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`categoria` ;

CREATE TABLE IF NOT EXISTS `banco`.`categoria` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DESCRICAO` VARCHAR(2000) NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`fornecedor` ;

CREATE TABLE IF NOT EXISTS `banco`.`fornecedor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `CPF_CNPJ` VARCHAR(18) NOT NULL,
  `ENDERECO` VARCHAR(100) NOT NULL,
  `ENDERECO_NUMERO` VARCHAR(20) NOT NULL,
  `ENDERECO_BAIRRO` VARCHAR(100) NOT NULL,
  `CEP` VARCHAR(10) NOT NULL,
  `FONE` VARCHAR(15) NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_NASCIMENTO` DATE NULL DEFAULT NULL,
  `EMAIL` VARCHAR(100) NULL DEFAULT NULL,
  `CIDADE_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `FORNECEDOR_CPFCNPJ_U` (`CPF_CNPJ` ASC) ,
  INDEX `FORNECEDOR_CID_FK` (`CIDADE_ID` ASC) ,
  CONSTRAINT `FORNECEDOR_CID_FK`
    FOREIGN KEY (`CIDADE_ID`)
    REFERENCES `banco`.`cidade` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`compra` ;

CREATE TABLE IF NOT EXISTS `banco`.`compra` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TIPO` CHAR(2) NOT NULL,
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FORNECEDOR_ID` INT NOT NULL,
  `FUNCIONARIO_ID` INT NOT NULL,
  `FPAGAMENTO_ID` INT NOT NULL,
  `DESCONTO` DECIMAL(12,2) NULL DEFAULT NULL,
  `ACRESCIMO` DECIMAL(12,2) NULL DEFAULT NULL,
  `TOTAL` DECIMAL(12,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `COMPRA_FORNECEDOR_FK` (`FORNECEDOR_ID` ASC) ,
  INDEX `COMPRA_FUNCIONARIO_FK` (`FUNCIONARIO_ID` ASC) ,
  CONSTRAINT `COMPRA_FORNECEDOR_FK`
    FOREIGN KEY (`FORNECEDOR_ID`)
    REFERENCES `banco`.`fornecedor` (`ID`),
  CONSTRAINT `COMPRA_FUNCIONARIO_FK`
    FOREIGN KEY (`FUNCIONARIO_ID`)
    REFERENCES `banco`.`funcionario` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`forma_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`forma_pagamento` ;

CREATE TABLE IF NOT EXISTS `banco`.`forma_pagamento` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(100) NOT NULL,
  `QTDE_PARCELAS` INT NOT NULL,
  `ENTRADA` CHAR(1) NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`conta_pagar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`conta_pagar` ;

CREATE TABLE IF NOT EXISTS `banco`.`conta_pagar` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `COMPRA_ID` INT NULL DEFAULT NULL,
  `FPAGAMENTO_ID` INT NOT NULL,
  `QTDE_PARC_PENDENTE` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `CPAG_COM_FK2` (`COMPRA_ID` ASC) ,
  INDEX `CPAG_FPAG_FK3` (`FPAGAMENTO_ID` ASC) ,
  CONSTRAINT `CPAG_COM_FK4`
    FOREIGN KEY (`COMPRA_ID`)
    REFERENCES `banco`.`compra` (`ID`),
  CONSTRAINT `CPAG_FPAG_FK5`
    FOREIGN KEY (`FPAGAMENTO_ID`)
    REFERENCES `banco`.`forma_pagamento` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`parcela_pagar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`parcela_pagar` ;

CREATE TABLE IF NOT EXISTS `banco`.`parcela_pagar` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `VALOR` DECIMAL(12,2) NOT NULL,
  `QUITADO` DECIMAL(12,2) NULL DEFAULT '0.00',
  `JUROS` DECIMAL(12,2) NULL DEFAULT '0.00',
  `DESCONTO` DECIMAL(12,2) NULL DEFAULT '0.00',
  `VENCIMENTO` DATETIME NULL DEFAULT NULL,
  `CPAGAR_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `PARPAGAR_CPAG_FK` (`CPAGAR_ID` ASC) ,
  CONSTRAINT `PARPAGAR_CPAG_FK`
    FOREIGN KEY (`CPAGAR_ID`)
    REFERENCES `banco`.`conta_pagar` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`pagamento` ;

CREATE TABLE IF NOT EXISTS `banco`.`pagamento` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(200) NULL DEFAULT NULL,
  `VALOR` DECIMAL(12,2) NULL DEFAULT NULL,
  `DATA_PAGAMENTO` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `PARCELA_PAGAR_ID` INT NULL DEFAULT NULL,
  `FORNECEDOR_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `PAG_PARPAG_FK` (`PARCELA_PAGAR_ID` ASC) ,
  INDEX `PAG_FORN_FK` (`FORNECEDOR_ID` ASC) ,
  CONSTRAINT `PAG_FORN_FK`
    FOREIGN KEY (`FORNECEDOR_ID`)
    REFERENCES `banco`.`fornecedor` (`ID`),
  CONSTRAINT `PAG_PARPAG_FK`
    FOREIGN KEY (`PARCELA_PAGAR_ID`)
    REFERENCES `banco`.`parcela_pagar` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`icaixa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`icaixa` ;

CREATE TABLE IF NOT EXISTS `banco`.`icaixa` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DESCRICAO` VARCHAR(100) NULL DEFAULT NULL,
  `NATUREZA` CHAR(1) NOT NULL,
  `VALOR` INT NOT NULL,
  `HORA` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CAIXA_ID` INT NOT NULL,
  `RECEBIMENTO_ID` INT NULL DEFAULT NULL,
  `PAGAMENTO_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `ICX_CX_FK` (`CAIXA_ID` ASC) ,
  INDEX `ICX_PAG_FK` (`PAGAMENTO_ID` ASC) ,
  CONSTRAINT `ICX_CX_FK`
    FOREIGN KEY (`CAIXA_ID`)
    REFERENCES `banco`.`caixa` (`ID`),
  CONSTRAINT `ICX_PAG_FK`
    FOREIGN KEY (`PAGAMENTO_ID`)
    REFERENCES `banco`.`pagamento` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`item_compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`item_compra` ;

CREATE TABLE IF NOT EXISTS `banco`.`item_compra` (
  `COMPRA_ID` INT NOT NULL,
  `PRODUTO_ID` INT NOT NULL,
  `QUANTIDADE` INT NOT NULL,
  `DESCONTO` DECIMAL(12,2) NULL DEFAULT NULL,
  PRIMARY KEY (`COMPRA_ID`, `PRODUTO_ID`),
  INDEX `ICOMPRA_PROD_FK` (`PRODUTO_ID` ASC) ,
  CONSTRAINT `ICOMPRA_COM_FK2`
    FOREIGN KEY (`COMPRA_ID`)
    REFERENCES `banco`.`compra` (`ID`),
  CONSTRAINT `ICOMPRA_PROD_FK2`
    FOREIGN KEY (`PRODUTO_ID`)
    REFERENCES `banco`.`produto` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`linha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`linha` ;

CREATE TABLE IF NOT EXISTS `banco`.`linha` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DESCRICAO` VARCHAR(2000) NULL DEFAULT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`linha_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`linha_categoria` ;

CREATE TABLE IF NOT EXISTS `banco`.`linha_categoria` (
  `LINHA_ID` INT NOT NULL,
  `CATEGORIA_ID` INT NOT NULL,
  PRIMARY KEY (`LINHA_ID`, `CATEGORIA_ID`),
  INDEX `LINCAT_FK_CATEGORIA` (`CATEGORIA_ID` ASC) ,
  CONSTRAINT `LINCAT_FK_CATEGORIA`
    FOREIGN KEY (`CATEGORIA_ID`)
    REFERENCES `banco`.`categoria` (`ID`),
  CONSTRAINT `LINCAT_FK_LINHA`
    FOREIGN KEY (`LINHA_ID`)
    REFERENCES `banco`.`linha` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`produto_categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`produto_categoria` ;

CREATE TABLE IF NOT EXISTS `banco`.`produto_categoria` (
  `PRODUTO_ID` INT NOT NULL,
  `CATEGORIA_ID` INT NOT NULL,
  PRIMARY KEY (`PRODUTO_ID`, `CATEGORIA_ID`),
  INDEX `PRODCAT_CATEGORIA_FK` (`CATEGORIA_ID` ASC) ,
  CONSTRAINT `PRODCAT_CATEGORIA_FK`
    FOREIGN KEY (`CATEGORIA_ID`)
    REFERENCES `banco`.`categoria` (`ID`),
  CONSTRAINT `PRODCAT_PRODUTO_FK`
    FOREIGN KEY (`PRODUTO_ID`)
    REFERENCES `banco`.`produto` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`tipo` ;

CREATE TABLE IF NOT EXISTS `banco`.`tipo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(100) NOT NULL,
  `DESCRICAO` VARCHAR(2000) NOT NULL,
  `STATUS` CHAR(1) NOT NULL DEFAULT 'A',
  `DATA_CADASTRO` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `banco`.`produto_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `banco`.`produto_tipo` ;

CREATE TABLE IF NOT EXISTS `banco`.`produto_tipo` (
  `PRODUTO_ID` INT NOT NULL,
  `TIPO_ID` INT NOT NULL,
  PRIMARY KEY (`PRODUTO_ID`, `TIPO_ID`),
  INDEX `PRODTIP_TIPO_FK` (`TIPO_ID` ASC) ,
  CONSTRAINT `PRODTIP_PRODUTO_FK`
    FOREIGN KEY (`PRODUTO_ID`)
    REFERENCES `banco`.`produto` (`ID`),
  CONSTRAINT `PRODTIP_TIPO_FK`
    FOREIGN KEY (`TIPO_ID`)
    REFERENCES `banco`.`tipo` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
