CREATE DATABASE bdDespesa; 

USE bdDespesa;

CREATE TABLE despesa (
 idDespesa INT PRIMARY KEY AUTO_INCREMENT,
 descricao VARCHAR(45), 
 categoria VARCHAR(45), CONSTRAINT chkCategoria CHECK (categoria IN ('Despesa Fixa', 'Despesa Variável'))
 dtVenc DATE,
 total FLOAT
); 

INSERT INTO despesa(descricao , categoria , dtVenc, total ) VALUES 
('Aluguel', 'Despesa Fixa', '2022-10-09', 1000.00),
('Alimentação', 'Despesa Variável', null, 290.00),
('Transporte', 'Despesa Fixa', '2022-09-01', 250.00),
('Telefone', 'Despesa Fixa', '2022-09-15', 59.90),
('Luz', 'Despesa Fixa', '2022-09-10', 107.00),
('Lazer', 'Despesa Variável', null, 100.00);

SELECT * FROM despesa; 

ALTER TABLE despesa ADD CONSTRAINT chkCategoria CHECK (categoria IN ('Despesa Fixa','Despesa Variável')); 

ALTER TABLE despesa MODIFY COLUMN total DOUBLE; 
ALTER TABLE despesa ADD COLUMN dtPagamento DATE; 