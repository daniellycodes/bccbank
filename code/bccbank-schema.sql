CREATE DATABASE bccbank
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE bccbank;

CREATE TABLE Cliente (
    cpf CHAR(11) PRIMARY KEY,
    nomecompleto VARCHAR(255) NOT NULL,
    datanascimento DATE NOT NULL,
    rua_endereco VARCHAR(255) NOT NULL,
    numero_endereco VARCHAR(4) NOT NULL,
    bairro_endereco VARCHAR(255) NOT NULL,
    cidade_endereco VARCHAR(255) NOT NULL,
    estado_endereco VARCHAR(2) NOT NULL,
    cep_endereco CHAR(8) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL UNIQUE
) default charset = utf8mb4;

CREATE TABLE ContaCorrente (
    numero_conta VARCHAR(10) PRIMARY KEY,
    saldo DECIMAL(10, 2),
    data_abertura DATE,
    cpf CHAR(11) NOT NULL,
    FOREIGN KEY (cpf) REFERENCES Cliente(cpf)
) default charset = utf8mb4;

CREATE TABLE TransacaoFinanceira (
    id_transacao INT PRIMARY KEY AUTO_INCREMENT,
    data_transacao DATE NOT NULL,
    valor_transacao DECIMAL(10, 2) NOT NULL,
    tipo_transacao VARCHAR(50) NOT NULL,
    numero_conta VARCHAR(10),
    FOREIGN KEY (numero_conta) REFERENCES ContaCorrente(numero_conta)
) default charset = utf8mb4;

CREATE TABLE CartaoCredito (
    numero_cartao CHAR(16) PRIMARY KEY,
    numero_conta VARCHAR(10),
    limite_credito DECIMAL(10, 2) NOT NULL,
    data_validade DATE NOT NULL,
    FOREIGN KEY (numero_conta) REFERENCES ContaCorrente(numero_conta)
) default charset = utf8mb4;

CREATE TABLE Emprestimo (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    valor_emprestimo DECIMAL(10, 2) NOT NULL,
    taxa_juros DECIMAL(5, 2) NOT NULL,
    data_concessao DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    numero_conta VARCHAR(10),
    FOREIGN KEY (numero_conta) REFERENCES ContaCorrente(numero_conta)
) default charset = utf8mb4;

CREATE TABLE Investimento (
    id_investimento INT PRIMARY KEY AUTO_INCREMENT,
    tipo_investimento VARCHAR(50) NOT NULL,
    valor_investido DECIMAL(10, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_vencimento DATE NOT NULL,
    numero_conta VARCHAR(10),
    FOREIGN KEY (numero_conta) REFERENCES ContaCorrente(numero_conta)
) default charset = utf8mb4;
