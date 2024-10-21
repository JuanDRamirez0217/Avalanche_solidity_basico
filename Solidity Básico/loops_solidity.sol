// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Loops_solidity{
    function loop() pure public {
        uint256 j;
        
        //Loop for
        for (uint256 i = 0; i < 10 ; i++){
            if (i == 3){
                continue;
            }

            if (i ==5){
                break;
            }
        }
        //Loop while
        while (j < 10) 
        {
            j++;

            if(j > 100){
                break;  // break the loop when the value is greater than 100 
                }
        }

    }
}