CREATE DATABASE sprint2;

USE sprint2;

CREATE TABLE musica(
    idMusica INT PRIMARY KEY AUTO_INCREMENT, 
    titulo VARCHAR(40), 
    artista VARCHAR(40),
    genero VARCHAR(40)
);

INSERT INTO musica(titulo, artista, genero) VALUES 
    ('Beija-Flor', 'Jorge Bem Jó', 'MPB'),
    ('Dança gatinha', 'Pitbull', 'Funk'),
    ('Soul', 'Nirvana', 'Rock'),
    ('Um tapinha não dói', 'Nego do Borel', 'Funk'),
    ('FAKE LOVE', 'BTS', 'KPOP');



CREATE TABLE album(
    idAlbum INT PRIMARY KEY AUTO_INCREMENT, 
    nomeAlbum VARCHAR(45), 
    dtLancamento DATE,
    tipoAlbum VARCHAR(45), CONSTRAINT chkTipo CHECK(tipoAlbum IN ('Digital', 'Fisíco'))
);

INSERT INTO album(nomeAlbum, tipoAlbum, dtLancamento) VALUES 
    ('Chico Doce', 'Fisíco', '2022-10-09'),
    ('EletroHits', 'Digital', '2010-09-01'),
    ('BTS', 'Digital', '2009-01-02');


-- ADICIONANDO A CHAVE ESTRANGEIRA 
ALTER TABLE musica ADD COLUMN fk_idAlbum INT;

ALTER TABLE musica ADD FOREIGN KEY (fk_idAlbum)
    REFERENCES album(idAlbum);

UPDATE musica SET fk_idAlbum = 1 
    WHERE idMusica IN (1,2);

UPDATE musica SET fk_idAlbum = 2
    WHERE idMusica IN (3,4);

UPDATE musica SET fk_idAlbum = 3
    WHERE idMusica = 5;


SELECT musica.titulo, nomeAlbum FROM musica
    JOIN album ON album.idAlbum = musica.fk_idAlbum;

SELECT musica.titulo, album.nomeAlbum FROM musica   
    JOIN album ON album.idAlbum = musica.fk_idAlbum
        WHERE album.nomeAlbum = 'Chico Doce';

SELECT musica.titulo, album.nomeAlbum FROM musica   
    JOIN album ON album.idAlbum = musica.fk_idAlbum
        WHERE album.tipoAlbum = 'Digital';

ALTER TABLE musica DROP COLUMN artista;


-- CRIANDO A TABELA ARTISTA 
CREATE TABLE artista (
    idArtista INT PRIMARY KEY AUTO_INCREMENT, 
    nomeArtista VARCHAR(50), 
    idadeArtista INT
);

INSERT INTO artista(nomeArtista, idadeArtista) VALUES 
    ('BTS', 10), 
    ('Pitbull do Funk', 41), 
    ('Nirvana', 00);

ALTER TABLE musica ADD COLUMN fk_idArtista INT;

ALTER TABLE musica ADD FOREIGN KEY (fk_idArtista)
    REFERENCES artista(idArtista);


UPDATE musica SET fk_idArtista = 3
    WHERE idMusica = 4;


SELECT titulo, nomeArtista, nomeAlbum FROM musica m 
    JOIN album a ON a.idAlbum = m.fk_idAlbum  
        JOIN artista ar ON ar.idArtista = m.fk_idArtista;