-- Table Genero
INSERT INTO Genero ([idGenero],[descripcion]) VALUES 
(1,'Hombre'),
(2,'Mujer');


-- Table Persona
INSERT INTO Persona([idPersona],[primerNombre],[segundoNombre],[primerApellido],[segundoApellido],[correoElectronico],[direccion],[numeroIdentidad],[fechaIngreso],[Genero_idGenero]) 
VALUES
(1,'Laith','Demetrius','Mejia','Branch','urna@eutellus.edu','P.O. Box 579, 6900 Imperdiet Rd.',                         '1690-0325-91448','2018-11-01 21:28:33',2),
(2,'Carter','Akeem','Frost','Kane','nunc.Quisque@Quisquefringilla.org','2017 Purus St.',                                '1643-0704-71367','2019-10-30 11:13:52',1),
(3,'Jelani','Macaulay','Bradshaw','Dawson','sed.hendrerit.a@ad.com','682-6749 Mattis Rd.',                              '1663-0829-71198','2018-10-21 20:44:46',1),
(4,'Conan','Fritz','Ferguson','Weeks','a.sollicitudin.orci@metusAeneansed.co.uk','270-166 Adipiscing Rd.',              '1693-1216-41800','2019-07-10 15:24:32',2),
(5,'Wesley','Abel','Boyd','Mccormick','feugiat.Sed@ipsumdolorsit.net','P.O. Box 522, 8945 Non Street',                  '1688-1104-91470','2019-05-22 22:10:41',1),
(6,'Norman','Damon','Mitchell','Hinton','senectus@nonlobortis.ca','961-8981 Ipsum. St.',                                '1651-0822-41444','2019-09-15 13:45:31',2),
(7,'Lars','Colton','Durham','Dennis','Fusce.aliquet.magna@loremtristique.com','9967 Et Rd.',                            '1656-0427-91991','2020-02-14 11:10:09',1),
(8,'Ray','Rigel','Maldonado','Jensen','pede@nonnisi.com','4046 Adipiscing St.',                                         '1685-0509-31537','2019-10-27 16:43:21',2),
(9,'Jasper','Beck','Good','Clark','odio.vel@lobortisquama.co.uk','P.O. Box 243, 6876 Libero. Road',                     '1694-1209-31099','2019-12-14 02:04:53',1),
(10,'Mark','Salvador','Watkins','Gallegos','Suspendisse.dui@sedtortorInteger.edu','Ap #183-7201 Tristique Rd.',         '1606-1113-91551','2019-01-31 11:37:06',2),
(11,'Luis','Fernando','Solano','Martínez','luisfer.game15@gmail.com','Colonia 21 de Febrero',                           '1804-1998-00220','2018-04-18 08:07:39',1),
(12,'Rene','David','Baca','Hernandez','molestie.tellus@idanteNunc.co.uk','6128 Libero Rd.',                   '1680-1028-91125','2020-02-09 13:58:45',1),
(13,'Mariela','Carolina','Martínez','Rodríguez','purus.in.molestie@etmagnis.edu','6609 Bibendum Rd.',                   '1674-1004-41205','2019-03-02 06:49:49',2),
(14,'Marvin','Quamar','Ponce','Monroe','semper.tellus.id@cubilia.net','2392 Sit Rd.',                                   '1629-1102-51753','2019-08-31 08:22:57',1),
(15,'Son','Goku','saiyajin','Lang','dolor.@dinadipiscing.com','Ap #766-5491 Eu Rd.',                                    '1630-1221-31975','2018-08-10 14:49:51',1),
(16,'Vegeta','Principe','saiyajin','Guy','sed.facilisis.vitae@pharetra.co.uk','6827 Libero Avenue',                     '1681-0120-71119','2019-08-21 05:25:54',1),
(17,'Ruben','','Doblas','Gundersen','odio@Aliquamul.org','3595 Pede. Road',                                             '1604-0714-81337','2018-07-24 23:07:58',1),
(18,'Link','','Trifuerzason','Spencer','Phasellus.fermentum@Etiamgravida.co.uk','Ap #520-2522 Posuere Ave',             '1655-0516-11124','2018-10-26 03:03:42',1),
(19,'JOHN-117','','Jefe','Maestro','masterchief@halo.com','316-7832 Ullamcorper. St.',                                  '1607-0409-51397','2019-07-02 13:16:05',1),
(20,'David','Troy','Zuniga','Bolton','nibh@Nulla.ca','Ap #811-2198 Elit. Road',                                         '1658-0412-01698','2019-01-20 14:18:27',1),
(21,'Hamish','Melvin','Cole','Maldonado','non.lacinia.at@sociosqu.com','Ap #287-9625 Non Rd.',                          '1658-1103-51665','2018-08-24 11:43:26',1),
(22,'Ashton','Kaseem','Foster','Wooten','magna.Nam@molestie.edu','768-8810 Ut Av.',                                     '1632-1019-61675','2018-04-29 20:45:56',2),
(23,'Elliott','Abel','Rocha','Blackwell','Lorem.ipsum.dolor@aliquetPhasellus.net','Ap #789-8628 Nisl. Rd.',             '1602-0903-01394','2018-05-30 00:51:58',1),
(24,'Brent','Lester','Williams','Crosby','diam@pharetranibh.edu','7042 Mollis Av.',                                     '1670-0514-31610','2019-10-27 16:13:20',1),
(25,'Caesar','Merrill','Park','York','tincidunt.Donec@Morbisitamet.net','P.O. Box 793, 4006 Vulputate Road',            '1677-0114-01613','2019-12-28 08:35:08',2),
(26,'Berk','Ciaran','Watkins','Harper','tempus@tellus.net','Ap #427-5974 Sed Av.',                                      '1658-0605-91605','2020-02-11 09:43:25',1),
(27,'Kenneth','Akeem','Howe','Stokes','quis.tristique.ac@Aeneaneuismod.ca','P.O. Box 194, 4403 Etiam Av.',              '1628-0108-81440','2019-05-17 07:58:37',1),
(28,'Omar','Grady','Hensley','Byrd','ornare.tortor@et.co.uk','P.O. Box 814, 4323 Dolor Ave',                            '1658-0206-31817','2018-02-20 15:22:35',1),
(29,'Wyatt','Cruz','Newman','Salazar','cursus.purus@Vivamussit.edu','P.O. Box 382, 9603 Sollicitudin Ave',              '1697-1001-51901','2019-08-11 12:16:07',1),
(30,'Fritz','Guy','Lang','Ortiz','dis.parturient.montes@elementumat.edu','Ap #850-7090 Interdum. Road',                 '1654-0904-01036','2020-02-07 00:49:28',1),
(31,'Hayes','Oren','Villarreal','Griffin','lectus.ante@Aliquamultrices.co.uk','Ap #148-6714 Ullamcorper, Street',       '1681-0910-61321','2019-06-21 13:17:09',1),
(32,'Jakeem','Craig','Joseph','Bradford','augue.porttitor.interdum@Suspendisse.com','862 Diam Rd.',                     '1669-0704-21789','2019-11-14 05:07:37',1),
(33,'Damon','Driscoll','Schmidt','Zimmerman','vitae@risusNunc.net','1343 A Rd.',                                        '1628-0529-41028','2019-01-27 12:07:34',2),
(34,'Evan','Armand','Malone','Velez','vulputate@faucibusorciluctus.ca','1388 Cras Av.',                                 '1639-0830-71204','2019-08-21 03:01:41',1),
(35,'Declan','Omar','Richards','Bass','hendrerit.a.arcu@urna.org','5016 Turpis. Ave',                                   '1682-0124-81849','2019-05-25 05:46:33',2),
(36,'Kelly','Dexter','Everett','Harris','sagittis@nequeSed.co.uk','8537 Ligula Avenue',                                 '1612-0601-61113','2018-08-09 21:51:02',2),
(37,'Hasad','Arsenio','Burch','Frye','Quisque.ornare@eratvolutpatNulla.ca','671-627 Ligula. Ave',                       '1653-0722-91319','2019-08-17 18:46:16',1),
(38,'Dorian','Len','Barrett','Gomez','penatibus.et@semperduilectus.com','P.O. Box 894, 1216 Magna. St.',                '1679-0704-91444','2018-02-22 12:05:11',2),
(39,'Henry','Jakeem','Bauer','Garcia','velit@natoque.net','646-1517 Quisque St.',                                       '1656-0107-41783','2019-05-02 04:07:19',1),
(40,'Dylan','Christopher','Stevenson','Wallace','dui.semper.et@at.edu','P.O. Box 478, 3357 Velit. Av.',                 '1621-0812-81402','2019-10-24 00:38:41',1),
(41,'Perry','Thane','Raymond','Jimenez','imperdiet@Aliquamgravida.com','P.O. Box 459, 2336 Orci Rd.',                   '1674-0812-61659','2018-03-19 13:56:39',2),
(42,'Griffin','Salvador','Gross','Roberts','at.pretium.aliquet@rhoncusDonecest.edu','2126 Dictum Street',               '1633-0922-31042','2018-05-17 17:58:24',2),
(43,'Damon','Christopher','Hawkins','Avery','tellus.Suspendisse@risusNullaeget.edu','Ap #135-6475 Convallis, Street',   '1639-0624-11553','2020-01-15 04:11:57',1),
(44,'Fletcher','Kirk','Reed','Merritt','vitae.erat@leoinlobortis.edu','Ap #251-307 Eu, Av.',                            '1626-1201-11300','2019-11-13 21:00:34',2),
(45,'Aquila','Kibo','Key','Herring','nisi@atiaculisquis.co.uk','P.O. Box 171, 6986 Massa. Ave',                         '1688-0623-51092','2019-09-26 06:25:31',2),
(46,'Fuller','Lionel','Trujillo','Reyes','sit.amet@acnullaIn.net','P.O. Box 238, 2065 Dolor Rd.',                       '1612-0815-01480','2019-10-26 12:09:34',1),
(47,'Roth','Quinn','Cochran','James','est.congue@luctus.org','Ap #773-844 Facilisi. Avenue',                            '1654-0502-71102','2018-12-23 21:57:51',1),
(48,'Quinlan','Armand','Boyd','Roth','eu.dui@aliquet.co.uk','7659 Blandit Rd.',                                         '1686-0325-21589','2019-05-25 07:44:27',1),
(49,'Chandler','Mufutau','Vinson','Eaton','est.mollis.non@varius.net','Ap #435-4719 Commodo Street',                    '1692-0923-21637','2019-05-22 18:37:48',1),
(50,'Blaze','Alvin','Santana','Craig','mauris.elit@a.net','Ap #180-2409 Orci, Rd.',                                     '1683-1010-81074','2018-10-13 20:37:17',2),
(51,'Craig','Tiger','Cleveland','Burton','ut.pharetra.sed@volutpatNulla.ca','533-9686 A Rd.',                           '1613-0511-31746','2019-06-10 06:46:14',1),
(52,'Bernard','Wang','Dale','Schwartz','dis.parturient.montes@milorem.com','Ap #709-6063 Neque St.',                    '1679-1217-41823','2019-08-16 17:03:19',2),
(53,'Kevin','Felix','Mcdonald','Raymond','dapibus@luctus.net','P.O. Box 544, 6634 Sagittis Rd.',                        '1654-0705-21074','2018-08-23 20:32:49',1),
(54,'Silas','Maxwell','Cooper','Guy','mollis.lectus@aliquetProin.ca','Ap #218-4211 Lacus. Ave',                         '1654-1018-51770','2020-01-13 16:52:51',2),
(55,'Vaughan','Dennis','Saunders','Gay','nec@natoquepenatibuset.net','9909 Est, Avenue',                                '1686-1201-51266','2020-01-19 09:22:53',1),
(56,'Emmanuel','Eagan','Hampton','Stanley','vel.convallis.in@ultriciesadipiscing.edu','2953 Erat. Av.',                 '1605-0426-81723','2019-07-17 02:18:52',1),
(57,'Addison','Joel','Mosley','Vinson','libero@imperdietnonvestibulum.edu','Ap #602-1603 Parturient Rd.',               '1628-0512-71608','2019-05-07 08:49:42',2),
(58,'Eric','Ferdinand','Schneider','Contreras','Cum@risus.co.uk','Ap #623-7311 Id Rd.',                                 '1689-0730-31690','2018-12-14 15:02:38',1),
(59,'Baker','Brody','Mcgee','Winters','nascetur@Vestibulumante.edu','870-3564 Elementum Avenue',                        '1612-1213-01130','2020-01-09 23:38:09',2),
(60,'Basil','Kyle','Flores','Dejesus','libero.Donec.consectetuer@velitCraslorem.net','Ap #563-2921 Posuere Road',       '1680-0720-01440','2018-02-06 23:56:29',2);


