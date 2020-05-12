///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////// VARIABLES GLOBALES ////////////////////////////////////////////////////////////////
var columnNames;
var dataTypeColumn = {};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////  FUNCIONALIDADES VARIAS ////////////////////////////////////////////////////////////

/*
    - SE RELLENAN SELECT DE TABLAS 
    POR DEFECTO SE DEJA SIN SELECCIONAR TABLA Y CAMPO DE ALGUNAS DE LAS TABLAS
*/
$(Document).ready(function(){
    $.ajax({
		url: "https://localhost:3000/volvo/api/GU/GU_LOGIN",
		data: {
            "usuario" : 'LuisFer15',
            "password" : 'Extremo15',
        },
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
			if (respuesta.pcodigoMensaje == 0) {
                localStorage.setItem('token',respuesta.token);
            }
		}
    }).then(function(){
        $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GET_TABLESNAMES_DB",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                    for(i=0; i< respuesta.data.length; i++){
                        $('#selectNombresTablaDB').append('<option value="'+respuesta.data[i].TABLE_NAME+'">'+respuesta.data[i].TABLE_NAME+'</option>');
                    }
                    $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">- Seleccione Tabla -</h3>');
            }
        });
    })
});

/*
    FUNCIONALIDAD CUANDO CAMBIA VALOR DEL SELECT NOMBRE DE TABLA LAS TABLAS SE VUELVE A RELLENAR EL SELECT DE LOS CAMPOS, POR DEFECTO SE DEJA QUE NO SELECCIONA UN CAMPO EN PARTICULAR
*/
$('#selectNombresTablaDB').change(function(){
    if( $('#selectNombresTablaDB').val() !== ""){
        $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GET_CAMPOS_TABLE_DB",
            data: {"nombreTabla": $("#selectNombresTablaDB").val()},
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                    $('#selectCamposTabla').empty();
                    $('#selectCamposTabla').append('<option value="">- Seleccione Campo Tabla -</option>');
                    for(i=0; i< respuesta.data.length; i++){
                        $('#selectCamposTabla').append('<option value="'+respuesta.data[i].COLUMN_NAME+'">'+respuesta.data[i].COLUMN_NAME+'</option>');
                        dataTypeColumn[respuesta.data[i].COLUMN_NAME] = respuesta.data[i].DATA_TYPE;
                    }
                    $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">'+$('#selectNombresTablaDB').val()+'</h3>');
                    rellenarTable();
            },
            error: function(err){
                console.log(err)
            }
            
        });     
    }else{
        $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">- Seleccionar Tabla -</h3>');
        $('#selectCamposTabla').empty();
        $('#selectCamposTabla').append('<option value="">- Seleccione Campo Tabla -</option>');
        $('#encabezadoTable').empty();
        $('#cuerpoTable').empty();
    }

});

/*
    FUNCIONALIDAD BUSQUEDA POR CAMPO SE REALIZA MEDIANTE INDEXOF
*/
$('#inputFiltroCampo').keyup(function(){
    if($('#selectCamposTabla').val() != ''){
        if($('#inputFiltroCampo').val() != ''){
            $.ajax({
                url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
                data: {
                    "nombreTabla" : $('#selectNombresTablaDB').val(),
                    "accion"      : 'SELECT'
                },
                dataType: "json",
                method: "POST",
                success: function (respuesta) {
                    if (respuesta.output.pcodigoMensaje == 0) {
                        $('#cuerpoTable').empty();
                        var cuerpoTable = document.querySelector("#cuerpoTable");
                        cuerpoTable.innerHTML = '';
                        const frontEndValorCampo = $('#inputFiltroCampo').val().toString().toLowerCase();
                        for(let backEndValorCampo of respuesta.data){
                            var i = 0;
                            let valorCampo = backEndValorCampo[$('#selectCamposTabla').val()].toString().toLowerCase();
                            if(valorCampo.indexOf(frontEndValorCampo) !== -1){
                                columnNames = Object.keys(backEndValorCampo);
                                    for(j = 0; j < columnNames.length; j++){
                                        if(j == 0){
                                            cuerpoTable.innerHTML += 
                                                `<tr id="registro${backEndValorCampo[columnNames[j]]}" style="display:flexbox; align-content: center;">
                                                    <th>
                                                        <input type="checkbox" id="${i}" value="${i}" name="${i}"/>
                                                        <label for="${i}">.</label>
                                                    </th>
                                                    <td id="${columnNames[j]+i}">${backEndValorCampo[columnNames[j]]}</td>
                                                </tr>
                                            `;
                                        }else{
                                            var registro = document.querySelector("#registro"+backEndValorCampo[columnNames[0]]);
                                            registro.innerHTML += `<td id="${columnNames[j]+i}">${backEndValorCampo[columnNames[j]]}</td>`;
                                        }
                                    }    
                            }
                            i++;
                        }
                        if(cuerpoTable.innerHTML === ''){
                            cuerpoTable.innerHTML += `
                                        <tr style="display:flexbox; justify-content: center; align-content: center; width:100%;">
                                            <th></th>
                                            <th></th>
                                            <th>
                                                <span style="width:100%; text-align:center;"> No hay registros con ese valor de campo</span>
                                            </th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                `;
                        }
                    }
                }
            });    
        }else{
            rellenarTable();
        }
    }
});


