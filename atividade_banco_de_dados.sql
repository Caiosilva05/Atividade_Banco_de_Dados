CREATE TABLE produto (
	id_produto INTEGER PRIMARY KEY,
	ds_produto VARCHAR (255) NOT NULL UNIQUE,
	qt_minima_reposicao INTEGER NOT NULL
);
INSERT INTO produto (id_produto,ds_produto,qt_minima_reposicao) VALUES (1, 'Margarina',50);
INSERT INTO produto (id_produto,ds_produto,qt_minima_reposicao) VALUES (2, 'Tomate',10);
INSERT INTO produto (id_produto,ds_produto,qt_minima_reposicao) VALUES (3, 'Macarrão',15);
INSERT INTO produto (id_produto,ds_produto,qt_minima_reposicao) VALUES (4, 'Sabonete',5);
INSERT INTO produto (id_produto,ds_produto,qt_minima_reposicao) VALUES (5, 'Esponja',3);




CREATE TABLE estoque (
	id_produto INTEGER PRIMARY KEY,
	qt_produto INTEGER NOT NULL
);
INSERT INTO estoque (id_produto,qt_produto) VALUES (1, 127);
INSERT INTO estoque (id_produto,qt_produto) VALUES (2, 2);
INSERT INTO estoque (id_produto,qt_produto) VALUES (3, 15);
INSERT INTO estoque (id_produto,qt_produto) VALUES (4, 7);
INSERT INTO estoque (id_produto,qt_produto) VALUES (5, 7);




CREATE TABLE cliente (
	id_cliente INTEGER PRIMARY KEY,
	ds_cliente VARCHAR (255) NOT NULL
);
INSERT INTO cliente (id_cliente,ds_cliente) VALUES (1, 'Maria da Silva');
INSERT INTO cliente (id_cliente,ds_cliente) VALUES (2, 'João Pedro');
INSERT INTO cliente (id_cliente,ds_cliente) VALUES (3, 'Eduardo Pereira');




CREATE TABLE compra_cliente (
	id_cliente INTEGER,
	FOREIGN KEY (id_cliente)
		REFERENCES cliente (id_cliente),
	id_produto INTEGER,
	FOREIGN KEY (id_produto)
		REFERENCES produto (id_produto),
	qt_produto INTEGER
);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (1, 1, 5);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (1, 3, 7);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (1, 5, 2);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (3, 1, 7);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (3, 1, 2);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (3, 4, 5);
INSERT INTO compra_cliente (id_cliente,id_produto,qt_produto) VALUES (3, 5, 9);




EXERCICIO_1

SELECT estoque.id_produto AS "Id Produto",
	   produto.ds_produto AS "Nome do Produto",
	   produto.qt_minima_reposicao AS "Quantidade Mínima para Reposição",
	   estoque.qt_produto AS "Quantidade de Produtos em Estoque"
	   FROM estoque
	   JOIN produto ON produto.id_produto = estoque.id_produto
	   WHERE estoque.qt_produto <= produto.qt_minima_reposicao
	   
	  


EXERCICIO_2

SELECT  DISTINCT
		cliente.id_cliente AS "Id Cliente",
		cliente.ds_cliente AS "Nome do Cliente",
		produto.id_produto 	AS "Id Produto",
		produto.ds_produto AS "Nome do Produto"
		FROM cliente
		JOIN compra_cliente ON compra_cliente.id_cliente = cliente.id_cliente
		JOIN produto ON produto.id_produto = compra_cliente.id_produto
		ORDER BY cliente.id_cliente
		



EXERCICIO_3

SELECT produto.id_produto AS "Id Produto",
	   produto.ds_produto AS "Nome do Produto",
	   COUNT(qt_produto) AS "Quantidade Vendida"
	   FROM produto
	   LEFT JOIN compra_cliente ON compra_cliente.id_produto = produto.id_produto
	   GROUP BY produto.id_produto,produto.ds_produto,compra_cliente.qt_produto
	   HAVING COUNT(compra_cliente.id_produto) = 0




EXERCICIO_4

SELECT cliente.id_cliente AS "Id Cliente",
	   cliente.ds_cliente AS "Nome do Cliente",
	   COUNT(qt_produto) AS "Quantidade de Produtos Comprado"
	   FROM cliente
	   LEFT JOIN compra_cliente ON compra_cliente.id_cliente = cliente.id_cliente
	   GROUP BY cliente.id_cliente,cliente.ds_cliente,compra_cliente.qt_produto
	   HAVING COUNT(compra_cliente.id_cliente) = 0




EXERCICIO_5
	
SELECT  produto.id_produto AS "Id Produto",
		SUM(compra_cliente.qt_produto) AS "Quantidade de Produto",
		produto.ds_produto AS "Nome do Produto"
		FROM produto
		JOIN compra_cliente ON compra_cliente.id_produto = produto.id_produto 
		GROUP BY produto.id_produto,produto.ds_produto
		ORDER BY SUM(compra_cliente.qt_produto) DESC
		