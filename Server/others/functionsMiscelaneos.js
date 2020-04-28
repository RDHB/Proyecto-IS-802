'use strict'

// IMPORTANDO MODULOS

// DEFINIENDO FUNCIONES MISCELANEAS
function redirectById(req,res){
    switch(req.session.idCargo){
        case 19:{
            res.redirect('/volvo/view/gestionUsuario/GU_Home');
            break;
        }
        case 17:{
            res.redirect('/volvo/view/ordenTrabajo/OT_Home');
            break;
        }
        case 9:
        case 15:
        case 16:
        case 2:
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