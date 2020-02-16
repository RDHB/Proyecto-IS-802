IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('VinculoCyV'))
BEGIN;
    DROP TABLE [VinculoCyV];
END;
GO

CREATE TABLE [VinculoCyV] (
    [VinculoCyVID] INTEGER NOT NULL IDENTITY(1, 1),
    [Cliente_idCliente] INTEGER NULL,
    [Vehiculos_idVehiculos] INTEGER NULL,
    [idVinculoCyV] INTEGER NULL,
    PRIMARY KEY ([VinculoCyVID])
);
GO

INSERT INTO VinculoCyV([Cliente_idCliente],[Vehiculos_idVehiculos],[idVinculoCyV]) 
VALUES
(8,1,1),
(3,2,2),
(7,3,3),
(3,4,4),
(4,5,5),
(1,6,6),
(5,7,7),
(4,8,8),
(3,9,9),
(6,10,10);


