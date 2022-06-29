-- -----------------------------------------------------
-- Schema CHECKPOINT3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CHECKPOINT3`;
USE `CHECKPOINT3`;

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`CLIENTE` (
  `ID_CLIENTE` INT NOT NULL AUTO_INCREMENT,
  `CPF_CNPJ` VARCHAR(45) NOT NULL,
  `NOME` VARCHAR(45) NOT NULL,
  `SOBRENOME` VARCHAR(50) NOT NULL,
  `EMAIL` VARCHAR(50) NULL DEFAULT NULL,
  `TELEFONE` VARCHAR(50) NULL DEFAULT NULL,
  `ATIVO` TINYINT NOT NULL,
  `DATA_CRIACAO` DATETIME NOT NULL,
  `ATUALIZACAO` TIMESTAMP NOT NULL,
  `LOGRADOURO` VARCHAR(45) NULL DEFAULT NULL,
  `CIDADE` VARCHAR(45) NULL DEFAULT NULL,
  `ESTADO` VARCHAR(2) NULL DEFAULT NULL,
  `CEP` VARCHAR(45) NULL DEFAULT NULL,
  `COMPLEMENTO` VARCHAR(45) NULL DEFAULT NULL,
  `DATA_NASC` DATE NOT NULL,
  PRIMARY KEY (`ID_CLIENTE`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`FORNECEDOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`FORNECEDOR` (
  `ID_FORNECEDOR` INT NOT NULL AUTO_INCREMENT,
  `NOME_FANTASIA` VARCHAR(45) NOT NULL,
  `CNPJ_CPF` VARCHAR(45) NOT NULL,
  `LOGRADOURO` VARCHAR(45) NULL DEFAULT NULL,
  `CIDADE` VARCHAR(45) NULL DEFAULT NULL,
  `ESTADO` VARCHAR(2) NULL DEFAULT NULL,
  `CEP` VARCHAR(45) NULL DEFAULT NULL,
  `COMPLEMENTO` VARCHAR(45) NULL DEFAULT NULL,
  `CONTATO` VARCHAR(45) NULL DEFAULT NULL,
  `EMAIL` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_FORNECEDOR`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`ENTRADA_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`ENTRADA_PRODUTO` (
  `ID_ENTRADA_PRODUTO` INT NOT NULL AUTO_INCREMENT,
  `ID_FORNECEDOR` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NOT NULL,
  `QUANTIDADE` INT NOT NULL,
  `VALOR_COMPRA` DOUBLE NOT NULL,
  `TAMANHO` VARCHAR(2) NULL DEFAULT NULL,
  `DATA_ENTRADA` DATETIME NOT NULL,
  PRIMARY KEY (`ID_ENTRADA_PRODUTO`),
  INDEX `ID_COMPRA_ID_FORNECEDOR_ID_FORNECEDOR` (`ID_FORNECEDOR` ASC) VISIBLE,
  CONSTRAINT `ID_COMPRA_ID_FORNECEDOR_ID_FORNECEDOR`
    FOREIGN KEY (`ID_FORNECEDOR`)
    REFERENCES `CHECKPOINT3`.`FORNECEDOR` (`ID_FORNECEDOR`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`ESTOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`ESTOQUE` (
  `ID_ESTOQUE` INT NOT NULL AUTO_INCREMENT,
  `ID_ENTRADA_PRODUTO` INT NOT NULL,
  `DESCRICAO` VARCHAR(45) NOT NULL,
  `QUANTIDADE` INT NOT NULL,
  `VALOR_VENDA` DOUBLE NOT NULL,
  PRIMARY KEY (`ID_ESTOQUE`),
  INDEX `ESTOQUE_ID_COMPRA` (`ID_ENTRADA_PRODUTO` ASC) VISIBLE,
  CONSTRAINT `ESTOQUE_ID_COMPRA`
    FOREIGN KEY (`ID_ENTRADA_PRODUTO`)
    REFERENCES `CHECKPOINT3`.`ENTRADA_PRODUTO` (`ID_ENTRADA_PRODUTO`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`FORMA_PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`FORMA_PAGAMENTO` (
  `ID_FORMA_PAGAMENTO` INT NOT NULL AUTO_INCREMENT,
  `PAGAMENTO` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID_FORMA_PAGAMENTO`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`FUNCIONARIO` (
  `ID_FUNCIONARIO` INT NOT NULL AUTO_INCREMENT,
  `NOME` VARCHAR(45) NOT NULL,
  `SOBRENOME` VARCHAR(45) NOT NULL,
  `ATIVO` TINYINT NOT NULL,
  `USUARIO` VARCHAR(45) NULL DEFAULT NULL,
  `SENHA` VARCHAR(45) NULL DEFAULT NULL,
  `ATUALIZACAO` TIMESTAMP NOT NULL,
  `LOGRADOURO` VARCHAR(45) NULL DEFAULT NULL,
  `CIDADE` VARCHAR(45) NULL DEFAULT NULL,
  `ESTADO` VARCHAR(2) NULL DEFAULT NULL,
  `CEP` VARCHAR(45) NULL DEFAULT NULL,
  `COMPLEMENTO` VARCHAR(45) NULL DEFAULT NULL,
  `CONTATO` VARCHAR(45) NULL DEFAULT NULL,
  `EMAIL` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_FUNCIONARIO`));

-- -----------------------------------------------------
-- Table `CHECKPOINT3`.`SAIDA_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CHECKPOINT3`.`SAIDA_PRODUTO` (
  `ID_SAIDA_PRODUTO` INT NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` INT NOT NULL,
  `ID_FUNCIONARIO` INT NOT NULL,
  `ID_ESTOQUE` INT NOT NULL,
  `ID_FORMA_PAGAMENTO` INT NOT NULL,
  `DATA_SAIDA` DATETIME NOT NULL,
  PRIMARY KEY (`ID_SAIDA_PRODUTO`),
  INDEX `VENDAS_ID_CLIENTE` (`ID_CLIENTE` ASC) VISIBLE,
  INDEX `VENDAS_ID_ESTOQUE` (`ID_ESTOQUE` ASC) VISIBLE,
  INDEX `VENDAS_ID_FUNCIONARIO` (`ID_FUNCIONARIO` ASC) VISIBLE,
  INDEX `FORMA_PAGAMENTO_ID_FORMA_PAGAMENTO_idx` (`ID_FORMA_PAGAMENTO` ASC) VISIBLE,
  CONSTRAINT `FORMA_PAGAMENTO_ID_FORMA_PAGAMENTO`
    FOREIGN KEY (`ID_FORMA_PAGAMENTO`)
    REFERENCES `CHECKPOINT3`.`FORMA_PAGAMENTO` (`ID_FORMA_PAGAMENTO`),
  CONSTRAINT `VENDAS_ID_CLIENTE`
    FOREIGN KEY (`ID_CLIENTE`)
    REFERENCES `CHECKPOINT3`.`CLIENTE` (`ID_CLIENTE`),
  CONSTRAINT `VENDAS_ID_ESTOQUE`
    FOREIGN KEY (`ID_ESTOQUE`)
    REFERENCES `CHECKPOINT3`.`ESTOQUE` (`ID_ESTOQUE`),
  CONSTRAINT `VENDAS_ID_FUNCIONARIO`
    FOREIGN KEY (`ID_FUNCIONARIO`)
    REFERENCES `CHECKPOINT3`.`FUNCIONARIO` (`ID_FUNCIONARIO`));

-- --------------------------------------------------------------------
-- Placeholder table for view `CHECKPOINT3`.`vw_HistoricoCompras`
-- --------------------------------------------------------------------

CREATE VIEW  vw_HistoricoCompras AS
SELECT 
    CLIENTE.CPF_CNPJ AS 'DOC CLIENTE',
    CLIENTE.ID_CLIENTE AS 'ID CLIENTE',
    CLIENTE.NOME AS 'NOME',
    CLIENTE.SOBRENOME AS 'SOBRENOME', 
    ESTOQUE.ID_ESTOQUE AS 'ID VENDA',
    ENTRADA_PRODUTO.DATA_ENTRADA AS 'DATA ENTRADA',
    ESTOQUE.DESCRICAO AS 'PROD',
    ESTOQUE.QUANTIDADE AS 'QT',
    ESTOQUE.VALOR_VENDA AS 'VR DA VENDA',
    (ESTOQUE.QUANTIDADE * ESTOQUE.VALOR_VENDA) AS 'VT TOTAL',
    SAIDA_PRODUTO.DATA_SAIDA AS 'DATA VENDA',
    FUNCIONARIO.ID_FUNCIONARIO AS 'ID VENDEDOR',
    FUNCIONARIO.NOME AS 'VENDEDOR'    
FROM 
	SAIDA_PRODUTO
INNER JOIN 
	CLIENTE ON CLIENTE.ID_CLIENTE = SAIDA_PRODUTO.ID_CLIENTE
INNER JOIN 
	FUNCIONARIO ON FUNCIONARIO.ID_FUNCIONARIO = SAIDA_PRODUTO.ID_FUNCIONARIO
INNER JOIN 
	ESTOQUE ON ESTOQUE.ID_ESTOQUE = SAIDA_PRODUTO.ID_ESTOQUE
INNER JOIN 
	ENTRADA_PRODUTO ON ENTRADA_PRODUTO.ID_ENTRADA_PRODUTO = ESTOQUE.ID_ENTRADA_PRODUTO;     

 -- --------------------------------------------------------------------------
-- Placeholder table for view `CHECKPOINT3`.`SP_ANIVERSARIANTES_MES`
-- --------------------------------------------------------------------------
    
DELIMITER //
CREATE PROCEDURE SP_AniversarioPorMes (
	IN MES VARCHAR(15)
)
BEGIN
	SELECT
		CLIENTE.ID_CLIENTE AS 'ID CLIENTE',
		CONCAT(CLIENTE.NOME, ' ', CLIENTE.SOBRENOME) AS 'Nome',
        CLIENTE.TELEFONE AS 'Telefone',
        CLIENTE.EMAIL AS 'E-mail',
        DATE_FORMAT(DATA_NASC, '%d/%m') AS 'Aniversário'
	FROM CLIENTE
    WHERE
		MONTH(DATA_NASC) = MES
	ORDER BY
		MONTH(DATA_NASC) ASC;
END //
DELIMITER ;

   -- -------------------------------------------------------------
-- Placeholder table for view `CHECKPOINT3`.`sp_AtualizaEstoque`
-- ----------------------------------------------------------------
    
DELIMITER //
CREATE PROCEDURE `SP_AtualizaEstoque`( `ID_PROD` INT, `QTD_COMPRADA` INT, VALOR_UNIT DOUBLE)
BEGIN
    DECLARE CONTADOR INT(11);
    
    SELECT COUNT(*) INTO CONTADOR FROM ESTOQUE WHERE ID_ENTRADA_PRODUTO = ID_PROD;

    IF CONTADOR >= 0 THEN
        UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE + QTD_COMPRADA, VALOR_VENDA = VALOR_UNIT
        WHERE ID_ENTRADA_PRODUTO = ID_PROD;
    ELSE
        INSERT INTO ESTOQUE (ID_ENTRADA_PRODUTO, QUANTIDADE, VALOR_VENDA) VALUES (ID_PROD, QTD_COMPRADA, VALOR_UNIT);
    END IF;
END //
DELIMITER ;

select * from vw_HistoricoCompras
