'use strict'

// IMPORTANDO MODULOS 


// FUNCIONES PARA AUTENTICAR LA VISITA A UN PAGINA DEPENDIENDO DE LA SESSION INICIADA
function authLogin(req,res,next){
    if (req.session.name){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authCajero(req,res,next){
    if (req.session.name && req.session.idCargo == 14){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAdmin(req,res,next){
    if (req.session.name && req.session.idCargo == 19){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAsesorServicios(req,res,next){
    if (req.session.name && req.session.idCargo == 17){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authJefeTaller(req,res,next){
    if (req.session.name && req.session.idCargo == 15){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authTecnico(req,res,next){
    if (req.session.name && req.session.idCargo == 16){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authEncargadoBodega(req,res,next){
    if (req.session.name && req.session.idCargo == 9){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authJefeRRHH(req,res,next){
    if (req.session.name && req.session.idCargo == 2){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authAsistenteRRHH(req,res,next){
    if (req.session.name && req.session.idCargo == 3){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authHomeOrdenTrabajo(req,res,next){
    if (req.session.name && (req.session.idCargo == 9 || req.session.idCargo == 15 || req.session.idCargo == 16 || req.session.idCargo == 17)){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

function authHomeRRHH(req,res,next){
    if (req.session.name && (req.session.idCargo == 2 || req.session.idCargo == 3)){
        return next();
    }else{
        return res.redirect('/volvo/view/login');
    }
}

// EXPORTANDO LAS FUNCIONES VALIDADORAS
module.exports = {
    authLogin,
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