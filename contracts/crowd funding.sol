// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

contract crowdFunding{
    mapping(address=>uint) public contributors;
    address manager;
    uint minContribution;
    uint raisedAmount;
    uint noOfContributors;
    uint target;
    uint deadline;

    constructor(uint _target,uint _deadline){
        manager=msg.sender;
        target=_target;
        deadline=block.timestamp+_deadline;
    }
        struct Request{
            string description;
            address  payable recepient;
            uint value;
            uint noOFVoters;
            bool completed;
            mapping(address=>bool)  voters;
        }

    mapping(uint=>Request) requests;
    uint public noOfRequests;
    

    function contribution() public payable{
        require(block.timestamp<deadline);
        if(contributors[msg.sender]==0){
            noOfContributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public payable{
        require(deadline>block.timestamp);
        require(raisedAmount<target);
        require(contributors[msg.sender]>0);
        address payable user=payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;

    }

    function creatRequest(string memory _description,address payable _recepient,uint _value) public{
        require(manager==msg.sender);
        Request storage newRequest=requests[noOfRequests];
        newRequest.description=_description;
        newRequest.recepient=_recepient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.noOFVoters=0;
         noOfRequests++;
    }

    function voting(uint _reqNo) public{
       require(manager==msg.sender);
       require(contributors[msg.sender]>0);
       Request storage thisRequest=requests[_reqNo];
       require(thisRequest.voters[msg.sender]==false);
       thisRequest.voters[msg.sender]==true;
       thisRequest.noOFVoters++;

    }

    function payment(uint _reqNo) public payable{
        require(manager==msg.sender);
        require(raisedAmount>=target);
        Request storage thisReq=requests[_reqNo];
        require(thisReq.noOFVoters>=noOfContributors/2);
        require(thisReq.completed==false);
        thisReq.recepient.transfer(thisReq.value);
        thisReq.completed==true;
    }

}