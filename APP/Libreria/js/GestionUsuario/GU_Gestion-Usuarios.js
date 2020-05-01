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
                $("#newNotificacion").replaceWith('<span  id="newNotificacion" style="color: green;">'+respuesta.output.pmensaje+'</span>');
			}else{
                $("#newNotificacion").replaceWith('<span  id="newNotificacion" style="color: brown;">'+respuesta.output.pmensaje+'</span>');
            }
        },
        error : function(error){
            $("#newNotificacion").replaceWith('<span  id="newNotificacion" style="color: brown;">'+error.responseText+'</span>');
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
                                            <input type="checkbox" id="${usuarioBackEnd.idUsuario}" value="${usuarioBackEnd.idUsuario}" style="width:10px; height:100%;"/>
                                            <label for="${usuarioBackEnd.idUsuario}">.</label>
                                        </th>
                                        <td style="width:15px; text-align:center;">${usuarioBackEnd.idUsuario}</td>
                                        <td id="${'nombrePersona'+usuarioBackEnd.idUsuario}">${usuarioBackEnd.nombrePersona}</td>
                                        <td id="${'nombreUsuario'+usuarioBackEnd.idUsuario}">${usuarioBackEnd.nombreUsuario}</td>
                                        <td id="${'correoElectronico'+usuarioBackEnd.idUsuario}">${usuarioBackEnd.correoElectronico}</td>
                                        <td id="${'numeroTelefono'+usuarioBackEnd.idUsuario}">${usuarioBackEnd.numeroTelefono}</td>
                                        <td id="${'areaTrabajo'+usuarioBackEnd.idUsuario}">${usuarioBackEnd.AreaTrabajo}</td>
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
                    $('#bodyTable').append(`
                        <tr>
                            <th>
                                <input type="checkbox" id="${respuesta.data[i].idUsuario}" value="${respuesta.data[i].idUsuario}" style="width:10px; height:100%;"/>  
                                <label for="${respuesta.data[i].idUsuario}">.</label>
                            </th>
                            <td style="width:15px; text-align:center;">${respuesta.data[i].idUsuario}</td>
                            <td id="${'nombrePersona'+respuesta.data[i].idUsuario}">${respuesta.data[i].nombrePersona}</td>
                            <td id="${'nombreUsuario'+respuesta.data[i].idUsuario}">${respuesta.data[i].nombreUsuario}</td>
                            <td id="${'correoElectronico'+respuesta.data[i].idUsuario}">${respuesta.data[i].correoElectronico}</td>
                            <td id="${'numeroTelefono'+respuesta.data[i].idUsuario}">${respuesta.data[i].numeroTelefono}</td>
                            <td id="${'areaTrabajo'+respuesta.data[i].idUsuario}">${respuesta.data[i].AreaTrabajo}</td>
                        </tr>`
                    );
                }
            }
        }
    });
}


$('#btnEditarUsuario').click(function(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    if(seleccionados.length == 1){
        $('#editUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
          });
        $('#updateNombreUsuario').val($('#nombreUsuario'+seleccionados[0]).text());
        $('#updateCorreoElectronico').val($('#correoElectronico'+seleccionados[0]).text());
        $('#updateNumeroTelefono').val($('#numeroTelefono'+seleccionados[0]).text());
    }
    
});
