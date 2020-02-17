--Historico_HorasExtras

INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(1,4,3);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(2,10,6);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(3,3,10);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(4,7,2);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(5,4,10);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(6,3,10);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(7,1,8);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(8,3,5);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(9,2,4);
INSERT INTO Historico_HorasExtras([idHistorico_HorasExtras],[AreadeTrabajo_idAreadeTrabajo],[Horas_extras_idHoras_extras]) VALUES(10,5,4);

--Empleado
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(1,'Morbi sit',10,4,1,2,2);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(2,'dui augue eu tellus. Phasellus',3,7,1,3,1);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(3,'In ornare sagittis felis.',5,3,7,1,10);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(4,'Vivamus nisi.',8,6,9,5,9);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(5,'quam quis',6,1,10,4,7);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(6,'leo. Cras vehicula aliquet',7,1,7,7,9);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(7,'nunc sed pede. Cum sociis',3,7,6,1,3);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(8,'sodales. Mauris blandit enim consequat',7,3,8,10,4);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(9,'eu nulla at',9,6,10,1,3);
INSERT INTO Empleado([idEmpleado],[descripcion],[JefeInmediato],[Pesona_idPersona],[Cargo_idCargo],[AreadeTrabajo_idAreadeTrabajo],[CodigodeEmpleado]) VALUES(10,'orci',9,4,2,9,1);

--RolPago
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(1,9555,'21/08/13',483,10,4,13869,666,3695,'dolor vitae',4);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(2,7894,'14/03/19',199,12,4,6095,1436,2076,'turpis egestas. Aliquam fringilla',4);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(3,14292,'15/05/16',229,12,2,5749,673,3703,'vel sapien',10);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(4,11449,'10/05/13',456,11,1,14303,889,4960,'tempor, est',3);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(5,8120,'09/06/18',317,12,1,7187,1488,1512,'lectus sit',3);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(6,13569,'03/03/17',191,11,2,9484,1456,1149,'magna tellus',9);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(7,10917,'23/06/18',377,12,4,14109,1878,3873,'Duis risus',2);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(8,5962,'06/04/16',361,10,1,5580,1277,3952,'mollis.',4);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(9,12844,'12/08/11',268,11,4,5915,1984,1648,'vestibulum lorem, sit amet',2);
INSERT INTO RolPago([idRolPago],[Sueldo],[Fecha],[Deducciones],[Cantidad de HT],[Cantidad de HE],[Pago de HT],[Pago de HE],[Comisiones],[Cargo],[Empleado_idEmpleado]) VALUES(10,13930,'14/03/14',223,12,2,13398,554,2823,'sed sem egestas',10);

--Solicitudes
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(1,'malesuada malesuada. Integer id magna',3,7,7);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(2,'quis',6,10,5);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(3,'Sed et libero. Proin',7,9,3);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(4,'Fusce dolor quam, elementum',9,8,5);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(5,'ornare, libero',9,1,4);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(6,'turpis egestas. Aliquam',2,8,6);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(7,'mauris sapien, cursus in, hendrerit',10,9,6);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(8,'eleifend, nunc risus',2,1,4);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(9,'lobortis, nisi',6,4,5);
INSERT INTO Solicitudes([idSolicitudes],[descripcion],[Permisos_idPermisos],[Vacaciones_idVacaciones],[Empleado_idEmpleado]) VALUES(10,'Nulla tincidunt,',2,8,4);

--Vacaciones
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(1,26,'20/05/12','13/02/11','06/02/21');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(2,25,'07/11/11','28/01/19','21/08/17');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(3,30,'22/06/14','20/05/11','18/08/11');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(4,19,'27/05/13','31/05/11','29/03/14');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(5,23,'11/02/11','27/01/18','04/02/13');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(6,2,'03/02/21','30/04/15','29/12/17');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(7,19,'12/01/13','04/12/20','09/02/13');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(8,21,'24/09/17','01/05/18','21/02/10');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(9,19,'23/02/20','01/04/18','26/06/16');
INSERT INTO Vacaciones([idVacaciones],[Cantidad de Dias],[FechaInicio],[FechaFin],[FechaRetorno]) VALUES(10,26,'23/08/14','28/08/16','06/08/20');

--Permisos
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(1,'magna. Phasellus dolor elit,','02/07/15');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(2,'posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo','17/08/18');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(3,'Proin','03/08/15');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(4,'pede et risus. Quisque libero lacus, varius','23/02/16');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(5,'convallis dolor. Quisque tincidunt pede ac','16/03/11');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(6,'accumsan','19/06/14');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(7,'leo. Vivamus nibh dolor, nonummy ac, feugiat non, lobortis','15/02/20');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(8,'at, velit. Pellentesque ultricies dignissim lacus. Aliquam','14/04/19');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(9,'iaculis quis,','16/09/17');
INSERT INTO Permisos([idPermisos],[motivo],[fecha]) VALUES(10,'purus. Nullam','09/02/19');

--TipoContrao
INSERT INTO TipoContrato([idTipoContrato],[descripcion]) VALUES(1,'penatibus et magnis dis parturient');
INSERT INTO TipoContrato([idTipoContrato],[descripcion]) VALUES(2,'amet nulla. Donec non');

