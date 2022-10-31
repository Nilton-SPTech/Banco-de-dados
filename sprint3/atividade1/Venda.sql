CREATE DATABASE Venda; 
USE Venda; 

CREATE TABLE Cliente(
    idCliente INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
  	email VARCHAR(60), 
  	logradouro VARCHAR(60), 
  	bairro VARCHAR(60), 
  	cep CHAR(9), 
  	numero INT,
  	complemento CHAR(3), 
  	cidade VARCHAR(45), 

    fkIndicador INT, 
    FOREIGN KEY (fkIndicador) REFERENCES Cliente (idCliente)
); 

CREATE TABLE Produto(
    idProduto INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
    descricao VARCHAR(100), 
    preco DECIMAL(5,2)
);

CREATE TABLE Venda(
    idVenda INT AUTO_INCREMENT, 
    totalVenda DECIMAL(5,2), 
    dataVenda DATE, 

    fkCliente INT, FOREIGN KEY (fkCliente) REFERENCES Cliente(idCliente),
    PRIMARY KEY (idVenda, fkCliente)

);

CREATE TABLE VendaProduto(
    quantidadeProduto INT, 
    valorDesconto DECIMAL(5,2)

    fkVenda INT, FOREIGN KEY (fkVenda) REFERENCES Venda(idVenda), 
    fkProduto INT, REFERENCES KEY (fkProduto) REFERENCES Produto(idProduto), 

    PRIMARY KEY(fkVenda, fkProduto) 
);


INSERT INTO Cliente VALUES  
    (null, 'Ana Ramos', 'ana@gmail.com', 'Rua dos Sonhos', 'Dorminhos', '01222-123', 3, 'A', 'São Paulo', null),
    (null, 'Jefferson Silva', 'jeff@gmail.com', 'Rua da Pamonha', 'Milhões', '55588-123', 5, 'D', 'São Paulo', 1),
    (null, 'Vergueiro Filho', 'junior@gmail.com', 'Comendador Junior', 'Itaim Paulista', '78965-123', 16, 'E', 'São Paulo', null),
    (null, 'Gabriel Neto', 'netinho_gg@gmail.com', 'Rua dos Sonhos', 'Dorminhos', '01222-123', 785, 'A', 'São Paulo', 4);


INSERT INTO Produto VALUES 
    (null, 'Shampoo', 'Esse é top', 34.3), 
    (null, 'Pente', 'Deixa os cabelos lindos', 100), 
    (null, 'Camiseta', 'Com um V de vingança', 50.66), 
    (null, 'Sapato', 'Sapato do Mike', 890.79);

INSERT INTO Venda VALUES
    (null, 150.40, '10/10/2022', 1),   
    (null, 160.40, '10/09/2022', 1),   
    (null, 150.40, '02/10/2022', 2),   
    (null, 1050.00, '11/10/2022', 2),   
    (null, 50.40, '10/01/2022', 4),   
    (null, 150.40, '10/07/2022', 3);

INSERT INTO VendaProduto VALUES 
    (12, 12.4, 1,1),
    (4, 1, 1,1),
    (2, 58.99, 2,3),
    (5, 12.4, 2,2),
    (1, null, 4,2),
    (2, 0.66, 4,1);

SELECT * FROM Cliente;
SELECT * FROM Produto;
SELECT * FROM Venda;
SELECT * FROM VendaProduto;

SELECT Cliente.*, Venda.* FROM Cliente 
    JOIN VendaProduto ON idCliente = fkCliente 
    JOIN Venda ON idVenda = fkVenda; 

SELECT Cliente.*, Venda.* FROM Cliente 
    JOIN VendaProduto ON idCliente = fkCliente 
    JOIN Venda ON idVenda = fkVenda
    WHERE Cliente.nome LIKE 'Jefferson%'; 

SELECT * FROM Cliente c
    JOIN Cliente ind ON c.idCliente = ind.fkCliente; 

SELECT ind.*, c.nome 'Indicador'  FROM Cliente c
    JOIN Cliente ind ON c.idCliente = ind.fkCliente
    WHERE c.nome LIKE 'Ana Ramos'; 

SELECT  * FROM Cliente c 
    JOIN Cliente i ON c.idCliente = i.fkCliente 
    JOIN Venda v ON c.idCliente = v.fkCliente
    JOIN VendaProduto vp ON v.idVenda = vp.fkVenda 
    JOIN Produto p ON p.idProduto = vp.fkProduto; 


SELECT v.dataVenda, p.nome, vp.quantidadeProduto FROM Venda v
    JOIN VendaProduto vp ON v.idVenda = vp.fkVenda 
    JOIN Produto p ON p.idProduto = vp.fkProduto
    WHERE v.idVenda = 2; 


SELECT p.nome, p.preco, COUNT(vp.fkProduto) FROM Produto p
    JOIN VendaProduto vp ON p.idProduto = vp.fkProduto
    GROUP BY p.nome; 


INSERT INTO Cliente VALUES
    (null, 'Messias Neto', 'memeNeto@gmail.com', 'Comendador Junior', 'Itaim Paulista', '78965-123', 106, 'abc', 'São Paulo', 1); 

SELECT * FROM Cliente c 
    LEFT JOIN Venda v ON c.idCliente = v.fkCliente;

SELECT MAX(preco) 'Valor máximo' FROM Produto 
UNION 
SELECT MIN(preco) 'Valor minímo' FROM Produto;

SELECT AVG(preco) 'Média' FROM Produto; 

SELECT * FROM Produto 
    WHERE preco > (SELECT AVG(preco) FROM Produto); 

SELECT SUM(preco) FROM Produto; 

SELECT SUM(preco) FROM Produto p
    JOIN VendaProduto vp ON p.idProduto = vp.fkProduto
    JOIN Venda v ON v.idVenda = vp.fkVenda 
    WHERE v.idVenda = 1; 




