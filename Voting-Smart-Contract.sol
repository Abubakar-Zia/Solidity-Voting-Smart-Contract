// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

error NotOwner();
error AlreadyVoted();

contract Voting {
    uint256 public candidateId1;
    uint256 public candidateId2;
    uint256 public candidateId3;
    address public immutable owner;
    bool public votingWindowOpen = false;

    mapping(address => bool) public voters;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    modifier requirements() {
        require(votingWindowOpen, "Voting is closed");
        if (voters[msg.sender]){ 
            revert AlreadyVoted(); 
        }
        voters[msg.sender] = true;
        _;
    }

    function votingWindowSet(bool _votingWindowSet) external  onlyOwner {
        votingWindowOpen = _votingWindowSet;
    }

    function voteForCandidate1() public requirements {
        candidateId1++;
    }

    function voteForCandidate2() public requirements {
        candidateId2++;
    }

    function voteForCandidate3() public requirements {
        candidateId3++;
    }

    function winner() external  view returns (string memory) {
    require(!votingWindowOpen, "Voting is Ongoing");

    if (candidateId1 > candidateId2 && candidateId1 > candidateId3) {
        return "CandidateOne is The Winner";
    } else if (candidateId2 > candidateId1 && candidateId2 > candidateId3) {
        return "CandidateTwo is The Winner";
    } else if (candidateId3 > candidateId1 && candidateId3 > candidateId2) {
        return "CandidateThree is The Winner";
    } else {
        return "Error";
    }
}

}
