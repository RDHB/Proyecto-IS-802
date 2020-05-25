/* Continuacion
    * 1. Una vez que el contenido ha sido formateado en una sola linea
    * 2. Ir a la linea de codigo siguiente
    *   $('body').prepend('');
    * 3. Reemplaze el codigo que esta dentro de las comillas simples de .preapend()
    * 4. Listo el Header se aplicado a todas las paginas
*/
$(Document.body).ready(function(){    
    $.ajax({
        url: "https://localhost:3000/volvo/api/Miscelaneos/GET_DATA_USER",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
            switch (respuesta.idCargo){
                case 19:{
                    $('body').prepend('<!-- Header --><div id="header"><div class="top"><!-- Usuario --><div id="perfil-usuario"><!-- Información del usuario --><span class="image avatar48"><a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;"><img src="'+localStorage.getItem('nombreArchivo')+'" alt="avatarUsuario"/></a></span> <h1><span id="nickNameUser">' + localStorage.getItem('usuario') +'</span></h1> <p id="nameOfUser">' + localStorage.getItem('nombre') + '</p></div><!-- Menu (Nav) --><nav class="nav"><ul id="menu-accion"><!-- Lista de acciones del usuario --><li> <a href="https://localhost:3000/volvo/view/gestionUsuario/GU_Home" id="btnHome"> <span class="icon solid fa-home"></span> <span>Inicio</span></a></li>          <li> <a href="https://localhost:3000/volvo/view/gestionUsuario/GU_Gestion_Usuarios"> <span class="icon solid fa-th"></span> <span>Gestión de Usuarios</span> </a> </li>           <li> <a href="https://localhost:3000/volvo/view/gestionUsuario/GU_DataBase"> <span class="icon solid fa-th"></span> <span>Control Base de Datos</span> </a> </li>            </ul></nav></div>      <div class="bottom nav"><ul><li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li></ul></div>         </div>');
                    break;
                }
                case 17:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión Orden de Trabajo</span></a></li>          
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_GenerarOT"> <span class="icon solid fa-th"></span> <span>Generar Orden de Trabajo</span> </a> </li> 
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_RevisionVehiculo"> <span class="icon solid fa-th"></span> <span>Revisión de Vehículo</span> </a> </li>            
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_ContratarServicios"> <span class="icon solid fa-th"></span> <span>Contratación de Servicios</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_Cotizacion"> <span class="icon solid fa-th"></span> <span>Cotizaciones</span> </a> </li>            
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_AprobacionCotizacion"> <span class="icon solid fa-th"></span> <span>Aprobación de Cotización</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-A_FinalizarOT"> <span class="icon solid fa-th"></span> <span>Finalizar Orden de Trabajo</span> </a> </li>            
                                    </ul>
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario Vehiculos -->
                                        <li> <a href="https://localhost:3000/volvo/view/vehiculos/VE_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión de Vehículos</span></a></li>          
                                        <li> <a href="https://localhost:3000/volvo/view/vehiculos/VE_RegistrarCliente"> <span class="icon solid fa-th"></span> <span>Registro de Clientes</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/vehiculos/VE_RegistrarVehiculos"> <span class="icon solid fa-th"></span> <span>Registro de Vehículos</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/vehiculos/VE_AsociarClienteVehiculo"> <span class="icon solid fa-th"></span> <span>Asociar Clientes a Vehículos</span> </a> </li>            
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>         
                        </div>                  
                    
                    `);
                    break;
                }        
                case 9:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión Orden de Trabajo</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-E_RebajarInventario" id="btnHome"> <span class="icon solid fa-th"></span><span>Rebajar productos del Inventario</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>         
                        </div>                  
                    
                    `);
                    break;
                }        
                case 15:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión Orden de Trabajo</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-J_AprobacionCotizacion" id="btnHome"> <span class="icon solid fa-th"></span><span>Aprobación Cotización</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-J_AprobacionLista" id="btnHome"> <span class="icon solid fa-th"></span><span>Aprobación Lista de Materiales</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-J_ControlCalidad" id="btnHome"> <span class="icon solid fa-th"></span><span>Control de Calidad</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>
                        </div>
                    `);
                    break;
                }        
                case 16:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión Orden de Trabajo</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-T_Generarlista" id="btnHome"> <span class="icon solid fa-th"></span><span>Generar Lista de Materiales</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/ordenTrabajo/OT-T_FinalizarMantenimiento" id="btnHome"> <span class="icon solid fa-th"></span><span>Finalizar Mantenimiento</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>
                        </div>          
                    `);
                    break;
                }        
                case 2:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión RRHH</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_Permisos" id="btnHome"> <span class="icon solid fa-th"></span><span>Permisos</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_Vacaciones" id="btnHome"> <span class="icon solid fa-th"></span><span>Vacaciones</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>
                        </div>          
                    `);
                    break;
                }        
                case 3:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión RRHH</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_Contratos" id="btnHome"> <span class="icon solid fa-th"></span><span>Contratos</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_EntrevistaTrabajo" id="btnHome"> <span class="icon solid fa-th"></span><span>Entrevista de Trabajo</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_HorasExtras" id="btnHome"> <span class="icon solid fa-th"></span><span>RH_HorasExtras</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_HuellaDigital" id="btnHome"> <span class="icon solid fa-th"></span><span>RH_HuellaDigital</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/rrhh/RH_RolPago" id="btnHome"> <span class="icon solid fa-th"></span><span>RH_RolPago</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>
                        </div>          
                    `);
                    break;
                }
                case 14:{
                    $('body').prepend(`
                        <!-- Header -->
                        <div id="header">
                            <div class="top">
                                <!-- Usuario -->
                                <div id="perfil-usuario">
                                    <!-- Información del usuario -->
                                    <span class="image avatar48">
                                        <a title="avatarUsuario" href="https://localhost:3000/volvo/view/gestionUsuario/GU_Configuracion_Usuario" style="width:100%; height:100%;">
                                            <img src="${localStorage.getItem('nombreArchivo')}" alt="avatarUsuario"/>
                                        </a>
                                    </span>
                                    <h1>
                                        <span id="nickNameUser">${localStorage.getItem('usuario')}</span>
                                    </h1> 
                                    <p id="nameOfUser">${localStorage.getItem('nombre')}</p>
                                </div>
                                <!-- Menu (Nav) -->
                                <nav class="nav">
                                    <ul id="menu-accion">
                                        <!-- Lista de acciones del usuario en Orden Trabajo-->
                                        <li> <a href="https://localhost:3000/volvo/view/facturacion/FA_Home" id="btnHome"> <span class="icon solid fa-home"></span><span>Inicio Gestión Factura</span></a></li>
                                        <li> <a href="https://localhost:3000/volvo/view/facturacion/FA_Facturar" id="btnHome"> <span class="icon solid fa-th"></span><span>Facturar</span></a></li>
                                    </ul>
                                </nav>
                            </div>      
                            <div class="bottom nav">
                                <ul>
                                    <li><a href="#" onClick="cerrarSession();" style="width:auto; color:white;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li>
                                </ul>
                            </div>
                        </div>          
                    `);
                    break;
                }            
            }
		},
		error: function (error) {
			$("#notificacion").append(error.responseText);
		}
    });
});

