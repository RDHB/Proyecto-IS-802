


/*
    CARGA INICIAL DE DATOS
*/
$(Document.body).ready(async function(){
    $('#nombreOfUsuario').append(localStorage.getItem('usuario'));
    $('#imgUsuario').attr("src",localStorage.getItem('nombreArchivo'));
    await rellenarNumerosTelefonos();
    await rellenarCorreoDireccion();
    await rellenarInformacionCuenta();
    await rellenarInformacionTrabajo ();
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
        $('#agregarTelefonoNotificacion').append('<p style="color: brown" >El número de teléfono no pudo ser agregado</p>');
    }
    $("#selectNumerosTelefonos").empty();
    $("#selectNumerosTelefonos").append(`<option value="">Números Telefónicos</option>`);
    await rellenarNumerosTelefonos();
    $('#cancelarAgregarTelefono').text('Cerrar');
});

/**
 * FUNCIONALIDAD PARA CAMBIAR NOMBRE USUARIO
 */
$('#btnCambiarINombreUsuario').click(function(){
    $('#cambiarNombreUsuarioCampo').empty();
    $('#cambiarNombreUsuarioNotificacion').empty();
    $('#cambiarNombreUsuario').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#cambiarNombreUsuarioCampo').append(
        `
        <tr>
            <td>Nuevo nombre de usuario</td>
            <td>
                <input  type="text" style="" id="cambiarNombreUsuarioNew" value="${$('#iNombreUsuario').val()}">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD PARA ACEPTAR DE CAMBIAR NOMBRE USUARIO
 */
$('#aceptarCambiarNombreUsuario').click(async function(){
    var codigoMessage = await cambiarNombreUsuario();
    $('#cambiarNombreUsuarioNotificacion').empty();
    if(codigoMessage == 0){
        $('#cambiarNombreUsuarioCampo').empty();
        $('#cambiarNombreUsuarioNotificacion').append('<p style="color: green" >El nombre del usuario fue modificado exitosamente</p>');
    }else if(codigoMessage == 5){
        $('#cambiarNombreUsuarioNotificacion').append('<p style="color: brown" >El nombre del usuario no fue modificado</p>');
    }else{
        $('#cambiarNombreUsuarioNotificacion').append('<p style="color: brown" >El nombre del usuario no pudo ser modificado</p>');
    }
    await rellenarInformacionCuenta();
    $('#cancelarCambiarNombreUsuario').text('Cerrar');
});

/**
 * FUNCIONALIDAD PARA CAMBIAR CONTRASENIA
 */
$('#btnCambiarIPassword').click(function(){
    $('#cambiarContraseniaCampo').empty();
    $('#cambiarContraseniaNotificacion').empty();
    $('#cambiarContrasenia').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#cambiarContraseniaCampo').append(
        `
        <tr>
            <td>Nueva contraseña</td>
            <td>
                <input  type="password" style="" id="cambiarContraseniaNew" value="">
            </td>
        </tr>
        `
    );
    $('#cambiarContraseniaCampo').append(
        `
        <tr>
            <td>Repetir contraseña</td>
            <td>
                <input  type="password" style="" id="cambiarContraseniaNewRepit" value="">
            </td>
        </tr>
        `
    );
});

/**
 * FUNCIONALIDAD PARA ACEPTAR DE CAMBIAR CONTRASENIA
 */
$('#aceptarCambiarContrasenia').click(async function(){
    var codigoMessage = await cambiarContrasenia();
    $('#cambiarContraseniaNotificacion').empty();
    switch(codigoMessage){
        case 0:{
            $('#cambiarContraseniaCampo').empty();
            $('#cambiarContraseniaNotificacion').append('<p style="color: green" >La contraseña fue modificada exitosamente</p>');
            break;
        }
        case 10:{
            $('#cambiarContraseniaNotificacion').append('<p style="color: brown" >Las contraseñas escritas no coinciden</p>');
            break;
        }
        case 11:{
            $('#cambiarContraseniaNotificacion').append('<p style="color: brown" >Rellene los campos solicitados</p>');
            break;
        }
        case 5:{
            $('#cambiarContraseniaNotificacion').append('<p style="color: brown" >La contraseña del usuario no fue modificada</p>');
            break;
        }
        default:{
            $('#cambiarContraseniaNotificacion').append('<p style="color: brown" >La contraseña del usuario no pudo ser modificado</p>');
            break;
        }
    }
    $('#cancelarCambiarContrasenia').text('Cerrar');
});

/**
 * FUNCIONALIDAD ELECCION ARCHIVO, MOSTRAR CUAL ELIGIO
 */
$("#iNewFilePhoto").change(function(){
    if($("#iNewFilePhoto").val() !== ''){
        $('#nameFileChoose').text($("#iNewFilePhoto").val().replace(/C:\\fakepath\\/i, ''));
    }else{
        $('#nameFileChoose').text('Elegir Foto');
    }
});

/**
 * FUNCIONALIDAD MODIFICAR FOTO
 */
$("#btnCambiarFotoPerfil").click(async function(){
    $('#cambiarFotoPerfilNotificacion').empty();
    $('#cambiarFotoPerfil').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    if( $('#nameFileChoose').text() != "" && $('#nameFileChoose').text() != "Elegir Foto" ){
        var codigoMessage = await subirArchivoCambiarFoto();
        if( codigoMessage == 0 ){
            location.reload();
        }else{
            $('#cambiarFotoPerfilNotificacion').append('<p style="color: brown" >La imagen de perfil no pudo ser modificada. Asegúrese el archivo sea una imagen</p>');    
        }
    }else{
        $('#cambiarFotoPerfilNotificacion').append('<p style="color: brown" >Necesita elegir un archivo primero</p>');
    }
});

/**
 * FUNCIONALIDAD NO USAR FOTO DE PERFIL
 */
$("#btnFotoPerfilDefecto").click(async function(){
    $('#cambiarFotoPerfilNotificacion').empty();
    $('#cambiarFotoPerfil').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await usarFotoPerfilDefecto();
    if( codigoMessage == 0 ){
        location.reload();
    }else{
        $('#cambiarFotoPerfilNotificacion').append('<p style="color: brown" >La imagen de perfil no pudo ser eliminada.</p>');    
    }
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

/*
    FUNCION PARA RELLENAR INFORMACION DEL TRABAJO DEL USUARIO ESTA INFORMACION SOLO SE MUESTRA NO SE MODIFICA 
*/
function rellenarInformacionTrabajo (){   
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
                $('#iCodigoEmpleado').val(respuesta.data[0].codigoEmpleado);
                $('#iAreaTrabajo').val(respuesta.data[0].AreaTrabajo);
                $('#iCargo').val(respuesta.data[0].Cargo);
                $('#iHoraEntrada').val(respuesta.data[0].HoraEntrada);
                $('#iHoraSalida').val(respuesta.data[0].HoraSalida);
                $('#iHorasExtras').val(respuesta.data[0].HorasExtras);
            }
        }
    });
}

/*
    FUNCION PARA RELLENAR INFORMACION DEL CUENTA DEL USUARIO
*/
function rellenarInformacionCuenta (){   
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
                $('#iNombreUsuario').val(respuesta.data[0].nombreUsuario);
                $('#iPassword').val(respuesta.data[0].Contrasenia);
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
                codigoMessage = respuesta.output.pcodigoMensaje;
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
                codigoMessage = respuesta.output.pcodigoMensaje;
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
            codigoMessage = respuesta.output.pcodigoMensaje;
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
            codigoMessage = respuesta.output.pcodigoMensaje;
        }        
    });
    return codigoMessage;
}

/**
 * FUNCION PARA CAMBIAR EL NOMBRE DEL USUARIO
 */
async function cambiarNombreUsuario(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'UPDATE-USUARIO',
            "nombreUsuario" : localStorage.getItem('usuario'),
            "newNombreUsuario": $('#cambiarNombreUsuarioNew').val()
        },
        dataType: "json",
        method: "POST",
        success: function(respuesta){
            if(respuesta.output.pcodigoMensaje == 0){
                codigoMessage = respuesta.output.pcodigoMensaje;
                localStorage.setItem('usuario', $('#cambiarNombreUsuarioNew').val());
                $('#nombreOfUsuario').text($('#cambiarNombreUsuarioNew').val());
                $('#nickNameUser').text($('#cambiarNombreUsuarioNew').val());

            }else{
                codigoMessage = respuesta.output.pcodigoMensaje;
            }
        }        
    });
    return codigoMessage;
}

/**
 * FUNCION PARA CAMBIAR LA CONTRASENIA
 */
async function cambiarContrasenia(){
    var codigoMessage;
    if($('#cambiarContraseniaNew').val() === "" || $('#cambiarContraseniaNewRepit').val() === ""){
        codigoMessage = 11;
    }else if( $('#cambiarContraseniaNew').val() !== $('#cambiarContraseniaNewRepit').val() ){
        codigoMessage = 10;
    }else{
        await $.ajax({
            url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'UPDATE-CONTRASENIA',
                "nombreUsuario" : localStorage.getItem('usuario'),
                "newContrasenia": $('#cambiarContraseniaNew').val()
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                codigoMessage = respuesta.output.pcodigoMensaje;
            }        
        });
    }
    return codigoMessage;
}

/**
 * FUNCION PARA CAMBIAR LA FOTO DE PERFIL
 */
async function subirArchivoCambiarFoto () {
    var codigoMessage;
    var fileFoto = new FormData();
    fileFoto.append('nombreArchivo' , $("#iNewFilePhoto")[0].files[0]);
    fileFoto.append('nombreUsuario' , localStorage.getItem('usuario'));
    fileFoto.append('accion' , 'UPDATE-FPERFIL');
    await $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        dataType: "json",
        method: "POST",
        type: 'POST',
        cache: false,
        contentType: false,
        processData: false,
        data: fileFoto,
        success: function(respuesta){
            codigoMessage = respuesta.output.pcodigoMensaje;
            if(codigoMessage == 0){localStorage.setItem('nombreArchivo',respuesta.output.pnombreArchivo);}
        }
    });
    return codigoMessage;
}

/**
 * FUNCION PARA ELIMINAR LA FOTO DE PERFIL Y USAR LA DE DEFECTO
 */
async function usarFotoPerfilDefecto(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_CONFIG",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        dataType: "json",
        method: "POST",
        type: 'POST',
        data: {
            "accion" : "DELETE-FPERFIL",
            "nombreUsuario" : localStorage.getItem('usuario')
        },
        success: function(respuesta){
            codigoMessage = respuesta.output.pcodigoMensaje;
            if(codigoMessage == 0){localStorage.setItem('nombreArchivo',respuesta.output.pnombreArchivo);}
        }
    });
    return codigoMessage;
}