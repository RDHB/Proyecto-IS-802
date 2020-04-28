$(Document).ready(function(){
    $.ajax({
		url: "https://localhost:3000/volvo/api/GU/GU_LOGIN",
		data: {
            "usuario" : 'Murphy',
            "password" : 'FSJ44MIN4FJ',
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
                localStorage.setItem('token',respuesta.token);
			}
		}
    }).then(function(){
        $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "nombreTabla" : 'AreaTrabajo',
                "accion"      : 'SELECT'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                if (respuesta.output.pcodigoMensaje == 0) {
                    for(i=0; i< respuesta.data.length; i++){
                        $('#selectAreaTrabajo').append('<option value="'+respuesta.data[i].idAreaTrabajo+'">'+respuesta.data[i].descripcion+'</option>');
                    }
                }
            }
        });
    }).then(function(){
        $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "nombreTabla" : 'Estado_Usuario',
                "accion"      : 'SELECT'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                if (respuesta.output.pcodigoMensaje == 0) {
                    for(i=0; i< respuesta.data.length; i++){
                        $('#selectEstadoUsuario').append('<option value="'+respuesta.data[i].idEstado_Usuario+'">'+respuesta.data[i].descripcion+'</option>');
                    }
                }
            }
        });
    })
});

$('#plus').click(function(){
    $('#plusUser').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
      });
});

$('#agregarUser').click(function(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
		data: {
            "codigoEmpleado" : $('#newCodigoEmpleado').val(),
            "nombreUsuario" : $('#newUser').val(),
            "contrasenia" : $('#newPassword').val(),
            "accion" : 'INSERT'
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
				$("#notificacion").replaceWith('<span  id="notificacion" style="color: green;">'+respuesta.pmensaje+'</span>');
			}else{
                $("#notificacion").replaceWith('<span  id="notificacion" style="color: brown;">'+respuesta.pmensaje+'</span>');
            }
        },
        error : function(error){
            $("#notificacion").replaceWith('<span  id="notificacion" style="color: brown;">'+error.responseText+'</span>');
        }
    });
});    