/**
 * FUNCION PARA HACER SALIR DE LA CUENTA
 */
function cerrarSession(){
    $.ajax({
        url: "https://localhost:3000/volvo/api/GU/GU_LOGOUT",
        headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')},
		data: {},
		dataType: "json",
		method: "POST",
		success: function (respuesta) {
            localStorage.removeItem('token');
            localStorage.removeItem('usuario');
			localStorage.removeItem('nombre');
			localStorage.removeItem('nombreArchivo');
            location.reload();
        }
	});
}


//ESTA ES LA ESTRUCTURA DEL HEADER, SE SECAMBIA HACERLO DE AQUI, LUEGO COMPACTARLO PARA COPIARLO EN EL PREPEND
/*
    <!-- Header -->' 
    <div id="header"> 
        <div class="top"> 
            <!-- Usuario --> 
            <div id="perfil-usuario">
                <!-- Información del usuario --> 
                <span class="image avatar48"> <img src="../images/images1.png" alt="" /> </span> 
                <h1>' + respuesta.user +'</h1> 
                <p>' + respuesta.name + '</p> 
            </div> 
            <!-- Menu (Nav) --> 
            <nav class="nav"> 
                <ul id="menu-accion"> 
                    <!-- Lista de acciones del usuario --> 
                    <li> <a href="#top"> <span class="icon solid fa-home"></span> <span>Home</span> </a> </li> 
                    <li> <a href="#portfolio"> <span class="icon solid fa-th"></span> <span>Pagina 1</span> </a> </li> 
                </ul> 
            </nav> 
        </div> 
        <div class="bottom"> 
            <!-- Social Icons --> 
            <ul class="icons"> 
                <li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li> 
                <li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li> 
                <li><a href="#" class="icon brands fa-github"><span class="label">Github</span></a></li> 
                <li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li> 
                <li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li> 
            </ul> 
        </div> 
    </div>



            <ul class="icons"><li> <a href="#"> <span class="icon solid fa-sign-out-alt"></span> <span>Cerrar Sesión</span></a></li></ul>
            


            <ul class="icons"><li style="width:100%/"><a href="#" style="width:auto;" class="icon solid fa-sign-out-alt"><span>Cerrar Sesión</span></a></li></ul>

*/

