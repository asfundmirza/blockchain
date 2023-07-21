// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

contract dApp{
    struct Access{
        address user;
        bool access;
    }
    mapping(address=>string[]) value;
    mapping(address=>mapping(address=>bool)) ownerShip;
    mapping(address=>mapping(address=>bool)) previousdata;
    mapping(address=>Access[]) accessList;


    function add(address _user,string memory url) public{

        value[_user].push(url);
        
    }
    function allow(address user) public{
        ownerShip[msg.sender][user]=true;
        if(previousdata[msg.sender][user]){
            for(uint i=0 ;i<accessList[msg.sender].length;i++){
            if(accessList[msg.sender][i].user==user){
                accessList[msg.sender][i].access=true;
            }
        }
        }
        else{
        accessList[msg.sender].push(Access(user,true));
        previousdata[msg.sender][user]=true;
        }



    }
    function disallow(address user) public{
        ownerShip[msg.sender][user]=false;
        for(uint i=0 ;i<accessList[msg.sender].length;i++){
            if(accessList[msg.sender][i].user==user){
                accessList[msg.sender][i].access=false;
            }
        }
    }
    function display(address _user) public view returns(string[] memory){
        require(_user==msg.sender || ownerShip[_user][msg.sender],"you are not allowed");
        return value[_user];

    }
    function share() public view returns(Access[] memory){
        return accessList[msg.sender];
    }

}