'use strict'

// IMPORTANDO MODULOS

// DEFINIENDO FUNCIONES MISCELANEAS
function redirectById(req,res){
    switch(req.session.idCargo){
        case 1:{
            res.redirect('/volvo/view/gestionUsuario/GU_Home');
            break;
        }
        case 7 || 12 || 13 || 14 :{
            res.redirect('/volvo/view/ordenTrabajo/OT_Home');
            break;
        }
        case 15 || 16:{
            res.redirect('/volvo/view/rrhh/RH_Home');
            break;
        }
        case 17:{
            res.redirect('/volvo/view/facturacion/FA_Home');
            break;
        }
    }
}

// EXPORTANDO FUNCIONES MISCELANEAS
module.exports = {
    redirectById
};