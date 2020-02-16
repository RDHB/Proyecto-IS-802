IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('FormaPago'))
BEGIN;
    DROP TABLE [FormaPago];
END;
GO

CREATE TABLE [FormaPago] (
    [FormaPagoID] INTEGER NOT NULL IDENTITY(1, 1),
    [idFormaPago ] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    PRIMARY KEY ([FormaPagoID])
);
GO

INSERT INTO FormaPago([idFormaPago ],[descripcion]) 
VALUES
(1,'Efectivo'),
(2,'Tarjeta de credito/debito');

