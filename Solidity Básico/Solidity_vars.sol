// SPDX-License-Identifier: MIT
//hola
pragma solidity ^0.8.24;

contract Solidity_vars{
    address public block_now;           //Ver la dirección de minero actual
    uint public block_diff;             //Dificultad del bloque actual
    uint public block_num;              //Muestra el número de bloque de la cadena actual
    bytes32 public block_hash;          //Tipo de dato para el blockhash
    uint public time_stamp;             //Muestra el tiempo actual en formato epoch
    uint public gas_left;               //Gas restante
    address public sender;              //Qiuen ejecuta el contrato
    bytes4 public sig_id;               //Primeros 4 bytesd e la llamada de la función
    uint public gas_limit;              //Límite de gas del bloque actual

    function update_params() public {
        block_now = block.coinbase;
        block_diff = block.prevrandao;
        block_num = block.number;
        time_stamp = block.timestamp;
        gas_left = gasleft();
        sender = msg.sender;
        sig_id = msg.sig;
        gas_limit = block.gaslimit;

    }
}