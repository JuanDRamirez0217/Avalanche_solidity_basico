// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract variables_nativas{
    string private full_name;
    constructor(string memory _lastName) {
        full_name = string.concat("Juan", " ", _lastName); // variables de incializacion
    }

    function getName() public view returns (string memory) {
        return full_name;
    }

    /*
    uint enteros sin signo (no negativos)
    
    uint8 rango de 0 a 2 ** 8 - 1 
    uint16 rango de 0 a 2 ** 16 - 1

    . . . 
    uint256 rango de 0 a 2 ** 256 - 1    
    */

    uint8 public uint_8 = 8;
    uint256 public uint_256 = 254;

    // int enteros pero a diferencia del uint me permite numeros negativos
    int8 public int_8 = -1;
    int256 public int_256 = 456;

    // la variable de tipo address propia de Solidity y me permite almacenar direcciones
    address public  address_var = 0x1d870f1210e66cba98093682b84d4491Ec04141b;

    // bytes guardar datos de typo binario
    bytes1 a_var = 0xb5; // [10110101]
    bytes1 b_var = 0x56; // [01011010]
    bytes1 c_var;

    function getBytes() public view returns (bytes1){
        return c_var;
    }
}