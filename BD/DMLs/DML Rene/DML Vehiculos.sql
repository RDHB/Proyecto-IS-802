IF EXISTS(SELECT 1 FROM sys.tables WHERE object_id = OBJECT_ID('Vehiculos'))
BEGIN;
    DROP TABLE [Vehiculos];
END;
GO

CREATE TABLE [Vehiculos] (
    [VehiculosID] INTEGER NOT NULL IDENTITY(1, 1),
    [idVehiculos] INTEGER NULL,
    [Vin] VARCHAR(MAX) NULL,
    [Color] VARCHAR(MAX) NULL,
    [Placa] VARCHAR(MAX) NULL,
    [numeroMotor] VARCHAR(MAX) NULL,
    [caja_de_cambios] VARCHAR(MAX) NULL,
    [Marca_idMarca] INTEGER NULL,
    [Modelo_idModelo] INTEGER NULL,
    PRIMARY KEY ([VehiculosID])
);
GO

INSERT INTO Vehiculos([idVehiculos],[Vin],[Color],[Placa],[numeroMotor],[caja_de_cambios],[Marca_idMarca],[Modelo_idModelo]) 
VALUES
(1,'1PCH23DF56GHJ3DF34A','Azul','PCH-2345','R134J4768341','Automatico',1,1),
(2,'1PCH23DF56GHJ3DF34B','Blanco','PCH-2346','R134J4768342','Mecanico',2,1),
(3,'1PCH23DF56GHJ3DF34C','Rojo','PCH-2347','R134J4768343','Automatico',3,1),
(4,'1PCH23DF56GHJ3DF34D','Verde Olivo','PCH-2348','R134J4768344','Mecanico',4,1),
(5,'1PCH23DF56GHJ3DF34E','Negro','PCH-2349','R134J4768345','Mecanico',5,1),
(6,'1PCH23DF56GHJ3DF34F','Azul','PCH-2350','R134J4768346','Automatico',6,1),
(7,'1PCH23DF56GHJ3DF34G','Plata','PCH-2351','R134J4768347','Mecanico',7,1),
(8,'1PCH23DF56GHJ3DF34H','Silver','PCH-2352','R134J4768348','Automatico',8,1),
(9,'1PCH23DF56GHJ3DF34I','Negro','PCH-2353','R134J4768349','Mecanico',9,1),
(10,'1PCH23DF56GHJ3DF34J','Rojo','PCH-2354','R134J4768310','Automatico',10,1);

