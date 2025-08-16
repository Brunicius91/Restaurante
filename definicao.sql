CREATE DATABASE restaurante;
USE restaurante;
DESC funcionarios;
DESC clientes;
DESC produtos;
DESC pedidos;
DESC info_produtos;
SELECT * FROM funcionarios;
SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;

CREATE TABLE funcionarios(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(255),
	cpf VARCHAR(14),
	data_nascimento DATE,
	endereco VARCHAR(255),
	telefone VARCHAR(15),
	email VARCHAR(100),
	cargo VARCHAR(100),
	salario DECIMAL(10,2),
	data_admissao DATE,
    UNIQUE (id_funcionario)
);

CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(255),
	cpf VARCHAR(14),
	data_nascimento DATE,
	endereco VARCHAR(255),
	telefone VARCHAR(15),
	email VARCHAR(100),
	data_cadastro DATE
);

CREATE TABLE produtos(
	id_produto INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10,2),
    categoria VARCHAR(100)
);

CREATE TABLE pedidos(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    id_cliente INT,
    id_funcionario INT,
    id_produto INT,
    quantidade INT,
    preco DECIMAL(10,2),
    data_pedido DATE,
    status_pedido VARCHAR(50)
);
ALTER TABLE pedidos ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);
ALTER TABLE pedidos ADD FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario);
ALTER TABLE pedidos ADD FOREIGN KEY (id_produto) REFERENCES produtos(id_produto);

CREATE TABLE info_produtos(
	id_info INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    id_produto INT,
    ingredientes TEXT,
    fornecedor VARCHAR(255)
);
ALTER TABLE info_produtos ADD FOREIGN KEY (id_produto) REFERENCES produtos(id_produto);