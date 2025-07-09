 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IBank {
    
    function withdraw() external ;
}

contract Bank is IBank {

    event Log(string title1, address admin, string title2, address owner);

    address public owner;
    constructor (){
        owner = msg.sender; 
    }

     receive() external payable {}

    function withdraw() override  external {
        emit Log("call address:", msg.sender , "admin:", owner);
        require(msg.sender == owner,"you are not the admin");
        payable(owner).transfer(address(this).balance);  
    }
}

contract BigBank is Bank{

    modifier onlyModifier(){
        require(msg.value > 0.01 ether,"mast than 0.01 ether");
        _;
    }

    
    //转移BigBank 的Owner 至 Admin
    function transferOwner(address newAdmin) external  {
       require(owner == msg.sender,"you are not the admin");
       require(newAdmin != address(0)," invalid addresss ");
       owner = newAdmin;
    }

    //存款
    function deposit() external payable onlyModifier{
    }
}

contract Admin {

    //管理员地址
    address public owner; 

    constructor(){
        owner = msg.sender;
    }

    // 接收BigBank转来的资金
    receive() external payable {}

    // 把 BigBank 的资金转移到 Admin 地址
    function adminWithdraw(IBank bank) external {
        bank.withdraw();
    }

    function showBanalan() view external returns (uint) {
        return address(this).balance;
    }
}