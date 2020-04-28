
$('#btnHome').click(function(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GET_DATA_USER",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
        dataType: "json",
        method: "POST",
        success: function (respuesta) {
            switch(respuesta.idCargo){
                case 19:{
                    window.location.href = "https://localhost:3000/volvo/view/gestionUsuario/GU_Home";
                    break;
                }
            }
        }
    });
});

$('#btnGestionUsuarios').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/gestionUsuario/GU_Gestion_Usuarios";
});

$('#btnControlBD').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/gestionUsuario/GU_DataBase";
});