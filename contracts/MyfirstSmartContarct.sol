// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract myFirtsSmartcontarct{

    mapping (string => uint256) public VotesReceived;

    string[] public candidateList;

    constructor (string[] memory candidateNames){
        candidateList = candidateNames;
    }

    function totalVotesfor(string memory candidate) view public returns (uint256){

        require(validCandidate(candidate));

        return VotesReceived[candidate];

    }

    function voteForCandidate(string memory candidate) public {
        require(validCandidate(candidate));

        VotesReceived[candidate] += 1;
    }

    function validCandidate (string memory candidate) view public returns (bool){
    
        for (uint i =0 ; i < candidateList.length; i++) {
            if (keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))){
                return true;
            }
        }
        return false;
    }

}