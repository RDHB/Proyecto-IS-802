
/**
 * HABILITACION DE LOS BOTONES CORRESPONDIENTES SI NO ESTA VACIO EL CAMPO DE INDENTIDAD CLIENTE
 */
$('#iIdentidadCliente').keyup(function(){
    if( $('#iIdentidadCliente').val() !== ""){
        $('#btnMostrarOT').prop('disabled', false);
        if( $('#iVin').val() !== "" ){
            $('#btnGenerarOT').prop('disabled', false);
        }
    }else{
        $('#btnMostrarOT').prop('disabled', true);
        $('#btnGenerarOT').prop('disabled', true);
        $('#cuerpoTabla').empty();
        $('#cuerpoTabla').append(`
            <tr>
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
    if( $('#iVin').val() !== "" && $('#iIdentidadCliente').val() !== "" ){
        $('#btnGenerarOT').prop('disabled', false);
    }else{
        $('#btnGenerarOT').prop('disabled', true);
    }
});

/**
 * FUNCIONALIDAD DEL BOTON GENERAR ORDEN DE TRABAJO
 */
$('#btnGenerarOT').click(async function(){
    $('#generarOTNotificacion').empty();
    $('#generarOT').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await generarOrdenTrabajo();
    switch(codigoMessage){
        case 0:{
            $('#generarOTNotificacion').append('<p style="color: green" >La orden de trabajo fue generada exitosamente</p>');
            await rellenarTabla();
            break;
        }
        default:{
            $('#generarOTNotificacion').append('<p style="color: brown" >La orden de trabajo no pudo ser generada</p>');
            break;
        }
    }
});

/**
 * FUNCIONALIDAD DEL BOTON MOSTRAR VEHICULOS
 */
$('#btnMostrarOT').click(async function(){
    await rellenarTabla();
});


/**
 * FUNCION PARA GENERAR ORDEN DE TRABAJO
 */
async function generarOrdenTrabajo(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_GENERAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "vin" : $('#iVin').val(),
            "numeroIdentidad" : $('#iIdentidadCliente').val(),
            "accion"      : 'INSERT'
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
 * FUNCION QUE SIREVE PARA RELLENAR LA TABLA UNA VES SE VINVULA CLIENTE O SE PIDE MOSTRAR INFORMACION
 */
async function rellenarTabla(){
    $('#cuerpoTabla').empty();
    await $.ajax({
        url: "https://localhost:3000/volvo/api/OT/OT_A_GENERAR_OT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "accion" : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                var bandera = 0;
                for(i=0; i< respuesta.data.length; i++){
                    if( respuesta.data[i].numeroIdentidad == $('#iIdentidadCliente').val() ){
                        bandera = 1;
                        $('#cuerpoTabla').append(`
                            <tr>
                                <td>${respuesta.data[i].numeroOT}</td>
                                <td>${respuesta.data[i].Cliente}</td>
                                <td>${respuesta.data[i].Vehiculo}</td>
                                <td>${respuesta.data[i].EstadoOT}</td>
                            </tr>
                        `);
                    }
                }
                if( bandera == 0 ){
                    $('#cuerpoTabla').append(`
                        <tr>
                            <td></td>
                            <td>El cliente no tiene aún ninguna orden de trabajo asociada</td>                                                        
                            <td></td>
                            <td></td>
                        </tr>  
                    `);
                }
            }else{
                $('#cuerpoTabla').append(`
                    <tr>
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



