
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

        
	
