IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Usuarios'))
BEGIN;
    DROP TABLE [Usuarios];
END;
GO

CREATE TABLE [Usuarios] (
    [UsuariosID] INTEGER NOT NULL IDENTITY(1, 1),
    [idUsuario] INTEGER NULL,
    [nombreUsuario] VARCHAR(255) NULL,
    [contrasenia ] VARCHAR(255) NULL,
    [Empleado_idEmpleado ] INTEGER NULL,
    [Estado_Usuario_idEstado_Usuario] INTEGER NULL,
    PRIMARY KEY ([UsuariosID])
);
GO

INSERT INTO Usuarios([idUsuario],[nombreUsuario],[contrasenia ],[Empleado_idEmpleado ],[Estado_Usuario_idEstado_Usuario]) 
VALUES
(1,'Murphy','FSJ44MIN4FJ',1,1),
(2,'Carson','FDN61QJI7UM',2,2),
(3,'Plato','BHE81RRR3RE',3,2),
(4,'Marvin','MYC35PEB8EV',4,1),
(5,'Avram','QFQ39QGO6SF',5,1),
(6,'Oliver','ODY47FJL1DH',6,2),
(7,'Odysseus','RKL51XQZ5XF',7,2),
(8,'Joshua','OHM31QHV2MV',8,1),
(9,'Sylvester','QWH00KBU3XE',9,1),
(10,'Reece','IKH08NXO5AA',10,2),
(11,'Hu','PQU24OYM5OU',11,1),
(12,'Denton','NAG63DHW6XI',12,1),
(13,'Emerson','QMF57AGC8LI',13,1),
(14,'Rajah','JED04HBG6GS',14,1),
(15,'Ferris','FCU55FMI1MJ',15,2),
(16,'Elliott','GBB29FUO7LZ',16,1),
(17,'Logan','HLV64AZT9VC',17,1),
(18,'Prescott','TEN88XYH0ZN',18,1),
(19,'Nissim','GKR57UFE1NF',19,1),
(20,'Zachary','NQI46GIZ7XV',20,2);

