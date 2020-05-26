

/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE INDENTIDAD CLIENTE
 */
$('#iIdentidadCliente').keyup(function(){
    if( $('#iIdentidadCliente').val() !== "" ){
        $('#btnMostrarVehiculo').prop('disabled', false);
        if( $('#iVin').val() !== "" ){
            $('#btnVincularVehiculoCliente').prop('disabled', false);
        }
    }else{
        $('#btnMostrarVehiculo').prop('disabled', true);
        $('#btnVincularVehiculoCliente').prop('disabled', true);
        $('#cuerpoTabla').empty();
        $('#cuerpoTabla').append(`
            <tr>
                <td></td>
                <td></td>
                <td>Rellene el campo correspondiente con la identidad del cliente</td>
                <td></td>
                <td></td>
            </tr>  
        `);
    }
});

/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE VIN
 */
$('#iVin').keyup(function(){
    if( $('#iVin').val() !== "" ){
        if( $('#iIdentidadCliente').val() !== "" ){
            $('#btnVincularVehiculoCliente').prop('disabled', false);
        }
    }else{
        $('#btnVincularVehiculoCliente').prop('disabled', true);
    }
});

/**
 * FUNCIONALIDAD DEL BOTON VINCULAR VEHICULO A CLIENTE
 */
$('#btnVincularVehiculoCliente').click(async function(){
    $('#vincularVehiculoClienteNotificacion').empty();
    $('#vincularVehiculoCliente').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await asociarVehiculoCliente();
    switch(codigoMessage){
        case 0:{
            $('#vincularVehiculoClienteNotificacion').append('<p style="color: green" >El vehículo fue asociado al cliente exitosamente</p>');
            await rellenarTabla();
            break;
        }
        default:{
            $('#vincularVehiculoClienteNotificacion').append('<p style="color: brown" >El vehículo no pudo ser asociado al cliente</p>');
            break;
        }
    }
});

/**
 * FUNCIONALIDAD DEL BOTON MOSTRAR VEHICULOS
 */
$('#btnMostrarVehiculo').click(async function(){
    await rellenarTabla();
});

/**
 * FUNCIONALIDAD PARA DEASOCIAR UNO O VARIOS VEHICULOS
 */
$('#btnDesasociarVehiculo').click(async function(){
    $('#desVincularVehiculoClienteNotificacion').empty();
    $('#desVincularVehiculoCliente').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var messages = await desasociarVehiculosCliente();
    for(message of messages){
        switch(message.pcodigoMensaje){
            case 0:{
                $('#desVincularVehiculoClienteNotificacion').append(`<p style="color: green" >El vehículo con VIN:${message.vehiculo} fue desvinvulado del cliente exitosamente</p>`);
                break;
            }
            default:{
                $('#vincularVehiculoClienteNotificacion').append(`<p style="color: brown" >El vehículo con VIN:${message.vehiculo} no pudo ser desvinculado del cliente</p>`);
                break;
            }
        }
    }
    await rellenarTabla();    
});

/**
 * FUNCION PARA ASOCIAR EL VEHICULO CON EL CLIENTE
 */
async function asociarVehiculoCliente(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/VE/VE_ASOCIAR_CYV",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "vin" : $('#iVin').val(),
            "numeroIdentidad" : $('#iIdentidadCliente').val(),
            "accion"      : 'LINK'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.pcodigoMensaje;
        }
    });
    return codigoMessage;
}

/**
 * FUNCION QUE SIREVE PARA RELLENAR LA TABLA UNA VES SE VINVULA CLIENTE O SE PIDE MOSTRAR INFORMACION
 */
async function rellenarTabla(){
    $('#cuerpoTabla').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/VE/VE_ASOCIAR_CYV",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion"      : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                for(i=0; i< respuesta.data.length; i++){
                    if( respuesta.data[i].identidad == $('#iIdentidadCliente').val() ){
                        bandera = 1;
                        $('#cuerpoTabla').append(`
                            <tr>
                                <td style="width: 0.5%;">
                                    <input onClick="activarDeasociarVehiculo()" type="checkbox" id="${respuesta.data[i].vin}" name="${respuesta.data[i].vin}" value="${respuesta.data[i].vin}">
                                    <label for="${respuesta.data[i].vin}"></label>
                                </td>
                                <td>${respuesta.data[i].identidad}</td>
                                <td>${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].marca+' '+respuesta.data[i].modelo}</td>
                                <td>${respuesta.data[i].vin}</td>
                            </tr>
                        `);
                    }
                }
                if( bandera == 0 ){
                    $('#cuerpoTabla').append(`
                        <tr>
                            <td></td>
                            <td></td>
                            <td>El cliente no tiene vehículos asociados</td>                                                        
                            <td></td>
                            <td></td>
                        </tr>  
                    `);
                }
            }else{
                $('#cuerpoTabla').append(`
                    <tr>
                        <td></td>
                        <td></td>
                        <td>Revise la información contenida en los campos</td>                                                        
                        <td></td>
                        <td></td>
                    </tr>  
                `);
            }
        }
    });
}

/**
 * FUNCION PARA DESASOCIAR VEHICULOS SELECIONADOS DEL CLIENTE
 */
async function desasociarVehiculosCliente(){
    var messages = new Array();
    var vehiculos = vehiculosSeleccionados();
    for(vehiculo of vehiculos){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/VE/VE_ASOCIAR_CYV",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "vin" : vehiculo,
                "numeroIdentidad" : $('#iIdentidadCliente').val(),
                "accion"      : 'UNLINK'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                messages.push({pcodigoMensaje: respuesta.pcodigoMensaje, vehiculo: vehiculo});
            }
        });
    }
    return messages;
}


/**
 *  FUNCION QUE DEVUELVE LOS VEHICULOS SELECCIONADOS
 */
function vehiculosSeleccionados(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    return seleccionados;
}

/**
 * FUNCION PARA ACTIVAR BOTON DE DESASOCIAR VEHICULO SI HAY VEHICULOS SELECCIONADOS
 */
function activarDeasociarVehiculo(){
    var vehiculos = vehiculosSeleccionados();
    if( vehiculos.length != 0 ){
        $('#btnDesasociarVehiculo').prop('disabled', false);
    }else{
        $('#btnDesasociarVehiculo').prop('disabled', true);
    }
}


