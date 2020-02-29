
select codigoEmpleado, Cargo_idCargo, u.nombreUsuario, u.contrasenia from Usuarios u 
inner join Empleado e on e.idEmpleado = u.Empleado_idEmpleado


declare @cMensaje int;
declare @Mensaje varchar(1000);
declare @cEmpleado varchar(50);
declare @pnIdCargo  int;

exec SP_LOGIN
	'Plato', 
	'BHE81RRR3RE', 
	@cMensaje output,
	@Mensaje output,
	@cEmpleado output,
	@pnIdCargo output
;

select @cMensaje;
select @Mensaje;
select @cEmpleado;
select @pnIdCargo;


select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero'