-- Table Cliente
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

-- Table AreadeTrabajo
INSERT INTO AreaTrabajo([idAreaTrabajo],[descripcion]) 
VALUES
(1,'Gerencia'),
(2,'RRHH'),
(3,'Administracion'),
(4,'Contabilidad'),
(5,'Almacen'),
(6,'Ventas'),
(7,'Taller'),
(8,'Servicios'),
(9,'Tecnologia'),
(10,'Limpieza');


-- Table Marca
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

-- Table Modelo
INSERT INTO Modelo([idModelo],[descripcion],[Marca_idMarca]) 
VALUES
(1,'Fiesta',1),
(2,'Everest',2),
(3,'Explorer',3),
(4,'Escape',4),
(5,'EcoSport',5),
(6,'Volvo V40',6),
(7,'Volvo S60',7),
(8,'Volvo S90',8),
(9,'Volvo V60',9),
(10,'Volvo XC40',10),
(11,'Civic',1),
(12,'City',2),
(13,'Fit',3),
(14,'Accor',4),
(15,'CR-V',5),
(16,'Nativa',6),
(17,'L-200',7),
(18,'Outlander',8),
(19,'Montero',9),
(20,'Space Star',10),
(21,'Elantra',1),
(22,'Santa Fe',2),
(23,'i20',3),
(24,'i30',4),
(25,'Tucson',5),
(26,'Corrola',6),
(27,'Prius',7),
(28,'Hilux',8),
(29,'Yaris',9),
(30,'Land Cruiser Prado',10),
(31,'Swift',1),
(32,'Ignis',2),
(33,'Vitara',3),
(34,'Jimny',4),
(35,'S-Cross',5),
(36,'Frontier',6),
(37,'Juke',7),
(38,'Qashqai',8),
(39,'X-Trail',9),
(40,'Pathfinder',10),
(41,'CX-3',1),
(42,'Mazda2',2),
(43,'Mazda3',3),
(44,'BT-50',4),
(45,'CX-5',5),
(46,'Rio',6),
(47,'Picanto',7),
(48,'Sportage',8),
(49,'Sorento',9),
(50,'Soul',10);

