/* Continuacion
    * 1. Una vez que el contenido ha sido formateado en una sola linea
    * 2. Ir a la linea de codigo siguiente
    *   $('body').prepend('');
    * 3. Reemplaze el codigo que esta dentro de las comillas simples de .preapend()
    * 4. Listo el Header se aplicado a todas las paginas
*/
$(Document).ready(function(){
    $('body').prepend('<!-- Header --> <div id="header"> <div class="top"> <!-- Usuario --> <div id="perfil-usuario"><!-- Información del usuario --> <span class="image avatar48"> <img src="../images/images1.png" alt="" /> </span> <h1>Nombre-Usuario</h1> <p>Nombre del Empleado</p> </div> <!-- Menu (Nav) --> <nav class="nav"> <ul id="menu-accion"> <!-- Lista de acciones del usuario --> <li> <a href="#top"> <span class="icon solid fa-home"></span> <span>Home</span> </a> </li> <li> <a href="#portfolio"> <span class="icon solid fa-th"></span> <span>Pagina 1</span> </a> </li> </ul> </nav> </div> <div class="bottom"> <!-- Social Icons --> <ul class="icons"> <li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li> <li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li> <li><a href="#" class="icon brands fa-github"><span class="label">Github</span></a></li> <li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li> <li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li> </ul> </div> </div>');
});
