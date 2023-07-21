// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

contract lottery{

    address public manager;
    address payable[] public participants;

    constructor(){
        manager=msg.sender; // manager will be the address through which we deploy
    }

    receive() external payable { // participant can transfer amount to the contract
        require(msg.value==1 ether);
        participants.push(payable(msg.sender)); //register the address in array
    }

    function getBalance() public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;   // to get contract balance
    }

    function random() public  view returns (uint){  //for getting random number e.g winner
        return uint(keccak256 (abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint r=random()%participants.length;
        address payable winner;
        winner=participants[r]; // remaindered index will be the winner
        winner.transfer(getBalance()); // transfer balance to winner from contract
        participants=new address payable[](0); // reset array
    }

}