-- Table Vehiculos
INSERT INTO Vehiculos([idVehiculos],[Vin],[Color],[Placa],[numeroMotor],[caja_de_cambios],[Modelo_idModelo]) 
VALUES
(1,'1PCH23DF56GHJ3DF34A','Azul','PCH-2345','R134J4768341','Automatico',1),
(2,'1PCH23DF56GHJ3DF34B','Blanco','PCH-2346','R134J4768342','Mecanico',1),
(3,'1PCH23DF56GHJ3DF34C','Rojo','PCH-2347','R134J4768343','Automatico',1),
(4,'1PCH23DF56GHJ3DF34D','Verde Olivo','PCH-2348','R134J4768344','Mecanico',1),
(5,'1PCH23DF56GHJ3DF34E','Negro','PCH-2349','R134J4768345','Mecanico',1),
(6,'1PCH23DF56GHJ3DF34F','Azul','PCH-2350','R134J4768346','Automatico',1),
(7,'1PCH23DF56GHJ3DF34G','Plata','PCH-2351','R134J4768347','Mecanico',1),
(8,'1PCH23DF56GHJ3DF34H','Silver','PCH-2352','R134J4768348','Automatico',1),
(9,'1PCH23DF56GHJ3DF34I','Negro','PCH-2353','R134J4768349','Mecanico',1),
(10,'1PCH23DF56GHJ3DF34J','Rojo','PCH-2354','R134J4768310','Automatico',1);

