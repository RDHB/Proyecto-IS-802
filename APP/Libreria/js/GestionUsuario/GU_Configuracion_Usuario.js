


/*
    CARGA INICIAL DE DATOS
*/
$(Document.body).ready(async function(){
    $('#nombreOfUsuario').append(localStorage.getItem('usuario'));
    //$('#imgUsuario').attr("src","second.jpg");
    await rellenarNumerosTelefonos();
    await rellenarCorreoDireccion();
})


/**
 * FUNCIONALIDAD CUANDO CAMBIA EL SELECET A UN VALOR DISTINTO DE: VALUE="" PARA HABILITAR O DESHABILITAR BOTONES
 */
$("#selectNumerosTelefonos").change(function(){
    if($('#selectNumerosTelefonos').val() !== ""){
        $('#btnEliminarTelefono').prop('disabled', false);
        $('#btnModificarTelefono').prop('disabled', false);
    }else{
        $('#btnEliminarTelefono').prop('disabled', true);
        $('#btnModificarTelefono').prop('disabled', true);
    }
});

/**
 * FUNCIONALIDAD PARA MODIFICAR CORREO O DIRECCION
 */
$('#btnCambiarCorreoDireccion').click(function(){
    $('#updateCamposCorreoDireccion').empty();
    $('#updateCorreoDireccionNotificacion').empty();
    $('#updateCorreoDireccion').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#updateCamposCorreoDireccion').append(
        `
        <tr>
            <td>Correo Electrónico</td>
            <td>
                <input  type="text" style="" id="updateICorreoElectronico" value="${$('#iCorreoElectronico').val()}">
            </td>
        </tr>
        `
    );
    $('#updateCamposCorreoDireccion').append(
        `
        <tr>
            <td>Dirección</td>
            <td>
                <input  type="text" style="" id="updateIDireccion" value="${$('#iDireccion').val()}">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD DEL BOTON ACEPTAR EN LA VENTANA MODAL MODIFICAR CORREO O DIRECCION
 */
$('#aceptarUpdateCorreoDireccion').click(async function(){
    var codigoMessage = await updateCorreoDireccion();
    $('#updateCorreoDireccionNotificacion').empty();
    if(codigoMessage == 0){
        $('#updateCamposCorreoDireccion').empty();
        $('#updateCorreoDireccionNotificacion').append('<p style="color: green" >La información fue modificada exitosamente</p>');
    }else if(codigoMessage == 10){
        $('#updateCorreoDireccionNotificacion').append('<p style="color: brown" >Los datos no fueron modificados</p>');
    }else{
        $('#updateCorreoDireccionNotificacion').append('<p style="color: brown" >La información no pudo ser modificada</p>');
    }
    await rellenarCorreoDireccion();
    $('#cancelarUpdateCorreoDireccion').text('Cerrar');
});

/**
 * FUNCIONALIDAD PARA MODIFICAR TELEFONO
 */
$('#btnModificarTelefono').click(function(){
    $('#updateCamposTelefono').empty();
    $('#updateTelefonoNotificacion').empty();
    $('#updateTelefono').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#updateCamposTelefono').append(
        `
        <tr>
            <td>Número de Teléfono</td>
            <td>
                <input  type="text" style="" id="updateNewTelefono" value="${$('select[id="selectNumerosTelefonos"] option:selected').text()}">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD PARA ACEPTAR DE MODIFICAR TELEFONO
 */
$('#aceptarUpdateTelefono').click(async function(){
    var codigoMessage = await updateTelefono();
    $('#updateTelefonoNotificacion').empty();
    if(codigoMessage == 0){
        $('#updateCamposTelefono').empty();
        $('#updateTelefonoNotificacion').append('<p style="color: green" >El número teléfonico fue modificado exitosamente</p>');
    }else if(codigoMessage == 10){
        $('#updateTelefonoNotificacion').append('<p style="color: brown" >El número de telefónico no fue modificado</p>');
    }else{
        $('#updateTelefonoNotificacion').append('<p style="color: brown" >El número de teléfono no pudo ser modificado</p>');
    }
    $("#selectNumerosTelefonos").empty();
    $("#selectNumerosTelefonos").append(`<option value="">Números Telefónicos</option>`);
    await rellenarNumerosTelefonos();
    $('#cancelarUpdateTelefono').text('Cerrar');
});


/**
 * FUNCIONALIDAD PARA ELIMINAR TELEFONO
 */
$('#btnEliminarTelefono').click(function(){
    $('#eliminateCamposTelefono').empty();
    $('#eliminateTelefonoNotificacion').empty();
    $('#eliminateTelefono').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#eliminateCamposTelefono').append(
        `
        <tr>
            <td>Número de Teléfono</td>
            <td>
                <input  type="text" style="" id="eliminateOldTelefono" value="${$('select[id="selectNumerosTelefonos"] option:selected').text()}">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD PARA ACEPTAR DE ELIMINAR TELEFONO
 */
$('#aceptarEliminateTelefono').click(async function(){
    var codigoMessage = await eliminateTelefono();
    $('#eliminateTelefonoNotificacion').empty();
    if(codigoMessage == 0){
        $('#eliminateCamposTelefono').empty();
        $('#eliminateTelefonoNotificacion').append('<p style="color: green" >El número teléfonico fue eliminado exitosamente</p>');
    }else {
        $('#eliminateTelefonoNotificacion').append('<p style="color: brown" >El número de teléfono no pudo ser eliminado</p>');
    }
    $("#selectNumerosTelefonos").empty();
    $("#selectNumerosTelefonos").append(`<option value="">Números Telefónicos</option>`);
    await rellenarNumerosTelefonos();
    $('#cancelarEliminateTelefono').text('Cerrar');
});

/**
 * FUNCIONALIDAD PARA AGREGAR TELEFONO
 */
$('#btnAgregarTelefono').click(function(){
    $('#agregarCamposTelefono').empty();
    $('#agregarTelefonoNotificacion').empty();
    $('#agregarTelefono').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#agregarCamposTelefono').append(
        `
        <tr>
            <td>Número de Teléfono</td>
            <td>
                <input  type="text" style="" id="agregarNewTelefono" value="">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD PARA ACEPTAR DE AGREGAR TELEFONO
 */
$('#aceptarAgregarTelefono').click(async function(){
    var codigoMessage = await agregarTelefono();
    $('#agregarTelefonoNotificacion').empty();
    if(codigoMessage == 0){
        $('#agregarCamposTelefono').empty();
        $('#agregarTelefonoNotificacion').append('<p style="color: green" >El número teléfonico fue agregado exitosamente</p>');
    }else {
        $('#eliminateTelefonoNotificacion').append('<p style="color: brown" >El número de teléfono no pudo ser agregado</p>');
    }
    $("#selectNumerosTelefonos").empty();
    $("#selectNumerosTelefonos").append(`<option value="">Números Telefónicos</option>`);
    await rellenarNumerosTelefonos();
    $('#cancelarAgregarTelefono').text('Cerrar');
});















/*
    FUNCION PARA RELLENAR EL SELECT DE NUMERO DE TELEFONOS DE LOS USUARIOS 
*/
function rellenarNumerosTelefonos (){   
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-TELEFONO',
            "nombreUsuario" : localStorage.getItem('usuario')

        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                $('#btnEliminarTelefono').prop('disabled', true);
                $('#btnModificarTelefono').prop('disabled', true);
                for(data of respuesta.data){
                    $("#selectNumerosTelefonos").append(`<option value="${data.idTelefono}">${data.numeroTelefono}</option>`);
                }
            }
        }
    });
}

