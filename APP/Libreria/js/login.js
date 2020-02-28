$("#btn-login").click(function () {
	//alert( $("#usuario").val() + " " + $("#password").val() );
	
	$.ajax({
		url: "php/proceso-login.php",
		data: "usuario=" + $("#usuario").val() + "&password=" + $("#password").val(),
		dataType: "json",
		method: "POST",
		success: function (respuesta) {

			console.log(respuesta);

			if (respuesta.CodigoMensaje == 0) {
				switch (respuesta.IdCargo) {
					case 1:
						// Administrador
						window.location.href = "GestionUsuario/GU_Home.html";
						break;
					case 7:
						// Asesor de Servicios
						window.location.href = "OrdenTrabajo/OT-A_Home.html";
						break;
					case 12:
						window.location.href = "OrdenTrabajo/OT-J_Home.html";
						// Jefe de Taller
						break;
					case 13:
						window.location.href = "OrdenTrabajo/OT-T_Home.html";
						// Tecnico
						break;
					case 14:
						window.location.href = "OrdenTrabajo/OT-E_Home.html";
						// Encargado de Bodega
						break;
					case 15:
						window.location.href = "RRHH/RH-J_Home.html";
						// Jefe de RRHH
						break;
					case 16:
						// Asistente de RRHH
						window.location.href = "RRHH/RH-A_Home.html";
						break;
					case 17:
						window.location.href = "Facturacion/FA_Home.html";
						// Cajero de Servicios			
						break;
					default:
					// code block
				}
			} else {
				console.log(${respuesta});
			}

		},
		error: function (error) {
			console.error(error);
			//$("#notificacion").append(error.responseText);
		}
	});
	return false;
	
});