/*
    FUNCIONALIDAD DEL BOTON EDITAR REGISTRO CUANDO ESTE ES SELECCIONADO
*/
$('#btnEditarRegistro').click( async function(){
    var seleccionados = registrosSeleccionados();
    $('#updateCamposRegistro').empty();
    $('#updateNotificacion').empty();
    if(seleccionados.length == 1){
        $('#updateRegistro').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        for (let seleccionado of seleccionados){
            for (columnName of columnNames){
                $('#updateCamposRegistro').append(
                    `
                    <tr>
                        <td>${columnName}</td>
                        <td>
                            <input  type="text" style="margin: 0 10 0 40" id="${'update'+columnName+seleccionado}" value="${$("#"+columnName+seleccionado).text()}">
                        </td>
                    </tr>
                
                    `
                );
            }
        }
    }
});

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE EDITAR REGISTRO
*/
$('#aceptarUpdateRegistro').click(async function(){
    var messages = await updateRegistros();
    $('#updateCamposRegistro').empty();
    for (i=0; i < messages.length; i++){
        if(messages[i].pcodigoMensaje == 0){
            $('#updateNotificacion').append('<p style="color: green" >El registro con identificador: '+columnNames[0]+' = '+messages[i].registro+' ha sido modificado</p>');
        }else{
            $('#updateNotificacion').append('<p style="color: brown" >El registro con identificador: '+columnNames[0]+' = '+messages[i].registro+' no pudo ser modificado</p>');
        }
    }
    $('#cancelarUpdateRegistro').text('Cerrar');
    rellenarTable();
});

/*
    ELIMINAR ALGUN REGISTRO SELECCIONADO
*/
$('#btnEliminarRegistro').click( async function(){
    var seleccionados = registrosSeleccionados();
    $('#eliminateCamposRegistros').empty();
    $('#eliminateNotificacion').empty();
    if(seleccionados.length >= 1){
        $('#eliminateRegistro').modal({
            fadeDuration: 250,
            fadeDelay: 1.5,
            modalClass: "modal"
        });
        for (let seleccionado of seleccionados){
            $('#eliminateCamposRegistros').append(
                `
                    <tr id="eliminateRegistro${seleccionado}"></tr>
                `
            );
            for (columnName of columnNames){
                $('#eliminateRegistro'+seleccionado).append(
                    `
                        <td style="margin: 0 10 0 40" id="${'eliminate'+columnName+seleccionado}" >${$("#"+columnName+seleccionado).text()} </td>
                
                    `
                );
            }
        }
    }
});

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE ELIMINAR REGISTRO
*/
$('#aceptarEliminateRegistro').click(async function(){
    var messages = await eliminarRegistros();
    $('#eliminateCamposRegistros').empty();
    for (i=0; i < messages.length; i++){
        if(messages[i].pcodigoMensaje == 0){
            $('#eliminateNotificacion').append('<p style="color: green" >El registro con identificador: '+columnNames[0]+' = '+messages[i].registro+' ha sido eliminado</p>');
        }else{
            $('#eliminateNotificacion').append('<p style="color: brown" >El registro con identificador: '+columnNames[0]+' = '+messages[i].registro+' no pudo ser eliminado</p>');
        }
    }
    $('#cancelarEliminateRegistro').text('Cerrar');
    rellenarTable();
});

