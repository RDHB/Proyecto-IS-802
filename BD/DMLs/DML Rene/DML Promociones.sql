IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Promociones'))
BEGIN;
    DROP TABLE [Promociones];
END;
GO

CREATE TABLE [Promociones] (
    [PromocionesID] INTEGER NOT NULL IDENTITY(1, 1),
    [idPromociones] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    [fechaInicio ] VARCHAR(255),
    [fechaFin] VARCHAR(255),
    [estado] VARCHAR(MAX) NULL,
    PRIMARY KEY ([PromocionesID])
);
GO

INSERT INTO Promociones([idPromociones],[descripcion],[fechaInicio ],[fechaFin]) 
VALUES
(1,'Inicio anio','2020-01-03 01:00:00','2020-02-01 22:56:54'),
(2,'Semana Santa','2020-14-01 01:00:00','2020-04-15 22:54:49'),
(3,'Fin anio','2020-12-15 16:01:00','2020-12-23 22:12:42');


