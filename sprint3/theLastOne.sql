CREATE DATABASE IF NOT EXISTS thelastone;

USE thelastone;

-- criando a tabela Empresa
CREATE TABLE IF NOT EXISTS Empresa (
  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  nomeFantasia VARCHAR(45) NULL,
  cnpj CHAR(14) NOT NULL UNIQUE
  );
  
  -- criando a tabela funcionario
  CREATE TABLE IF NOT EXISTS Funcionario (
  idFuncionario INT AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  cpf CHAR(11) NOT NULL UNIQUE,
  email VARCHAR(45) NOT NULL,
  senha VARCHAR(100) NOT NULL,
  fkEmpresa INT NOT NULL,
  PRIMARY KEY (idFuncionario, fkEmpresa),
  CONSTRAINT fk_Funcionario_Empresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa (idEmpresa)
)AUTO_INCREMENT = 1000;

-- criando a tabela dispositivo
CREATE TABLE IF NOT EXISTS Dispositivo (
  idDispositivo INT PRIMARY KEY AUTO_INCREMENT,
  tipo VARCHAR(45) NOT NULL,
  CONSTRAINT chkTipo CHECK (tipo IN ('Input','Output')),
  descricao VARCHAR(100) NULL,
  status VARCHAR(45) NOT NULL,
  CONSTRAINT chkStatus CHECK (status IN ('Ativo', 'Inativo','Manutenção'))
  )AUTO_INCREMENT = 100;
  
  -- criando a tabela associativa Log de Acesso
  CREATE TABLE IF NOT EXISTS Log_Acesso (
  idLog INT NOT NULL AUTO_INCREMENT,
  fkDispositivo INT NOT NULL,
  fkFuncionario INT NOT NULL,
  fkEmpresaFunc INT NOT NULL,
  dtLog DATETIME NOT NULL DEFAULT current_timestamp,
  log VARCHAR(45) NOT NULL DEFAULT 'Entrou no sistema' ,
  PRIMARY KEY (idLog, fkDispositivo, fkFuncionario, fkEmpresaFunc),
  FOREIGN KEY (fkDispositivo) REFERENCES Dispositivo (idDispositivo),
  FOREIGN KEY (fkFuncionario, fkEmpresaFunc) 
	REFERENCES Funcionario (idFuncionario, fkEmpresa)
);

-- criando índice para melhorar a consulta sql da tabela fraca
CREATE INDEX idxTbFracaFunc ON funcionario(idFuncionario,fkEmpresa);

-- criando índice para melhorar a consulta da tabela associativa
CREATE INDEX idxAssLog ON log_acesso
	(idLog, fkDispositivo, fkFuncionario, fkEmpresaFunc);

SELECT 
empresa.cnpj CNPJ,
funcionario.cpf CPF,
dispositivo.status Dispositivo,
log_acesso.dtLog DataAcesso
 FROM empresa
	JOIN funcionario 
		ON empresa.idEmpresa = funcionario.fkEmpresa
	JOIN log_acesso
		ON funcionario.idFuncionario = log_acesso.fkFuncionario 
        AND funcionario.fkEmpresa = log_acesso.fkEmpresaFunc
	JOIN dispositivo
		ON log_acesso.fkDispositivo = dispositivo.idDispositivo;

DESC empresa;
DESC funcionario;
DESC dispositivo;
DESC log_acesso;

INSERT INTO empresa (nome, nomeFantasia, cnpj) VALUES 
	('Educare', 'SPTech', '12345678900122');

SELECT * FROM empresa;

INSERT INTO funcionario VALUES 
	(null, 'Vivian', '12345678900', 
		'vivian.silva@sptech.school', sha2('1234', 256),1);
        
INSERT INTO funcionario VALUES 
	(NULL, 'Matheus', '98765432100', 'matheus@gmail.com',
		sha2('1234',256),1);

SELECT * FROM funcionario;

INSERT INTO dispositivo VALUES (null, 'Input', 'Memória 8GB', 'Ativo');

SELECT * FROM dispositivo;

INSERT INTO log_acesso (fkDispositivo, fkFuncionario, fkEmpresaFunc, log) VALUES 
	(100, 1000, 1, 'Memória 6GB');
    
SELECT * FROM log_acesso;

SELECT 
empresa.cnpj CNPJ,
funcionario.cpf CPF,
dispositivo.status Dispositivo,
log_acesso.dtLog DataAcesso,
funcionario.senha Senha
 FROM empresa
	JOIN funcionario 
		ON empresa.idEmpresa = funcionario.fkEmpresa
	JOIN log_acesso
		ON funcionario.idFuncionario = log_acesso.fkFuncionario 
        AND funcionario.fkEmpresa = log_acesso.fkEmpresaFunc
	JOIN dispositivo
		ON log_acesso.fkDispositivo = dispositivo.idDispositivo;
        
