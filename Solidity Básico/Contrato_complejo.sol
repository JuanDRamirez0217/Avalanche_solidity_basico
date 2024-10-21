// SPDX-License-Identifier: MIT
//Contrato de saludo dinámico
pragma solidity ^0.8.24;

contract Contrato_complejo{
    string saludo_d = "Hola Dinamico";
    string public saludo_estatico = "Hola estatico uwu";

    function leer_saludo() public view returns (string memory){
        return saludo_d;
    }

    function guardar_saludo(string memory nuevo_saludo) public{
        saludo_d = nuevo_saludo;
    } 
}

