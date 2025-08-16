USE restaurante;

-- Soma a quantidade de pedidos
SELECT SUM(quantidade) FROM pedidos;

-- Conta quantos clientes fizeram pedidos
SELECT COUNT(DISTINCT id_cliente) FROM pedidos;

-- Calcula a média de preços da tabela produtos
SELECT AVG(preco) FROM produtos;

-- Exibe o produto com maior preço
SELECT MAX(preco) FROM produtos;

-- Exibe o produto com menor preço
SELECT MIN(preco) FROM produtos;

-- Exibe o nome e o preço por rank ordenado pelo preço, limite de 5
SELECT nome, preco, RANK() OVER (ORDER BY preco DESC) AS ranking_preco FROM produtos LIMIT 5;

-- Calcula a média de preço para cada categoria do produto
SELECT categoria, ROUND(AVG(preco),2) FROM produtos GROUP BY categoria;

-- Conta quantos produtos cada fornecedor tem
SELECT fornecedor, COUNT(fornecedor) FROM info_produtos GROUP BY fornecedor;

-- Exibe apenass fornecedores ccom mais de 1 produto cadastrado
SELECT fornecedor, COUNT(fornecedor) FROM info_produtos GROUP BY fornecedor HAVING COUNT(*) > 1;

-- Exibe os clientes que fizeram apenas 1 pedido
SELECT id_cliente, COUNT(id_cliente) FROM pedidos GROUP BY id_cliente HAVING COUNT(*) = 1;