/*
    FUNCIONALIDAD DEL BOTON AGREGAR REGISTRO CUANDO ESTE ES SELECCIONADO
*/
$('#plus').click( async function(){
    var seleccionados = registrosSeleccionados();
    $('#agregarCamposRegistro').empty();
    $('#agregarNotificacion').empty();
    $('#agregarRegistro').modal({
        fadeDuration: 250,
        fadeDelay: 1.5,
        modalClass: "modal"
    });
    for (columnName of columnNames){
        $('#agregarCamposRegistro').append(
            `
            <tr>
                <td>${columnName}</td>
                <td>
                    <input  type="text" style="margin: 0 10 0 40" id="${'agregar'+columnName}" value="">
                </td>
            </tr>
            `
        );
    }
});

/*
    FUNCIONALIDAD DEL BOTON ACEPTAR DE AGREGAR
*/
$('#aceptarAgregarRegistro').click(async function(){
    var messages = await agregarRegistros();
    $('#agregarCamposRegistro').empty();
    for (i=0; i < messages.length; i++){
        if(messages[i].pcodigoMensaje == 0){
            $('#agregarNotificacion').append('<p style="color: green" >El registro ha sido agregado</p>');
        }else{
            $('#agregarNotificacion').append('<p style="color: brown" >El registro no pudo ser agregado</p>');
        }
    }
    $('#cancelarAgregarRegistro').text('Cerrar');
    rellenarTable();
});




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// FUNCIONES //////////////////////////////////////////////////////////////////////////////////////////
/*
    FUNCIONES USADAS PARA RELLENAR LA TABLA
*/
async function rellenarTable(){
    $('#encabezadoTable').empty();
    $('#encabezadoTable').append('<th></th>');
    $('#cuerpoTable').empty();
    await rellenarEncabezadoTabla();
    await rellenarCuerpoTabla();

}

function rellenarEncabezadoTabla(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GET_CAMPOS_TABLE_DB",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {"nombreTabla": $("#selectNombresTablaDB").val()},
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
                for(i=0; i< respuesta.data.length; i++){
                    $('#encabezadoTable').append(`<th>${respuesta.data[i].COLUMN_NAME}</th>`);
                }
        }
    });     
}

function rellenarCuerpoTabla(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        data: {
            "nombreTabla" : $('#selectNombresTablaDB').val(),
            "accion"      : 'SELECT'
        },
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            if (respuesta.output.pcodigoMensaje == 0) {
                if(respuesta.data.length > 0){
                    columnNames = Object.keys(respuesta.data[0]);
                for(i=0; i < respuesta.data.length; i++){
                    for(j = 0; j < columnNames.length; j++){
                        if(j == 0){
                            $('#cuerpoTable').append(
                                `<tr id="registro${respuesta.data[i][columnNames[j]]}"  style="display:flexbox; align-content: center;">
                                    <th>
                                        <input type="checkbox" id="${i}" value="${i}" name="${i}"/>
                                        <label for="${i}">.</label>
                                    </th>
                                    <td id="${columnNames[j]+i}" >${respuesta.data[i][columnNames[j]]}</td>
                                </tr>`
                            );
                        }else{
                            $('#registro'+respuesta.data[i][columnNames[0]]).append(
                                `<td id="${columnNames[j]+i}">${respuesta.data[i][columnNames[j]]}</td>`
                            );
                        }
                    }    
                }
                }
            }
        }
    });    
}

/*
    FUNCION QUE DEVUELVE ID DE USUARIOS SELECCIONADOS
*/
function registrosSeleccionados(){
    var seleccionados = new Array();
    $('input[type=checkbox]:checked').each(function() {
        seleccionados.push($(this).val());
    });
    return seleccionados;
}

