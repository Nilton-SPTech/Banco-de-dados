CREATE DATABASE sprint2;

USE sprint2; 

-- ATIVIDADE 01

CREATE TABLE cliente(
    idCliente INT PRIMARY KEY AUTO_INCREMENT, 
    nomeCliente VARCHAR(45), 
    telefoneFixo VARCHAR(20),
    telefoneCelular VARCHAR(20),
    cep CHAR(9),
    logradouro VARCHAR(45),
    bairro VARCHAR(45)
);
ALTER TABLE cliente ADD COLUMN sobrenome VARCHAR(45);


CREATE TABLE pet(
    idPet INT AUTO_INCREMENT, 
    tipoPet VARCHAR(45),
    nomePet VARCHAR(45),
    racaPet VARCHAR(45),
    dataNasc DATE, 
    fkCliente INT, FOREIGN KEY (fkCliente) REFERENCES cliente(idCliente), 
    PRIMARY KEY(idPet, fkCliente)
)AUTO_INCREMENT = 100;


INSERT INTO cliente VALUES 
    (null, 'Ronaldo','Gaucho', '1712345678', '110987654', '08152-130', 'Rua Redonda','Campo Limpo' ),
    (null, 'Lucas', 'Alves','12902920399', '1112345665', '12345-120', 'Rua Quadrada','Campo Sujo' ),
    (null, 'Yuri', 'Carlos','876543290', '8022939122', '09876-098', 'Rua Triangular','Quadra Lisa' );

INSERT INTO pet VALUES
    (null, 'Cachorro', 'Bolinha', 'Cachorrão', '1999-10-20', 1),
    (null, 'Gato', 'Miau', 'Malhado', '2022-01-20', 2),
    (null, 'Piriquito', 'Blabla', 'Ave', '1970-11-25', 2),
    (null, 'Cachorro', 'Bolinha', 'Cachorrão', '1999-10-20', 1),
    (null, 'Gato', 'Bichano', 'Persia', '2018-04-11', 3);


SELECT * FROM cliente; 

SELECT * FROM pet;

ALTER TABLE cliente MODIFY COLUMN nomeCliente VARCHAR(70);

SELECT * FROM pet 
    WHERE tipoPet = 'Cachorro';


SELECT nomePet, dataNasc FROM pet;

SELECT * FROM pet 
    ORDER BY nomePet;

SELECT * FROM cliente
    ORDER BY bairro DESC;

SELECT * FROM pet
    WHERE nomePet LIKE 'b%';


SELECT * FROM cliente 
    WHERE sobrenome = 'Alves';

UPDATE cliente SET telefoneFixo = '0987654311', telefoneCelular = '71272878123'
    WHERE idCliente = 2;

SELECT * FROM cliente
    WHERE idCliente = 2;

SELECT * FROM cliente 
    JOIN pet 
        ON idCliente = fkCliente;


SELECT * FROM cliente
    JOIN pet 
        ON idCliente= fkCliente 
            WHERE idCliente = 1;

DELETE FROM pet 
    WHERE idPet = 1;

SELECT * FROM pet;

DROP TABLE pet; 
DROP TABLE cliente; 


----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ATIVIDADE 02 

CREATE DATABASE sprint2;

USE sprint2; 


CREATE TABLE pessoa (
    idPessoa INT PRIMARY KEY AUTO_INCREMENT, 
    nomePessoa VARCHAR(45), 
    dataNasc DATE, 
    profissao VARCHAR(45)
);

CREATE TABLE gasto(
    idGasto INT AUTO_INCREMENT, 
    dataGasto DATE, 
    valor FLOAT, 
    descricao VARCHAR(45), 
    fkPessoa INT, FOREIGN KEY (fkPessoa) REFERENCES pessoa(idPessoa), 
    PRIMARY KEY(idGasto,fkPessoa)
);


INSERT INTO pessoa VALUES 
    (null, 'Joseph', '1966-09-10', 'Militar'),
    (null, 'Hermelindo', '1999-12-19', 'Bombeiro'),
    (null, 'Rosalia', '2013-02-03', 'Professor'),
    (null, 'Vivian', '1985-10-17', 'Professor'),
    (null, 'Lucas', '1994-03-09', 'Programador'),
    (null, 'Nilton', '2003-09-30', 'Programador');


INSERT INTO gasto VALUES
    (null, '2022-09-01', 180.90, 'Compra de uma bermuda', 1),
    (null, '2020-01-01', 3800.00, 'Rolê começo do ano', 2),
    (null, '2021-03-21', 10.10, 'Compra de bebidas', 3),
    (null, '2019-09-01', 100.00, 'Comprade uma blusa', 4),
    (null, '2022-08-02', 80.80, 'Compra de um café', 5),
    (null, '2022-09-13', 1000.00, 'Compra de um notebook', 6);


SELECT * FROM pessoa 
    WHERE dataNasc > '1999-01-01';

SELECT * FROM gasto 
    WHERE valor <= 100.00;

SELECT * FROM pessoa 
    JOIN gasto 
        ON idPessoa = fkPessoa; 

SELECT * FROM pessoa 
    JOIN gasto 
        ON idPessoa = fkPessoa
            WHERE nomePessoa = 'Nilton'; 


UPDATE pessoa SET profissao = 'Dentista'
    WHERE idPessoa = 1 OR idPessoa = 5;

DELETE FROM gasto 
    WHERE idGasto IN (2,4);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- ATIVIDADE 03
CREATE DATABASE praticaFuncionario;

USE praticaFuncionario;


