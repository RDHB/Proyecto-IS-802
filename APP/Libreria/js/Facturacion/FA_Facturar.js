/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE ORDEN DE TRABAJO
 */
$('#iNumeroOT').keyup(async function(){
    if( $('#iNumeroOT').val() !== "" ){
        $('#btnBuscarOT').prop('disabled', false);
        $('#btnFacturar').prop('disabled', false);
        $('#btnVerFactura').prop('disabled', false);
    }else{
        $('#btnBuscarOT').prop('disabled', true);
        $('#btnFacturar').prop('disabled', true);
        $('#btnVerFactura').prop('disabled', true);
        $('#iIdentidadCliente').val(data.numeroIdentidad); 
        $('#iNombreCliente').val(''); 
        $('#iInfoVehiculo').val(''); 
        $('#iVin').val(''); 
        $('#iFechaInicio').val(''); 
        $('#iFechaFin').val(''); 
        $('#iEstadoVehiculo').val(''); 
        $('#iObjetosPersonales').val(''); 
        $('#iReparacionesEfectuadas').val(''); 
        $('#iReparacionesNoEfectuadas').val('');
        await rellenarTablaProductos();
        await rellenarTablaServicios(); 
        await totalPagar();
    }
});



/**
 * FUNCION CUANDO SE PRESIONA BUSCAR ORDEN DE TRABAJO
 */
$('#btnBuscarOT').click(async function (){
    await buscarOrdenTrabajo();
    await rellenarTablaServicios();
    await rellenarTablaProductos();
    await totalPagar();
});



/**
 * FUNCION CUANDO SE PRESIONA REGRESAR ORDEN DE TRABAJO
 */
async function facturar(){
    $('#vFacturarNotificacion').empty();
    $('#vFacturar').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/FA/FA_FACTURA",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SAVE',
            "numeroOT" : $('#iNumeroOT').val(),
            "idEmpleado": localStorage.getItem('idEmpleado')
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.output.pcodigoMensaje;
        }
    });
    switch(codigoMessage){
        case 0:{
            $('#vFacturarNotificacion').append(`<p style="color: green" >La facturación fue realizada.</p>`);
            break;
        }
        default:{
            $('#vFacturarNotificacion').append(`<p style="color: brown" >La facturacion no pudo ser realizada.</p>`);
            break;
        }
    }
}


/**
 * FUNCION QUE BUSCA LA ORDEN DE TRABAJO
 */
async function buscarOrdenTrabajo(){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/FA/FA_FACTURA",
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
                        if( respuesta.data[i].servicioEfectuado == 1 ){
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
        url: "https://localhost:3000/volvo/api/FA/FA_FACTURA",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-L',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                for(i=0; i< respuesta.data.length; i++){
                        if( respuesta.data[i].rebajado == 1 ){
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

/**
 * FUNCION PARA RELLENAR TOTAL PAGAR
 */
async function totalPagar(){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/FA/FA_FACTURA",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-FA',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(data of respuesta.data){
                    $('#iTotalPagar').val(data.total_a_pagar); 
                }
            }
        }
    });
}

/**
 * FUNCION QUE SIRVE PARA VISUALIZAR FACTURA
*/
async function verFactura(){
    $('#verFacturaNotificacion').empty();
    $('#verFacturaCampos').empty();
    $('#verFactura').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_FINALIZAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-FA',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if(respuesta.output.pcodigoMensaje == 0){
                var keys = Object.keys(respuesta.data);
                for(key of keys){
                    switch(key){
                        case 'numeroFactura':{
                            $('#verFacturaCampos').append(
                                `
                                <tr>
                                    <td>Numero de Factura</td>
                                    <td>
                                        <input disabled type="text" style="margin: 0 10 0 40" value="${respuesta.data[numeroFactura]}">
                                    </td>
                                </tr>
                            
                                `
                            );
                            break
                        }
                        case 'fecha':{
                            $('#verFacturaCampos').append(
                                `
                                <tr>
                                    <td>Fecha</td>
                                    <td>
                                        <input disabled type="text" style="margin: 0 10 0 40" value="${respuesta.data[fecha]}">
                                    </td>
                                </tr>
                            
                                `
                            );
                            break
                        }
                        case 'idOrdenTrabajo':{
                            $('#verFacturaCampos').append(
                                `
                                <tr>
                                    <td>Codigo Orden de Trabajo</td>
                                    <td>
                                        <input disabled type="text" style="margin: 0 10 0 40" value="${respuesta.data[idOrdenTrabajo]}">
                                    </td>
                                </tr>
                            
                                `
                            );
                            break
                        }

                        case 'total_a_pagar':{
                            $('#verFacturaCampos').append(
                                `
                                <tr>
                                    <td>Total a Pagar</td>
                                    <td>
                                        <input disabled type="text" style="margin: 0 10 0 40" value="${respuesta.data[total_a_pagar]}">
                                    </td>
                                </tr>
                            
                                `
                            );
                            break
                        }
                    }
                }
            }
        }
    });
}





//<input disabled id="btnFacturar" onclick="facturar()" type="button" class="button primary" style="width:auto" value="Facturar">

