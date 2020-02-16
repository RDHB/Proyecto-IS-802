IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Modelo'))
BEGIN;
    DROP TABLE [Modelo];
END;
GO

CREATE TABLE [Modelo] (
    [ModeloID] INTEGER NOT NULL IDENTITY(1, 1),
    [idModelo] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    PRIMARY KEY ([ModeloID])
);
GO

INSERT INTO Modelo([idModelo],[descripcion]) 
VALUES
(1,'Fiesta'),
(2,'Everest'),
(3,'Explorer'),
(4,'Escape'),
(5,'EcoSport'),
(6,'Volvo V40'),
(7,'Volvo S60'),
(8,'Volvo S90'),
(9,'Volvo V60'),
(10,'Volvo XC40'),
(11,'Civic'),
(12,'City'),
(13,'Fit'),
(14,'Accor'),
(15,'CR-V'),
(16,'Nativa'),
(17,'L-200'),
(18,'Outlander'),
(19,'Montero'),
(20,'Space Star'),
(21,'Elantra'),
(22,'Santa Fe'),
(23,'i20'),
(24,'i30'),
(25,'Tucson'),
(26,'Corrola'),
(27,'Prius'),
(28,'Hilux'),
(29,'Yaris'),
(30,'Land Cruiser Prado'),
(31,'Swift'),
(32,'Ignis'),
(33,'Vitara'),
(34,'Jimny'),
(35,'S-Cross'),
(36,'Frontier'),
(37,'Juke'),
(38,'Qashqai'),
(39,'X-Trail'),
(40,'Pathfinder'),
(41,'CX-3'),
(42,'Mazda2'),
(43,'Mazda3'),
(44,'BT-50'),
(45,'CX-5'),
(46,'Rio'),
(47,'Picanto'),
(48,'Sportage'),
(49,'Sorento'),
(50,'Soul');

