
-- -----------------------------------------------------
-- Schema CHECKPOINT3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS CHECKPOINT3;
USE CHECKPOINT3;

-- -----------------------------------------------------
-- Table CHECKPOINT3.CLIENTE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.CLIENTE (
  ID_CLIENTE INT NOT NULL AUTO_INCREMENT,
  CPF_CNPJ VARCHAR(45) NOT NULL,
  NOME VARCHAR(45) NOT NULL,
  SOBRENOME VARCHAR(50) NOT NULL,
  EMAIL VARCHAR(50) NULL DEFAULT NULL,
  TELEFONE VARCHAR(50) NULL DEFAULT NULL,
  ATIVO TINYINT NOT NULL,
  DATA_CRIACAO DATETIME NOT NULL,
  ATUALIZACAO TIMESTAMP NOT NULL,
  LOGRADOURO VARCHAR(45) NULL DEFAULT NULL,
  CIDADE VARCHAR(45) NULL DEFAULT NULL,
  ESTADO VARCHAR(2) NULL DEFAULT NULL,
  CEP VARCHAR(45) NULL DEFAULT NULL,
  COMPLEMENTO VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (ID_CLIENTE));

-- -----------------------------------------------------
-- Table CHECKPOINT3.FORNECEDOR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.FORNECEDOR (
  ID_FORNECEDOR INT NOT NULL AUTO_INCREMENT,
  NOME_FANTASIA VARCHAR(45) NOT NULL,
  CNPJ_CPF VARCHAR(45) NOT NULL,
  LOGRADOURO VARCHAR(45) NULL DEFAULT NULL,
  CIDADE VARCHAR(45) NULL DEFAULT NULL,
  ESTADO VARCHAR(2) NULL DEFAULT NULL,
  CEP VARCHAR(45) NULL DEFAULT NULL,
  COMPLEMENTO VARCHAR(45) NULL DEFAULT NULL,
  CONTATO VARCHAR(45) NULL DEFAULT NULL,
  EMAIL VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (ID_FORNECEDOR));

-- -----------------------------------------------------
-- Table CHECKPOINT3.ENTRADA_PRODUTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.ENTRADA_PRODUTO (
  ID_ENTRADA_PRODUTO INT NOT NULL AUTO_INCREMENT,
  ID_FORNECEDOR INT NOT NULL,
  DESCRICAO VARCHAR(45) NOT NULL,
  QUANTIDADE INT NOT NULL,
  VALOR_COMPRA DOUBLE NOT NULL,
  TAMANHO VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (ID_ENTRADA_PRODUTO),
  INDEX ID_COMPRA_ID_FORNECEDOR_ID_FORNECEDOR (ID_FORNECEDOR ASC) VISIBLE,
  CONSTRAINT ID_COMPRA_ID_FORNECEDOR_ID_FORNECEDOR
    FOREIGN KEY (ID_FORNECEDOR)
    REFERENCES CHECKPOINT3.FORNECEDOR (ID_FORNECEDOR));

-- -----------------------------------------------------
-- Table CHECKPOINT3.ESTOQUE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.ESTOQUE (
  ID_ESTOQUE INT NOT NULL AUTO_INCREMENT,
  ID_ENTRADA_PRODUTO INT NOT NULL,
  DESCRICAO VARCHAR(45) NOT NULL,
  QUANTIDADE VARCHAR(45) NOT NULL,
  VALOR_VENDA DOUBLE NOT NULL,
  PRIMARY KEY (ID_ESTOQUE),
  INDEX ESTOQUE_ID_COMPRA (ID_ENTRADA_PRODUTO ASC) VISIBLE,
  CONSTRAINT ESTOQUE_ID_COMPRA
    FOREIGN KEY (ID_ENTRADA_PRODUTO)
    REFERENCES CHECKPOINT3.ENTRADA_PRODUTO (ID_ENTRADA_PRODUTO));

-- -----------------------------------------------------
-- Table CHECKPOINT3.FUNCIONARIO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.FUNCIONARIO (
  ID_FUNCIONARIO INT NOT NULL AUTO_INCREMENT,
  NOME VARCHAR(45) NOT NULL,
  SOBRENOME VARCHAR(45) NOT NULL,
  ATIVO TINYINT NOT NULL,
  USUARIO VARCHAR(45) NULL DEFAULT NULL,
  SENHA VARCHAR(45) NULL DEFAULT NULL,
  ATUALIZACAO TIMESTAMP NOT NULL,
  LOGRADOURO VARCHAR(45) NULL DEFAULT NULL,
  CIDADE VARCHAR(45) NULL DEFAULT NULL,
  ESTADO VARCHAR(2) NULL DEFAULT NULL,
  CEP VARCHAR(45) NULL DEFAULT NULL,
  COMPLEMENTO VARCHAR(45) NULL DEFAULT NULL,
  CONTATO VARCHAR(45) NULL DEFAULT NULL,
  EMAIL VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (ID_FUNCIONARIO));

-- -----------------------------------------------------
-- Table CHECKPOINT3.FORMA_PAGAMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.FORMA_PAGAMENTO (
  ID_FORMA_PAGAMENTO INT NOT NULL AUTO_INCREMENT,
  PAGAMENTO VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_FORMA_PAGAMENTO));

-- -----------------------------------------------------
-- Table CHECKPOINT3.SAIDA_PRODUTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CHECKPOINT3.SAIDA_PRODUTO (
  ID_SAIDA_PRODUTO INT NOT NULL AUTO_INCREMENT,
  ID_CLIENTE INT NOT NULL,
  ID_FUNCIONARIO INT NOT NULL,
  ID_ESTOQUE INT NOT NULL,
  ID_FORMA_PAGAMENTO INT NOT NULL,
  PRIMARY KEY (ID_SAIDA_PRODUTO),
  INDEX VENDAS_ID_CLIENTE (ID_CLIENTE ASC) VISIBLE,
  INDEX VENDAS_ID_ESTOQUE (ID_ESTOQUE ASC) VISIBLE,
  INDEX VENDAS_ID_FUNCIONARIO (ID_FUNCIONARIO ASC) VISIBLE,
  INDEX FORMA_PAGAMENTO_ID_FORMA_PAGAMENTO_idx (ID_FORMA_PAGAMENTO ASC) VISIBLE,
  CONSTRAINT VENDAS_ID_CLIENTE
    FOREIGN KEY (ID_CLIENTE)
    REFERENCES CHECKPOINT3.CLIENTE (ID_CLIENTE),
  CONSTRAINT VENDAS_ID_ESTOQUE
    FOREIGN KEY (ID_ESTOQUE)
    REFERENCES CHECKPOINT3.ESTOQUE (ID_ESTOQUE),
  CONSTRAINT VENDAS_ID_FUNCIONARIO
    FOREIGN KEY (ID_FUNCIONARIO)
    REFERENCES CHECKPOINT3.FUNCIONARIO (ID_FUNCIONARIO),
  CONSTRAINT FORMA_PAGAMENTO_ID_FORMA_PAGAMENTO
    FOREIGN KEY (ID_FORMA_PAGAMENTO)
    REFERENCES CHECKPOINT3.FORMA_PAGAMENTO (ID_FORMA_PAGAMENTO)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
