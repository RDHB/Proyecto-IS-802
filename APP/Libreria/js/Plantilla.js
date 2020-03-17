/* Funcionalidad: <nombre_funcionalidad>
 * Datos a Enviar:
 * parametro1, parametro2, parametro3, <ninguno>
 * 
 * Datos por Recibir:
 * dato1, dato2, dato3, <ninguno>
*/
$("#btn-").click(function () {
	$.ajax({
		url: "http://localhost:3000/volvo/api/<Modulo>/<Ruta>",
        data: {
            "parametro1" : $("#idparametro1").val(),
            "parametro2" : $("#idparametro2").val(),
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
				// Accion en caso de que no hay error del servidor
			}else{
				// Accion en caso de que hay error del servidor 
			}
		},
		error: function (error) {
            // Accion en caso de que hay error de comunicacion con el servidor 
			$("#notificacion").append(error.responseText);
		}
	});
	return false;
});