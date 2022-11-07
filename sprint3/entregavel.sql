
CREATE DATABASE entregavel; 

USE entregavel;

CREATE TABLE grupo (
	idGrupo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(45)
);

CREATE TABLE aluno (
	RA INT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45), CONSTRAINT chkEmail CHECK (email like '%@%'), 
    fkGrupo INT, FOREIGN KEY (fkGrupo) REFERENCES Grupo (idGrupo)
);

CREATE TABLE professor (
	idProfessor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    disciplina VARCHAR(45)
) AUTO_INCREMENT=1000;

CREATE TABLE avaliacao (
    fkProfessor INT,
    fkGrupo INT,
    dataHora DATETIME,
    nota DECIMAL(10,2),
	FOREIGN KEY (fkProfessor) REFERENCES professor (idProfessor),
    FOREIGN KEY (fkGrupo) REFERENCES grupo (idGrupo),
    PRIMARY KEY ( fkProfessor, fkGrupo)
);

DESC avaliacao;

INSERT INTO grupo (nome, descricao) VALUES
	('TermoLab', 'grupo sobre medicamento'),
	('DataTermo', 'grupo sobre temperatura de datacenter');
    
INSERT INTO aluno VALUES
	(1, 'Diego', 'diegoMarquies@sptech.school',2),
	(2, 'Lucas', 'lucasNobre@sptech.school',2),
	(3, 'Victor', 'vivi@sptech.school',1),
	(4, 'Igor', 'igor@sptech.school', 1);
    
INSERT INTO professor (nome, disciplina) VALUES 
	('Fernanda Caramico', 'Pesquisa e Inovação'),
	('Vivian', 'Banco de Dados'),
	('Monica', 'Tecnologia da Informação');
    
INSERT INTO avaliacao VALUES 
	(1000, 1, '2022-10-10 16:00:00', 8.90),
	(1001, 2, '2022-10-10 16:00:00', 7.50),
	(1002, 2, '2022-10-10 15:00:00', 9.50),
	(1000, 2, '2022-10-10 15:00:00', 2.50);
    
SELECT * FROM aluno;
SELECT * FROM grupo;
SELECT * FROM professor;
SELECT * FROM avaliacao;

-- 5. Exibir os dados dos grupos e de seus respectivos alunos
SELECT * FROM grupo 
	JOIN aluno ON fkGrupo = idGrupo;

-- 6. Exibir os dados de um determinado grupo e os dados de seus respectivos alunos
SELECT * FROM grupo 
	JOIN aluno ON fkGrupo = idGrupo 
    WHERE idGrupo = 1;

-- 7. Exibir a média das notas atribuidos aos grupos, no geral.
SELECT AVG(nota) 'Média Notas' FROM grupo 
	JOIN avaliacao ON fkGrupo = idGrupo;

-- 8. Exibir a nota mínima e a nota máxima que foi atribuída aos grupos, no geral.
SELECT MIN(nota) 'Nota Minima', MAX(nota) 'Nota Maxima' FROM grupo 
	JOIN avaliacao ON fkGrupo = idGrupo;

-- 9. Exibir a soma das notas dadas aos grupos, no geral.
SELECT SUM(nota) 'Soma das Notas' FROM grupo 
	JOIN avaliacao ON fkGrupo = idGrupo;

-- 10. Exibir os dados dos professores que avaliaram cada grupo, os dados
-- dos grupos, a data e o horario da avaliaçao
SELECT p.*, v.dataHora, g.* FROM professor as p 
	LEFT JOIN avaliacao as v ON fkProfessor = idProfessor 
	RIGHT JOIN grupo as g ON fkGrupo = idGrupo;

-- 11. Exibir os dados dos professores que avaliaram um determinado grupo,
-- os dados do grupo, a data e o horário da avaliaçao
SELECT p.*, v.dataHora, g.* FROM professor as p 
	LEFT JOIN avaliacao as v ON fkProfessor = idProfessor 
    RIGHT JOIN grupo as g ON fkGrupo = idGrupo 
    WHERE idGrupo = 2;

-- 12. Exibir os nomes dos grupos que foram avaliados por um determinado professor.
SELECT g.nome 'Nome dos Grupos', p.* FROM grupo as g 
	JOIN avaliacao ON fkGrupo = idGrupo 
    JOIN professor as p ON fkProfessor = idProfessor 
    WHERE idProfessor = 1000;

-- 13. Exibir os dados dos grupos, os dados dos alunos correspondentes, os dados
-- dos professores que avaliaram, a data e o horario da avaliaçao
SELECT g.*, al.*, p.*, av.dataHora FROM grupo as g 
	JOIN aluno as al ON al.fkGrupo = g.idGrupo
    JOIN avaliacao as av ON av.fkGrupo = g.idGrupo
    JOIN professor as p ON av.fkProfessor = p.idProfessor;
    
-- 14. Exibir a quantidade de notas distintas
SELECT COUNT(distinct nota) 'Soma das Notas' FROM grupo 
	JOIN avaliacao ON fkGrupo = idGrupo;
    
-- 15. Exibir a identificacao do professor (pode ser o fk ou o nome), a media
-- das notas e a soma das notas atribuidas, agrupadas por professor
SELECT p.idProfessor, AVG(nota) 'Média Nota', sum(nota) 'Soma Nota' FROM professor as p 
	JOIN avaliacao as av ON av.fkProfessor = p.idProfessor GROUP BY idProfessor;
    
-- 16. Exibir a identificaçao do grupo (pode ser o fk ou o nome), a média das
-- notas e a soma das notas atribuidas, agrupadas por grupo.
SELECT g.idGrupo, AVG(nota) 'Média Nota', sum(nota) 'Soma Nota' FROM grupo as g 
	JOIN avaliacao as av ON av.fkGrupo = g.idGrupo GROUP BY idGrupo;
    
-- 17. Exibir a identificaçao do professor (pode ser o fk ou o nome), a menor nota
-- e a maior nota atribuida, agrupada por professor.
SELECT p.idProfessor, MIN(nota) 'Menor Nota', MAX(nota) 'Maior Nota' FROM professor as p 
	JOIN avaliacao as av ON av.fkProfessor = p.idProfessor GROUP BY idProfessor;
    
-- 18. Exibir a identificaçao do grupo (pode ser o fk ou o nome), a menor nota
-- e a maior nota atribuida, agrupada por grupo.
SELECT g.idGrupo, MIN(nota) 'Menor Nota', MAX(nota) 'Maior Nota' FROM grupo as g 
	JOIN avaliacao as av ON av.fkGrupo = g.idGrupo GROUP BY idGrupo;
