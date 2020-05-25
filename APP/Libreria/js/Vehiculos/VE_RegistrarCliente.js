
/**
 * FUNCIONALIDAD DEL BOTON GUARDAR
 */

$('#btnGuardar').click(async function(){
    $('#guardarNotificacion').empty();
    $('#guardar').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await registrarCliente();
    switch(codigoMessage){
        case 0:{
            $('#guardarNotificacion').append('<p style="color: green" >El cliente fue registrado exitosamente</p>');
            break;
        }
        case 10:{
            $('#guardarNotificacion').append('<p style="color: brown" >Asegúrese que la información obligatoria del cliente esté completa</p>');
            break;
        }
        default:{
            $('#guardarNotificacion').append('<p style="color: brown" >El cliente no pudo ser registrado</p>');
            break;
        }
    }
});


/**
 * FUNCIONALIDAD DEL BOTON CANCELAR
 */
$('#btnCancelar').click(async function(){
    $('#iPrimerNombre').val("");
    $('#iSegundoNombre').val("");
    $('#iPrimerApellido').val("");
    $('#iSegundoApellido').val("");
    $('#iNumeroIdentidad').val("");
    $('#iCorreoElectronico').val("");
    $('#iNumeroTelefono').val("");
});


/**
 * FUNCION QUE SIRVE PARA REGISTRAR EL CLIENTE HACIENDO USO DEL API
 */
async function registrarCliente(){
    var codigoMessage = 1;
    if( $('#iPrimerNombre').val() == "" || $('#iPrimerApellido').val() == "" || $('#iSegundoApellido').val() == "" || $('#iNumeroIdentidad').val() == "" || $('#iNumeroTelefono').val() == "" ){
        codigoMessage = 10; //INDICA QUE FALTAN QUE LLENAR CAMPOS OBLIGATORIOS
    }else{
        await $.ajax({
            url: "https://localhost:3000/volvo/api/VE/VE_GESTION_CLIENTES",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            dataType: "json",
            method: "POST",
            data: {
                "primerNombre" : $('#iPrimerNombre').val(),
                "segundoNombre" : $('#iSegundoNombre').val(),
                "primerApellido" : $('#iPrimerApellido').val(),
                "segundoApellido" : $('#iSegundoApellido').val(),
                "numeroIdentidad" : $('#iNumeroIdentidad').val(),
                "correoElectronico" : $('#iCorreoElectronico').val(),
                "numeroTelefono" : $('#iNumeroTelefono').val(),
                "idGenero" : $('input[type=radio]:checked').val(),
                "accion" : "INSERT"
            },
            success: function(respuesta){
                codigoMessage = respuesta.output.pcodigoMensaje;
            }        
        });
    }
    return codigoMessage;
}