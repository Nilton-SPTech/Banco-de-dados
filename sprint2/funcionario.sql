CREATE TABLE sprint2; 

USE sprint2; 


CREATE TABLE Funcionario (
	idFunc INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
    sobrenome VARCHAR(45), 
    telefoneFixo CHAR(11), 
    telefoneCelulcar CHAR(11), 
    ddd CHAR(3), 
    prefixo CHAR(5), 
    sufixo CHAR(4)
);


INSERT INTO Funcionario(nome, sobrenome, telefoneFixo) VALUES 
	('Nilton', 'Gomes', '11-11111111');
    
INSERT INTO Funcionario(sobrenome, ddd,prefixo,sufixo) VALUES
	('Xuarsnega', '11', '12345','6789');

UPDATE Funcionario SET nome = 'Arnold'
    WHERE pkFunc = 2;    

SELECT * FROM Funcionario;


INSERT INTO Funcionario (nome) VALUES 
    ('Vivian');

SELECT CONCAT('Meu nome completo é ', IFNULL(nome, ''), 
    ' ', IFNULL(sobrenome, '')) 'Mensagem de olá' 
        FROM Funcionario;