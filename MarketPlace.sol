// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    address contractAddress;

    constructor(address MktPlaceAddress) ERC721("Fatma's MarketPlace","FMP"){
        contractAddress = MktPlaceAddress;

    }

    function createToken(string memory tokenURI) public returns(uint){
      uint256 newItemId = _tokenId.current();
        _tokenId.increment();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}

contract NFTMarket is ReentrancyGuard{
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;

    struct MarketItem{
        uint itemId,
        address nftContract,
        uint256 tokenId,
        address payable seller;
        address payable owner;
        uint256 price;
            }

    mapping(uint256=>MarketItem) private idToMarketItem;

    event marketItemCreated(
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller;
        address owner;
        uint256 price;
    )

    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price)
        public payable nonReentrant {
            require(price>0,"No free market items,price must be atleast 1 wei");
            _itemIds.increment();
            uint256 currentItemId = _itemIds.current();

    }
    idToMarketItem[itemId] = MarketItem(
                itemId,
                nftContract,
                tokenId,
                payable(msg.sender);
                payable(address(0));
                price;
            );

    IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

    emit marketItemCreated(
        itemId,
        nftContract,
        tokenId,
        msg.sender;
        address(0);
        price;
    ) ;

    function createMarketSale(address nftConract, uint256 itemId) public payable nonReentrant{
        uint price = idToMarketItem[itemId].price;
        uint tokenId = idToMarketItem[itemId].tokenId;

        require(msg.value==price,"Please enter the required price o complete the purchase")
    }
}
