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

