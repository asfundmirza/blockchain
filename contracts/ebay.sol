// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract Ebay{
    struct Auction{
        uint id;
        string name;
        uint minPrice;
        uint bestOfferId;
        address payable seller;
        uint[] offerIds;
    }
    struct Offer{
        uint auctionId;
        uint id;
        uint offerPrice;
        address payable buyer;
    }
    mapping(address=>mapping(uint=>Auction)) public auctions;
    mapping(address=>mapping(uint=>Offer)) public offers;

    function createAuction(uint _id,string memory _name,uint _minPrice)  public {
        require(auctions[msg.sender][_id].id!=_id,"this id already exists");
        require(_minPrice>0,"price should be greater than zero");
        uint[] memory offerIds=new uint[](0);
        auctions[msg.sender][_id]=Auction(_id,_name,_minPrice,0,payable(msg.sender),offerIds);
    }
    function createOffer(uint _auctioniId) public {
        Auction storage auction=auctions[seller][_auctioniId].bestOfferId;
        Offer storage offer=offers[msg.sender][auctions[_auctioniId].bestOfferId];
    }
}