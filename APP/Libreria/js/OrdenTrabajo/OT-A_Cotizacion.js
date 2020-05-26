/**
 * ES LA LISTA DE PRODUCTOS ASOCIADOS CON EL CLIENTE
 */
var listaProductos = new Array();

/**
 * HABILITACION DEL BOTON BUSCAR COTIZACION
 */
$('#iNumeroOT').keyup(function(){
    if( $('#iNumeroOT').val() !== "" ){
        $('#btnBuscarCotizacion').prop('disabled', false);
    }else{
        $('#btnBuscarCotizacion').prop('disabled', true);
        $('#btnAgregarProductos').prop('disabled', true);
        $('#cuerpoTabla').empty();
        $('#cuerpoTabla').append(`
            <tr>
                <td></td>
                <td></td>
                <td>Rellene el campo correspondiente con el número de orden de trabajo</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>  
        `);
    }
});

/**
 * FUNCIONALIDAD DEL BOTON BUSCAR COTIZACION
 */
$('#btnBuscarCotizacion').click(async function(){
    await rellenarTabla();
    $('#btnAgregarProductos').prop('disabled', false);
});

/**
 * FUNCIONALIDAD DEL BOTON AGREGAR PRODUCTO
 */
$('#btnAgregarProductos').click(async function(){
    $('#agregarProductos').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    await rellenarTablaAgregarProductos();
});

/**
 * FUNCIONALIDAD SALVAR SERVICIOS CONTRATADOS
 */
$('#btnCotizar').click(async function(){
    $('#salvarListaCotizacionNotificacion').empty();
    $('#salvarListaCotizacion').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await salvarCambiosCotizacion();
        switch(codigoMessage){
            case 0:{
                $('#salvarListaCotizacionNotificacion').append(`<p style="color: green" >Lista de cotización salvada, se puede pasar a la siguiente etapa</p>`);
                break;
            }
            default:{
                $('#salvarListaCotizacionNotificacion').append(`<p style="color: brown" >La lista de cotización no pudo ser salvada, intente nuevamente o es probable no puede modificar en este momento</p>`);
                break;
            }
        }
});

/**
 * FUNCION QUE SIRVE PARA RELLENAR LA TABLA
 */