/*
    FUNCION QUE SIRVE PARA ELIMINAR EL REGISTRO SELECCIONADO, FUNCIONA DENTRO DE LA FUNCIONALIDAD DEL BOTON ACEPTAR
 */
async function eliminarRegistros(){
    var messages = new Array();
    var seleccionados = registrosSeleccionados();
    for (let seleccionado of seleccionados){
        var informationRegistro = '{"'+columnNames[0]+'":'+$('#eliminate'+columnNames[0]+seleccionado).text()+'}';
        await $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : 'DELETE',
                "nombreTabla" : $('#selectNombresTablaDB').val(),
                "json" : informationRegistro
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#eliminate'+columnNames[0]+seleccionado).text()});
                }else{
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#eliminate'+columnNames[0]+seleccionado).text()});
                }
            },
            error : function(error){
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#eliminate'+columnNames[0]+seleccionado).text()});
            }
        });
    }
    return messages;
}

/*
    FUNCION QUE SIRVE PARA EDITAR EL REGISTRO SELECCIONADO, FUNCIONA DENTRO DE LA FUNCIONALIDAD DEL BOTON ACEPTAR
 */
async function updateRegistros(){
    var messages = new Array();
    var seleccionados = registrosSeleccionados();
    for (let seleccionado of seleccionados){
        var informationRegistro = '{';
        for(i = 0; i < columnNames.length; i++){
            if(dataTypeColumn[columnNames[i]] === "varchar"){
                informationRegistro += '"'+columnNames[i]+'":"'+$('#update'+columnNames[i]+seleccionado).val()+'"';
            }else{
                informationRegistro += '"'+columnNames[i]+'":'+$('#update'+columnNames[i]+seleccionado).val();
            }
            if(i != columnNames.length -1){
                informationRegistro += ','
            }

        }
        informationRegistro += '}';
        console.log(informationRegistro);
        await $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : "UPDATE",
                "nombreTabla" : $('#selectNombresTablaDB').val(),
                "json" : informationRegistro
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#update'+columnNames[0]+seleccionado).val()});
                    console.log(respuesta.output.pmensaje)
                }else{
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#update'+columnNames[0]+seleccionado).val()});
                    console.log(respuesta.output.pmensaje)
                }
            },
            error : function(error){
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje, registro: $('#update'+columnNames[0]+seleccionado).val()});
                console.log(respuesta.output.pmensaje)
            }
        });
    }
    return messages;
}


/*
    FUNCION QUE SIRVE PARA AGREGAR UN REGISTRO SELECCIONADO, FUNCIONA DENTRO DE LA FUNCIONALIDAD DEL BOTON ACEPTAR
 */
async function agregarRegistros(){
    var messages = new Array();
    var informationRegistro = '{';
    for(i = 0; i < columnNames.length; i++){
        if(dataTypeColumn[columnNames[i]] === "varchar"){
            informationRegistro += '"'+columnNames[i]+'":"'+$('#agregar'+columnNames[i]).val()+'"';
        }else{
            informationRegistro += '"'+columnNames[i]+'":'+$('#agregar'+columnNames[i]).val();
        }
        if(i != columnNames.length -1){
            informationRegistro += ','
        }
    }
    informationRegistro += '}';
    console.log(informationRegistro);
        await $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GENERIC_GESTION_TABLAS",
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            data: {
                "accion" : "INSERT",
                "nombreTabla" : $('#selectNombresTablaDB').val(),
                "json" : informationRegistro
            },
            dataType: "json",
            method: "POST",
            success: function(respuesta){
                if(respuesta.output.pcodigoMensaje == 0){
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje});
                    console.log(respuesta.output.pmensaje)
                }else{
                    messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje});
                    console.log(respuesta.output.pmensaje)
                }
            },
            error : function(error){
                messages.push({pcodigoMensaje: respuesta.output.pcodigoMensaje});
                console.log(respuesta.output.pmensaje)
            }
        });
    return messages;
}