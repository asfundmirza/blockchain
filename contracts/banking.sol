// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

contract bank{

    struct account{
        uint id;
        uint balance;
        address owner;
    }
    address payable manager;
    mapping(address=>account) public accounts;
    
    uint private time;
    constructor (){
        manager=payable(msg.sender);

    }
    function addAccount(uint _id,uint _balance,address _owner) public{
        require(msg.sender==manager,"you are not the manager");
        accounts[_owner]=account({
            id:_id,
            balance:_balance,
            owner:_owner
        });
       
    }

    function deposit(uint _amount,address _account) public payable{
        require(msg.sender==manager,"you are not the manager");
        require(_amount>0,"cannot deposit zero amount");
         accounts[_account].balance+=_amount;
    }
    function withdraw(uint _amount) public payable{
        require(msg.sender==accounts[msg.sender].owner,"you are not the owner of this account");
        require(_amount>0,"amount should be greater than zero");
        require(_amount<=accounts[msg.sender].balance,"balance is not enough");
        accounts[msg.sender].balance-=_amount;
    }
    function transfer(address _account,uint _amount) public payable{
        require(_amount>0,"amount should be greater than zero");
        require(msg.sender==accounts[msg.sender].owner,"you are not the owner of this account");
        require(_amount<=accounts[msg.sender].balance,"you dont have enough balance");
        accounts[_account].balance+=_amount;
        accounts[msg.sender].balance-=_amount;

    }
    function giveLoan(address _account,uint _amount,uint _time) public payable{
        require(msg.sender==accounts[msg.sender].owner,"you are not the owner of this account");
        require(_amount<=accounts[msg.sender].balance,"balance is not enough");
        require(_amount>0,"amount should be greater than zero");
        require(_time>block.timestamp,"time should be greater than timestamp");
        accounts[_account].balance+=_amount;
        accounts[msg.sender].balance-=_amount;
        if(_time<=block.timestamp){
            accounts[_account].balance-=_amount;
            accounts[msg.sender].balance+=_amount;
        }
    }
    function getAccountInfo() public view returns(account memory){
        return accounts[msg.sender];
    }
    function grantAccess(address _account) public{
        require(accounts[msg.sender].balance!=0,"balance is not enough");
        require(msg.sender==accounts[msg.sender].owner,"you are not the owner of this account");
        accounts[msg.sender].owner=_account;
    }
    //same will be for the revokeAccess just change last line to !=
    //to destroy the account use selfdestruct



}