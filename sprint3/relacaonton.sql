CREATE TABLE relacaonton; 
USE relacaonton;


CREATE TABLE Pessoa(
  idPessoa INT PRIMARY KEY AUTO_INCREMENT, 
  nome VARCHAR(45), 
  salario DECIMAL(10,2)
);

CREATE TABLE Endereco(
  idEndereco INT PRIMARY KEY AUTO_INCREMENT, 
  cep CHAR(9), 
  bairro VARCHAR(45),
  cidade VARCHAR(45)
);

CREATE TABLE EnderecoCompleto(
  numero INT, 
  complemento VARCHAR(45), 
  fkPessoa INT, FOREIGN KEY (fkPessoa) REFERENCES Pessoa(idPessoa), 
  fkEndereco INT, FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco),
  PRIMARY KEY(fkPessoa, fkEndereco)
);


INSERT INTO Pessoa VALUES 
    (null, 'Vivian', 1.99), 
    (null, 'Paulo', 1.59), 
    (null, 'Nison', 0.09);

INSERT INTO Endereco VALUES 
    (null, '00000-100', 'Cerqueira Cesar', 'São Paulo'),
    (null, '10049-160', 'Sacomã', 'São Paulo'),
    (null, '12345-100', 'Centro', 'São Paulo');


SELECT * FROM Pessoa; 
SELECT * FROM Endereco; 


INSERT INTO EnderecoCompleto VALUES
    (1500, 'apto 100',1,1),
    (595, '10 andar',2,2),
    (595, '6 andar',3,3);

SELECT  Pessoa.nome as Nome,
        Endereco.bairro as Bairro
    FROM Pessoa
    JOIN EnderecoCompleto ON idPessoa = fkPessoa 
    JOIN Endereco ON idEndereco = fkEndereco; 


SELECT * FROM Pessoa 
    RIGHT JOIN EnderecoCompleto ON idPessoa = fkPessoa 
    RIGHT JOIN Endereco ON idEndereco = fkEndereco; 


SELECT nome, bairro, cidade FROM Pessoa 
    LEFT JOIN EnderecoCompleto ON idPessoa = fkPessoa 
    LEFT JOIN Endereco ON idEndereco = fkEndereco
    WHERE fkEndereco IS NULL
UNION
SELECT nome, bairro, cidade FROM Pessoa 
    RIGHT JOIN EnderecoCompleto ON idPessoa = fkPessoa 
    RIGHT JOIN Endereco ON idEndereco = fkEndereco
    WHERE fkPessoa IS NULL; 


-- FUNÇOES MATEMÁTICAS 
-- QUANTIDADE DE REGISTROS NA TABELA PESSOA
-- COUNT()

SELECT COUNT(*) as 'Quantidade de registros' FROM Pessoa; 

INSERT INTO pessoa VALUES
    (null, 'Nathan', 1.99);

SELECT COUNT(salario) 'Quantidade de salários' FROM Pessoa;


-- LIMIT 
SELECT nome FROM Pessoa
    WHERE salario > 1.00
    LIMIT 3,2;

-- SQL Server - SE UTILIZA O TOP NO LUGAR DO LIMIT E ELE FICA NO TOPO 

-- MOSTRANDO O MENOR VALOR E O MAIOR VALOR
SELECT MAX(salario) 'Maior salário', 
       MIN(salario) 'Menor salário'
    FROM Pessoa; 

-- SUM / SOMA 
SELECT SUM(salario) FROM Pessoa; 


-- AVG / MEDIA 
SELECT AVG(salario) FROM Pessoa; 

--ROUND / ARRENDONDAR 
-- ROUND( *valor que queremos arredondar*, *casas decimais*)
SELECT ROUND(AVG(salario), 2) FROM Pessoa;  

--TRUNCATE()
SELECT TRUNCATE(AVG(salario), 2) FROM Pessoa; 

--DISTINCT
-- TRAZ APENAS OS SALÁRIOS DIFERENTES, ELES NÃO REPETEM OS MESMOS VALORES
SELECT AVG(DISTINCT salario) FROM Pessoa;


--GROUP BY - Ele agrupa os resultados dos operadores matematicos com os campos do campo de dados 
SELECT bairro, TRUNCATE(AVG(salario), 2) FROM Pessoa 
    JOIN EnderecoCompleto ON idPessoa = fkPessoa 
    JOIN Endereco ON idEndereco = fkEndereco
    GROUP BY bairro;  


-- SELECT DENTRO DO WHERE - Ele funciona para selecionar os valores de um operador metamático
SELECT nome, salario FROM Pessoa 
    WHERE salario = (SELECT MIN(salario) FROM Pessoa)
UNION
SELECT nome, salario FROM Pessoa
    WHERE salario = (SELECT MAX(salario) FROM Pessoa);