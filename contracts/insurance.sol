// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract CarInsurance{

    struct policy{
        uint ID;
        string name;
        string refundAmount;
        uint purchaseAmount;
    }
    policy[] public policies;
    mapping(address=>policy) public policyHolders;
    //mapping(address=>policy[]) public claims;
    address payable owner;

    constructor(){
        owner=payable(msg.sender);
    }

    function addPolicy( uint _ID,string memory _name,string memory _refundAmount,uint _purchaseAmount) public {
        require(msg.sender==owner,"you are not the owner");
        require(_purchaseAmount>0,"amount should be greater than zero");
        // policies[ID]=policy({
        //     name:_name,
        //     refundAmount:_refundAmount,
        //     purchaseAmount:_purchaseAmount
        // });
        // to add values in struct type arrays we make an instance of the struct then push it in array
        policy memory myPolicy=policy(_ID,_name,_refundAmount,_purchaseAmount);
        policies.push(myPolicy);
    }
    function purchasePolicy(uint256 ID) public payable{
        require(msg.value>=policies[ID].purchaseAmount,"amount should be equal to purchase amount");
        require(msg.sender!=owner,"owner cannot purchase policy");
        require(msg.sender.balance >= msg.value, "insufficient balance to complete transaction");
        owner.transfer(msg.value);
        //payable (msg.sender).transfer(msg.value);
        policyHolders[msg.sender]=policies[ID];
    }
    function refundAmount(address _policyHolder,uint ID) public payable{
    require(msg.sender==owner,"you are not the owner");
    require(policyHolders[_policyHolder].ID==ID,"you dont have any policy");
    uint refund=policyHolders[_policyHolder].purchaseAmount;
    uint refundedAmount=refund/2;
    require(refundedAmount>0,"amount should be greater than zero");
    require(refundedAmount<=owner.balance, "insufficient balance in owner's account");
    payable(_policyHolder).transfer(refundedAmount);
    }
    

}