/**
 * FUNCION QUE SIRVE PARA RELLENAR DIRECCION Y CORREO DEL USUARIO;
 * SE HACE JUNTO POR SI HAY CAMBIOS EN CUALQUIERA DE LOS DOS, EL PROCEDIMIENTO ALMACENADO PARA ELLO NECESITA DE AMBOS
*/
function rellenarCorreoDireccion(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-INFO',
            "nombreUsuario" : localStorage.getItem('usuario')

        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                $('#iCorreoElectronico').val(respuesta.data[0].correoElectronico);
                $('#iDireccion').val(respuesta.data[0].direccion);
            }
        }        
    });
}

/**
 * FUNCION PARA MODIFICAR EL CORREO Y LA DIRECCION
 */
async function updateCorreoDireccion(){
    var codigoMessage;
    if( ($('#iCorreoElectronico').val() !== $('#updateICorreoElectronico').val()) || ($('#iDireccion').val() !== $('#updateIDireccion').val()) ){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'UPDATE-PERSONA',
                "nombreUsuario" : localStorage.getItem('usuario'),
                "newCorreoElectronico": $('#updateICorreoElectronico').val(),
                "newDireccion": $('#updateIDireccion').val()
    
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    codigoMessage = respuesta.output.pcodigoMensaje;
                }else{
                    codigoMessage = respuesta.output.pcodigoMensaje;
                }
            }        
        });
    }else{
        codigoMessage = 10; //INDICA QUE LOS DATOS NO FUERON MODIFICADOS
    }
    return codigoMessage;
}

/**
 * FUNCION PARA MODIFICAR EL NUMERO DE TELEFONO SELECCIONADO
 */
async function updateTelefono(){
    var codigoMessage;
    if( $('select[id="selectNumerosTelefonos"] option:selected').text() !== $('#updateNewTelefono').val() ){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'UPDATE-TELEFONO',
                "nombreUsuario" : localStorage.getItem('usuario'),
                "idTelefono": $('#selectNumerosTelefonos').val(),
                "newTelefono": $('#updateNewTelefono').val()
    
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    codigoMessage = respuesta.output.pcodigoMensaje;
                }else{
                    codigoMessage = respuesta.output.pcodigoMensaje;
                }
            }        
        });
    }else{
        codigoMessage = 10; //INDICA QUE LOS DATOS NO FUERON MODIFICADOS
    }
    return codigoMessage;
}

/**
 * FUNCION PARA ELIMINAR EL NUMERO DE TELEFONO SELECCIONADO
 */
async function eliminateTelefono(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'DELETE-TELEFONO',
            "nombreUsuario" : localStorage.getItem('usuario'),
            "idTelefono": $('#selectNumerosTelefonos').val()
        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                codigoMessage = respuesta.output.pcodigoMensaje;
            }else{
                codigoMessage = respuesta.output.pcodigoMensaje;
            }
        }        
    });
    return codigoMessage;
}

/**
 * FUNCION PARA AGREGAR UN NUMERO DE TELEFONO
 */
async function agregarTelefono(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'ADD-TELEFONO',
            "nombreUsuario" : localStorage.getItem('usuario'),
            "newTelefono": $('#agregarNewTelefono').val()
        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                codigoMessage = respuesta.output.pcodigoMensaje;
            }else{
                codigoMessage = respuesta.output.pcodigoMensaje;
            }
        }        
    });
    return codigoMessage;
}