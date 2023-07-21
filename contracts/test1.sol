// SPDX-License-Identifier: MIT

pragma solidity^0.8.0;

 contract lotteryDapp{
//     uint public count;

//     function store(uint value) public{
//         count=value;
//     }
//     function increment() public {
//         count++;
//     }
//     function decrement() public view returns(uint){
//         return (count-1);
//     }


   address payable manager;
   // uint public initialAmount=2 ether;
    //uint public Totalamount=10 ether;
    uint  time;
    

    mapping (address=>bool) public participants;
    address payable[] public totalparticipants;

    receive() external payable{}

   constructor(uint _time){
       manager= payable(msg.sender);
       time=_time;
        }
        uint i=0;

    function participate() public payable{
        require(msg.value==2 ether,"initial amount is not enough");
        require(manager!=msg.sender,"you are manager so you cannot participate");
        require(time>=block.timestamp,"time is over to participate");
        require(participants[msg.sender]==false,"you are already participated");
        participants[msg.sender]=true;
        totalparticipants.push(payable(msg.sender));
        i++;
        }

        function getBalance()public view returns(uint){
            return address(this).balance;
        }

        function lotteryWinner()  public payable{
            require(manager==msg.sender,"only manager can call this function");
           uint randomNum= uint (keccak256(abi.encodePacked(block.timestamp,block.prevrandao, msg.sender)));
           uint WinnerIndex=randomNum%totalparticipants.length;
           address payable winner=totalparticipants[WinnerIndex];
           winner.transfer(getBalance());
           totalparticipants=new address payable[](0);
        }
       

       


    

}