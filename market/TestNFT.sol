// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TestNFT is ERC721{

   
    //token计数
    uint256 private tokenCount ;

    //tokenid对应nfturl
    mapping (uint256 => uint256) _tokenurlmap;
    

     constructor() ERC721("MyNFT","MyNFT"){
        tokenCount = 0;
    }

    //铸造NFT
    function _mints(address _address, uint256 _tokenURI) public returns (uint256) {

        uint256 tokenid = tokenCount;
        _safeMint(_address, tokenid);
        _tokenurlmap[tokenid] = _tokenURI;
        tokenCount++;

        return tokenid;
    }
}