// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Custom error for unauthorized access
error NotOwner();
// Custom error for already voted status
error AlreadyVoted();

contract Voting {
    // State variables to keep track of votes for each candidate
    uint256 public candidateId1;
    uint256 public candidateId2;
    uint256 public candidateId3;

    // Address of the contract owner (deployer)
    address public immutable owner;
    
    // Boolean to check if the voting window is open
    bool public votingWindowOpen = false;

    // Mapping to track whether an address has already voted
    mapping(address => bool) public voters;

    // Constructor to set the owner as the address that deploys the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    // Modifier to check voting window status and whether the sender has already voted
    modifier requirements() {
        require(votingWindowOpen, "Voting is closed"); // Ensure voting window is open
        if (voters[msg.sender]){ 
            revert AlreadyVoted(); // Ensure sender hasn't already voted
        }
        voters[msg.sender] = true; // Mark sender as voted
        _;
    }

    // Function to set the voting window open/close status, only callable by the owner
    function votingWindowSet(bool _votingWindowSet) external onlyOwner {
        votingWindowOpen = _votingWindowSet;
    }

    // Function for casting a vote for candidate 1
    function voteForCandidate1() public requirements {
        candidateId1++;
    }

    // Function for casting a vote for candidate 2
    function voteForCandidate2() public requirements {
        candidateId2++;
    }

    // Function for casting a vote for candidate 3
    function voteForCandidate3() public requirements {
        candidateId3++;
    }

    // Function to determine the winner based on vote counts
    function winner() external view returns (string memory) {
        require(!votingWindowOpen, "Voting is Ongoing"); // Ensure voting window is closed

        // Compare votes and return the winner
        if (candidateId1 > candidateId2 && candidateId1 > candidateId3) {
            return "CandidateOne is The Winner";
        } else if (candidateId2 > candidateId1 && candidateId2 > candidateId3) {
            return "CandidateTwo is The Winner";
        } else if (candidateId3 > candidateId1 && candidateId3 > candidateId2) {
            return "CandidateThree is The Winner";
        } else {
            return "Error"; // In case of a tie or an error in vote counts
        }
    }
}
