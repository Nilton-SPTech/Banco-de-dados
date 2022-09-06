CREATE DATABASE bdSprint1; 

USE bdSprint1;

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT, 
    nomeUsuario VARCHAR(45),
    emailUsuario VARCHAR(50),
    senhaUsuario VARCHAR(45),
    cnpj CHAR(14)
);


CREATE TABLE Animal (
    idAnimal INT PRIMARY KEY AUTO_INCREMENT, 
    nomeAnimmal VARCHAR(45),
    especie VARCHAR(45),
    pesoAnimals FLOAT, 
    dataNasc DATE
); 

CREATE TABLE Arduino(
    idArduino INT PRIMARY KEY AUTO_INCREMENT, 
    temperatura FLOAT,
    dataHoraRegistrada DATETIME
);