-- Table Servicios
INSERT INTO Servicios([idServicios],[nombre],[precioCosto],[duracion]) 
VALUES
(1,'Lavado de auto',220,'04:18:45'),
(2,'Inspeccion del Vehiculo',651,'03:59:53'),
(3,'Mantenimiento',418,'02:58:05'),
(4,'Pintura',874,'02:13:54'),
(5,'Cambio de llantas',486,'22:27:54'),
(6,'Cambio de aceites',502,'06:35:31'),
(7,'Cambio de amortiguadores',754,'02:30:54'),
(8,'Reparacion de motor',245,'16:30:13'),
(9,'Reparacion de abolladuras',479,'03:34:59'),
(10,'Otras Reparaciones',802,'02:53:56');

-- Table EstadoOT
INSERT INTO EstadoOT([idEstadoOT],[descripcion]) 
VALUES
(1,'Creando Orden de Trabajo'),
(2,'Revision del vehiculo'),
(3,'Contratar servicios'),
(4,'Cotizar repuestos'),
(5,'Aprobar cotizacion Cliente'),
(6,'Aprobar cotizacion JefeTaller'),
(7,'Generar lista de materiales'),
(8,'Aprobar lista de materiales'),
(9,'Rebajar productos del inventario'),
(10,'Finalizar mantenimiento'),
(11,'Aprobar control de calidad'),
(12,'Crear lista de sugerencias'),
(13,'Orden de Trabajo finalizada');

-- Table OrdenTrabajo
INSERT INTO OrdenTrabajo([idOrdenTrabajo],[fechaInicio],[fechaFin],[estado_del_vehiculo],[objetosPersonales],[reparacionesEfectuadas],[reparacionesNoEfectuadas],[Recomendaciones],     [Cliente_idCLiente],[EstadoOT_idEstadoOT],[Vehiculos_idVehiculos]) 
VALUES
(1,'2019-10-03','2020-05-20',   'Perfecto estado',              'Sin objetos personales',   'Cambio de aceite, Fuga de agua',   'Calibrado de suspensión',  'Se recomienda cambiar las llantas',        1,1,1),
(2,'2018-12-20','2019-03-06',   'Abolladuras en las puertas',   'Llaves',                   'Cambio de aceite, Fuga de agua',   'Calibrado de suspensión',  'Se recomienda cambiar las llantas',        2,2,2),
(3,'2013-06-19','2020-03-19',   'Abolladuras en las puertas',   'Monederos',                'Cambio de aceite, Fuga de agua',   'Reparacion del motor',     'Se recomienda revisar la caja de cambios', 3,3,3),
(4,'2020-01-20','2020-02-20',   'Perfecto estado',              'Tarjetas Bancarias',       'Mantenimiento 100 KM',             'Reparacion del motor',     '',                                         4,4,4),
(5,'2020-01-21','2020-10-20',   'Perfecto estado',              'Alimentos y Refrescos',    'Mantenimiento 100 KM',             'Reparacion del motor',     '',                                         5,5,5),
(6,'2019-02-19','2020-02-21',   'Abolladuras en las puertas',   'Computadora ASUS',         'Mantenimiento 100 KM',             'Pintura del Vehiculo',     '',                                         6,6,6),
(7,'2019-05-20','2020-06-19',   'Perfecto estado',              '2 Celulares Huawei',       'Todas las reparaciones',           '',                         '',                                         7,7,7),
(8,'2019-06-19','2020-12-20',   'Perfecto estado',              'Sin objetos personales',   'Todas las reparaciones',           '',                         '',                                         8,8,8),
(9,'2020-05-19','2020-09-19',   'Sin retrovisores',             'Sin objetos personales',   'Todas las reparaciones',           '',                         '',                                         9,9,9),
(10,'2020-04-20','2020-10-20',  'Ventanas quebrados',           'Sin objetos personales',   'Todas las reparaciones',           '',                         '',                                         10,10,10);

-- Table TipoContrato
INSERT INTO TipoContrato([idTipoContrato],[descripcion]) 
VALUES
(1,'Permanente'),
(2,'Temporal');

