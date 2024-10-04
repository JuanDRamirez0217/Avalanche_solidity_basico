// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract portero_didactico{
    
    uint256 public numero; //Variable de estado que almacenará a la edad
    uint256 public edad_init; //Edad límite para la mayoría de edad
    constructor (uint256 _edad_init){
        edad_init = _edad_init;
    }

    function establecer_numero(uint256 _numero) public{
        numero = _numero;
    }

    function mensaje() public view returns (string memory){
        
        //If-Else
        if (numero >= edad_init){
            return "Puedes ingresar porque eres mayor de edad";
        }else{
            return "No puedes ingresar, debes ser mayor de edad";
        }

    }

}