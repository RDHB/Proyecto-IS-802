$("#btn-login").click(function () {
	$.ajax({
		url: "http://localhost:3000/SP_LOGIN",
		data: "usuario=" + $("#usuario").val() + "&password=" + $("#password").val(),
		dataType: "json",
		method: "POST",
		success: function (respuesta) {

			if (respuesta.pnCodigoMensaje == 0) {
				switch (respuesta.pnIdCargo) {
					case 1:
						// Administrador
						window.location.href = "GestionUsuario/GU_Home.html";
						break;
					case 2:
						// Asesor de Servicios
						window.location.href = "OrdenTrabajo/OT-A_Home.html";
						break;
					case 3:
						window.location.href = "OrdenTrabajo/OT-J_Home.html";
						// Jefe de Taller
						break;
					case 4:
						window.location.href = "OrdenTrabajo/OT-T_Home.html";
						// Tecnico
						break;
					case 5:
						window.location.href = "OrdenTrabajo/OT-E_Home.html";
						// Encargado de Bodega
						break;
					case 6:
						window.location.href = "RRHH/RH-J_Home.html";
						// Jefe de RRHH
						break;
					case 7:
						// Asistente de RRHH
						window.location.href = "RRHH/RH-A_Home.html";
						break;
					case 8:
						window.location.href = "Facturacion/FA_Home.html";
						// Cajero de Servicios			
						break;
					default:
					// code block
				}
			}else{
				//$("#notificacion").append(respuesta.pcMensaje);
				alert(respuesta.pcMensaje);
			}
		},
		error: function (error) {
			$("#notificacion").append(error.responseText);
		}
	});
	return false;
	
});