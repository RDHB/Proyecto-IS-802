$(Document).ready(function(){
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
    }).
    then(function(){
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
    }).
    then(function(){
        informacionUsuarios();
    });
});

$('#plus').click(function(){
    $('#plusUser').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
      });
});


$('#selectEstadoUsuario').change(function(){
    $('#bodyTable').empty();
    informacionUsuarios();
});    

$('#selectAreaTrabajo').change(function(){
    $('#bodyTable').empty();
    informacionUsuarios();
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
            if (respuesta.output.pcodigoMensaje == 0) {
                $("#notificacion").replaceWith('<span  id="notificacion" style="color: green;">'+respuesta.output.pmensaje+'</span>');
			}else{
                $("#notificacion").replaceWith('<span  id="notificacion" style="color: brown;">'+respuesta.output.pmensaje+'</span>');
            }
        },
        error : function(error){
            $("#notificacion").replaceWith('<span  id="notificacion" style="color: brown;">'+error.responseText+'</span>');
        }
    });
});    


$('#searchName').keyup(function(){
    if($('#searchName').val()!= ''){
        $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'SELECT',
                "idEstadoUsuario" : $('#selectEstadoUsuario').val(),
                "idAreaTrabajo" : $('#selectAreaTrabajo').val()
    
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    $('#bodyTable').empty();
                    const bodyTable = document.querySelector("#bodyTable");
                    bodyTable.innerHTML = '';
                    const usuarioFrontEnd = $('#searchName').val().toLowerCase();
                    for(let usuarioBackEnd of respuesta.data){
                        let usuario =  usuarioBackEnd.nombrePersona.toLowerCase();
                        if(usuario.indexOf(usuarioFrontEnd) !== -1){
                            bodyTable.innerHTML += `
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="${usuarioBackEnd.idUsuario}" value="${{idUsuario: usuarioBackEnd.idUsuario, nombreUsuario: usuarioBackEnd.nombreUsuario, correoElectronico: usuarioBackEnd.correoElectronico, telefono: usuarioBackEnd.numeroTelefono}}" style="width:10px; height:100%;"/>
                                            <label for="${usuarioBackEnd.idUsuario}">.</label>
                                        </th>
                                        <td style="width:15px; text-align:center;">${usuarioBackEnd.idUsuario}</td>
                                        <td>${usuarioBackEnd.nombrePersona}</td>
                                        <td>${usuarioBackEnd.nombreUsuario}</td>
                                        <td>${usuarioBackEnd.correoElectronico}</td>
                                        <td>${usuarioBackEnd.numeroTelefono}</td>
                                        <td>${usuarioBackEnd.AreaTrabajo}</td>
                                    </tr>
                                `;
                        }
                    }

                    if(bodyTable.innerHTML === ''){
                        bodyTable.innerHTML += `
                                    <tr style="display:flexbox; justify-content: center; align-content: center; width:100%;">
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th>
                                            <span style="width:100%; text-align:center;"> No hay registros con ese nombre</span>
                                        </th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                            `;
                    }
                }
            }
        });
    }else{
        $('#bodyTable').empty();
        informacionUsuarios();
    }
});


function informacionUsuarios(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT',
            "idEstadoUsuario" : $('#selectEstadoUsuario').val(),
            "idAreaTrabajo" : $('#selectAreaTrabajo').val()

        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                for(i=0; i < respuesta.data.length; i++){
                    $('#bodyTable').append('<tr><th><input type="checkbox" id="'+respuesta.data[i].idUsuario+'" data-json="'+{idUsuario: respuesta.data[i].idUsuario, nombreUsuario: respuesta.data[i].nombreUsuario,correoElectronico: respuesta.data[i].correoElectronico, telefono: respuesta.data[i].numeroTelefono}+'" style="width:10px; height:100%;"/><label for="'+respuesta.data[i].idUsuario+'">.</label></th><td style="width:15px; text-align:center;">'+respuesta.data[i].idUsuario+'</td><td>'+respuesta.data[i].nombrePersona+'</td><td>'+respuesta.data[i].nombreUsuario+'</td><td>'+respuesta.data[i].correoElectronico+'</td><td>'+respuesta.data[i].numeroTelefono+'</td><td>'+respuesta.data[i].AreaTrabajo+'</td></tr>');
                }
            }
        }
    });
}


$('#btnEditarUsuario').click(function(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        //seleccionados.push($(this).val());
        console.log($.parseJSON($(this).data('json')));
    });

    if(seleccionados.length == 1){
        $('#editUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
          });
        //console.log(seleccionados[0].nombreUsuario);
        /*$('$updateNombreUsuario').val() = seleccionados[0].nombreUsuario;
        $('$updateCorreoElectronico').val() = seleccionados[0].correoElectronico;
        $('$updateTelefono').val() = seleccionados[0].telefono;*/
    }
    
});


/*$('input[type=checkbox]').on('change', function() {
    if ($(this).is(':checked') ) {
        console.log("Checkbox " + $(this).prop("id") +  " (" + $(this).val() + ") => Seleccionado");
    } else {
        console.log("Checkbox " + $(this).prop("id") +  " (" + $(this).val() + ") => Deseleccionado");
    }
});*/