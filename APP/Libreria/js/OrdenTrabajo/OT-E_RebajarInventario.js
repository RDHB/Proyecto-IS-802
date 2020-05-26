var GlobalURL = "https://localhost:3000/volvo/api/OT/OT_E_REBAJAR_INVENTARIO";
$('#btnBuscar').on('click', function() {
    (async function(){
        var respuesta;
        respuesta = await seleccionarInfoLista();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                var html = '';
                var len = respuesta.data.length;
                for (var i = 0; i< len; i++) {
                    html += '<tr>';
                    html += '<td>' + respuesta.data[i].idProducto + '</td>';
                    html += '<td>' + respuesta.data[i].nombre + '</td>';
                    html += '<td>' + respuesta.data[i].cantidad + '</td>';
                    html += '<td>' + respuesta.data[i].precioVenta + '</td>';
                    html += '<td>' + respuesta.data[i].SubTotal + '</td>';
                    html += '</tr>';
                }
                document.getElementById("tbodyProductos").innerHTML = html;
                break;
            }
            case 4:{
                document.getElementById("tbodyProductos").innerHTML = '';
                alert('Orden de trabajo no encontrada');
                break;
            }
            default:{
                document.getElementById("tbodyProductos").innerHTML = '';
                break;
            }
        }
    })()
});




$('#btnAceptar').on('click', function() {
    (async function(){
        var respuesta = await rebajarProductos();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                alert('Productos Rebajados del inventario');
                break;
            }
            case 5:{
                alert('No se puede rebajar los productos actualmente. Consulte el estado de orden de trabajo.');
                break;
            }
            case 4:{
                alert('Orden de trabajo no encontrada');
                break;
            }
            case 3:{
                break;
            }
            default:{
                break;
            }
        }
    })()
});

$('#btnRechazar').on('click', function() {
    (async function(){
        var respuesta = await rechazarLista();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                alert('Lista Rechazada');
                break;
            }
            case 5:{
                alert('No se puede rechazar la lista actualmente. Consulte el estado de orden de trabajo.');
                break;
            }
            case 4:{
                alert('Orden de trabajo no encontrada');
                break;
            }
            case 3:{
                break;
            }
            default:{
                break;
            }
        }
    })()
});



















//Seleccionar informacion de Lista de Materiales
async function seleccionarInfoLista (){
    var respuesta;
    //<====={Selecciona Servicios}=====>
    await $.ajax({
        url: GlobalURL,
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (res) {
            respuesta = res;
            console.log(res);
            
        },
        error: function (error) {
            console.error(error);
        }
    });
    return respuesta;
}



//Rebajar Productos
async function rebajarProductos (){
    var respuesta;
    await $.ajax({
        url: GlobalURL,
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'SAVE'
        },
        dataType: "json",
        method: "POST",
        success: function (res) {
            respuesta = res;
            console.log(res);
            
        },
        error: function (error) {
            console.error(error);
            //$("#notificacion").append(error.responseText);
        }
    });
    return respuesta;
}



//Rechazar Lista
async function rechazarLista (){
    var respuesta;
    await $.ajax({
        url: GlobalURL,
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'CANCEL'
        },
        dataType: "json",
        method: "POST",
        success: function (res) {
            respuesta = res;
            console.log(res);
        },
        error: function (error) {
            console.error(error);
            //$("#notificacion").append(error.responseText);
        }
    });
    return respuesta;
}