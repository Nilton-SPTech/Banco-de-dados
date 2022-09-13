CREATE DATABASE sprint2; 

USE sprint2; 

CREATE TABLE Funcionario(
    idFunc INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
    salario DECIMAL(3,2)  --(total_caractere , qnt_depois_virgula)
);

-- ESSA É UMA ENTIDADE FRACA
CREATE TABLE Dependente(
    idDep INT AUTO_INCREMENT,
    nome VARCHAR(45),
    parentesco VARCHAR(45), 

    fkFunc INT, FOREIGN KEY (fkFunc) REFERENCES Funcionario (idFunc), -- CHAVE ESTRANGEIRA

    PRIMARY KEY (idDep, fkFunc) -- CHAVE PRIMÁRIA COM DOIS CAMPOS O ID E A FK, PQ ELA DEPENTE
)AUTO_INCREMENT= 100; 


-- INSERINDO DADOS
INSERT INTO Funcionario VALUES 
    (null, 'Paulo', 0.99), 
    (null, 'Vivian', 0.99);


INSERT INTO Dependente VALUES
    (null, 'Paula','irmã',1),
    (null,'Rafaela', 'irmã',2),
    (null, 'Paulão', 'pai',1);


SELECT  f.nome 'Funcionario', d.nome 'Dependente' FROM Funcionario as f
    JOIN Dependente as d
        ON f.idFunc = d.fkFunc; 

SELECT CONCAT('O funcionario ', f.nome, ' tem como dependente o(a)', d.nome) as 'Pessoas que dependem do funcionario' FROM Funcionario as f
    JOIN Dependente as d
        ON f.idFunc = d.fkFunc; 





------------------------------------------------------------------------------------------------------------------------------------------------------------------

--PERMISSÕES DCL (Data Control Language)

-- CRIANDO O USUARIO PARA TER ACESSO
CREATE USER 'estagiario'@'localhost' IDENTIFIED BY
    'SPTECH';

-- DANDO PRIVILÉGIOS PARA TODAS AS TABELAS  - pt2.1
GRANT ALL privileges ON faculdade1adsc.*
    TO 'estagiario'@'localhost';

--DANDO ALGUNS PRIVILÉGIOS NAS TABELAS, ELE NÃO PODE FAZER TUDO  - pt2.2
GRANT SELECT,UPDATE,DELETE,CREATE ON
    faculdade1adsc.*
    TO 'estagiario'@'localhost';

-- DANDO CERTEZA PARA EMPREGAR AS PERMISSÕES
FLUSH privileges; 

