IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Cliente'))
BEGIN;
    DROP TABLE [Cliente];
END;
GO

CREATE TABLE [Cliente] (
    [ClienteID] INTEGER NOT NULL IDENTITY(1, 1),
    [idCliente] INTEGER NULL,
    [descripcion] VARCHAR(MAX) NULL,
    [Persona_idPersona] INTEGER NULL,
    PRIMARY KEY ([ClienteID])
);
GO

INSERT INTO Cliente([idCliente],[descripcion],[Persona_idPersona]) 
VALUES
(1,'vehicula et, rutrum eu,',1),
(2,'mus. Proin vel nisl.',2),
(3,'ac risus. Morbi metus.',3),
(4,'Mauris vel turpis. Aliquam',4),
(5,'ornare egestas ligula. Nullam',5),
(6,'vulputate dui, nec tempus',6),
(7,'Quisque purus sapien, gravida',7),
(8,'tincidunt congue turpis. In',8),
(9,'Donec fringilla. Donec feugiat',9),
(10,'auctor vitae, aliquet nec,',10);

