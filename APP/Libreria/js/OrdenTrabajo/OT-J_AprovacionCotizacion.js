var total = 0;
$('#btnBuscar').on('click', function() {
    (async function(){
        var total = 0;
        total += await seleccionarInfoServicios();
        total += await seleccionarInfoCotizacion();
        console.log(total);
        $('#txtTotal').val(total);
    })()
});



$('#btnAprobar').on('click', function() {
    aprobarCotizacion();
});

$('#btnRechazar').on('click', function() {
    rechazarCotizacion();
});


//Seleccionar informacion de servicios
async function seleccionarInfoServicios (){
    var total = 0;
    //<====={Selecciona Servicios}=====>
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_J_APROVACION_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'SELECT-S'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0){
                var html = '';
                var len = respuesta.data.length;
                
                for (var i = 0; i< len; i++) {
                    var d = new Date(respuesta.data[i].duracion);
                    html += '<tr>';
                    html += '<td>' + respuesta.data[i].idServicios + '</td>';
                    html += '<td>' + respuesta.data[i].nombre + '</td>';
                    html += '<td>' + respuesta.data[i].precioCosto + '</td>';
                    html += '<td>' + d.toLocaleTimeString() + ' horas</td>';
                    html += '</tr>';
                    total += parseFloat(respuesta.data[i].precioCosto);
                }
                document.getElementById("tbodyServicios").innerHTML = html;
            }else if (respuesta.output.pcodigoMensaje == 4){

                document.getElementById("tbodyServicios").innerHTML = '';
                alert('Orden de trabajo no encontrada');

            }else{

                document.getElementById("tbodyServicios").innerHTML = '';

            }
        },
        error: function (error) {
            console.error(error);
        }
    });
    return total;
}



//Seleccionar informacion de cotizacion
async function seleccionarInfoCotizacion (){
    var total = 0;
    
    //<====={Selecciona Cotizacion}=====>
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_J_APROVACION_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'SELECT-C'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0){
                var html = '';
                var len = respuesta.data.length;
                
                for (var i = 0; i< len; i++) {
                    html += '<tr>';
                    html += '<td>' + respuesta.data[i].idProducto + '</td>';
                    html += '<td>' + respuesta.data[i].nombre + '</td>';
                    html += '<td>' + respuesta.data[i].cantidad + '</td>';
                    html += '<td>' + respuesta.data[i].precioVenta + '</td>';
                    html += '<td>' + respuesta.data[i].subTotal + '</td>';
                    total += parseFloat(respuesta.data[i].precioVenta);
                    html += '</tr>';
                }
                document.getElementById("tbodyCotizacion").innerHTML = html;
            }else if (respuesta.output.pcodigoMensaje == 4){

                document.getElementById("tbodyCotizacion").innerHTML = '';
                alert('Orden de trabajo no encontrada');

            }else{

                document.getElementById("tbodyCotizacion").innerHTML = '';

            }
        },
        error: function (error) {
            console.error(error);
            //$("#notificacion").append(error.responseText);
        }
    });
    
    return total;
}

//Aprobar cotizacion
async function aprobarCotizacion (){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_J_APROVACION_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'SAVE'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            switch (respuesta.output.pcodigoMensaje){
                case 0:{
                    alert('Cotizacion Aprobada');
                    break;
                }
                case 5:{
                    alert('No se puede aprobar la cotizacion actualmente. Consulte el estado de orden de trabajo.');
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
        },
        error: function (error) {
            console.error(error);
            //$("#notificacion").append(error.responseText);
        }
    });
}



//Rechazar cotizacion
async function rechazarCotizacion (){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_J_APROVACION_COTIZACION",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "accion"      : 'CANCEL'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            switch (respuesta.output.pcodigoMensaje){
                case 0:{
                    alert('Cotizacion Rechazada');
                    break;
                }
                case 5:{
                    alert('No se puede rechazar la cotizacion actualmente. Consulte el estado de orden de trabajo.');
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
        },
        error: function (error) {
            console.error(error);
            //$("#notificacion").append(error.responseText);
        }
    });
}