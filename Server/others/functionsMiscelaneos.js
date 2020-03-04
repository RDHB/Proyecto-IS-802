'use strict'

// IMPORTANDO MODULOS

// DEFINIENDO FUNCIONES MISCELANEAS
function redirectById(req,res){
    switch(req.session.idCargo){
        case 1:{
            res.redirect('/volvo/view/home/gestionUsuario');
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        case 4:{
            break;
        }
        case 5:{
            break;
        }
        case 6:{
            break;
        }
        case 7:{
            break;
        }
        case 8:{
            break;
        }
        case 9:{
            break;
        }
        case 10:{
            break;
        }
        case 11:{
            break;
        }
        case 12:{
            break;
        }
        case 13:{
            break;
        }
        case 14:{
            break;
        }
        case 15:{
            break;
        }
        case 16:{
            break;
        }
        case 17:{
            break;
        }
    }
}

// EXPORTANDO FUNCIONES MISCELANEAS
module.exports = {
    redirectById
};