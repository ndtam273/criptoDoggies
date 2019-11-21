pragma solidity ^0.4.18;

import "./AccessControl.sol";
import "./ERC721.sol";
import "./SafeMath.sol";

contract DetailedERC721 is ERC721 {
    function name() public view returns (string _name);
    function symbol() public view returns (string _symbol);

}
contract CryptoDoggies is AccessControl, DetailedERC721 {
  using SafeMath for uint256;

  event TokenCreated(uint256 tokenId, string name, bytes5 dna, uint256 price, address owner);
  event TokenSold(
      uint256 indexed tokenId, 
      string name, 
      bytes5 dna, 
      uint256 sellingPrice, 
      uint256 newPrice), 
      address indexed oldOwner, 
      address indexed newOwner
  
};

mapping (uint256 => address) private tokenIdToOwner; // map tokenId to owner
mapping (uint256 => uint256) private tokenIdToPrice; // reference price of a token
mapping (address => uint256) private ownershipToTokenCount; // Count token of an owner
mapping (uint256 => address) private tokenIdToApproved; // ???

struct Doggy {
    string name;
    bytes5 dna;
}

Doggy[] private doggies;

uint256 private startingPrice = 0.01 ether;
bool private erc721Enabled = false;

modifier onlyERC721() {
    require(erc721Enabled);
    _;
}

function createToken(string _name, address _owner, uint256 _price) public onlyCLevel {
    
}







