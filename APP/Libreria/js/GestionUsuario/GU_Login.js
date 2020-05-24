/* Funcionalidad: Login
 * Datos a Enviar:
 * usuario, password
 * 
 * Datos por Recibir:
 * <ninguno>
*/
$("#btn-login").click(function () {
	$.ajax({
		url: "https://localhost:3000/volvo/api/GU/GU_LOGIN",
		data: {
            "usuario" : $("#usuario").val(),
            "password" : $("#password").val(),
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
				localStorage.setItem('token',respuesta.token);
				localStorage.setItem('usuario',respuesta.usuario);
				localStorage.setItem('nombre',respuesta.nombre);
				localStorage.setItem('nombreArchivo',respuesta.nombreArchivo);
				localStorage.setItem('cargo',respuesta.pidCargo);
				window.location.href = "https://localhost:3000/volvo";
			}else{
				$("#notificacion").replaceWith('<label  id="notificacion" style="color: brown;">'+respuesta.pmensaje+'</label>');
			}
		},
		error: function (error) {
			$("#notificacion").append(error.responseText);
		}
	});
	return false;
});