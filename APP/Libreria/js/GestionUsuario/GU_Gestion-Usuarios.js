//////////////////////////  FUNCIONALIDADES VARIAS ///////////////////////////////////

/*
    CARGA DE LA TABLA COMPLETA SIN IMPORTAR EL NOMBRE, ESTADO DEL USUARIO O DEPARTAMENTO
    - SE CARGA LA TABLA
    - SE RELLENAN SELECT AREA DE TRABAJO
    - SE RELLENAN SELECT ESTADO DE USUARIO
*/
$(Document.body).ready(function(){
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

/*
    FUNCIONALIDAD DEL BOTON "+" PARA AGREGAR UN USUARIO
    - SE CARGA LA TABLA
    - SE RELLENAN SELECT AREA DE TRABAJO
    - SE RELLENAN SELECT ESTADO DE USUARIO
*/
$('#plus').click(function(){
    $('#newNotificacion').empty();
    $('#newCodigoEmpleado').val("");
    $('#newUser').val("");
    $('#plusUser').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
      });
});


/*
    CUANDO CAMBIA EL VALOR DEL SELECT SE VUELVE A RELLENAR LA TABLA CON LA INFORMACION NECESARIA
*/
$('#selectEstadoUsuario').change(function(){
    $('#bodyTable').empty();
    informacionUsuarios();
});    

/*
    CUANDO CAMBIA EL VALOR DEL SELECT AREA DE TRABAJO SE VUELVE A RELLENAR LA TABLA
*/
$('#selectAreaTrabajo').change(function(){
    $('#bodyTable').empty();
    informacionUsuarios();
});    


/*
    FUNCIONALIDAD DEL CAMPO DE TEXTO DE BUSQUEDA POR NOMBRE SE HACEN DIFERENTES ACCIONES DEPENDIENDO SI EL CAMPO SE ESCRIE O SE DEJA VACIO
    SI EL CAPO NO ESTA VACIO Y SE ESCRIBE SE CONSULTA A LA BASE DE DATOS Y SE FILTRA USANDO GUNCION INDEXOF DE JAVASCRIPT, LUEGO LAS COINCIDENCIAS SE PINTAN EN LA TABLA
*/
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
                                            <input type="checkbox" id="${usuarioBackEnd.idUsuario}" value="${usuarioBackEnd.idUsuario}" style="width: 0.5%;"/>
                                            <label for="${usuarioBackEnd.idUsuario}"></label>
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


//////////////////////////  FUNCIONALIDAD AGREGAR ///////////////////////////////////

/*
    FUNCIONALIDAD DEL BOTON AGREGAR USUARIO QUE APARECE EN LA VENTANA MODAL
    SE INVOCA A UN API ESPECIAL PARA ELLO ENVIANDO TRES PARAMETROS: CODIGO DE EMPLEADO, NOMBRE USUARIO Y EL PARAMETRO "INSERT"
*/
$('#agregarUser').click(function(){
    $('#bodyTable').empty();
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
		data: {
            "codigoEmpleado" : $('#newCodigoEmpleado').val(),
            "nombreUsuario" : $('#newUser').val(),
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
    }).then(informacionUsuarios);
});    


//////////////////////////  FUNCIONALIDAD ACTUALIZAR ///////////////////////////////////

/*
    ABRE LA VENTANA MODAL PARA PODER EDITAR LA INFORMACION DEL USUARIO
*/
$('#btnEditarUsuario').click(function(){
    var seleccionados = usersSeleccionados();
    if(seleccionados.length == 1){
        $('#updateNotoficacion').empty();
        $('#editUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
          });
        $('#updateNombreUsuario').val($('#nombreUsuario'+seleccionados[0]).text());
        $('#updateCorreoElectronico').val($('#correoElectronico'+seleccionados[0]).text());
        $('#updateNumeroTelefono').val($('#numeroTelefono'+seleccionados[0]).text());
        $('#updateNotificacion').empty();
    }
    
});

/*
    FUNCIONALIDAD DEL BOTON ACTUALIZAR INFORMACION DEL USUARIO
*/
$('#updateUser').click(function(){
    var seleccionados = usersSeleccionados();
    $('#bodyTable').empty();
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'UPDATE',
            "idUsuario": seleccionados[0],
            "nombreUsuario" : $('#updateNombreUsuario').val(),
            "correoElectronico": $('#updateCorreoElectronico').val(),
            "telefono": $('#updateNumeroTelefono').val()

        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                $("#updateNotificacion").replaceWith('<span  id="updateNotificacion" style="color: green;">'+respuesta.output.pmensaje+'</span>');
            }else{
                $("#updateNotificacion").replaceWith('<span  id="updateNotificacion" style="color: brown;">'+respuesta.output.pmensaje+'</span>');
            }
        },
        error : function(error){
            $("#updateNotificacion").replaceWith('<span  id="updateNotificacion" style="color: brown;">'+error.responseText+'</span>');
        }
    })
    .then(informacionUsuarios);
});

/*
    FUNCIONALIDAD DEL BOTON REINICIAR CONTRASENIA
*/
$('#updatePasswordUser').click(function(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_REINICIO_CONTRASENIA",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'RESET',
            "nombreUsuario" : $('#updateNombreUsuario').val()

        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                $("#updateNotificacion").replaceWith('<span  id="newNotificacion" style="color: green;">'+respuesta.output.pmensaje+'</span>');
            }else{
                $("#updateNotificacion").replaceWith('<span  id="newNotificacion" style="color: brown;">'+respuesta.output.pmensaje+'</span>');
            }
        },
        error : function(error){
            $("#updateNotificacion").replaceWith('<span  id="newNotificacion" style="color: brown;">'+error.responseText+'</span>');
        }
    });
});

