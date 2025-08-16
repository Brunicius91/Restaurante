USE restaurante;

-- Busca o nome e a categoria dos produtos com preço < 30 
SELECT nome, categoria FROM produtos WHERE preco < 30;

-- Busca o nome, telefone e data_nascimento dos clientes nascidos antes de 1985-01-01
SELECT nome, telefone, data_nascimento FROM clientes WHERE data_nascimento < '1985-01-01';

-- Seleciona o id_produto e os ingredientes cujo o ingrediente tem a palavra 'carne'
SELECT id_produto, ingredientes FROM info_produtos WHERE ingredientes LIKE 'carne%';

-- Ordenar produtos por categoria e nome
SELECT nome, categoria FROM produtos ORDER BY categoria ASC, nome ASC;

-- Ordenar produtos por preço, limite de 5 produtos 
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 5;

-- Exibe o 6º e 7º prato principal do menu
SELECT nome FROM produtos WHERE categoria = 'Prato Principal' LIMIT 2 OFFSET 5;

-- Criando a tabela backup_pedidos
CREATE TABLE backup_pedidos AS SELECT * FROM pedidos;