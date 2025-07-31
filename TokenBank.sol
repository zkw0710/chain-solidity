// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokanBank{

    IERC20 public token;

    mapping(address => uint256) balanceof;

    constructor(address _address){
        token = IERC20(_address);
    } 

    //存入本合约
    function deposit(uint256 _value) external returns (bool) {

        require(_value > 0,"The _value must be greater than 0.");
        //需要先授权
        require(token.allowance(msg.sender, address(this)) >= _value,
                "The authorized _value must be gt or equal to the quantity being transferred.");

        balanceof[msg.sender] += _value;
        bool success = token.transferFrom(msg.sender, address(this), _value);
        
        require(success,"transferFrom fail");

        return success;
    }

    //提取token
    function withdraw(uint256 _value) external returns(bool) {
        require(_value > 0,"The _value must be greater than 0.");
        require(balanceof[msg.sender] > _value,"balance must be greater than 0.");

        balanceof[msg.sender] -= _value;
        bool success = token.transfer(msg.sender, _value);

        require(success,"transfer fail");
        return success;
    }

}