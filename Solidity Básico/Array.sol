// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Array{
    //Declarar arrays
    uint256[] public arr;
    uint256[] public arr2 = [22,33,44];

    //Array de tamaño fijo, todos sus elementos serán 0
    uint256[10] public arr_fijo;

    //Muestra un elemento en específico del array
    function get(uint256 i) public view returns(uint256) {
        return arr2[i];
    }

    //Muestra todos los elementos del array
    function getArr() public view returns(uint256[] memory) {
        return arr2;
    }

    //El push añade un nuevo elemento al array
    function push(uint256 i) public  {
        arr2.push(i);
    }

    //El pop elimina el último elemento del array
    function pop() public  {
        arr2.pop();
    }

    //Devuelve la longitud del array

    function getLenght() public view returns(uint256)  {
        return arr2.length;
    }
    
    //Elimina un elemento en particular
    function remove(uint256 index) public  {
        delete arr2[index];
    }



}