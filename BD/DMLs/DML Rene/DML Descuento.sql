IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Descuento'))
BEGIN;
    DROP TABLE [Descuento];
END;
GO

CREATE TABLE [Descuento] (
    [DescuentoID] INTEGER NOT NULL IDENTITY(1, 1),
    [idDescuento] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    [porcentaje] UNIQUEIDENTIFIER NULL,
    [fecha_de_validez] VARCHAR(255),
    PRIMARY KEY ([DescuentoID])
);
GO

INSERT INTO Descuento([idDescuento],[descripcion],[porcentaje],[fecha_de_validez]) 
VALUES(1,'Tercera edad',25,'2021-02-17 22:09:24');

