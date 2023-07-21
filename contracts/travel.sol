// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract travelAgency{

    address payable owner;
    struct permanentVisa{
        uint ID;
        string name;
        uint cost;
        uint timePeriod;
        
    }
    struct travelVisa{
        uint ID;
        string name;
        uint cost;
        uint timePeriod;
    }
    struct client{
        string name;
        uint age;
        address account;
    }
    mapping(uint=>permanentVisa) public permanentVisas;
    mapping(uint=>travelVisa) public travelVisas;
    mapping(address=>permanentVisa) public permanentClients;
    mapping(address=>travelVisa) public travelClients;
    
    constructor(){
        owner=payable (msg.sender);
    }
    function addPermanentVisa(uint _ID,string memory _name,uint _cost,uint _timePeriod) public{
        require(msg.sender==owner,"you are not the owner");
        require(_ID!=permanentVisas[_ID].ID,"this visa is already added");
        permanentVisas[_ID]=permanentVisa({
            ID:_ID,
            name:_name,
            cost:_cost,
            timePeriod:_timePeriod
        });
    }
    function addTravelVisa(uint _ID,string memory _name,uint _cost,uint _timePeriod) public{
        require(msg.sender==owner,"you are not the owner");
        require(_ID!=travelVisas[_ID].ID,"this visa is already added");
        travelVisas[_ID]=travelVisa({
            ID:_ID,
            name:_name,
            cost:_cost,
            timePeriod:_timePeriod
        });
    }
    function applyForPermanentVisa(uint _ID) public payable{
        require(msg.value>=permanentVisas[_ID].cost,"amount is not enough to buy this visa");
        require(permanentClients[msg.sender].ID!=permanentVisas[_ID].ID,"you have already applied for visa");
        owner.transfer(msg.value);          
        permanentClients[msg.sender]=permanentVisas[_ID];

    }
    function applyForTravelVisa(uint _ID) public payable{
        require(msg.value>=travelVisas[_ID].cost,"amount is not enough to buy this visa");
        require(travelClients[msg.sender].ID!=travelVisas[_ID].ID,"you have already applied for visa");
        owner.transfer(msg.value);          
        travelClients[msg.sender]=travelVisas[_ID];

    }
    function getPermanentClients(address clientAddress) public view returns(uint,string memory,uint,uint){
        return(permanentClients[clientAddress].ID,permanentClients[clientAddress].name,permanentClients[clientAddress].cost,
                permanentClients[clientAddress].timePeriod);
    }
    function getTravelClients(address clientAddress) public view returns(uint,string memory,uint,uint){
        return(travelClients[clientAddress].ID,travelClients[clientAddress].name,travelClients[clientAddress].cost,
                travelClients[clientAddress].timePeriod);
    }
    
}