-- Table ContratoPersonal
INSERT INTO ContratoPersonal([idContratoPersonal],[fechaContrato],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) 
VALUES
(1,'2020-01-29',16229,'13:16:19','20:14:33',1),
(2,'2019-04-19',5735,'06:55:48','08:02:23',2),
(3,'2020-01-18',10446,'11:27:13','17:51:23',1),
(4,'2020-12-29',15730,'07:21:43','21:25:34',2),
(5,'2019-03-08',4361,'12:34:40','17:32:16',1),
(6,'2020-07-10',24789,'10:13:58','11:24:33',1),
(7,'2019-08-19',7488,'00:43:28','09:03:42',1),
(8,'2019-06-24',19434,'05:02:42','08:40:07',2),
(9,'2021-02-11',21813,'03:39:55','10:13:36',2),
(10,'2020-12-27',6718,'03:34:49','07:17:11',2);

-- Table Horas_extras
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) 
VALUES
(1,'13:16:19','20:14:33','05/08/2015'),
(2,'06:55:48','08:02:23','2011/11/16'),
(3,'11:27:13','17:51:23','2019/01/05'),
(4,'07:21:43','21:25:34','2020/08/01'),
(5,'12:34:40','17:32:16','2017/02/17'),
(6,'10:13:58','11:24:33','2014/10/22'),
(7,'00:43:28','09:03:42','2012/05/19'),
(8,'05:02:42','08:40:07','2016/03/21'),
(9,'03:39:55','10:13:36','2011/08/03'),
(10,'03:34:49','07:17:11','2018/02/04');

-- Table Historico_HE
INSERT INTO Historico_HE([idHistorico_HE],[AreaTrabajo_idAreaTrabajo],[Horas_extras_idHoras_extras]) 
VALUES
(1,4,3),
(2,10,6),
(3,3,10),
(4,7,2),
(5,4,9),
(6,3,1),
(7,1,8),
(8,3,5),
(9,2,4),
(10,5,4);

-- Table Descuento
INSERT INTO Descuento([idDescuento],[descripcion],[porcentaje],[fecha_de_validez]) 
VALUES
(1,'Tercera edad',25,'2021-02-17 22:09:24');

-- Table TipoProducto
INSERT INTO TipoProducto([idTipoProducto],[descripcion]) 
VALUES
(1,'Recambio'),
(2,'Herramienta');

-- Table Producto
INSERT INTO Producto([idProducto],[nombre],[cantidad],[precioVenta],[precioCompra],[FechaIngreso],[FechaVencimiento],[TipoProducto_idTipoProducto]) 
VALUES
(1,'Llantas',              1,78,900,      '2020-09-20','2027-01-20',1),
(2,'Rines',                2,174,809,     '2020-05-19','2027-07-20',1),
(3,'Retrovisores',         7,77,159,      '2020-08-20','2027-11-19',1),
(4,'Manubrio',             7,693,179,     '2020-10-20','2027-11-19',1),
(5,'Caja de cambios',      4,668,593,     '2020-12-20','2027-09-19',1),
(6,'Bompers',              3,332,78,      '2020-02-19','2027-01-20',1),
(7,'Guarda Fangos',        20,571,558,    '2020-07-20','2027-03-20',1),
(8,'Limpia para brizas',   17,329,665,    '2020-07-20','2027-02-20',1),
(9,'Bujia',                15,747,898,    '2020-11-20','2027-02-19',1),
(10,'Focos Traseros',      11,591,406,    '2020-09-20','2027-04-19',1),
(11,'Frenos',              14,78,900,     '2020-09-20','2027-01-20',1),
(12,'Polarizado',          1,174,809,     '2020-05-19','2027-07-20',1),
(13,'Aceite',              14,77,159,     '2020-08-20','2027-11-19',1),
(14,'Liquido de freno',    13,693,179,    '2020-10-20','2027-11-19',1),
(15,'Jumpers',             12,668,593,    '2020-12-20','2027-09-19',1),

(16,'Llave 1 9/16',             21,0,469,    '2020-05-19','2027-08-20',2),
(17,'Llave 1 5/8',              21,0,19,     '2020-08-19','2027-07-19',2),
(18,'Llave 1 11/16',            2,0,862,     '2020-04-19','2027-08-20',2),
(19,'Llave 1 3/4',              21,0,442,    '2020-05-19','2027-06-20',2),
(20,'Llave 1 1/4',              2,0,909,     '2020-08-20','2027-10-19',2),
(21,'Sierra de mano',           22,0,248,    '2020-03-20','2027-06-20',2),
(22,'Pinza',                    2,0,406,     '2020-09-20','2027-04-19',2),
(23,'Tijeras',                  23,0,405,    '2020-05-20','2027-07-19',2),
(24,'Destornillador Filix',     2,0,616,     '2020-08-20','2027-12-19',2),
(25,'Destornillador Plano',     24,0,671,    '2020-09-19','2027-06-20',2),
(26,'Destornillador Estrella',  25,0,544,    '2020-02-20','2027-06-19',2),
(27,'Sargento',                 3,0,78,      '2020-02-19','2027-01-20',2),
(28,'Tenaza',                   22,0,558,    '2020-07-20','2027-03-20',2),
(29,'Terraja de roscar',        21,0,665,    '2020-07-20','2027-02-20',2),
(30,'Escariador',               2,0,898,     '2020-11-20','2027-02-19',2);



