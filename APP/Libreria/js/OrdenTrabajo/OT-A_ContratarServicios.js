/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE ORDEN DE TRABAJO
 */
$('#iNumeroOT').keyup(function(){
    if( $('#iNumeroOT').val() !== "" ){
        $('#btnMostrarServicios').prop('disabled', false);
    }else{
        $('#btnMostrarServicios').prop('disabled', true);
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
 * FUNCIONALIDAD DEL BOTON MOSTRAR SERVICIOS
 */
$('#btnMostrarServicios').click(async function(){
    await rellenarTabla();
});

/**
 * FUNCIONALIDAD PARA CONTRATAR SERVICIOS
 */
$('#btnAgregarServicios').click(async function(){
    $('#contratarServiciosNotificacion').empty();
    $('#contratarServicios').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var messages = await contratarServicios();
    for(message of messages){
        switch(message.pcodigoMensaje){
            case 0:{
                $('#contratarServiciosNotificacion').append(`<p style="color: green" >El servicio ${message.servicio} fue agregado a la orden de trabajo</p>`);
                break;
            }
            default:{
                $('#contratarServiciosNotificacion').append(`<p style="color: brown" >El servicio ${message.servicio} no pudo ser agregado a la orden de trabajo</p>`);
                break;
            }
        }
    }
    $('#cuerpoTabla').empty();
    await rellenarTabla();  
});

/**
 * FUNCIONALIDAD PARA DESCONTRATAR SERVICIOS
 */
$('#btnEliminarServicios').click(async function(){
    $('#descontratarServiciosNotificacion').empty();
    $('#descontratarServicios').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var messages = await descontratarServicios();
    for(message of messages){
        switch(message.pcodigoMensaje){
            case 0:{
                $('#descontratarServiciosNotificacion').append(`<p style="color: green" >El servicio: ${message.servicio}, fue eliminado de la orden de trabajo</p>`);
                break;
            }
            default:{
                $('#descontratarServiciosNotificacion').append(`<p style="color: brown" >El servicio: ${message.servicio}, no pudo ser eliminado de la orden de trabajo</p>`);
                break;
            }
        }
    }
    $('#cuerpoTabla').empty();
    await rellenarTabla(); 
});


/**
 * FUNCIONALIDAD SALVAR SERVICIOS CONTRATADOS
 */
$('#btnSalvarServiciosContratados').click(async function(){
    $('#salvarServiciosNotificacion').empty();
    $('#salvarServicios').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await salvarCambiosContratacion();
        switch(codigoMessage){
            case 0:{
                $('#salvarServiciosNotificacion').append(`<p style="color: green" >Contratación salvada se puede pasar a la siguiente etapa</p>`);
                break;
            }
            default:{
                $('#salvarServiciosNotificacion').append(`<p style="color: brown" >Contratación no pudo ser salvada, intente nuevamente o es probable no puede modificar en este momento</p>`);
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
        url: "https://localhost:3000/volvo/api/OT/OT_A_CONTRATAR_SERVICIOS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT',
            "numeroOT" : $('#iNumeroOT').val()
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(i=0; i< respuesta.data.length; i++){
                    var contratado;
                    if(respuesta.data[i].servicioEfectuado != null){contratado="Contratado"}else{contratado="No contratado"}
                        $('#cuerpoTabla').append(`
                            <tr>
                                <td style="width: 0.5%;">
                                    <input onClick="activarAgregarQuitarServicios()" type="checkbox" id="${respuesta.data[i].idServicios}" name="${respuesta.data[i].idServicios}" value="${respuesta.data[i].idServicios}">
                                    <label for="${respuesta.data[i].idServicios}"></label>
                                </td>
                                <td>${contratado}</td>
                                <td id="${'nombreServicio'+respuesta.data[i].idServicios}">${respuesta.data[i].nombre}</td>
                                <td>${respuesta.data[i].precioCosto}</td>
                                <td>${respuesta.data[i].duracion}</td>
                                <td>${respuesta.data[i].servicioEfectuado}</td>
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
 * FUNCION PARA CONTRATAR SERVICIOS
 */
async function contratarServicios(){
    var messages = new Array();
    var servicios = serviciosSeleccionados();
    for(servicio of servicios){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_CONTRATAR_SERVICIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "idServicios" : servicio,
                "numeroOT" : $('#iNumeroOT').val(),
                "accion"      : 'INSERT'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, servicio: $('#nombreServicio'+servicio).text()});
            }
        });
    }
    return messages;
}

/**
 * FUNCION PARA DESCONTRATAR SERVICIOS
 */
async function descontratarServicios(){
    var messages = new Array();
    var servicios = serviciosSeleccionados();
    for(servicio of servicios){
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_CONTRATAR_SERVICIOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "idServicios" : servicio,
                "numeroOT" : $('#iNumeroOT').val(),
                "accion"      : 'DELETE'
            },
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, servicio: $('#nombreServicio'+servicio).text()});
            }
        });
    }
    return messages;
}

/**
 * FUNCION PARA CONTRATAR SERVICIOS
 */
async function salvarCambiosContratacion(){
    var codigoMessage;
        await $.ajax({
            url: "https://localhost:3000/volvo/api/OT/OT_A_CONTRATAR_SERVICIOS",
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
 * FUNCION PARA ACTIVAR LOS BOTONES DE AGREGAR O QUITAR SERVICIOS
 */
function activarAgregarQuitarServicios(){
    var servicios = serviciosSeleccionados();
    if( servicios.length != 0 ){
        $('#btnAgregarServicios').prop('disabled', false);
        $('#btnEliminarServicios').prop('disabled', false);
    }else{
        $('#btnAgregarServicios').prop('disabled', true);
        $('#btnEliminarServicios').prop('disabled', true);
    }
}

/**
 *  FUNCION QUE DEVUELVE LOS SERVICIOS SELECCIONADOS
 */
function serviciosSeleccionados(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    return seleccionados;
}