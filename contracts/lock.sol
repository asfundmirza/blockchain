// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract Lock{

    address private fundsOwner;
    mapping(address=>uint) public lockFunds;
    mapping(address=>uint) public lockPeriod;
    mapping(address=>uint) public lockTimestamp;
    mapping(address=>bool) public fundsLocked;
    mapping(uint=>uint) public rewards;
   // uint[] public rewards;
    address[] public allAddress;
    //uint private lockDuration1=1 day;
    address public owner;
    constructor(){
        owner=payable(msg.sender);
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"you are not the owner");
    _;
    }
    function lockFund(uint _value,uint _period) public  payable{
        require(msg.value>=_value,"funds are not enough");
        fundsOwner=msg.sender;
        lockFunds[msg.sender]=_value;
        lockPeriod[msg.sender]=_period;
        lockTimestamp[msg.sender]=block.timestamp;
        fundsLocked[msg.sender]=true;
        payable (owner).transfer(_value);
        allAddress.push(msg.sender);
       // rewards.push(lockPeriod[msg.sender]);
    }
    function releaseFunds(uint _value) public{
        require(block.timestamp>=lockPeriod[msg.sender]+lockTimestamp[msg.sender]);
        require(fundsLocked[msg.sender]==true,"you dont have any locked funds");
        require(_value==lockFunds[msg.sender],"funds amount is greater than your locked funds");
        for(uint i=0;i<allAddress.length;i++){
            if(lockPeriod[msg.sender]==i+1){
                payable(msg.sender).transfer(_value+rewards[i+1]);
            }
        }
     }
     function addRewards(uint rewardNumber,uint _value) public onlyOwner{
         require(rewards[rewardNumber]==0,"this rewards is already listed");
            rewards[rewardNumber]=_value;

     }
     function updateRewards(uint rewardNumber,uint _value) public onlyOwner{
         rewards[rewardNumber]=_value;
     }
     
   
    
}