-- Table Aspirante
INSERT INTO Aspirante([idAspirante],[descripcion],[fechaEntrevista],[Persona_idPersona]) 
VALUES
(1,'Area de Tecnologia','2014-01-21',41),
(2,'Area de Contabilidad','2019-12-21',42),
(3,'Area de RRHH','2011-01-17',43),
(4,'Area de Administracion','2018-06-15',44),
(5,'Area de Ventas','2011-07-19',45),
(6,'Area de Almacen','2012-10-31',46),
(7,'Area de Limpieza','2019-06-13',47),
(8,'Area de Gerencia','2016-07-04',48),
(9,'Area de Servicios','2020-06-16',49),
(10,'Area de Taller','2017-08-28',50);

-- Table Curriculum
INSERT INTO Curriculum([idCurriculum],[nombreArchivo],[Aspirante_idAspirante]) 
VALUES
(1,'1. Perry Raymond.docx',1),
(2,'2. Griffin Gross.docx',2),
(3,'3. Damon Hawkins.docx',3),
(4,'4. Fletcher Reed.docx',4),
(5,'5. Aquila Key.docx',5),
(6,'6. Fuller Trujillo.docx',6),
(7,'7. Roth Cochran.docx',7),
(8,'8. Quinlan Boyd.docx',8),
(9,'9. Chandler Vinson.docx',9),
(10,'10. Blaze Santana.docx',10);

-- Table Cargo
INSERT INTO Cargo([idCargo],[descripcion]) 
VALUES
(1,'Presidente'),
(2,'Jefe de RRHH'),
(3,'Asistente de RRHH'),
(4,'Jefe Administrativo'),
(5,'Asistente Administrativo'),
(6,'Consejero'),
(7,'Jefe de Contabilidad'),
(8,'Contador'),
(9,'Encargado de Bodega'),
(10,'Gerente de Ventas'),
(11,'Jefe de Recambios'),
(12,'Vendedor de Recambios'),
(13,'Asistente de Recambios'),
(14,'Cajero'),
(15,'Jefe de Taller'),
(16,'Tecnico'),
(17,'Asesor de Servicios'),
(18,'Operario Lavador de Vehiculos'),
(19,'Administrador de Sistema'),
(20,'Aseador');

-- Table Permisos
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) 
VALUES
(1,'Coronavirus','2019-07-15'),
(2,'Examen de la Universidad','2019-08-18'),
(3,'Llevar el hijo a la escuela','2019-08-15'),
(4,'Tramitar la Visa','2019-02-16'),
(5,'Llevar el perro al veterinario','2019-03-11'),
(6,'Dengue','2019-06-14'),
(7,'Graduacion de Estudios Universitarios','2019-02-20'),
(8,'Defuncion de un Familiar','2019-04-19'),
(9,'Conpulsar titulos para maestria','2019-09-17'),
(10,'Reporte de asalto','2019-02-19');

--Table Vacaciones
INSERT INTO Vacaciones([idVacaciones],[cantidadDias],[FechaInicio],[FechaFin],[FechaRetorno]) 
VALUES
(1,26,'2019-05-12','2020-02-11','2021-02-21'),
(2,25,'2019-11-11','2020-01-19','2021-08-17'),
(3,30,'2019-06-14','2020-05-11','2021-08-11'),
(4,19,'2019-05-13','2020-05-11','2021-03-14'),
(5,23,'2019-02-11','2020-01-18','2021-02-13'),
(6,2,'2019-02-21','2020-04-15','2021-12-17'),
(7,19,'2019-01-13','2020-12-20','2021-02-13'),
(8,21,'2019-09-17','2020-05-18','2021-02-10'),
(9,19,'2019-02-20','2020-04-18','2021-06-16'),
(10,26,'2019-08-14','2020-08-16','2021-08-20');

-- Table Empleado
INSERT INTO Empleado([idEmpleado],[CodigoEmpleado],[descripcion],[JefeInmediato],[Persona_idPersona],[Cargo_idCargo],[AreaTrabajo_idAreaTrabajo]) 
VALUES
(1,'EMP0001','Excelente', 10, 11, 19, 9),
(2,'EMP0002','Excelente', 3, 12, 17, 8),
(3,'EMP0003','Excelente', 5, 13, 15, 7),
(4,'EMP0004','Excelente', 8, 14, 16, 7),
(5,'EMP0005','Excelente', 6, 15, 9, 5),
(6,'EMP0006','Excelente', 7, 16, 2, 2),
(7,'EMP0007','Excelente', 3, 17, 3, 2),
(8,'EMP0008','Excelente', 7, 18, 19, 9),
(9,'EMP0009','Excelente', 9, 19, 17, 8),
(10,'EMP0010','Bueno', 9, 20, 16, 7),
(11,'EMP0011','Bueno', 8, 21, 1, 1),
(12,'EMP0012','Bueno', 1, 22, 2, 2),
(13,'EMP0013','Bueno', 4, 23, 3, 3),
(14,'EMP0014','Bueno', 10, 24, 4, 4),
(15,'EMP0015','Regular', 6, 25, 5, 5),
(16,'EMP0016','Regular', 3, 26, 6, 6),
(17,'EMP0017','Regular', 4, 27, 7, 7),
(18,'EMP0018','Regular', 6, 28, 8, 8),
(19,'EMP0019','Malo', 7, 29, 9, 9),
(20,'EMP0020','Malo', 9, 30, 10, 10);

