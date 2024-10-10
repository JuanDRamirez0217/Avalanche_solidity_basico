// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Mapping{
    //Mapping de direcciones y enteros
    mapping(address => uint256) balance;

    //Funcion para ver el balance de Avax en el mapping
    function setBalance(address _addr) public {
        uint256 avax_balance = _addr.balance;
        balance[_addr] = avax_balance;

    }

    //Funcion para obtener el valor del mapping en la dirección indice
    function getBalance(address _addr)public view returns (uint256){
        return balance[_addr];
    }

    //Eliminar elementos del mapping
    function remove(address _addr) public  {
        delete balance[_addr];
    }
    
    //Llamado de una función dentro de otra para la actualización los balances del mapping

    function update_balance_avax(address _addr) public{
        setBalance(_addr);
    }
}