async function rellenarTabla(){
    $('#cuerpoTabla').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-OT',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                listaProductos = [];
                for(i=0; i< respuesta.data.length; i++){
                        bandera = 1;
                        listaProductos.push(respuesta.data[i].nombre);
                        $('#cuerpoTabla').append(`
                            <tr>
                                <td style="width: 0.5%;">
                                    <input onClick="activarQuitarProductos()" type="checkbox" id="${respuesta.data[i].idProducto}" name="${respuesta.data[i].idProducto}" value="${respuesta.data[i].idProducto}">
                                    <label for="${respuesta.data[i].idProducto}"></label>
                                </td>
                                <td>${respuesta.data[i].idProducto}</td>
                                <td id="${'nombreProducto'+respuesta.data[i].idProducto}">${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].cantidad}</td>
                                <td>${respuesta.data[i].precioVenta}</td>
                                <td>${respuesta.data[i].SubTotal}</td>
                            </tr>
                        `);
                }
                if( bandera == 0 ){
                    $('#cuerpoTabla').append(`
                        <tr>
                            <td></td>
                            <td></td>
                            <td>El cliente no tiene productos en lista de cotización</td>                                                        
                            <td></td>
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
 * FUNCION QUE SIRVE PARA RELLENAR LA TABLA AGREGAR PRODUCTOS
 */
async function rellenarTablaAgregarProductos() {
    $('#agregarProductosNotificacion').empty();
    $('#agregarProductosCampos').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT-P'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(i=0; i< respuesta.data.length; i++){
                    if( listaProductos.indexOf(respuesta.data[i].nombre) == -1 ){
                        $('#agregarProductosCampos').append(`
                            <tr>
                                <td>${respuesta.data[i].idProducto}</td>
                                <td>${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].precioVenta}</td>
                                <td style="height:auto; width:13%; margin: 0%"><input type="text" value="" id="${'cantidad'+respuesta.data[i].idProducto}" onkeyup="activarBotonAgregar('#btnAgregarProducto${respuesta.data[i].idProducto}','${'#cantidad'+respuesta.data[i].idProducto}')" style=" text-align: center"></td>
                                <td style="width: 0.5%;">
                                    <input disabled id="btnAgregarProducto${respuesta.data[i].idProducto}" onClick="agregarProductoLista('${$('#iNumeroOT').val()}','${respuesta.data[i].idProducto}','${'#cantidad'+respuesta.data[i].idProducto}')" type="buttom" class="button small" style="width: auto; display:block; margin: auto;" value="Agregar">
                                </td>
                            </tr>
                        `);
                    }
                }
            }else{
                $('#agregarProductosCampos').append(`
                    <tr>
                        <td></td>
                        <td></td>
                        <td>Existe un problema al conectar con el servidor</td>                                                        
                        <td></td>
                        <td></td>
                    </tr>  
                `);
            }
        }
    });
}

/**
 * FUNCION QUE SIRVE PARA AGREGAR UN PRODUCTO A LISTA DE COTIZACION DEL CLIENTE
 */
async function agregarProductoLista(numeroOT,idProducto,cantidad){
    $('#agregarProductosNotificacion').empty();
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : numeroOT,
            "idProducto" : idProducto,
            "cantidad" : $(cantidad).val(),
            "accion"      : 'INSERT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            codigoMessage = respuesta.output.pcodigoMensaje;
        }
    });
        switch(codigoMessage){
            case 0:{
                $('#agregarProductosNotificacion').append(`<p style="color: green" >El producto fue agregado a la lista de cotización del cliente exitosamente</p>`);
                $('#btnAgregarProducto'+idProducto).prop('disabled', true);
                await rellenarTabla();
                break;
            }
            default:{
                $('#agregarProductosNotificacion').append(`<p style="color: brown" >El producto no pudo ser agregado a la lista de cotización del cliente</p>`);
                break;
            }
        }
}

/**
 * FUNCION PARA ACTIVAR BOTON DE ACTIVAR PRODUCTO EN LA VENTANA MODAL
 */
function activarBotonAgregar(txtProducto,txtCantidaProducto){
    if( $(txtCantidaProducto).val() !== "" ){
        $(txtProducto).prop('disabled', false);
    }else{
        $(txtProducto).prop('disabled', true);
    }
}

/**
 * FUNCION QUE SIRVE PARA ELIMINAR PRODUCTOS DE LA LISTA
 */
async function eliminarProductosLista(){
    /*$('#eliminarProductosNotificacion').empty();
    $('#eliminarProductos').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var messages = new Array();
    var productos = productosSeleccionados();
    for(producto of productos){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_COTIZACION",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "numeroOT" : numeroOT,
                "idProducto" : producto,
                "accion"      : 'DELETE'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, producto: $('#nombreProducto'+producto).val()});
            }
        });
    }
    for(message of messages){
        switch(message.pcodigoMensaje){
            case 0:{
                $('#eliminarProductosNotificacion').append(`<p style="color: green" >El producto: ${message.producto} fue eliminado de la lista de cotización del cliente exitosamente</p>`);
                break;
            }
            default:{
                $('#eliminarProductosNotificacion').append(`<p style="color: brown" >El producto: ${message.producto} no pudo ser eliminado de la lista de cotización del cliente</p>`);
                break;
            }
        }
    }    
    await rellenarTabla();*/
}

/**
 * FUNCION PARA SALVAR LISTA DE PRODUCTOS COTIZADOS Y CONTINUAR CON LA SIGUIENTE ETAPA
 */
async function salvarCambiosCotizacion(){
    var codigoMessage;
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_COTIZACION",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "numeroOT" : $('#iNumeroOT').val(),
                "accion"      : 'SAVE'
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
 * FUNCION PARA ACTIVAR BOTON DE ELIMINAR PRODUCTO
 */
function activarQuitarProductos(){
    var servicios = productosSeleccionados();
    if( servicios.length != 0 ){
        $('#btnEliminarProductos').prop('disabled', false);
    }else{
        $('#btnEliminarProductos').prop('disabled', true);
    }
}

/**
 *  FUNCION QUE DEVUELVE LOS PRODUCTOS SELECCIONADOS
 */
function productosSeleccionados(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    return seleccionados;
}
