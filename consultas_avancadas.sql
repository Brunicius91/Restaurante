USE restaurante;

-- Cria uma VIEW com um resumo dos pedidos
CREATE VIEW resumo_pedido AS
SELECT
	p.id_pedido, p.quantidade, p.data_pedido,
	c.nome AS nome_cliente, c.email,
	f.nome AS nome_funcionario,
	pr.nome AS nome_produto, pr.preco
FROM
	pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN funcionarios f ON f.id_funcionario = p.id_funcionario
JOIN produtos pr ON pr.id_produto = p.id_produto;

SELECT id_pedido, nome_cliente, SUM(quantidade * preco) AS total
FROM resumo_pedido
GROUP BY id_pedido, nome_cliente;

-- Atualiza a VIEW para acrescentar a coluna total
CREATE OR REPLACE VIEW resumo_pedido AS
SELECT
    p.id_pedido,
    p.quantidade,
    p.data_pedido,
    c.nome AS nome_cliente,
    c.email,
    f.nome AS nome_funcionario,
    pr.nome AS nome_produto,
    pr.preco,
    (SELECT SUM(pr2.preco * p2.quantidade)
     FROM pedidos p2
     JOIN produtos pr2 ON pr2.id_produto = p2.id_produto
     WHERE p2.id_pedido = p.id_pedido) AS total
FROM
    pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN funcionarios f ON f.id_funcionario = p.id_funcionario
JOIN produtos pr ON pr.id_produto = p.id_produto;

SELECT id_pedido, nome_cliente, total
FROM resumo_pedido
GROUP BY id_pedido, nome_cliente;

EXPLAIN
SELECT id_pedido, nome_cliente, total
FROM resumo_pedido
GROUP BY id_pedido, nome_cliente;

-- Cria uma função onde busca os ingredientes de um produto aparti do id_produto
DELIMITER //
CREATE FUNCTION BuscaIngredientesProduto(idProduto INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
	DECLARE InfoIngredientes VARCHAR(200);
    SELECT ingredientes INTO InfoIngredientes FROM info_produtos WHERE id_produto = idProduto;
    RETURN InfoIngredientes;
END //
DELIMITER ;

SELECT BuscaIngredientesProduto (10);

-- Cria uma função onde calcula a média dos pedidos 
DELIMITER //
CREATE FUNCTION mediaPedido(idPedido INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
	DECLARE PedidoMedio DECIMAL (10,2);
    DECLARE desempenho VARCHAR (200);
    DECLARE TotalPedido INT;
    
    SELECT SUM(quantidade) INTO TotalPedido
    FROM pedidos
    WHERE id_pedido = idPedido;
    
    SELECT AVG(quantidade) INTO PedidoMedio
    FROM pedidos;
    
    SET desempenho = 
    CASE 
		WHEN TotalPedido > PedidoMedio THEN 'Total de pedidos é acima da média'
        WHEN TotalPedido < PedidoMedio THEN 'Total de pedidos é abaixo da média'
        ELSE 'Total de pedidos é a média'
	END;
    RETURN desempenho;

END //
DELIMITER ;

SELECT mediaPedido (5);
SELECT mediaPedido (6);

