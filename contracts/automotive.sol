// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract automotive{

    struct car{
        string model;
        string make;
        uint price;
        bool forSale;
        
    }
    address payable owner;
    
    
    mapping(address=>mapping(uint=>car)) private buyers;
    mapping(uint=>car) public cars;
    uint private carID=1;
    uint private buyersID=1;

    constructor(){
        owner= payable(msg.sender);
    }

    function addCar(string memory _model,string memory _make,uint _price) public{
        require(msg.sender==owner,"you are not the owner");
        cars[carID]=car(_model,_make,_price,true);
        carID++;
    }
    function buyCar(uint _carID) public payable {
        require(msg.sender!=owner,"you cannot buy because you are owner");
        require(msg.value>=cars[_carID].price,"amount is not enough");
        require(cars[_carID].forSale==true,"already sold out");
        owner.transfer(msg.value);
        cars[_carID].forSale=false;
        buyers[msg.sender][buyersID]=cars[_carID];
        buyersID++;
        
    }

    function buyersInfo(address _buyerAddress,uint _ID) public view returns(car memory ){
        return buyers[_buyerAddress][_ID];
    }

    function updatePrice(uint _carID,uint _price) public {
        require(msg.sender==owner,"you are not the owner");
        cars[_carID].price=_price;
    } 
    
    function getCars() external view returns(car[] memory){
    car[] memory _car = new car[](carID-1);

    for(uint i=1;i<carID;i++){
        _car[i-1]=cars[i];
    }
    return _car;
}
    function getCarPrice(uint _carID) public view returns(uint){
        return cars[_carID].price;
    }

}