// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    uint public candidate1Votes;
    uint public candidate2Votes;

    event VoteRecorded(address voter, uint candidateNumber);

    function vote(uint candidateNumber) public {
        require(candidateNumber == 1 || candidateNumber == 2, "Invalid candidate number");

        if (candidateNumber == 1) {
            candidate1Votes++;
        } else {
            candidate2Votes++;
        }

        emit VoteRecorded(msg.sender, candidateNumber);
    }
}
