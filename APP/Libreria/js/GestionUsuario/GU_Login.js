/* Funcionalidad: Login
 * Datos a Enviar:
 * usuario, password
 * 
 * Datos por Recibir:
 * <ninguno>
*/
$("#btn-login").click(function () {
	$.ajax({
		url: "http://localhost:3000/volvo/api/GU/GU_LOGIN",
		data: {
            "usuario" : $("#usuario").val(),
            "password" : $("#password").val(),
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
				window.location.href = "http://localhost:3000/volvo";
			}else{
				$("#notificacion").replaceWith('<label  id="notificacion" style="color: brown;">'+respuesta.pmensaje+'</label>');// respuesta.pmensaje.error);
			}
		},
		error: function (error) {
			$("#notificacion").append(error.responseText);
		}
	});
	return false;
});