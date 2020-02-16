IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Marca'))
BEGIN;
    DROP TABLE [Marca];
END;
GO

CREATE TABLE [Marca] (
    [MarcaID] INTEGER NOT NULL IDENTITY(1, 1),
    [idMarca] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    PRIMARY KEY ([MarcaID])
);
GO


INSERT INTO Marca([idMarca],[descripcion]) 
VALUES
(1,'Volvo'),
(2,'Ford'),
(3,'Honda'),
(4,'Mitsubishi'),
(5,'Hyundai'),
(6,'Toyota'),
(7,'Suzuki'),
(8,'Nissan'),
(9,'Mazda'),
(10,'Kia');