CREATE TABLE setor(
	idSetor INT PRIMARY KEY AUTO_INCREMENT, 
    nomeSetor VARCHAR(45), 
    andarSetor VARCHAR(2)
);

CREATE TABLE funcionario(
	idFuncionario INT PRIMARY KEY AUTO_INCREMENT, 
    nomeFunc VARCHAR (45), 
    telefoneCelular VARCHAR(20),
    salario FLOAT, CONSTRAINT chkSalario CHECK(salario > 0), 
    fkSetor INT, FOREIGN KEY (fkSetor) REFERENCES setor(idSetor)
);

CREATE TABLE acompanhante (
	idAcompanhante INT AUTO_INCREMENT, 
    nomeAcomp VARCHAR (45), 
    parentescoAcomp VARCHAR(45),
    dataNasc DATE, 
    fkFuncionario INT, FOREIGN KEY (fkFuncionario) REFERENCES funcionario (idFuncionario), 
    PRIMARY KEY(idAcompanhante, fkFuncionario)
);

INSERT INTO setor VALUES
	(null, 'RH', '2'), 
    (null, 'TI', '8'),
    (null, 'Contabilidade', '3');
    
INSERT INTO funcionario VALUES 
	(null, 'Trinity', '12345676455', 1.99, 1),
    (null, 'Jaime', '88329189', 2.31, 1),
    (null, 'Morale Ramos', '8377737123', 8.01, 2), 
    (null, 'Edimilson', '838212532', 10.11, 3), 
    (null, 'Erick', '5454884878', 2.20, 3), 
    (null, 'Fernanda', '554121362', 5.50, 2);
    
INSERT INTO acompanhante VALUES 
	(null, 'Gabriel', 'marido', '2000-10-20',1),
    (null, 'Evandro', 'filho', '2010-01-09',3), 
    (null, 'Luisa', 'irmã', '1996-12-30', 2), 
    (null, 'João', 'pai', '1978-03-21',4), 
    (null, 'Kevenlin', 'mãe', '1981-10-23',5), 
    (null, 'Vanessa', 'irmã', '2007-01-30', 1);
    
SELECT * FROM setor;
SELECT * FROM funcionario;
SELECT * FROM acompanhante;

SELECT * FROM setor
	JOIN funcionario on idSetor = fkSetor;
    
SELECT * FROM setor 
	JOIN funcionario ON idSetor = fkSetor
		WHERE nomeSetor = 'RH';
        
SELECT * FROM funcionario 
	JOIN acompanhante ON idFuncionario = fkFuncionario;
    
SELECT * FROM funcionario 
	JOIN setor ON idSetor = fkSetor
		JOIN acompanhante ON idFuncionario = fkFuncionario;
        
---------------------------------------------------------------------------------------------------------------------


-- ATIVIDADE 04

CREATE DATABASE Treinador;
USE Treinador;

CREATE TABLE treinador (
	idTreinador INT PRIMARY KEY AUTO_INCREMENT, 
    nomeTreinador VARCHAR(45), 
    telefoneTreinador VARCHAR(20), 
    emailTreinador VARCHAR(50), 
    fkTreinadorEx INT, FOREIGN KEY (fkTreinadorEx) REFERENCES treinador(idTreinador)
)AUTO_INCREMENT = 10; 

CREATE TABLE nadador (
	idNadador INT AUTO_INCREMENT, 
    nomeNadador VARCHAR(45), 
    estadoOrigem VARCHAR(40),
    dataNasc DATE, 
    fkTreinador INT, FOREIGN KEY (fkTreinador) REFERENCES treinador (idTreinador),
    PRIMARY KEY (idNadador, fkTreinador)
)AUTO_INCREMENT = 100;


INSERT INTO treinador VALUES 
	(null, 'Dara', '75361561253', 'da_ra@gmail.com', null) /*10*/;

INSERT INTO treinador VALUES
	(null, 'Gerson', '2342348923', 'gersinho@hotmail.com', 10), 
    (null, 'Jeremias', '983498223', 'jeje@gmail.com', 10);
    
INSERT INTO nadador VALUES 
	(null, 'Ermelindo', 'São Paulo', '1990-10-20',10),
    (null, 'James Bond', 'Minas Gerais', '1998-02-23',10),
    (null, 'Garcia Jr.', 'São Paulo', '1999-09-12',11),
    (null, 'Juliana Bond', 'Minas Gerais', '2001-04-12',11),
    (null, 'Mariana', 'Bahia', '2003-09-30', 12),
    (null, 'Trinity', 'Santa Catarina', '2004-01-01', 12);


SELECT * FROM treinador;
SELECT * FROM nadador;

SELECT * FROM treinador 
	JOIN nadador ON idTreinador = fkTreinador;
    
SELECT * FROM treinador 
	JOIN nadador ON idTreinador = fkTreinador 
		WHERE nomeTreinador = 'Dara';
        
SELECT * FROM treinador orientador
	JOIN treinador orientado ON orientador.idTreinador = orientado.fkTreinadorEx;

SELECT * FROM treinador orientador 
	JOIN treinador orientado ON orientador.idTreinador = orientado.fkTreinadorEx
		WHERE orientador.nomeTreinador LIKE 'Dara';
        
SELECT * FROM treinador ex 
	JOIN treinador nEx ON ex.idTreinador = nEx.fkTreinadorEx
		JOIN nadador ON ex.idTreinador = nadador.fkTreinador;
        
SELECT * FROM treinador nEx 
	JOIN treinador ex ON ex.idTreinador = nEx.fkTreinadorEx
		JOIN nadador ON nEx.idTreinador = nadador.fkTreinador
			WHERE nEx.nomeTreinador LIKE 'Gerson';
