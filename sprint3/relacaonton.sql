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
