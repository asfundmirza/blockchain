// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

contract EventOrganization{

    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }

    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public i ;
    //uint public eventsID=1;
     address public owner;
    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner,"you are the owner");
        _;
    }

    function creatEvent(string  memory _name,uint _date,uint _price,uint _ticketCount,uint _ticketRemain) public onlyOwner{
        require(_date>block.timestamp,"date should be greater than present time");
        require(_ticketCount!=0,"ticket count must be greater than zero");
        require(_ticketRemain==_ticketCount,"ticket count must be equal to remaining");
        events[i]=Event(owner, _name, _date, _price, _ticketCount, _ticketRemain);
        i++;
      //  eventsID++;

    }
    function buyTicket(uint id,uint quantity) payable public{
        require(events[id].date!=0);
        require(msg.value==(events[id].price*quantity));
        require(events[id].date>block.timestamp);
        require(events[id].ticketRemain>=quantity);
        events[id].ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;
        payable(owner).transfer(msg.value);

    }

    function transfer(uint eventID,uint quantity,address receiver) public payable{
        
        require(events[eventID].date>block.timestamp);
        require(events[eventID].date!=0);
        require(tickets[msg.sender][eventID]>=quantity);
        tickets[msg.sender][eventID]-=quantity;
        tickets[receiver][eventID]+=quantity;

    }
   function getEvents(uint _eventsID) public view returns(Event memory){
      return events[_eventsID];
    }
}

