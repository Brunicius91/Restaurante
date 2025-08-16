USE restaurante;

-- Exibe os pedidos de acordo com o id_funcionario e o status_pedido
SELECT * FROM pedidos
WHERE id_funcionario = 4 AND status_pedido = 'Pendente';

-- Exibe os pedidos com status_pedido = 'Concluído'
SELECT * FROM pedidos
WHERE NOT status_pedido = 'Concluído';

-- Exibe os pedidos com id_produto '1,3,5,7,8'
SELECT * FROM pedidos
WHERE id_produto IN (1,3,5,7,8);

-- Exibe os clientes que o nome começam com a letra C
SELECT * FROM clientes
WHERE nome LIKE 'c%';

-- Exibe a info_produtos que tenham ingredientes 'carne' ou 'frango'
SELECT * FROM info_produtos
WHERE ingredientes LIKE 'carne%' OR ingredientes LIKE 'frango%';

-- Exibe os produtos com preço entre 20 e 30
SELECT * FROM produtos
WHERE preco BETWEEN 20 AND 30;

-- Define o pedido de id_pedido 6 com status_pedido NULL
UPDATE pedidos
SET status_pedido = 'null'
WHERE id_pedido = 6;

-- Exibe todos os pedidos com status_pedido = NULL
SELECT * FROM pedidos
WHERE status_pedido = 'null';

-- Exibe o id_pedido e o status_pedido mas caso tenha algum pedido NULL, informa como 'Cancelado'
SELECT id_pedido, status_pedido, IFNULL(NULLIF(status_pedido, 'null'), 'Cancelado') FROM pedidos;

-- Exibe do funcionario o nome, cargo, salario e se o salario está acima ou abaixo da média 
SELECT nome, cargo, salario, 
	CASE
		WHEN salario > 3000 THEN 'Acima da média'
        ELSE 'Abaixo da média'
	END AS media_salario
FROM funcionarios;