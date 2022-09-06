 USE sprint2; 

-- ATIVIDADE 01

 CREATE TABLE Professor (
    idProfessor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    especialidade1 VARCHAR(40),
    especialidade2 VARCHAR(40)
 );

 INSERT INTO Professor(nome, sobrenome, especialidade1, especialidade2) VALUES
    ('Vivan', 'Silva', 'Banco de Dados', 'Inglês'), 
    ('Lucas', 'Lima', 'Algoritmo', 'Matemática'), 
    ('Emilio', 'Chaves', 'Inglês', 'Geografia'),
    ('Thiago', 'Santos', 'Socioemocional', 'Gestão empresarial'),
    ('Emilia', 'Sanches', 'Português', 'Inglês'), 
    ('José', 'Roberto', 'Administração', 'Francês'); 


CREATE TABLE Disciplina (
    idDisc INT PRIMARY KEY AUTO_INCREMENT, 
    nomeDisc VARCHAR(45)
);

INSERT INTO Disciplina(nomeDisc) VALUES 
    ('Matemática'), 
    ('Português'), 
    ('Algoritmo');

ALTER TABLE Disciplina ADD COLUMN fk_idProfessor INT;

ALTER TABLE Disciplina ADD FOREIGN KEY (fk_idProfessor)
    REFERENCES Professor(idProfessor);

UPDATE Disciplina SET fk_idProfessor = 1
    WHERE idDisc = 2;

UPDATE Disciplina SET fk_idProfessor = 2
    WHERE idDisc = 3;

UPDATE Disciplina SET fk_idProfessor = 6
    WHERE idDisc = 1;

SELECT nome, nomeDisc FROM Disciplina
    JOIN Professor ON idProfessor = fk_idProfessor;

SELECT nome, nomeDisc FROM Disciplina
    JOIN Professor ON idProfessor = fk_idProfessor
        WHERE sobrenome = 'Roberto';

SELECT especialidade1, nomeDisc FROM Disciplina
    JOIN Professor ON idProfessor = fk_idProfessor
        WHERE nome LIKE 'José'
            ORDER BY especialidade1;


---------------------------------------------------------------------------

-- ATIVIDADE 02

USE sprint2; 

CREATE TABLE Curso(
    idCurso INT PRIMARY KEY AUTO_INCREMENT, 
    nomeCurso VARCHAR(50),
    sigla CHAR(3),
    coordenador VARCHAR(50)
); 

INSERT INTO Curso(nomeCurso, sigla,coordenador) VALUES 
    ('Algoritmo', 'ab1', 'Yoshi'), 
    ('Banco de dados', 'ab2', 'Vivian'), 
    ('Tecnologia da Informação', 'ab1', 'Monica');



CREATE TABLE Aluno (
    idAluno INT PRIMARY KEY AUTO_INCREMENT, 
    nomeAluno VARCHAR(50), 
    dataNasc DATETIME, 
    fk_idCurso INT, FOREIGN KEY (fk_idCurso) REFERENCES Curso(idCurso)
);

INSERT INTO Aluno(nomeAluno, dataNasc, fk_idCurso) VALUES 
    ('João', '1900-10-20', 1),
    ('Claudia', '2000-11-22', 2),
    ('Lucas', '2009-09-02', 3),
    ('José', '2010-02-10', 2),
    ('Matheus', '2011-04-16', 1);

SELECT nomeAluno, nomeCurso, sigla FROM Aluno 
    JOIN Curso ON idCurso = fk_idCurso;

SELECT nomeAluno, nomeCurso, sigla FROM Aluno 
    JOIN Curso ON idCurso = fk_idCurso
        WHERE nomeAluno LIKE 'J%';

ALTER TABLE Curso ADD CONSTRAINT chkSigla CHECK(sigla IN ('ab1', 'ab2', 'ab3'));