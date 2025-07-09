// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Immutable{

    //2505  
    address public owner = msg.sender;    
    //2505 
    //address public immutable owner = msg.sender;

    uint public x;
    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}