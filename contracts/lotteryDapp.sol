// SPDX-License-Identifier: MIT

pragma solidity>=0.5.0<0.9.0;

contract Lottery{

    address payable[] public players;
    address manager;
    address payable winner;
    uint public x;

    constructor(){
        manager=msg.sender;
    }    

    receive() external payable{
        require(msg.value==1 ether,"Ether is not enough");
        players.push(payable(msg.sender));
         x++;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function random() internal view returns(uint){
        return uint(keccak256 (abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function lotteryWinner() public{
        require(manager==msg.sender);
        require(players.length>=3,"players are not enough");
        uint r=random();
        uint winIndex=r%players.length;
        winner=players[winIndex];
        winner.transfer(getBalance());
        players=new address payable[](0);
    }
        function allPlayers() public view returns(address payable[] memory ){
             return players;
             
        }
}