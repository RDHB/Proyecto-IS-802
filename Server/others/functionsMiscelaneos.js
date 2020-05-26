'use strict'

// IMPORTANDO MODULOS

// DEFINIENDO FUNCIONES MISCELANEAS
function redirectById(req,res){
    switch(req.session.idCargo){
        case 19:{
            res.redirect('/volvo/view/gestionUsuario/GU_Home');
            break;
        }
        case 9:{
            break;
        }
        case 15:{
            break;
        }
        case 16:{
            break;
        }
        case 17:{
            res.redirect('/volvo/view/vehiculos/VE_Home');
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            res.redirect('/volvo/view/rrhh/RH_Home');
            break;
        }
        case 14:{
            res.redirect('/volvo/view/facturacion/FA_Home');
            break;
        }
    }
}

// EXPORTANDO FUNCIONES MISCELANEAS
module.exports = {
    redirectById
};