// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract stockTrading{

    struct stock{
        uint id;
        string name;
        uint price;
        uint stockQuantity;
    }
    stock[] public stocks;
    mapping(address=>stock) public userStocks;
    mapping (address=>uint) public userStockQuantity;
    address public owner;
    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner,"you are the owner");
        _;
    }
    function addStock(uint _id,string memory _name,uint _price,uint _stockQuantity) public  onlyOwner {
       require(stocks[_id].id!=_id,"this stock is already listed");
       stocks[_id]=stock({
           id:_id,
           name:_name,
           price:_price,
           stockQuantity:_stockQuantity
       });
    }
    function buyStock(uint stockID,uint _stockQuantity) public payable{
        require(msg.value>0,"value should be greater than zero");
        require(msg.value>=stocks[stockID].price*_stockQuantity,"amount is not enough to buy this stock");
        require(stocks[stockID].stockQuantity>=_stockQuantity,"this stock is not enough on exchange");
        userStocks[msg.sender]=stocks[stockID];
        userStockQuantity[msg.sender]=stocks[stockID].stockQuantity;
        payable(owner).transfer(msg.value);
    }
    function transferStock(uint stockID,uint _stockQuantity,address receiver) public{
        require(userStocks[msg.sender].id==stocks[stockID].id,"you dont have this stock");
        require(userStockQuantity[msg.sender]>=_stockQuantity,"you dont have enough quantity to transfer");
        userStockQuantity[msg.sender]-=_stockQuantity;
        userStocks[receiver]=stocks[stockID];
        userStockQuantity[receiver]+=_stockQuantity;
    }
    function withDraw(uint stockID,uint _stockQuantity) public payable{
        require(userStocks[msg.sender].id==stocks[stockID].id,"you dont have this stock");
        require(userStockQuantity[msg.sender]>=_stockQuantity,"you dont have enough quantity to sell");
        userStockQuantity[msg.sender]-=_stockQuantity;
        userStockQuantity[owner]+=_stockQuantity;
        payable(msg.sender).transfer(stocks[stockID].price*_stockQuantity);
        
    }

}