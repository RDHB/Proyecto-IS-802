$(document).ready(function() {
    switch(localStorage.getItem('cargo')){
        case "2":{
            document.getElementById("RH_EntrevistaTrabajo").remove();
            document.getElementById("RH_Contratos").remove();
            document.getElementById("RH_HuellaDigital").remove();
            document.getElementById("RH_HorasExtras").remove();
            document.getElementById("RH_RolPago").remove();
            break;
        }
        case "3":{
            document.getElementById("RH_Permisos").remove();
            break;
        }
    }
    /*
    RH_EntrevistaTrabajo
    RH_Contratos
    RH_HuellaDigital
    RH_HorasExtras
    RH_RolPago

    RH_Permisos
    RH_Vacaciones
    */
});


$('#btnRH_EntrevistaTrabajo').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_EntrevistaTrabajo";
});

$('#btnRH_Contratos').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_Contratos";
});

$('#btnRH_HuellaDigital').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_HuellaDigital";
});

$('#btnRH_HorasExtras').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_HorasExtras";
});

$('#btnRH_RolPago').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_RolPago";
});


$('#btnRH_Permisos').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_Permisos";
});

$('#btnRH_Vacaciones').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/rrhh/RH_Vacaciones";
});
