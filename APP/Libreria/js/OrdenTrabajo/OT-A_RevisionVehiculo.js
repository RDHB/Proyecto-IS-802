/**
 *  HABILITACION DE FUNCIONES SI INPUT NUMERO OT NO ESTA VACIO 
 *  HABILITACION DE FUNCIONES SI TEXET AREA ESTADO VEHICULO NO ESTA VACIO
 */
$('#iNumeroOT').keyup(function(){habilitarDeshabilitarGuardar()});
$('#tEstadoVehiculo').keyup(function(){habilitarDeshabilitarGuardar()});


/**
 * FUNCION PARA HABILITAR O DESHABILITAR BOTON GUARDAR
 */
function habilitarDeshabilitarGuardar(){
    if( $('#iNumeroOT').val() != "" && $('#tEstadoVehiculo').val() != "" ){
        $('#btnGuardar').prop('disabled', false);
    }else{
        $('#btnGuardar').prop('disabled', true);
    }
}

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
    var codigoMessage = await guardarRevisionVehiculo();
    switch(codigoMessage){
        case 0:{
            $('#guardarNotificacion').append('<p style="color: green" >La revisión del vehículo fue guardado exitosamente</p>');
            break;
        }
        default:{
            $('#guardarNotificacion').append('<p style="color: brown" >La revisión del vehículo no pudo ser guardada</p>');
            break;
        }
    }
});


/**
 * FUNCION PARA GUARDAR INFORMACION DEL VEHICULO
 */
async function guardarRevisionVehiculo(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_REVISION_VEHICULO",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#iNumeroOT').val(),
            "estado_del_vehiculo" : $('#tEstadoVehiculo').val(),
            "objetosPersonales" : $('#tObjetosPersonales').val(),
            "accion" : 'UPDATE'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.output.pcodigoMensaje;
        }
    });
    return codigoMessage;
}

/**
 * FUNCIONALIDAD BOTON LIMPIAR
 */
$('#btnLimpiar').click(function(){
    $('#iNumeroOT').val("");
    $('#tEstadoVehiculo').val("");
    $('#tObjetosPersonales').val("");
});