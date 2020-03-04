$("#btn-login").click(function () {
	$.ajax({
		url: "http://localhost:3000/volvo/api/GU/SP_LOGIN",
		data: "usuario=" + $("#usuario").val() + "&password=" + $("#password").val(),
		dataType: "json",
		method: "POST",
		success: function (respuesta) {

			if (respuesta.pcodigoMensaje == 0) {
				window.location.href = "http://localhost:3000/volvo";
			}else{
				//$("#notificacion").append(respuesta.pcMensaje);
				alert(respuesta.pMensaje);
			}
		},
		error: function (error) {
			$("#notificacion").append(error.responseText);
		}
	});
	return false;
	
});