USE restaurante;

-- 1. Unir as tabelas 'produtos' e 'info_produtos'
-- Objetivo: Obter informações detalhadas dos produtos, como ingredientes, ao unir dados de duas tabelas relacionadas.
SELECT pr.id_produto, pr.nome AS Nome_Produto, pr.descricao, inf.ingredientes
FROM produtos pr
INNER JOIN info_produtos inf ON pr.id_produto = inf.id_produto;

-- 2. Unir as tabelas 'pedidos' e 'clientes'
-- Objetivo: Vincular cada pedido ao cliente que o realizou, para obter informações como o nome e e-mail.
SELECT ped.id_pedido, ped.quantidade, ped.data_pedido, cl.nome AS Nome_Cliente, cl.email
FROM pedidos ped
INNER JOIN clientes cl ON ped.id_cliente = cl.id_cliente;

-- 3. Unir 'pedidos', 'clientes' e 'funcionarios'
-- Objetivo: Juntar informações de pedido, cliente e funcionário em uma única visualização.
SELECT ped.id_pedido, ped.quantidade, ped.data_pedido, cl.nome AS Nome_Cliente, cl.email, fun.nome AS nome_funcionario
FROM pedidos ped
INNER JOIN clientes cl ON ped.id_cliente = cl.id_cliente
INNER JOIN funcionarios fun ON ped.id_funcionario = fun.id_funcionario;

-- 4. Unir 'pedidos', 'clientes', 'funcionarios' e 'produtos'
-- Objetivo: Criar um relatório completo que mostra todos os detalhes de cada item de pedido, incluindo nome do produto e seu preço.
SELECT ped.id_pedido, ped.quantidade, ped.data_pedido, cl.nome AS nome_cliente, cl.email, fun.nome AS nome_funcionario, pr.nome AS nome_produto, pr.preco
FROM pedidos ped
INNER JOIN clientes cl ON ped.id_cliente = cl.id_cliente
INNER JOIN funcionarios fun ON ped.id_funcionario = fun.id_funcionario
INNER JOIN produtos pr ON ped.id_produto = pr.id_produto;

-- 5. Consultar clientes com pedidos pendentes
-- Objetivo: Encontrar clientes cujo status de pedido é 'Pendente', ordenando os pedidos do mais recente para o mais antigo.
SELECT cl.nome, ped.status_pedido, ped.id_pedido
FROM clientes cl
INNER JOIN pedidos ped ON cl.id_cliente = ped.id_cliente
WHERE status_pedido = 'Pendente'
ORDER BY id_pedido DESC;

-- 6. Encontrar clientes sem pedidos (LEFT JOIN)
-- Objetivo: Identificar clientes que ainda não fizeram um pedido. A cláusula 'IS NULL' filtra os resultados que não têm correspondência na tabela de pedidos.
SELECT cl.* 
FROM clientes cl
LEFT JOIN pedidos ped ON cl.id_cliente = ped.id_cliente
WHERE ped.id_pedido IS NULL;

-- 7. Contar o total de pedidos por cliente (Subquery)
-- Objetivo: Para cada cliente, contar o número total de pedidos que ele fez. A subquery calcula esse total para cada cliente na lista.
SELECT cl.nome,
	(SELECT COUNT(*) FROM pedidos ped WHERE ped.id_cliente = cl.id_cliente) AS Total_Pedidos
FROM clientes cl;

-- 8. Calcular o preço total para cada pedido (Agregação)
-- Objetivo: Somar o valor total de cada pedido individual, calculando a soma do preço de cada item multiplicado pela sua quantidade.
SELECT ped.id_pedido, SUM(ped.quantidade * pr.preco) AS Preco_total
FROM pedidos ped
INNER JOIN produtos pr ON ped.id_produto = pr.id_produto
GROUP BY ped.id_pedido;