// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SendEther {
    constructor() payable {}

    receive() external payable { }

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(123);
    }
    function sendViaSend(address payable _to) external payable {
        bool send = _to.send(123);
        require(send,"send failed");
    }
    function sendViacall(address payable _to) external payable {
        (bool success,) =  _to.call{value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}