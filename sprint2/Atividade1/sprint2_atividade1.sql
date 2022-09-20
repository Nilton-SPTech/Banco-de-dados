CREATE DATABASE sprint2;

USE sprint2; 

CREATE TABLE Atleta (
    idAtleta INT PRIMARY KEY AUTO_INCREMENT, 
    nomeAtleta VARCHAR(40), 
    qntMedalhas INT
);

INSERT INTO atleta(nomeAtleta, qntMedalhas) VALUES
    ('Neymar', 300), 
    ('Willian', 10), 
    ('Serginho', 90), 
    ('Lucareli', 102), 
    ('José Bolt', 42);



CREATE TABLE pais (
    idPais INT PRIMARY KEY AUTO_INCREMENT, 
    nomePais VARCHAR(30), 
    capital VARCHAR(40)
);

INSERT INTO pais(nomePais, capital) VALUES 
    ('Brasil', 'Brasilia'), 
    ('Estados Unidos', 'Nova York'), 
    ('Alemanha', 'Berlim'), 
    ('Rússia', 'Moscou');

-- INSERINDO A CHAVE ESTRANGEIRA 
ALTER TABLE atleta ADD COLUMN fk_idPais INT; 

-- ADICIONANDO A CONSTRAINT FOREIGN KEY
ALTER TABLE atleta ADD FOREIGN KEY (fk_idPais) 
    REFERENCES pais(idPais);


UPDATE atleta SET fk_idPais = 1 
    WHERE idAtleta IN (1,3); 

UPDATE atleta SET fk_idPais = 2 
    WHERE idAtleta = 2; 

UPDATE atleta SET fk_idPais = 3
    WHERE idAtleta = 4; 

UPDATE atleta SET fk_idPais = 4
    WHERE idAtleta = 5;



-- EXIBINDO APENAS OS NOMES DOS ATLETAS AO LADO DOS NOMES DO PAÍS
SELECT a.nomeAtleta 'Atleta', p.nomePais 'País' FROM atleta as a
    JOIN pais as p ON p.idPais = a.fk_idPais;


SELECT nomeAtleta, nomePais FROM atleta as a
    JOIN pais as p ON p.idPais = a.fk_idPais
        WHERE capital = 'Moscou';


DROP DATABASE sprint2;