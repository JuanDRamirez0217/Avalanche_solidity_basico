// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract crowfunding{
    //Dinero recaudado
    mapping (address => uint256) public fondos_contribuyentes;
    //Administrador del contrato
    address public manager;
    //tiempo de campaña
    uint public deadline; 
    //Objetivo de la campaña
    uint public target_amount;
    //Dinero realmente recogido
    uint public rise_amount;

    struct Request{
        string descripcion;
        address payable recipient;
        uint value;
        bool completed;
    }

    mapping (uint => Request )  public requests;
    uint public num_requests;

    constructor(uint _target_amount, uint _deadline) {
        target_amount = _target_amount;
        deadline = block.timestamp + _deadline;
        manager = msg.sender;
    }

    function enviar_fondos() public payable {
        require(block.timestamp < deadline, "El plazo ha terminado");
        fondos_contribuyentes[msg.sender] += msg.value;
        rise_amount += msg.value;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    //Permite tarnsferir los fondos del contrato una vez se cumpla las condiciones de tiepo y balance
    function refund() public{
        require(block.timestamp > deadline && rise_amount < target_amount, "La meta fue alcanzada o el plazo...");
        uint amount_refund = fondos_contribuyentes[msg.sender];
        require(amount_refund>0, "No has contribuido fondos");
        fondos_contribuyentes[msg.sender] = 0;
        payable(msg.sender).transfer(amount_refund); 
    }

    modifier only_manager() {
        require(msg.sender == manager, "Solo el administrador puede realizar esta accion");
        _;
    }
    // si se cumplió el objetivo y el que lo ejecuta es el manager, puede sacar dinero del contrato a un tercero
    function create_request(string memory _descripcion, address payable _recipient, uint _value) public only_manager {
        require(rise_amount>= _value, "No hay fondos suficientes para esta solicitud");
        Request storage new_request  = requests[num_requests];
        num_requests++;
        new_request.descripcion = _descripcion;
        new_request.recipient = _recipient;
        new_request.value = _value;
        new_request.completed = false;
    }
    //Función que permite realizar el pago de la peticion
    function make_payment(uint _request_num) public only_manager {
        require(rise_amount >= target_amount, "No se cumplio la meta");
        Request storage this_request  = requests[_request_num];
        require(!this_request.completed,"Esta peticion ya se ha realizado");
        this_request.recipient.transfer(this_request.value);
        this_request.completed = true;
    }

}

