// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./NFTMarket.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestERC20 is ERC20 {


    NFTMarket market;

    constructor(address _address) ERC20("Myname","Mysymbol") {
        market = NFTMarket(_address);
    }

    //实现NFT购买功能,进行交易
    function tokensReceived (uint256 _tokenId, uint256 price) public {

       require(balanceOf(msg.sender) != 0,"address not token");
       require(balanceOf(msg.sender) >= price, "not enough token");

       address from = market.buyNFT(_tokenId,price);
       transfer(from, price);
    }
}