-- FUNCTION (minha primeira função validando se o login e senha estão corretos)
DELIMITER $  
 DROP FUNCTION IF EXISTS fun_valida_usuario;
 CREATE FUNCTION fun_valida_usuario
	(p_login VARCHAR(45), p_senha VARCHAR(100) ) 
RETURNS INT(1)  
DETERMINISTIC
 BEGIN  
 DECLARE l_ret INT(1) DEFAULT 0;  
     SET l_ret = IFNULL((SELECT DISTINCT 1 FROM funcionario WHERE email = p_login  
                       AND senha = SHA2(p_senha,256)),0);                           
 RETURN l_ret;  
 END$  
 DELIMITER ;  
 
  SELECT fun_valida_usuario('vivian.silva@sptech.school','1234') as Validou;
  SELECT fun_valida_usuario('vivian.silva@sptech.school','5678') as Validou;
  SELECT fun_valida_usuario('vivian@sptech.school','1234') as Validou;
  
  -- para ficar bonito...
  SELECT CASE 
	WHEN fun_valida_usuario('vivian.silva@sptech.school','1234') = 1 
    THEN 'Login realizado com sucesso'
    ELSE 'Login ou senha incorreta' END Validação;
    
 SELECT CASE 
	WHEN fun_valida_usuario('vivian.silva@sptech.school','5678') = 1 THEN 
    'Login realizado com sucesso'
    ELSE 'Login ou senha incorreta' END Validação;
    
-- Minha primeira VIEW
CREATE VIEW VW_Select_Maroto AS 
SELECT 
empresa.cnpj CNPJ,
funcionario.cpf CPF,
dispositivo.status Dispositivo,
log_acesso.dtLog DataAcesso,
funcionario.senha Senha
 FROM empresa
	JOIN funcionario 
		ON empresa.idEmpresa = funcionario.fkEmpresa
	JOIN log_acesso
		ON funcionario.idFuncionario = log_acesso.fkFuncionario 
        AND funcionario.fkEmpresa = log_acesso.fkEmpresaFunc
	JOIN dispositivo
		ON log_acesso.fkDispositivo = dispositivo.idDispositivo;
        
-- Chamando a VIEW
SELECT * FROM VW_Select_Maroto;

-- TRIGGER (criando meu primeiro gatilho)
CREATE TABLE log_auditoria_func (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idFunc INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    dt_alteracao DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER TG_before_update_func 
    BEFORE UPDATE ON funcionario
    FOR EACH ROW 
 INSERT INTO log_auditoria_func
 SET action = 'update',
     idFunc = OLD.idFuncionario,
     nome = OLD.nome,
     dt_alteracao = NOW();
     
SELECT * FROM funcionario;
SELECT * FROM log_auditoria_func;
UPDATE funcionario SET nome = 'Vivian Silva' WHERE idFuncionario = 1000;

select * from log_auditoria_func;

UPDATE funcionario SET nome = 'Prof Vivian' WHERE idFuncionario = 1000;

-- PROCEDURE (meu primeiro processo/método)
DELIMITER $$
CREATE PROCEDURE SP_GetAllFuncionarios()
BEGIN
	DECLARE vNrError INT;    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET vNrError = 1;

	SET vNrError = 0;

	SELECT * FROM funcionario;
    
END$$
DELIMITER ;

/*
CALL SP_GetAllFuncionarios();
*/

DELIMITER $$
CREATE PROCEDURE SP_GetAllAcessos()
BEGIN
	DECLARE vNrError INT;    
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET vNrError = 1;

	SET vNrError = 0;

	SELECT 
empresa.cnpj CNPJ,
funcionario.cpf CPF,
dispositivo.status Dispositivo,
log_acesso.dtLog DataAcesso,
log_acesso.log Log
 FROM empresa
	JOIN funcionario 
		ON empresa.idEmpresa = funcionario.fkEmpresa
	JOIN log_acesso
		ON funcionario.idFuncionario = log_acesso.fkFuncionario 
        AND funcionario.fkEmpresa = log_acesso.fkEmpresaFunc
	JOIN dispositivo
		ON log_acesso.fkDispositivo = dispositivo.idDispositivo;
    
END$$
DELIMITER ;

/*
CALL SP_GetAllAcessos();
*/

-- TRANSACTION
START TRANSACTION;

UPDATE dispositivo SET status = 'Manutenção' WHERE idDispositivo = 100;

SELECT * FROM dispositivo;

-- confirma as alterações realizadas dentro da transação
COMMIT;

-- OUTRA TRANSACTION
START TRANSACTION;

UPDATE dispositivo SET status = 'Inativo' WHERE idDispositivo = 100;

SELECT * FROM dispositivo;

-- retorna os registros antes de iniciar a transação;
ROLLBACK;

SELECT * FROM dispositivo;