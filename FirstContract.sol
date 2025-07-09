// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FirstContract{

    uint  public  amount;

    function add() public {
        amount += 1;
    }

    function get() public view returns(uint){
        return amount;
    }
}