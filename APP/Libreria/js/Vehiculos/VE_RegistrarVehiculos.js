/**
 * AL INICIAR LA PAGINA SE DEBE CARGAR LOS SELECT CON LA INFORMACION PERTINENTE
 */
$(Document.body).ready(async function(){
    await rellenarSelectMarca();
    $('#btnNuevaMarca').remove();
    $('#btnNuevoModelo').remove();
});

/**
 * FUNCIONALIDAD AL CAMBIAR EL SELECT LA MARCA
 */
$('#selectMarca').change(async function(){
    $('#selectModelo').empty();
    $('#selectModelo').append(`<option value="">Modelo</option>`);
    if( $('#selectMarca').val() !== "" ){
        await rellenarSelectModelo();
        $('#btnNuevoModelo').prop('disabled', false);
    }else{
        $('#btnNuevoModelo').prop('disabled', true);
    }
});

/**
 * FUNCIONALIDAD DEL BOTON NUEVA MARCA
 */
/*$('#btnNuevaMarca').click(async function(){
    $('#nuevaMarcaCampo').empty();
    $('#nuevaMarcaNotificacion').empty();
    $('#nuevaMarca').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    $('#nuevaMarcaCampo').append(
        `
        <tr>
            <td>Marca del vehículo</td>
            <td>
                <input  type="text" style="" id="nuevaMarcaVehiculo" value="">
            </td>
        </tr>
        `
    );
});*/

/**
 * FUNCIONALIDAD BOTON ACEPTAR NUEVA MARCA
 */
/*$('#aceptarNuevaMarca').click(async function(){
    var codigoMessage = await agregarMarca();
    $('#nuevaMarcaNotificacion').empty();
    if(codigoMessage == 0){
        $('#nuevaMarcaCampo').empty();
        $('#nuevaMarcaNotificacion').append('<p style="color: green" >La nueva marca fue agregada</p>');
        $('#selectMarca').empty();
        $('#selectMarca').append(`<option value="">Marca</option>`);
        await rellenarSelectMarca();
    }else{
        $('#nuevaMarcaNotificacion').append('<p style="color: brown" >La nueva marca no pudo ser agregada</p>');
    }
    await rellenarCorreoDireccion();
    $('#cancelarNuevaMarca').text('Cerrar');
});*/


/**
 * FUNCIONALIDAD DEL BOTON GUARDAR
 */

$('#btnGuardar').click(async function(){
    $('#guardarNotificacion').empty();
    $('#guardar').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    var codigoMessage = await registrarVehiculo();
    switch(codigoMessage){
        case 0:{
            $('#guardarNotificacion').append('<p style="color: green" >El vehículo fue registrado exitosamente</p>');
            break;
        }
        case 10:{
            $('#guardarNotificacion').append('<p style="color: brown" >Asegúrese que la información del vehículo esté completa</p>');
            break;
        }
        default:{
            $('#guardarNotificacion').append('<p style="color: brown" >El vehículo no pudo ser registrado</p>');
            break;
        }
    }
});


/**
 * FUNCIONALIDAD DEL BOTON CANCELAR
 */
$('#btnCancelar').click(async function(){
    $('#iVin').val("");
    $('#iColor').val("");
    $('#iPlaca').val("");
    $('#iNumeroMotor').val("");
});

/**
 * FUNCION QUE SIRVE PARA RELLENAR SELECT MARCA
 */
async function rellenarSelectMarca(){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "nombreTabla" : 'Marca',
            "accion"      : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(i=0; i< respuesta.data.length; i++){
                    $('#selectMarca').append('<option value="'+respuesta.data[i].idMarca+'">'+respuesta.data[i].descripcion+'</option>');
                }
            }
        }
    });
}

 /**
  * FUNCION QUE SIRVE PARA RELLENAR SELECT MODELO
  */
 async function rellenarSelectModelo(){
    await $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "nombreTabla" : 'Modelo',
            "accion"      : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                for(i=0; i< respuesta.data.length; i++){
                    if( respuesta.data[i].Marca_idMarca == $('#selectMarca').val() ){
                        $('#selectModelo').append('<option value="'+respuesta.data[i].idModelo+'">'+respuesta.data[i].descripcion+'</option>');
                    }
                }
            }
        }
    });
 }

 /**
  * FUNCION QUE SIRVE PARA AGREGAR UNA NUEVA MARCA
  */
 /*async function agregarMarca(){
    var codigoMessage;
    await $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "nombreTabla" : 'Marca',
            "accion"      : 'INSERT',
            "json" : '{}'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                console.log(respuesta)
                for(i=0; i< respuesta.data.length; i++){
                    if( respuesta.data[i].Marca_idMarca == $('#selectMarca').val() ){
                        $('#selectModelo').append('<option value="'+respuesta.data[i].idModelo+'">'+respuesta.data[i].descripcion+'</option>');
                    }
                }
            }
        }
    });
    return codigoMessage;
 }*/

/**
 * FUNCION QUE SIRVE PARA REGISTRAR EL CLIENTE HACIENDO USO DEL API
 */
async function registrarVehiculo(){
    var codigoMessage;
    if( $('#iVin').val() == "" || $('#iColor').val() == "" || $('#iPlaca').val() == "" || $('#iNumeroMotor').val() == "" || $('#selectModelo').val() == "" ){
        codigoMessage = 10;
    }else{
        await $.ajax({
            url: "https://localhost:3000/volvo/api/VE/VE_GESTION_VEHICULOS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            dataType: "json",
            method: "POST",
            data: {
                "vin" : $('#iVin').val(),
                "color" : $('#iColor').val(),
                "placa" : $('#iPlaca').val(),
                "numeroMotor" : $('#iNumeroMotor').val(),
                "caja_de_cambios" : $('input[type=radio]:checked').val(),
                "idModelo" : $('#selectModelo').val(),
                "accion" : "INSERT"
            },
            success: function(respuesta){
                codigoMessage = respuesta.output.pcodigoMensaje;
            }        
        });
    }
    return codigoMessage;
}