//////////////////////////  FUNCIONALIDAD ELIMINAR ///////////////////////////////////

/*
    PROGRAMANDO EL BOTON DE ELIMINAR EL USUARIO, ESTE BOTON ABRE UNA VENTANA MODAL
*/
/*$('#btnEliminarUsuario').click(function(){
    var seleccionados = usersSeleccionados();
    $('#eliminateNombresUsuarios').empty();
    if(seleccionados.length >= 1){
        $('#eliminateUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        for (i = 0; i<seleccionados.length; i++){
            $('#eliminateNombresUsuarios').append('<p style="margin: 0 10 0 40">'+$('#nombreUsuario'+seleccionados[i]).text()+'</p>');
        }    
    }
});*/

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE ELIMINATE
*/
/*$("aceptarEliminateUser").click(function(){
    var seleccionados = usersSeleccionados();
    var errors = new Array();
});*/


//////////////////////////  FUNCIONALIDAD ACTIVAR ///////////////////////////////////

/*
    PROGRAMANDO EL BOTON DE ACTIVAR EL USUARIO, ESTE BOTON ABRE UNA VENTANA MODAL
*/
$('#btnActivarUsuario').click(function(){
    var seleccionados = usersSeleccionados();
    $('#activateNombresUsuarios').empty();
    $('#activateNotificacion').empty();
    if(seleccionados.length >= 1 && $('#selectEstadoUsuario').val() == 2){
        $('#activateUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        for (i = 0; i<seleccionados.length; i++){
            $('#activateNombresUsuarios').append('<p style="margin: 0 10 0 40">'+$('#nombreUsuario'+seleccionados[i]).text()+'</p>');
        }
    }
});

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE ACTIVAR
*/
$("#aceptarActivateUser").click(function(){
    (async function(){
        var seleccionados = usersSeleccionados();
        var messages = await activarUsuarios (seleccionados);
        $('#activateNombresUsuarios').empty();
        for (i=0; i < messages.length; i++){
            if(messages[i].pcodigoMensaje == 0){
                $('#activateNotificacion').append('<p style="color: green" >El usuario: '+messages[i].usuario+' ha sido activado</p>');
            }else{
                $('#activateNotificacion').append('<p style="color: brown" >El usuario: '+messages[i].usuario+' no pudo ser activado</p>');
            }
        }
        $('#cancelarActivateUser').text('Cerrar');
        $('#bodyTable').empty();
        informacionUsuarios();
    })()
});

//////////////////////////  FUNCIONALIDAD DESACTIVAR ///////////////////////////////////


/*
    PROGRAMANDO EL BOTON DE DESACTIVAR EL USUARIO, ESTE BOTON ABRE UNA VENTANA MODAL
*/
$('#btnDesactivarUsuario').click(function(){
    var seleccionados = usersSeleccionados();
    $('#desactivateNombresUsuarios').empty();
    $('#desactivateNotificacion').empty();
    if(seleccionados.length >= 1 && $('#selectEstadoUsuario').val() == 1){
        $('#desactivateUser').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        for (i = 0; i<seleccionados.length; i++){
            $('#desactivateNombresUsuarios').append('<p style="margin: 0 10 0 40">'+$('#nombreUsuario'+seleccionados[i]).text()+'</p>');
        }
    }
});

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE DESACTIVAR
*/
$("#aceptarDesactivateUser").click(function(){
    (async function(){
        var seleccionados = usersSeleccionados();
        var messages = await desactivarUsuarios(seleccionados);
        $('#desactivateNombresUsuarios').empty();
        for (i=0; i < messages.length; i++){
            if(messages[i].pcodigoMensaje == 0){
                $('#desactivateNotificacion').append('<p style="color: green" >El usuario: '+messages[i].usuario+' ha sido activado</p>');
            }else{
                $('#desactivateNotificacion').append('<p style="color: brown" >El usuario: '+messages[i].usuario+' no pudo ser activado</p>');
            }
        }
        $('#cancelarDesactivateUser').text('Cerrar');
        $('#bodyTable').empty();
        informacionUsuarios();
    })()
});


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////   FUNCIONES  //////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    FUNCION QUE RELLENA LA TABLA DEPENDIENDO DE LOS VALORES DE LOS SELECT'S
*/
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
                                <label for="${respuesta.data[i].idUsuario}"></label>
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


/*
    FUNCION QUE DEVUELVE ID DE USUARIOS SELECCIONADOS
*/
function usersSeleccionados(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    return seleccionados;
}


/*
    FUNCION QUE SIRVE PARA ACTIVAR A LOS USUARIOS SELECCIONADOS
*/
async function activarUsuarios (seleccionados){
    var messages = new Array();
    for (i=0; i < seleccionados.length; i++){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'ACTIVATE',
                "nombreUsuario" : $('#nombreUsuario'+seleccionados[i]).text()
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
                }else{
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
                }
            },
            error : function(error){
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
            }
        });
    }
    return messages;
}


/*
    FUNCION QUE SIRVE PARA DESACTIVAR A LOS USUARIOS SELECCIONADOS
*/
async function desactivarUsuarios (seleccionados){
    var messages = new Array();
    for (i=0; i < seleccionados.length; i++){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_GESTION_USUARIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'DESACTIVATE',
                "nombreUsuario" : $('#nombreUsuario'+seleccionados[i]).text()
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
                }else{
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
                }
            },
            error : function(error){
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, usuario: $('#nombreUsuario'+seleccionados[i]).text()})
            }
        });
    }
    return messages;
}