-- Table Solicitudes
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado])
VALUES
(1,'Vacaciones de mes',3,7,7),
(2,'Vacaciones de semana santa',6,10,5),
(3,'Permiso de Salud',7,9,3),
(4,'Permiso de Estudio',9,8,5),
(5,'Vacaciones de semana morazanica',9,1,4),
(6,'Permiso Familiar',2,8,6),
(7,'Permiso de Obligaciones',10,9,6),
(8,'Vacaciones de Navidad',2,1,4),
(9,'Dias Libres',6,4,5),
(10,'Otros Permisos',2,8,4);

-- Table Reservacion
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) 
VALUES
(1,'elit, dictum eu, eleife.','2020-10-12',7,5),
(2,'magnis dis parturient m mus.','2020-12-12',5,8),
(3,'magna, malesuada vel, cin,','2020-01-20',10,9),
(4,'augue. Sed molestie. Ses quis','2020-02-10',5,5),
(5,'torquent per conubia no','2020-08-12',5,7),
(6,'orci. Ut sagittis lobors.','2020-07-10',8,5),
(7,'eget metus eu erat se. Fusce','2020-02-16',7,1),
(8,'mattis ornare,','2020-09-12',7,4),
(9,'nunc','2020-12-16',10,9),
(10,'ridiculus mus.','2020-05-11',3,4);

-- Table Huella
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) 
VALUES
(1,'Hora Correcta','13:16:19','20:14:33','2020-08-11',7),
(2,'Hora Correcta','06:55:48','08:02:23','2020-01-14',1),
(3,'Hora Correcta','11:27:13','17:51:23','2020-06-18',9),
(4,'Hora Correcta','07:21:43','21:25:34','2020-09-13',1),
(5,'Hora Correcta','12:34:40','17:32:16','2020-04-16',10),
(6,'Retraso','10:13:58','11:24:33','2020-11-10',5),
(7,'Retraso y Salida Temprana','00:43:28','09:03:42','2020-11-13',3),
(8,'Salida Temprana','05:02:42','08:40:07','2020-07-12',8),
(9,'Hora Correcta y Horas extras','03:39:55','10:13:36','2020-02-15',7),
(10,'Horas extras','13:16:19','20:14:33','2020-02-20',5);

-- Table FormaPago
INSERT INTO FormaPago([idFormaPago],[descripcion]) 
VALUES
(1,'Efectivo'),
(2,'Tarjeta de credito/debito'),
(3,'Billeteras Digitales');

-- Table Promociones
INSERT INTO Promociones([idPromociones],[descripcion],[fechaInicio],[fechaFin])
VALUES
(1,'Inicio anio','2020-01-03','2020-02-01'),
(2,'Semana Santa','2020-04-01','2020-04-15'),
(3,'Fin anio','2020-12-15','2020-12-23');


-- Table Factura


-- Table Telefono
INSERT INTO Telefono([idTelefono],[numeroTelefono],[Persona_idPersona]) 
VALUES
(1,'16360925 8813',1),
(2,'16630509 2022',2),
(3,'16670706 8109',3),
(4,'16810926 1548',4),
(5,'16270718 4517',5),
(6,'16021022 7864',6),
(7,'16600830 6638',7),
(8,'16920413 2725',8),
(9,'16560207 0731',9),
(10,'16980717 0999',10),
(11,'16470411 4604',11),
(12,'16251209 2863',12),
(13,'16100829 5907',13),
(14,'16231107 5895',14),
(15,'16191101 9915',15),
(16,'16580529 9830',16),
(17,'16621125 9103',17),
(18,'16390715 8996',18),
(19,'16361214 3663',19),
(20,'16910524 4884',20),
(21,'16630218 5175',21),
(22,'16351221 6874',22),
(23,'16990329 5898',23),
(24,'16350817 1729',24),
(25,'16221216 8518',25),
(26,'16330813 4141',26),
(27,'16830610 6140',27),
(28,'16801212 1318',28),
(29,'16640626 7788',29),
(30,'16500528 8799',30),
(31,'16261003 2159',31),
(32,'16631004 3325',32),
(33,'16300523 3741',33),
(34,'16710719 6037',34),
(35,'16401103 1251',35),
(36,'16680602 3997',36),
(37,'16280728 7517',37),
(38,'16120524 6612',38),
(39,'16681020 3130',39),
(40,'16290718 6494',40),
(41,'16040902 6374',41),
(42,'16610607 1332',42),
(43,'16000622 7821',43),
(44,'16110405 2228',44),
(45,'16540419 2469',45),
(46,'16121107 2622',46),
(47,'16030510 2378',47),
(48,'16190622 0064',48),
(49,'16790419 5596',49),
(50,'16350723 0914',50),
(51,'16151225 2824',51),
(52,'16271224 0585',52),
(53,'16210324 0608',53),
(54,'16590303 1168',54),
(55,'16420815 3413',55),
(56,'16341225 1377',56),
(57,'16100630 1038',57),
(58,'16140206 7548',58),
(59,'16210910 4253',59),
(60,'16751004 6480',60);

-- Table VinculoCyV
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

