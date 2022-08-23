-- Usando o banco 
USE faculdade1adsc; 

-- MOSTRAR AS TABELAS DO BANCO DE DADOS
SHOW TABLES; 

-- SELECIONANDO A TABELA EMPRESA
SELECT * FROM aluno;

-- CRIANDO TABELA CHAMADA PESSOA
CREATE TABLE pessoa (
    idPessoa INT PRIMARY KEY, 
    nome VARCHAR(50), 
    peso FLOAT,                 -- FLOAT PERMITE 8 DIGITOS 32bits
    altura DOUBLE,              -- DOUBLE PERMITE 16 DIGITOS 64bits,
    salario DECIMAL(10,2)       -- DECIMAL(10,2) PERMITE 28 DIGITOS 128bits
);

-- INSERINDO DADOS 
INSERT INTO pessoa VALUES 
    (1, 'Cebolinha', 87.9, 1.55, 1.99);
    
INSERT INTO pessoa VALUES 
    (null, 'Monica', 200, 1.35, 2.99);

INSERT INTO pessoa (nome, peso,altura,salario) VALUES ('Cascão', 1.58, 1.99, 2.00);

-- ACRESCENTANDO O AUTO_INCREMENT
ALTER TABLE pessoa MODIFY COLUMN idPessoa INT AUTO_INCREMENT; 

-- O AUTO_INCREMENT VAI DE 100 EM 100
ALTER TABLE pessoa AUTO_INCREMENT = 100; 

-- EXIBINDO UMA FRASE COM O CONTACT() => Concatenação
SELECT CONCAT('A pessoa ' ,nome, ', pesa ' ,peso, ', mede ' ,altura, ' e ganha ' ,salario, '!') as Frase FROM pessoa; 

-- EXIBINDO A FRASE MAS EM ORDEM CRESCENTE
SELECT CONCAT('A pessoa ' ,nome, ', pesa ' ,peso, ', mede ' ,altura, ' e ganha' ,salario, '!' ) AS 'Frase Ordenada Crescente' FROM pessoa ORDER BY nome;

-- TREINAMENTO 
SELECT CONCAT('A pessoa ' ,nome, ' pesa ' ,peso, 'kg') AS 'Peso usúario' FROM pessoa; 