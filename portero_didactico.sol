// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract portero_didactico{
    
    uint256 public numero; //Variable de estado que almacenará a la edad

    function establecer_numero(uint256 _numero) public{
        numero = _numero;
    }

    function mensaje() public view returns (string memory){
        
        //If-Else
        if (numero >= 18){
            return "Puedes ingresar porque eres mayor de edad";
        }else{
            return "No puedes ingresar, debes ser mayor de edad";
        }

    }

}