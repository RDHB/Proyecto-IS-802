/*
-- Funcion Agregar Curriculum
-- Se necesita como parametro el numero de identidad
declare @nid varchar(45);
set @nid = '16740812 6659';
update Curriculum set 
descripcion = CONCAT(
	CAST( (
			select idAspirante from Aspirante a 
			inner join persona p on p.idPersona = a.Persona_idPersona
			where p.numeroIdentidad = @nid
		) AS VARCHAR
	)
	, '. '
	, (
		select CONCAT(p.primerNombre, ' ', p.primerApellido) from Persona p
		where p.numeroIdentidad = @nid
	)
	, '.docx'
)
where Aspirante_idAspirante = (
	select a.idAspirante from Persona p
	inner join Aspirante a on p.idPersona = a.Persona_idPersona
	where p.numeroIdentidad = @nid
)
*/