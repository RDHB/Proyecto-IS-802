IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Estado_Usuario'))
BEGIN;
    DROP TABLE [Estado_Usuario];
END;
GO

CREATE TABLE [Estado_Usuario] (
    [Estado_UsuarioID] INTEGER NOT NULL IDENTITY(1, 1),
    [idEstado_Usuario] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    PRIMARY KEY ([Estado_UsuarioID])
);
GO

INSERT INTO Estado_Usuario([idEstado_Usuario],[descripcion]) 
VALUES
(1,'Habilitado'),
(2,'Deshabilitado');

