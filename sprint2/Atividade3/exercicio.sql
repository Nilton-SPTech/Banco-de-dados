CREATE TABLE sprint2; 

USE sprint2; 

CREATE TABLE projeto (
    idProjeto INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
    descricao VARCHAR(100)
);

CREATE TABLE aluno (
    ra CHAR(8) PRIMARY KEY,
    nome VARCHAR(45), 
    telefone VARCHAR(12), 

    fkProjeto INT, FOREIGN KEY (fkProjeto) REFERENCES projeto(idProjeto), 
    fkRepresentante CHAR(8), FOREIGN KEY (fkRepresentante) REFERENCES aluno(ra) 
); 


CREATE TABLE acompanhante (
    idAcompanhante INT AUTO_INCREMENT, 
    nome VARCHAR(45), 
    parentesco VARCHAR(45), 
    fkAluno CHAR(8), FOREIGN KEY (fkAluno) REFERENCES aluno(ra),
    PRIMARY KEY (idAcompanhante, fkAluno)
);


INSERT INTO projeto VALUES 
    (null, 'Controle de soja', 'Um sistema web que controla a soja'), 
    (null, 'Controle e manutenção de notebook', 'Sistema que auxilia os tecnicos na manutenção dos aparelhos');

INSERT INTO aluno VALUES    
    ('01222078', 'Nilton', '1234567-8901', 1, null),
    ('01000999', 'Lucas', '890123-49832', 1, '01222078'), 
    ('04999221','Matheus','234152-09832',2,null), 
    ('03882903','Livia','256783-09123',2,'04999221');

INSERT INTO acompanhante  VALUES 
    (null, 'Vivian', 'mãe','01000999'), 
    (null,'Caio','filho','04999221'),
    (null, 'Josias','pai','03882903'),
    (null,'Evandro','irmão','03882903');

SELECT * FROM projeto;
SELECT * FROM aluno; 
SELECT * FROM acompanhante;


-- Exibir os dados dos alunos e dos projetos correspondentes.
SELECT * FROM projeto 
 JOIN aluno ON idProjeto = fkProjeto;


-- Exibir os dados dos alunos e dos seus acompanhantes.
SELECT * FROM aluno 
 JOIN acompanhante ON ra = fkAluno;

-- Exibir os dados dos alunos e dos seus representantes.
SELECT * FROM aluno r
 JOIN aluno a ON r.ra = a.fkRepresentante; 

-- Exibir os dados dos alunos e dos projetos correspondentes, mas somente
-- de um determinado projeto (indicar o nome do projeto na consulta).
SELECT * FROM aluno a
 JOIN projeto p ON p.idProjeto = a.fkProjeto
  WHERE a.nome = 'Nilton';

-- Exibir os dados dos alunos, dos projetos correspondentes e dos seus acompanhantes.
SELECT * FROM aluno a
 JOIN projeto p ON p.idProjeto = a.fkProjeto
  JOIN acompanhante ac ON a.ra = ac.fkAluno;


---------------------------------------------------------------------------------------------------------

-- EXERCICIO 02

CREATE DATABASE campanha; 
USE campanha;

CREATE TABLE organizador(
    idOrganizador INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(45), 
    rua VARCHAR(45),
    bairro VARCHAR(45), 
    email VARCHAR(55), 
    fkOrientador INT, FOREIGN KEY (fkOrientador) REFERENCES organizador(idOrganizador) 
) AUTO_INCREMENT = 30;

CREATE TABLE campanha(
    idCampanha INT PRIMARY KEY AUTO_INCREMENT, 
    categoriaDoacao VARCHAR(45), 
    dataFinal DATE, 
    primeiraInstituicao VARCHAR(45), 
    segundaInstituicao VARCHAR(45), 
    fkOrganizador INT, FOREIGN KEY (fkOrganizador) REFERENCES organizador(idOrganizador)
) AUTO_INCREMENT = 500;


-- d) Inserir dados nas tabelas, de forma que exista mais de uma campanha para
-- algum organizador, e mais de um organizador novato sendo orientado por algum
-- organizador mais experiente

INSERT INTO organizador VALUES
    (null, 'Vivian', 'Rua do banco', 'Jardim Dados', 'ilove_bd@gmail.com', null);

INSERT INTO organizador VALUES
    (null, 'Lucas', 'Rua abc', 'Itaquera', 'luquinha@hotmail.com',30), 
    (null, 'Evandro', 'Av. Abidigal', 'Jardim Abdigal', 'vanvan@gmail.com', 30), 
    (null, 'Domingues', 'Av. Paulista', 'Bairro de São Paulo', 'feriado@gmail.com', null); 

INSERT INTO campanha VALUES
    (null, 'alimento', '2022-12-01','Bradesco','SPTech',30), 
    (null, 'produto higiene','2024-10-20','SPTech', null, 31), 
    (null, 'roupas de frio', '2029-08-08', 'ETEC', 'FATEC', 32);

--e) Exibir todos os dados de cada tabela criada, separadamente.
SELECT * FROM campanha; 
SELECT * FROM organizador; 

--g) Exibir os dados dos organizadores e os dados de suas respectivas campanhas.
SELECT * FROM organizador
 JOIN campanha ON idOrganizador = fkOrganizador;  

--h) Exibir os dados de um determinado organizador (informar o nome do
-- organizador na consulta) e os dados de suas respectivas campanhas.
SELECT * FROM organizador o
 JOIN campanha ON idOrganizador = fkOrganizador
  WHERE o.nome = 'Evandro';

--i) Exibir os dados dos organizadores novatos e os dados dos respectivos
-- organizadores orientadores.
SELECT * FROM organizador n
 JOIN organizador o ON o.idOrganizador = n.fkOrientador;



-- j) Exibir os dados dos organizadores novatos e os dados dos respectivos
-- organizadores orientadores, porém somente de um determinado organizador
-- orientador (informar o nome do organizador orientador na consulta).
SELECT * FROM organizador n 
 JOIN organizador o ON o.idOrganizador = n.fkOrientador
    WHERE n.nome = 'Lucas';


--l) Exibir os dados dos organizadores novatos, os dados das respectivas
-- campanhas organizadas e os dados dos respectivos organizadores orientadores.
SELECT * FROM organizador n
 JOIN organizador o ON o.idOrganizador = n.fkOrientador
  JOIN campanha c ON n.idOrganizador = c.fkOrganizador;


-- m)
SELECT * FROM organizador n 
 JOIN organizador o ON o.idOrganizador = n.fkOrientador
  JOIN campanha c ON n.idOrganizador = c.fkOrganizador
   WHERE n.nome = 'Evandro';
