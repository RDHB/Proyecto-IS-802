-- Area Trabajo
select e.codigoEmpleado, art.descripcion from AreaTrabajo art
inner join Empleado E on E.AreaTrabajo_idAreaTrabajo = art.idAreaTrabajo
/* Recomendaciones:
 * 
 * 
*/



-- Cargo
select nombreUsuario, e.Cargo_idCargo, c.descripcion from Usuarios u
inner join Empleado E on u.Empleado_idEmpleado = e.idEmpleado
inner join Cargo c on c.idCargo = e.Cargo_idCargo
/* Recomendaciones: 
 * El cargo debe ser parte del area de trabjo
*/



-- Horas extras
select * from AreaTrabajo
select * from Horas_extras
select * from Historico_HE

select art.descripcion, he.idHoras_extras, he.fecha, he.horaInicio, he.horaFin from Horas_extras he
inner join Historico_HE hhe on hhe.Horas_extras_idHoras_extras = he.idHoras_extras
inner join AreaTrabajo art on art.idAreaTrabajo = hhe.AreaTrabajo_idAreaTrabajo
order by art.idAreaTrabajo
/* Recomendaciones:
 * El area de trabajo no puede tener mas de una hora extra en el mismo dia
 * Validar que la hora de inicio sea menor que la hora fin
 * Todas las horas extras deben empezar a partir de las 4 de la tarde
 * Todas las horas extras deben comprender por lo menos 1 hora y maximo durar 3 horas
 * Las horas extras deben crearse en el mismo año
*/



-- Huella
select codigoEmpleado, horaEntrada, horaSalida, h.fecha from Huella h
inner join Empleado e on e.idEmpleado = h.Empleado_idEmpleado
order by codigoEmpleado
/* Recomendaciones:
 * El empleado no puede tener mas de una huella en el mismo dia
 * Validar que la hora de entrada sea menor que la hora de salida
 * Todas las huellas deben empezar a partir de las 8 de la mañana
 * Todas las huellas deben comprender por lo menos 1 hora y maximo durar 11 horas
 * Las huellas deben crearse en el mismo dia si se utiliza la maquina, si no deben crearse en un rango de un mes del dia actual
*/



-- Contrato
select * from ContratoPersonal
select * from Historico_Contratos
select * from Empleado

select e.codigoEmpleado, cp.idContratoPersonal, cp.fechaContrato, cp.sueldo from ContratoPersonal cp
inner join Historico_Contratos hcp on hcp.ContratoPersonal_idContratoPersonal = cp.idContratoPersonal
inner join Empleado e on e.idEmpleado = hcp.Empleado_idEmpleado
order by e.codigoEmpleado
/* Recomendaciones:
 * Los contratos deben crearse si el aspirante ya cuenta con una descripcion
 * Validar que la hora de entrada sea menor que la hora de salida
 * La diferencia de la hora de entrada con la hora de salida debe ser mayor a 7 y menor a 9
*/



-- Rol de Pago
select rp.idRolPago, rp.cargo, c.descripcion from RolPago rp
inner join Empleado e on e.idEmpleado = rp.Empleado_idEmpleado
inner join Cargo c on c.idCargo = e.Cargo_idCargo
/* Recomendaciones:
 * El empleado solo puede tener un pago al mes
 * Se crea un rol de pago sin fecha
 * Cuando se le de acepatar se le agrega la fecha, si no se elimina el rol de pago
*/



-- Solicitudes Permisos
select * from Empleado
select * from Solicitudes
select * from Permisos

select e.codigoEmpleado, s.descripcion, p.motivo, p.fecha  from Permisos p
inner join Solicitudes s on s.Permisos_idPermisos = p.idPermisos
inner join Empleado e on e.idEmpleado = s.Empleado_idEmpleado
/* Recomendaciones:
 * Los permisos sirven para llenar la tabla huella durante un dia
 * Los permisos solo se pueden dar un dia para todo el dia
 * Un empleado no puede tener mas de 5 permisos en el mes
*/



-- Solicitudes Vacaciones
select * from Empleado
select * from Solicitudes
select * from Vacaciones

select e.codigoEmpleado, s.descripcion, v.cantidadDias, v.fechaInicio, v.fechaFin, v.fechaRetorno from Vacaciones v
inner join Solicitudes s on s.Vacaciones_idVacaciones = v.idVacaciones
inner join Empleado e on e.idEmpleado = s.Empleado_idEmpleado
/* Recomendaciones:
 * Validar que la fecha de inicio sea menor que la fecha fin, y que la fecha fin sea menor que la fecha de retorno
 * Un empleado no puede tener mas de dos solicitudes de vacaciones al año
 * Los dias de vacaciones no pueden superar los 40 dias
*/