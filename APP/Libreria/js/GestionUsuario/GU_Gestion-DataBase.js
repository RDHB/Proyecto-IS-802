$(Document).ready(function(){
    $.ajax({
		url: "https://localhost:3000/volvo/api/GU/GU_LOGIN",
		data: {
            "usuario" : 'Murphy',
            "password" : 'FSJ44MIN4FJ',
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
                    $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">'+$('#selectNombresTablaDB').val()+'</h3>');
            }
        });
    })
});

$('#selectNombresTablaDB').change(function(){
    if( $('#selectNombresTablaDB').val() !== "- Seleccione Tabla -"){
        $.ajax({
            url: "https://localhost:3000/volvo/api/Miscelaneos/GET_CAMPOS_TABLE_DB",
            data: {"nombreTabla": $("#selectNombresTablaDB").val()},
            headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
            dataType: "json",
            method: "POST",
            success: function (respuesta) {
                    $('#selectCamposTabla').empty();
                    $('#selectCamposTabla').append('<option value="ninguna">- Seleccione Campo Tabla -</option>');
                    for(i=0; i< respuesta.data.length; i++){
                        $('#selectCamposTabla').append('<option value="'+respuesta.data[i].COLUMN_NAME+'">'+respuesta.data[i].COLUMN_NAME+'</option>');
                    }
                    $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">'+$('#selectNombresTablaDB').val()+'</h3>');
            },
            error: function(err){
                console.log(err)
            }
            
        });     
    }else{
        $("#displaNombreTabla").replaceWith('<h3 id="displaNombreTabla">'+$('#selectNombresTablaDB').val()+'</h3>');
        $('#selectCamposTabla').empty();
        $('#selectCamposTabla').append('<option value="ninguna">- Seleccione Campo Tabla -</option>');
    }

});