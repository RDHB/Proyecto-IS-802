/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE ORDEN DE TRABAJO
 */
$('#iNumeroOT').keyup(function(){
    if( $('#iNumeroOT').val() !== "" ){
        $('#btnBuscarOT').prop('disabled', false);
        $('#btnRegresarOT').prop('disabled', false);
        $('#btnFinalizarOT').prop('disabled', false);
    }else{
        $('#btnBuscarOT').prop('disabled', true);
        $('#btnRegresarOT').prop('disabled', true);
        $('#btnFinalizarOT').prop('disabled', true);
    }
});



/**
 * FUNCION CUANDO SE PRESIONA BUSCAR ORDEN DE TRABAJO
 */
$('#btnBuscarOT').click(async function (){
    await buscarOrdenTrabajo();
    await rellenarTablaServicios();
    await rellenarTablaProductos();
});


/**
 * FUNCION CUANDO SE PRESIONA FINALIZAR ORDEN DE TRABAJO
 */
async function finalizarOT(){
    $('#finalizarOTNotificacion').empty();
    $('#finalizarOT').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SAVE',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.output.pcodigoMensaje;
        }
    });
    switch(codigoMessage){
        case 0:{
            $('#finalizarOTNotificacion').append(`<p style="color: green" >La orden de trabajo fue finalizada</p>`);
            break;
        }
        default:{
            $('#finalizarOTNotificacion').append(`<p style="color: brown" >La orden de trabajo no pudo ser finalizada</p>`);
            break;
        }
    }
}


/**
 * FUNCION CUANDO SE PRESIONA REGRESAR ORDEN DE TRABAJO
 */
async function regresarOT(){
    $('#regresarOTNotificacion').empty();
    $('#regresarOT').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'CANCEL',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.output.pcodigoMensaje;
        }
    });
    switch(codigoMessage){
        case 0:{
            $('#regresarOTNotificacion').append(`<p style="color: green" >La orden de trabajo fue regresada a una etapa previa</p>`);
            break;
        }
        default:{
            $('#regresarOTNotificacion').append(`<p style="color: brown" >La orden de trabajo no pudo ser regresada a una etapa previa</p>`);
            break;
        }
    }
}


/**
 * FUNCION QUE BUSCA LA ORDEN DE TRABAJO
 */
async function buscarOrdenTrabajo(){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-OT',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(data of respuesta.data){
                    $('#iIdentidadCliente').val(data.numeroIdentidad); 
                    $('#iNombreCliente').val(data.nombreCliente); 
                    $('#iInfoVehiculo').val(data.Vehiculo); 
                    $('#iVin').val(data.vin); 
                    $('#iFechaInicio').val(data.fechaInicio); 
                    $('#iFechaFin').val(data.fechaFin); 
                    $('#iEstadoVehiculo').val(data.estado_del_vehiculo); 
                    $('#iObjetosPersonales').val(data.objetosPersonales); 
                    $('#iReparacionesEfectuadas').val(data.reparacionesEfectuadas); 
                    $('#iReparacionesNoEfectuadas').val(data.reparacionesNoEfectuadas); 
                }
            }
        }
    });
}

/**
 * FUNCION PARA RELLENAR LA TABLE DE SERVICIOS
 */
async function rellenarTablaServicios(){
    $('#cuerpoTablaServicios').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-S',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                for(i=0; i< respuesta.data.length; i++){
                    bandera = 1;
                        $('#cuerpoTablaServicios').append(`
                            <tr>
                                <td>${respuesta.data[i].idServicios}</td>
                                <td>${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].servicioEfectuado}</td>
                                <td>${respuesta.data[i].duracion}</td>
                                <td>${respuesta.data[i].precioCosto}</td>
                            </tr>
                        `);
                }
                if( bandera == 0 ){
                    $('#cuerpoTablaServicios').append(`
                        <tr>
                            <td></td>
                            <td></td>
                            <td>El cliente no tiene servicios por aprobar en la cotización</td>                                                        
                            <td></td>
                            <td></td>
                        </tr>  
                    `);
                }
            }else{
                $('#cuerpoTablaServicios').append(`
                    <tr>
                        <td></td>
                        <td></td>
                        <td>Revise el número de orden de trabajo</td>                                                        
                        <td></td>
                        <td></td>
                    </tr>  
                `);
            }
        }
    });
}

/**
 * FUNCION PARA RELLENAR LA TABLE DE PRODUCTOS
 */
async function rellenarTablaProductos(){
    $('#cuerpoTablaProductos').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-P',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                for(i=0; i< respuesta.data.length; i++){
                    bandera = 1;
                        $('#cuerpoTablaProductos').append(`
                            <tr>
                                <td>${respuesta.data[i].idProducto}</td>
                                <td>${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].cantidad}</td>
                                <td>${respuesta.data[i].precioVenta}</td>
                                <td>${respuesta.data[i].SubTotal}</td>
                                <td>${respuesta.data[i].rebajado}</td>
                            </tr>
                        `);
                }
                if( bandera == 0 ){
                    $('#cuerpoTablaProductos').append(`
                        <tr>
                            <td></td>
                            <td></td>
                            <td>El cliente no tiene productos por aprobar en la cotización</td>                                                        
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>  
                    `);
                }
            }else{
                $('#cuerpoTablaProductos').append(`
                    <tr>
                        <td></td>
                        <td></td>
                        <td>Revise el número de orden de trabajo</td>                                                        
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>  
                `);
            }
        }
    });
}