-- Table Historico_Contratos
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratoPersonal_idContratoPersonal],[Empleado_idEmpleado]) 
VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5),
(6,6,6),
(7,7,7),
(8,8,8),
(9,9,9),
(10,10,10);

-- Table RolPago
INSERT INTO RolPago([idRolPago],[cargo],[fecha],[sueldoBase],[cantidadHE],[pagoHE],[comisiones],[deducciones],[totalPago],[Empleado_idEmpleado]) 
VALUES
(1,'Asesor de Servicios'   ,'2013-08-21',9555,10,40,483     ,666,13869,4),
(2,'Asesor de Servicios'   ,'2019-03-14',7894,12,40,199     ,1436,6095,4),
(3,'Jefe de RRHH'          ,'2016-05-15',14292,12,20,229    ,673,5749,10),
(4,'Administrador Sistema' ,'2013-05-10',11449,11,10,456    ,889,14303,3),
(5,'Administrador Sistema' ,'2018-06-09',8120,12,10,317     ,1488,7187,3),
(6,'Asistente de RRHH'     ,'2017-03-03',13569,11,20,191    ,1456,9484,9),
(7,'Cajero'                ,'2018-06-23',10917,12,40,377    ,1878,14109,2),
(8,'Asesor de Servicios'   ,'2016-04-06',5962,10,10,361     ,1277,5580,4),
(9,'Cajero'                ,'2011-08-12',12844,11,40,268    ,1984,5915,2),
(10,'Jefe de RRHH'         ,'2014-03-14',13930,12,20,223    ,554,13398,10);

-- Table Lista_Servicios
INSERT INTO Lista_Servicios([OrdenTrabajo_idOrdenTrabajo],[Servicios_idServicios],[servicioEfectuado]) 
VALUES
(1,1,0),
(2,2,0),
(3,3,1),
(4,4,1),
(5,5,1),
(6,6,0),
(7,7,1),
(8,8,1),
(9,9,1),
(10,10,1);

-- Table Lista_MyR
INSERT INTO Lista_MyR([OrdenTrabajo_idOrdenTrabajo],[Producto_idProducto],[rebajados]) 
VALUES
(1,1,1),
(2,2,0),
(3,3,0),
(4,4,0),
(5,5,1),
(6,6,1),
(7,7,1),
(8,8,1),
(9,9,0),
(10,10,1);

-- Table Lista_Cotizacion
INSERT INTO Lista_Cotizacion([OrdenTrabajo_idOrdenTrabajo],[Producto_idProducto],[aprovados]) 
VALUES
(1,1,0),
(2,2,0),
(3,3,1),
(4,4,1),
(5,5,0),
(6,6,0),
(7,7,0),
(8,8,1),
(9,9,0),
(10,10,1);

-- Table Estado_Usuario
INSERT INTO Estado_Usuario([idEstado_Usuario],[descripcion]) 
VALUES
(1,'Habilitado'),
(2,'Deshabilitado');

-- Table Usuarios
INSERT INTO Usuarios([idUsuario],[nombreUsuario],[contrasenia],[nombreArchivo],[Empleado_idEmpleado],[Estado_Usuario_idEstado_Usuario]) 
VALUES
(1,'LuisFer15','3xtr1+0eA'              ,'1. LuisFer15.jpg',1,1), -- Extremo15
(2,'Rene2','.6s6-0p8rt6-7l8sU'          ,'2. Rene.png',2,1), -- Fisicoparticulas2
(3,'Mary17','G8+14!Thr0 1sie'           ,'3. Mary17.jpg',3,1), -- GameOfThrones61
(4,'MarvinPonce','V8s0UEe'              ,'default.png',4,1), -- Vaso231
(5,'Goku10','K8+1H8+1H8'                ,'default.png',5,1), -- KameHameHa
(6,'Vegeta20','R1spl8 _0r.6 8l'         ,'default.png',6,1), -- ResplandorFinal
(7,'elRubius','G8t0e'                   ,'default.png',7,1), -- Gato1
(8,'MasterChief','?0rt0 8'              ,'default.png',8,1), -- Cortona
(9,'Link20','Z1l_84-8r6 84!T6+1U'       ,'default.png',9,1), -- ZeldaOcarinaOfTime2
(10,'Dazu','2/5HUoUo'                   ,'default.png',10,1), -- UNAH2020
(11,'Hu','PQU24OYM5OU'                  ,'default.png',11,1),
(12,'Denton','NAG63DHW6XI'              ,'default.png',12,1),
(13,'Emerson','QMF57AGC8LI'             ,'default.png',13,1),
(14,'Rajah','JED04HBG6GS'               ,'default.png',14,1),
(15,'Ferris','FCU55FMI1MJ'              ,'default.png',15,2),
(16,'Elliott','GBB29FUO7LZ'             ,'default.png',16,1),
(17,'Logan','HLV64AZT9VC'               ,'default.png',17,1),
(18,'Prescott','TEN88XYH0ZN'            ,'default.png',18,1),
(19,'Nissim','GKR57UFE1NF'              ,'default.png',19,1),
(20,'Zachary','NQI46GIZ7XV'             ,'default.png',20,2);

-- Table Accion


-- Table Registro_de_Actividad

