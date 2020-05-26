/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE ORDEN DE TRABAJO
 */
$('#iNumeroOT').keyup(function(){
    if( $('#iNumeroOT').val() !== "" ){
        $('#btnBuscarCotizacionAprobar').prop('disabled', false);
    }else{
        $('#btnBuscarCotizacionAprobar').prop('disabled', true);
        $('#cuerpoTablaServicios').empty();
        $('#cuerpoTablaProductos').empty();
        $('#cuerpoTablaServicios').append(`
            <tr>
                <td></td>
                <td></td>
                <td>Rellene el campo correspondiente con el número de orden de trabajo</td>
                <td></td>
                <td></td>
            </tr>  
        `);
        $('#cuerpoTablaProductos').append(`
            <tr>
                <td></td>
                <td></td>
                <td>Rellene el campo correspondiente con el número de orden de trabajo</td>
                <td></td>
                <td></td>
            </tr>  
        `);
    }
});


/**
 * FUNCIONALIDAD DEL BOTON BUSCAR SERVICIOS Y PRODUCTOS POR APROBAR
 */
$('#btnBuscarCotizacionAprobar').click(async function(){
    await rellenarTablaServicios();
    await rellenarTablaProductos();
});




/**
 * FUNCION PARA RELLENAR LA TABLE DE SERVICIOS
 */
async function rellenarTablaServicios(){
    $('#cuerpoTablaServicios').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_APROVACION_COTIZACION",
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
        url: "https://localhost:3000/volvo/api/OT/OT_A_APROVACION_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-C',
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
                    </tr>  
                `);
            }
        }
    });
}

/***
 * FUNCION APROBAR COTIZACION
 */
async function aprobarCotizacion(){
    if($('#iNumeroOT').val()!=""){
        $('#vAprobarCotizacionNotificacion').empty();
        $('#vAprobarCotizacion').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        var codigoMessage;
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_APROVACION_COTIZACION",
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
                $('#vAprobarCotizacionNotificacion').append(`<p style="color: green" >La cotización fue aprobada, se pasa a la siguiente etapa.</p>`);
                break;
            }
            default:{
                $('#vAprobarCotizacionNotificacion').append(`<p style="color: brown" >La cotización no pudo ser aprobada. Revise el estado de la orden de trabajo.</p>`);
                break;
            }
        }
    }
}


 /**
  * FUNCION RECHAZAR COTIZACION
  */
 async function rechazarCotizacion(){
    if($('#iNumeroOT').val()!=""){
        $('#vRechazarCotizacionNotificacion').empty();
        $('#vRechazarCotizacion').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        var codigoMessage;
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_APROVACION_COTIZACION",
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
                $('#vRechazarCotizacionNotificacion').append(`<p style="color: green" >La cotización fue rechazada, se regresa a una etapa anterior.</p>`);
                break;
            }
            default:{
                $('#vRechazarCotizacionNotificacion').append(`<p style="color: brown" >La cotización no pudo ser rechazada. Revise el estado de la orden de trabajo.</p>`);
                break;
            }
        }
    }
 }