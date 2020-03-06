'use strict'

// IMPORTANDO MODULOS 


// FUNCIONES PARA AUTENTICAR LA VISITA A UN PAGINA DEPENDIENDO DE LA SESSION INICIADA
function authCajero(req,res,next){
    if (req.session.name && req.session.idCargo == 17){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAdmin(req,res,next){
    if (req.session.name && req.session.idCargo == 1){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAsesorServicios(req,res,next){
    if (req.session.name && req.session.idCargo == 7){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authJefeTaller(req,res,next){
    if (req.session.name && req.session.idCargo == 12){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authTecnico(req,res,next){
    if (req.session.name && req.session.idCargo == 13){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authEncargadoBodega(req,res,next){
    if (req.session.name && req.session.idCargo == 14){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authJefeRRHH(req,res,next){
    if (req.session.name && req.session.idCargo == 15){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAsistenteRRHH(req,res,next){
    if (req.session.name && req.session.idCargo == 16){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authHomeOrdenTrabajo(req,res,next){
    if (req.session.name && (req.session.idCargo == 7 || req.session.idCargo == 12 ||req.session.idCargo == 13 || req.session.idCargo == 14)){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authHomeRRHH(req,res,next){
    if (req.session.name && (req.session.idCargo == 16 || req.session.idCargo == 15)){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

// EXPORTANDO LAS FUNCIONES VALIDADORAS
module.exports = {
    authCajero,
    authAdmin,
    authAsesorServicios,
    authAsistenteRRHH,
    authJefeRRHH,
    authJefeTaller,
    authTecnico,
    authEncargadoBodega,
    authHomeOrdenTrabajo,
    authHomeRRHH
};