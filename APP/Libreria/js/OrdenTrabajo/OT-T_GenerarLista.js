var GlobalURL = "https://localhost:3000/volvo/api/OT/OT_T_GENERAR_LISTA";
$('#btnBuscarOrden').on('click', function() {
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
                    html += '<td>' + respuesta.data[i].subTotal + '</td>';
                    html += '</tr>';
                }
                document.getElementById("tbodyListaMateriales").innerHTML = html;
                break;
            }
            case 4:{
                document.getElementById("tbodyListaMateriales").innerHTML = '';
                alert('Orden de trabajo no encontrada');
                break;
            }
            default:{
                document.getElementById("tbodyListaMateriales").innerHTML = '';
                break;
            }
        }
    })()
});



$('#btnBuscarProducto').on('click', function() {
    (async function(){
        $('#updateNotoficacion').empty();
        $('#modalProductos').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        $('#updateNotoficacion').empty();
    })()
});



$('#btnAgregarProducto').on('click', function() {
    (async function(){
        var respuesta;
        var proCantidad = prompt("Ingrese la cantidad de producto", 0);
        respuesta = await agregarProducto(proCantidad);
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                alert('Producto Agregado');
                break;
            }
            case 4:{
                alert('id Incorrecto');
                break;
            }
            default:{
                alert('Producto Agregado u Orden de Trabajo no disponible');
                break;
            }
        }
        
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
                    html += '<td>' + respuesta.data[i].subTotal + '</td>';
                    html += '</tr>';
                }
                document.getElementById("tbodyListaMateriales").innerHTML = html;
                break;
            }
            case 4:{
                document.getElementById("tbodyListaMateriales").innerHTML = '';
                alert('Orden de trabajo no encontrada');
                break;
            }
            default:{
                document.getElementById("tbodyListaMateriales").innerHTML = '';
                break;
            }
        }
    })()
});



$('#btnGenerar').on('click', function() {
    (async function(){
        var respuesta = await generarLista();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                alert('Lista Generada');
                break;
            }
            case 5:{
                alert('No se puede generar la lista actualmente. Consulte el estado de orden de trabajo.');
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

$('#btnCancelar').on('click', function() {
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT_HOME";
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



async function agregarProducto (cantidad){
    var respuesta;
    //<====={Selecciona Servicios}=====>
    await $.ajax({
        url: GlobalURL,
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "idProducto" : $('#txtProducto').val(),
            "cantidad" : cantidad,
            "accion"      : 'INSERT'
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


//Generar Lista
async function generarLista (){
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


/*
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
}/* */