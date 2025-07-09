// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank{

    //记录合约地址
    address payable public  owner;
    //记录每个地址的存款金额
    mapping (address => uint) addressAccountMap;
    //记录所有转账的地址
    address[] public addressAccount;
    //数组记录存款金额前三名用户
    address[] public topThree = new address[](3);
    
    
    constructor(){
        owner= payable (msg.sender);  /*The sender will be the creator*/
    }

    //转账到合约地址
    function deposit() external payable {
        transfer(msg.sender, msg.value);
    }

    function showBanlance() external view returns (uint256){
        return address(this).balance;
    }

    //并记录账号存款金额
    function transfer(address _address, uint value) internal   {

       require(value > 0,"Must be greater than 0.");

        if(addressAccountMap[_address] == 0){

            addressAccountMap[_address] = value;
            addressAccount.push(_address);
        } else {

            addressAccountMap[_address] = addressAccountMap[_address] + value;
        }

        for(uint8 i = 0; i < 3; i++){

           address vaddress = topThree[i];
           uint vvalue = addressAccountMap[vaddress];

           if(value > vvalue){
            
              for(uint8 j = 2; j > i; j--){
                 topThree[j] = topThree[j - 1];
              }
              topThree[i] = _address;
              break ;
           }
        }
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"mast owner address");
        _;
    }
    
    //管理提取合约资金
    function  withdraw() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}