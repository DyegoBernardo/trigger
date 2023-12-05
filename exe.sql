CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE Autores (
    AutorID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Nacionalidade VARCHAR(50)
);

CREATE TABLE Livros (
    LivroID INT PRIMARY KEY,
    Titulo VARCHAR(150),
    AnoPublicacao INT,
    AutorID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Inserir autores
INSERT INTO Autores (AutorID, Nome, Nacionalidade) VALUES
    (1, 'Machado de Assis', 'Brasileiro'),
    (2, 'Jane Austen', 'Inglesa');

-- Inserir livros
INSERT INTO Livros (LivroID, Titulo, AnoPublicacao, AutorID) VALUES
    (101, 'Dom Casmurro', 1899, 1),
    (102, 'Orgulho e Preconceito', 1813, 2);

DELIMITER //
CREATE TRIGGER BeforeInsertLivro
BEFORE INSERT ON Livros
FOR EACH ROW
BEGIN
    DECLARE NumLivros INT;
    SELECT COUNT(*) INTO NumLivros FROM Livros WHERE AutorID = NEW.AutorID;
    UPDATE Autores SET NumLivrosPublicados = NumLivros + 1 WHERE AutorID = NEW.AutorID;
END;
//
DELIMITER ;


