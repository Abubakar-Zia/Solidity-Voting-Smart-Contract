# Voting Contract

## Overview

This is a simple voting contract written in Solidity that allows users to vote for one of three candidates. The contract includes basic functionality to manage the voting process, including opening and closing the voting window, voting for candidates, and determining the winner.

## Features

- **Vote Management**: Allows users to vote for one of three candidates.
- **Owner Control**: Only the contract owner can open or close the voting window.
- **Vote Tracking**: Ensures that each address can only vote once per voting session.
- **Determine Winner**: Provides functionality to determine which candidate has the most votes.

## Contract Details

### Errors

- `NotOwner()`: Thrown when a non-owner tries to perform an action restricted to the contract owner.
- `AlreadyVoted()`: Thrown when a user tries to vote more than once during the same voting session.

### State Variables

- `candidateId1`: Vote count for Candidate 1.
- `candidateId2`: Vote count for Candidate 2.
- `candidateId3`: Vote count for Candidate 3.
- `owner`: Address of the contract owner.
- `votingWindowOpen`: Boolean indicating whether the voting window is open.
- `voters`: Mapping to track whether an address has voted.

### Functions

- `constructor()`: Initializes the contract, setting the owner to the address that deployed the contract.

- `modifier onlyOwner()`: Restricts access to certain functions to the owner of the contract.

- `modifier requirements()`: Ensures that the voting window is open and that the caller has not voted yet.

- `function votingWindowSet(bool _votingWindowSet) external onlyOwner`: Opens or closes the voting window.

- `function voteForCandidate1() public requirements`: Allows the caller to vote for Candidate 1.

- `function voteForCandidate2() public requirements`: Allows the caller to vote for Candidate 2.

- `function voteForCandidate3() public requirements`: Allows the caller to vote for Candidate 3.

- `function winner() external view returns (string memory)`: Returns the name of the candidate with the most votes or an error message if the voting window is still open.

## Usage

1. Deploy the contract.
2. The owner can open or close the voting window using `votingWindowSet()`.
3. Users can vote for a candidate when the voting window is open.
4. Once voting is closed, anyone can call `winner()` to determine which candidate received the most votes.

## Contributing

Feel free to open an issue or submit a pull request if you have any improvements or bug fixes.

## Contact

For further inquiries or feedback, you can reach out:

- Email: abu.bakar.zia146@proton.me

