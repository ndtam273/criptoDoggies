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
      uint256 newPrice, 
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
    require(_owner != address(0));
    require(_price >= startingPrice);

    bytes5 _dna = _generateRandomDna();
    _createToken(_name, _dna, _owner, _price);
}

function _generateRandomDna() private view returns (bytes5) {
    uint256 lastBlockNumber =block.number - 1;
    bytes32 hashVal = bytes32(block.blockhash(lastBlockNumber));
    bytes5 dna = bytes5(hashVal & 0xffffffff) << 216);
    return dna;

}

function createToken(string _name) public conlyCLevel {
 bytes5 _dna = _generateRandomDna();
 _createToken(_name, _dna, address(this), startingPrice);
}

function _createToken(string _name, bytes5 _dna, address _owner, uint256 _price) {
    Doggy memory _doggy = Doggy({
        name: _name;
        dna: _dna
    });
    uint256 newTokenId = doggies.push(doggy) - 1;
    tokenIdToPrice[newTokenId] = _price;

    TokenCreate(newTokenId, _name, _dna, _price, _owner);

    _transfer(address(0), _owner, newTokenId);
}

function getToken(uint256 _tokenId) public view returns (
    string _tokenName,
    bytes5 _dna,
    uint256 _price,
    uint256 _nextPrice,
    address _owner

) {
    _tokenName = doggies[_tokenId].name;
    _dna = doggies[_tokenId].dna;
    _price = tokenIdToPrice[_tokenId];
    _nextPrice = nextPriceOf(_tokenID);
    _owner = tokenIdToOwner[tokenId];
}

function getAllToken() public view returns (
    uint256[],
    uint256[],
    address[]
) {
    uint256 total = totalSupply();
    uint256[] memory prices = new uint256[](total);
    uint256[] memory nextPrices = new uint256[](total);
    address[] memory owners = new address[](total);

    for (unit256 i = 0; i < total; i++) {
        prices[i] = tokenIdToPrice[i];
        nextPrices[i] = nextPriceOf(i);
        owners[i] = tokenIdToOwner[i];
    }
    return (prices, nextPrices, owners);
}
    
}
    







