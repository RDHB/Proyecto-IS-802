var GlobalURL = "https://localhost:3000/volvo/api/OT/OT_T_FINALIZAR_MANTENIMIENTO";
$('#btnBuscar').on('click', function() {
    (async function(){
        var respuesta;
        respuesta = await seleccionarInfoListaServicios();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
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
                }
                document.getElementById("tbodyServicios").innerHTML = html;
                break;
            }
            case 4:{
                document.getElementById("tbodyServicios").innerHTML = '';
                alert('Orden de trabajo no encontrada');
                break;
            }
            default:{
                document.getElementById("tbodyServicios").innerHTML = '';
                break;
            }
        }

        respuesta = await seleccionarInfoControlCalidad();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                $('#txtEfectuadas').val(respuesta.data[0].reparacionesEfectuadas);
                $('#txtNoEfectuadas').val(respuesta.data[0].reparacionesNoEfectuadas);
                $('#txtRecomendaciones').val(respuesta.data[0].recomendaciones);
                break;
            }
            case 4:{
                document.getElementById("tbodyServicios").innerHTML = '';
                alert('Orden de trabajo no encontrada');
                break;
            }
            default:{
                document.getElementById("tbodyServicios").innerHTML = '';
                break;
            }
        }
        $('#updateNotoficacion').empty();
        $('#modalServicios').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        $('#updateNotoficacion').empty();
    })()
});


$('#btnMostrar').on('click', function() {
    (async function(){
        $('#updateNotoficacion').empty();
        $('#modalServicios').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        $('#updateNotoficacion').empty();
    })()
});


$('#btnFinalizar').on('click', function() {
    (async function(){
        var respuesta = await finalizarMantenimiento();
        switch (respuesta.output.pcodigoMensaje){
            case 0:{
                alert('Mantenimiento Finalizado');
                break;
            }
            case 5:{
                alert('No se puede finalizar el mantenimiento actualmente. Consulte el estado de orden de trabajo.');
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

















//Seleccionar informacion de Lista de Servicios
async function seleccionarInfoListaServicios (){
    var respuesta;
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

//Seleccionar informacion de Control de Calidad
async function seleccionarInfoControlCalidad (){
    var respuesta;
    //<====={Selecciona Servicios}=====>
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_J_CONTROL_CALIDAD",
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



//Finalizar Mantenimiento
async function finalizarMantenimiento (){
    var respuesta;
    await $.ajax({
        url: GlobalURL,
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "numeroOT" : $('#txtnumeroOT').val(),
            "reparacionesEfectuadas" : $('#txtEfectuadas').val(),
            "reparacionesNoEfectuadas" : $('#txtNoEfectuadas').val(),
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


