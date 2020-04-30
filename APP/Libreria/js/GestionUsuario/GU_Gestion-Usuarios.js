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
        $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'SELECT'
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    for(i=0; i < respuesta.data.length; i++){
                        $('#bodyTable').append('<tr><th><input type="checkbox" id="'+respuesta.data[i].idUsuario+'" value="'+respuesta.data[i].idUsuario+'" style="width:10px; height:100%;"/><label for="'+respuesta.data[i].idUsuario+'">.</label></th><td style="width:15px; text-align:center;">'+respuesta.data[i].idUsuario+'</td><td>'+respuesta.data[i].nombrePersona+'</td><td>'+respuesta.data[i].nombreUsuario+'</td><td>'+respuesta.data[i].correoElectronico+'</td><td>'+respuesta.data[i].numeroTelefono+'</td><td>'+respuesta.data[i].AreaTrabajo+'</td></tr>');
                    }
                }
            }
        });
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


function informacionUsuarios(){
    console.log($('#selectAreaTrabajo').val());
    console.log($('#selectEstadoUsuario').val());
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
                    $('#bodyTable').append('<tr><th><input type="checkbox" id="'+respuesta.data[i].idUsuario+'" value="'+respuesta.data[i].idUsuario+'" style="width:10px; height:100%;"/><label for="'+respuesta.data[i].idUsuario+'">.</label></th><td style="width:15px; text-align:center;">'+respuesta.data[i].idUsuario+'</td><td>'+respuesta.data[i].nombrePersona+'</td><td>'+respuesta.data[i].nombreUsuario+'</td><td>'+respuesta.data[i].correoElectronico+'</td><td>'+respuesta.data[i].numeroTelefono+'</td><td>'+respuesta.data[i].AreaTrabajo+'</td></tr>');
                }
            }
        }
    });
}































// ESTRUCTURA DE LA TABLA A RELLENAR
/*

<tbody id="bodyTable">
    <tr>
        <th>
            <input type="checkbox" id="copy" name="copy" />
            <label for="copy">.</label>
        </th>
        <td>1</td>
        <td>Luis Solano</td>
        <td>luis@unah.hn</td>
        <td>96458212</td>
    </tr>
</tbody>


    '<tr>
        <th>
            <input type="checkbox" id="'+respuesta.data[i].idUsuario+' name="'+respuesta.data[i].idUsuario+'  value="'+respuesta.data[i].idUsuario+'"/>
            <label for="'+respuesta.data[i].idUsuario+'">.</label>
        </th>
        <td>'+respuesta.data[i].idUsuario+'</td>
        <td>'+respuesta.data[i].nombrePersona+'</td>
        <td>'+respuesta.data[i].nombreUsuario+'</td>
        <td>'+respuesta.data[i].correoElectronico+'</td>
        <td>'+respuesta.data[i].numeroTelefono+'</td>
        <td>'+respuesta.data[i].AreaTrabajo+'</td>
    </tr>'


    '<tr><th><input type="checkbox" id="'+respuesta.data[i].idUsuario+' value="'+respuesta.data[i].idUsuario+'"/><label for="'+respuesta.data[i].idUsuario+'">.</label></th><td>'+respuesta.data[i].idUsuario+'</td><td>'+respuesta.data[i].nombrePersona+'</td><td>'+respuesta.data[i].nombreUsuario+'</td><td>'+respuesta.data[i].correoElectronico+'</td><td>'+respuesta.data[i].numeroTelefono+'</td><td>'+respuesta.data[i].AreaTrabajo+'</td></tr>'



<label for="copy">.</label>
*/