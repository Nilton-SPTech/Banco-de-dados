

CREATE DATABASE Hotel;

USE Hotel; 


-- CRIANDO A TABELA DO HOTEL
CREATE TABLE hotel(
    idHotel INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(50),
    bairro VARCHAR(45), 
    cep CHAR(11), 
    logradouro VARCHAR(70), 
    complemento VARCHAR(4), 

    -- FAZENDO A FK DO MODO TRADICIONAL
    fkMatriz INT, FOREIGN KEY (fkMatriz) REFERENCES Hotel(idHotel)
);


-- FAZENDO A FK FORA DA TABELA
ALTER TABLE hotel ADD COLUMN fkMatriz INT;
ALTER TABLE hotel ADD FOREIGN KEY (fkMatriz) REFERENCES hotel(idHotel)


--CRIANDO A TABELA DOS QUARTOS

CREATE TABLE quarto(
    idQuarto INT,
    nome VARCHAR(50),
    andar INT, 
    tipo VARCHAR(20), CONSTRAINT chkTipo CHECK(tipo IN('Casal', 'Solteiro')),

    fkHotel INT, FOREIGN KEY fkHotel REFERENCES hotel(idHotel),

    PRIMARY KEY(idQuarto, fkHotel)
);

--FAZENDO A FK E A CONSTRAINT FORA DA TABELA
ALTER TABLE quarto ADD COLUMN tipo VARCHAR(20);
ALTER TABLE quarto ADD CONSTRAINT chkTipo CHECK(tipo IN('Casal', 'Solteiro')); 

ALTER TABLE quarto ADD COLUMN fkHotel INT; 
ALTER TABLE quarto ADD FOREIGN KEY (fkHotel) REFERENCES hotel(idHotel); 



INSERT INTO hotel VALUES
    (null, 'Hotel da esquina', 'xxxxx', 'xxxxx', 'xxxx', '00', null), 
    (null, 'Hotel da rua', 'xxxxxx','xxxxx','xxxxx','1ab',1),
    (null, 'Hotel da avenida', 'xxxxx','xxxxxx','xxxxx','180',2); 

    
