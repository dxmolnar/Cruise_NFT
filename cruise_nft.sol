// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CruiseNFT is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Price for each NFT
    uint256 public nftPrice = 1 ether; // Just as an example. Adjust as necessary.
    uint256 public constant maxSupply = 150;

    constructor() ERC721("CruiseNFT", "CNFT") {}

    function mintNFT(address recipient) public payable {
        require(msg.value == nftPrice, "Incorrect Ether sent");
        require(_tokenIdCounter.current() < maxSupply, "All NFTs have been minted");

        _tokenIdCounter.increment();
        _safeMint(recipient, _tokenIdCounter.current());
    }

    // If the owner wants to withdraw the accumulated Ether
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    // Update the NFT price
    function setNFTPrice(uint256 newPrice) public onlyOwner {
        nftPrice = newPrice;
    }
}