--Contratos de Personal
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(1,7571,9,15,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(2,13661,10,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(3,5402,9,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(4,10179,9,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(5,10815,8,14,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(6,12695,8,16,1);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(7,8575,10,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(8,6515,9,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(9,6285,10,16,2);
INSERT INTO ContratosdePersonal([idContratosdePersonal],[Sueldo],[HoraEntrada],[HoraSalida],[TipoContrato_idTipoContrato]) VALUES(10,12295,9,16,2);

--Cargo
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(1,'Pellentesque habitant morbi tristique');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(2,'felis. Nulla tempor augue ac');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(3,'lobortis');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(4,'Donec dignissim');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(5,'vitae, posuere at,');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(6,'non, sollicitudin');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(7,'dolor. Quisque tincidunt');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(8,'mi');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(9,'taciti sociosqu ad');
INSERT INTO Cargos([idCargo],[descripcion]) VALUES(10,'dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies');

--AreadeTrabajo
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(1,'pulvinar arcu et pede.');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(2,'ipsum primis in');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(3,'luctus et ultrices posuere cubilia');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(4,'rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(5,'turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(6,'Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(7,'lorem tristique aliquet.');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(8,'tortor nibh sit amet orci. Ut sagittis');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(9,'Duis volutpat nunc sit amet metus. Aliquam erat volutpat.');
INSERT INTO AreadeTrabajo([idAreadeTrabajo],[descripcion]) VALUES(10,'vitae, posuere at, velit. Cras lorem lorem, luctus');

--Reservaciòn
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(1,'elit, dictum eu, eleifend nec, malesuada ut, sem.','17/10/12',7,5);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(2,'magnis dis parturient montes, nascetur ridiculus mus.','31/12/12',5,8);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(3,'magna, malesuada vel, convallis in,','10/01/20',10,9);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(4,'augue. Sed molestie. Sed id risus quis','27/02/10',5,5);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(5,'torquent per conubia nostra, per','03/08/12',5,7);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(6,'orci. Ut sagittis lobortis mauris.','08/07/10',8,5);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(7,'eget metus eu erat semper rutrum. Fusce','22/02/16',7,1);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(8,'mattis ornare,','05/09/12',7,4);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(9,'nunc','09/12/16',10,9);
INSERT INTO Reservacion([idReservacion],[descripcion],[cita],[Empleado_idEmpleado],[Cliente_idCliente]) VALUES(10,'ridiculus mus.','26/05/11',3,4);

--Aspirante
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(1,'condimentum. Donec at arcu. Vestibulum ante ipsum',8);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(2,'vel, mauris. Integer sem',7);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(3,'Cras lorem lorem,',1);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(4,'dolor vitae dolor. Donec fringilla. Donec feugiat metus sit',10);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(5,'convallis convallis',9);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(6,'purus mauris a nunc. In at pede. Cras',6);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(7,'nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque',5);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(8,'facilisis eget,',2);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(9,'tristique aliquet. Phasellus fermentum convallis',10);
INSERT INTO Aspirante([idAspirante],[descripcion],[Persona_idPersona]) VALUES(10,'amet orci. Ut',3);

--Curriculum
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(1,'non enim commodo hendrerit. Donec porttitor',8);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(2,'turpis vitae purus gravida sagittis. Duis gravida.',5);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(3,'euismod ac, fermentum vel, mauris. Integer sem elit, pharetra',8);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(4,'eu enim. Etiam imperdiet',6);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(5,'Aenean euismod',8);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(6,'lacus,',6);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(7,'aliquet vel, vulputate eu, odio. Phasellus at augue',1);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(8,'fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies',6);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(9,'nisl.',5);
INSERT INTO Curriculum([idCurriculum],[descripcion],[Aspirante_idAspirante]) VALUES(10,'tortor at risus. Nunc ac sem',5);

--Huella
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(1,'interdum. Sed auctor',8,15,'29/08/11',7);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(2,'velit. Cras lorem lorem, luctus ut, pellentesque eget,',8,14,'04/01/14',1);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(3,'a, magna.',9,14,'24/06/18',9);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(4,'dui quis accumsan convallis, ante lectus convallis est, vitae',10,15,'24/09/13',1);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(5,'dictum eu, placerat eget, venenatis a, magna.',8,14,'03/04/16',10);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(6,'non',10,15,'23/11/10',5);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(7,'nisl sem,',10,15,'26/11/13',3);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(8,'hendrerit a, arcu.',8,14,'15/07/12',8);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(9,'vitae erat vel pede blandit congue.',9,15,'23/02/15',7);
INSERT INTO Huella([idHuella],[descripcion],[HoraEntrada],[HoraSalida],[Fecha],[Empleado_idEmpleado]) VALUES(10,'Nunc mauris elit, dictum eu, eleifend',10,16,'07/02/20',5);

--EntrevistaTrabajo
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(1,'21/01/2014',6);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(2,'21/12/2019',3);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(3,'17/01/2011',6);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(4,'15/06/2018',7);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(5,'19/07/2011',5);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(6,'31/10/2012',1);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(7,'13/06/2019',10);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(8,'04/07/2016',9);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(9,'16/06/2020',2);
INSERT INTO EntrevistaTrabajo([idEntrevistaTrabajo],[Hora_Fecha],[Curriculum]) VALUES(10,'28/08/2017',8);

--Historico_Contratos
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(1,5,7);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(2,3,6);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(3,7,5);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(4,5,5);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(5,7,5);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(6,8,9);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(7,6,1);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(8,3,4);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(9,4,9);
INSERT INTO Historico_Contratos([idHistorico_Contratos],[ContratosdePersonal_idContratosdePersonal],[Empleado_idEmpleado]) VALUES(10,10,3);

--HorasExtras
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(1,14,19,'05/08/15');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(2,14,21,'16/11/11');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(3,14,19,'01/05/19');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(4,16,21,'08/01/20');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(5,15,21,'17/02/17');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(6,16,19,'22/10/14');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(7,15,21,'19/05/12');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(8,14,20,'21/03/16');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(9,14,21,'08/03/11');
INSERT INTO Horas_extras([idHoras_extras],[HoraInicio],[HoraFin],[fecha]) VALUES(10,14,19,'02/04/18');
