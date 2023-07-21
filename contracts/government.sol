// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract Government{
    struct official{
        string name;
        string designation;
        uint ID;
        uint vote;
        address account;
    }
    mapping(address=>official) public officials;
    struct citizen{
        string name;
        uint ID;
        bool voteCasted;
    }
    mapping(uint=>citizen)  public citizens;
    address payable owner;

    constructor (){
        owner=payable(msg.sender);
    }

    function addOfficial(address _account,string memory _name,string memory _designation,uint _ID,uint _vote) public{
        require(msg.sender==owner,"only owner can add official member");
        officials[_account]=official({
            name:_name,
            designation:_designation,
            ID:_ID,
            vote:_vote,
            account:_account
        });
    }
    function addCitizen(string memory _name,uint _ID,uint index) public{
        require(msg.sender!=officials[msg.sender].account,"Address associated with official");
        citizens[index]=citizen({
            name:_name,
            ID:_ID,
            voteCasted:false
        });
    }
    function addVote(uint citizenID,address officialAddress) public {
        //require(officialAddress!=officials[].account,"officials cannot cast vote");
        require(citizens[citizenID].voteCasted==false,"you have voted already");
        require(msg.sender==owner,"you are not the owner");
        citizens[citizenID].voteCasted=true;
        officials[officialAddress].vote+=1;
    }

}