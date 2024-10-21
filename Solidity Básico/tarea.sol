// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract tarea{
    string private fullname;
    constructor(string memory nombre_completo) {
        fullname = string.concat("Tu Nombre completo es:", " ", nombre_completo); 
    } 

    function hola_name()public view returns(string memory) {
        return fullname;
    }
    // creamos la variable y un boton dinamico del correo al igual que del numero que cuando digiten 
    // un dato este los actualice y los guarde de una vez 
    string correo = "Tu correo es:";

    function leer_correo() public view returns(string memory){
        return correo; 
        }
    
    function guardarcorreo(string memory Dame_tu_correo) public {
        correo = Dame_tu_correo;
    }
 
  
    string numero = "Tu numero de telefono es:";

    function leer_numero() public view returns(string memory){
        return numero; 
        }
    
    function guardarnumero(string memory Dame_tu_numero_telefonico) public {
        numero = Dame_tu_numero_telefonico;
    }
}