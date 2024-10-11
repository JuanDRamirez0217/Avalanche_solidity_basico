// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract tc_avax{
    //Determinar la dirección de la billetera que crea el contrato
    address payable public owner;

    struct Data{
        string date;
        string delivery_date;
        string product;
        string price;
        string code;
        string cel_number;
        int8 status;
        address wallet;
    }

    Data public data;

    event new_data(
        string date,
        string delivery_date,
        string product,
        string price,
        string code,
        string cel_number,
        int8 status,
        address wallet
    );

    //Verifica dentro de otras funciones que al ejecutar la función se tenga el valor del fee + el gas
    modifier cost(uint amount){
        require(msg.value >= amount, "Missing Avax to execute the contract");
        _;
    }

    //modifier para que solo el owner pueda retirar los fondos del contrato
    modifier only_owner(){
        require(msg.sender == owner, "Only the owner can withdraw the funds");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    //función para cambiar los datos del enum
    function push_Data(string memory _date,
                       string memory _delivery_date,
                       string memory _product,
                       string memory _price,
                       string memory _code,
                       string memory _cel_number,
                       int8 _status) public payable cost(100000000000000000) {
        data = Data( _date,
                    _delivery_date,
                    _product,
                    _price,
                    _code,
                    _cel_number,
                    _status, msg.sender);

        emit new_data(_date, _delivery_date, _product, _price, _code, _cel_number, _status, msg.sender);
    }
    
    //función para retirar los fondos
    function withdraw() public only_owner {
        uint balance = address(this).balance;
        require(balance > 0, "There are no funds in the contract to withdraw");

        owner.transfer(balance);
    }

    //funcion para consultar el valor que se encuentra en el contrato
    function get_balance() public view returns (uint256){
        return address(this).balance;
    }
}