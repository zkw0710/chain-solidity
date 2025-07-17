// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./testBasicERC20.sol";

contract TokenBank {

     BaseERC20 private erc20;

     // 记录每个用户的存款数量
     mapping(address => uint256) public deposits;

     constructor(){
        erc20 = new BaseERC20();
     }


     //需要记录每个地址的存入数量；
     function deposit(uint256 _value) public {

        deposits[msg.sender] += _value;

        bool success = erc20.transferFrom(msg.sender, address(this), _value);
        require(success,"Transfer failed");
     }

     //用户可以提取自己的之前存入的 token
     function withdraw(uint256 _value) public {
        bool success = erc20.transfer(msg.sender, _value);
        require(success,"Transfer failed");
        deposits[msg.sender] -= _value;
     }
}