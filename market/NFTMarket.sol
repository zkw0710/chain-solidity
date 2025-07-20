// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./TestNFT.sol";

contract NFTMarket{

    TestNFT private nft;

    //token对应的单价
    mapping (uint256 => uint256) private  _pricemap;

    constructor(address _nftaddress){
        nft = TestNFT(_nftaddress);
    }

    //铸造nft，并上架
    function list(address _address, uint256 _tokenURI, uint256 price) public {
        uint256 tokenid = nft._mints(_address,_tokenURI);
        _pricemap[tokenid] = price;
    }

    //购买nft
    function buyNFT(uint256 tokenId,uint256 price) public returns (address){
        require(_pricemap[tokenId] != 0, "token is not exists");
        require(_pricemap[tokenId] >= price," private is less ");

        //获取原tokenid地址
        address from = nft.ownerOf(tokenId);
        //nft交易
        nft.safeTransferFrom(from, msg.sender, tokenId);

        return from;
    }
}