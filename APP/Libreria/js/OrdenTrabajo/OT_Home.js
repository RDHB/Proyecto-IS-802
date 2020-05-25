$(document).ready(function() {
    switch(localStorage.getItem('cargo')){
        case "9":
            document.getElementById("OT-A_GenerarOT").remove();
            document.getElementById("OT-A_ContratarServicios").remove();
            document.getElementById("OT-A_RevisionVehiculo").remove();
            document.getElementById("OT-A_Cotizacion").remove();
            document.getElementById("OT-A_AprobacionCotizacion").remove();
            document.getElementById("OT-A_FinalizarOT").remove();

            document.getElementById("OT-J_AprobacionCotizacion").remove();
            document.getElementById("OT-J_AprobacionLista").remove();
            document.getElementById("OT-J_ControlCalidad").remove();
            
            document.getElementById("OT-T_Generarlista").remove();
            document.getElementById("OT-T_FinalizarMantenimiento").remove();
            break;
        case "15":
            document.getElementById("OT-A_GenerarOT").remove();
            document.getElementById("OT-A_ContratarServicios").remove();
            document.getElementById("OT-A_RevisionVehiculo").remove();
            document.getElementById("OT-A_Cotizacion").remove();
            document.getElementById("OT-A_AprobacionCotizacion").remove();
            document.getElementById("OT-A_FinalizarOT").remove();

            document.getElementById("OT-E_RebajarInventario").remove();

            document.getElementById("OT-T_Generarlista").remove();
            document.getElementById("OT-T_FinalizarMantenimiento").remove();
            break;
        case "16":
            document.getElementById("OT-A_GenerarOT").remove();
            document.getElementById("OT-A_ContratarServicios").remove();
            document.getElementById("OT-A_RevisionVehiculo").remove();
            document.getElementById("OT-A_Cotizacion").remove();
            document.getElementById("OT-A_AprobacionCotizacion").remove();
            document.getElementById("OT-A_FinalizarOT").remove();

            document.getElementById("OT-E_RebajarInventario").remove();

            document.getElementById("OT-J_AprobacionCotizacion").remove();
            document.getElementById("OT-J_AprobacionLista").remove();
            document.getElementById("OT-J_ControlCalidad").remove();
            
            break;
        case "17":{
            document.getElementById("OT-E_RebajarInventario").remove();

            document.getElementById("OT-J_AprobacionCotizacion").remove();
            document.getElementById("OT-J_AprobacionLista").remove();
            document.getElementById("OT-J_ControlCalidad").remove();

            document.getElementById("OT-T_Generarlista").remove();
            document.getElementById("OT-T_FinalizarMantenimiento").remove();
            break;
        }
    }
    /*

    OT-A_GenerarOT
    OT-A_ContratarServicios
    OT-A_RevisionVehiculo
    OT-A_Cotizacion
    OT-A_AprobacionCotizacion
    OT-A_FinalizarOT
    OT-E_RebajarInventario
    OT-J_AprobacionCotizacion
    OT-J_AprobacionLista
    OT-J_ControlCalidad
    OT-T_Generarlista
    OT-T_FinalizarMantenimiento
    */
});

$('#btnOT-A_GenerarOT').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_GenerarOT";
});

$('#btnOT-A_ContratarServicios').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_ContratarServicios";
});

$('#btnOT-A_RevisionVehiculo').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_RevisionVehiculo";
});

$('#btnOT-A_Cotizacion').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_Cotizacion";
});

$('#btnOT-A_AprobacionCotizacion').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_AprobacionCotizacion";
});

$('#btnOT-A_FinalizarOT').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-A_FinalizarOT";
});

$('#btnOT-E_RebajarInventario').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-E_RebajarInventario";
});

$('#btnOT-J_AprobacionCotizacion').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-J_AprobacionCotizacion";
});

$('#btnOT-J_AprobacionLista').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-J_AprobacionLista";
});

$('#btnOT-J_ControlCalidad').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-J_ControlCalidad";
});

$('#btnOT-T_Generarlista').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-T_Generarlista";
});

$('#btnOT-T_FinalizarMantenimiento').click(function(){
    window.location.href = "https://localhost:3000/volvo/view/ordenTrabajo/OT-T_FinalizarMantenimiento";
});
