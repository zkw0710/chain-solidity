// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Counter{

    uint public count;
    function inc() external {
        count +=1;
    }
    function sec()external {
        count -= 1;
    }
}