pragma solidity ^0.4.19;

/**
 * Created by Ha Truong
 * Created at August 13rd, 2018
 * The Election contract does this and that...
 */
contract Election {

	// Model a candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;		
	}
	// Store accounts that have voted
	mapping(address => bool) public voters;

	// Store a candidate
	event votedEvent (
        uint indexed _candidateId
    );

	// Fetch candidate
	mapping (uint => Candidate) public candidates;
	
	// Store candidate count
	uint public candidatesCount;

	function Election () public{
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}	

	function addCandidate (string _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}
	
	function vote (uint _candidateId) public {
	    // require that they haven't voted before
	    require(!voters[msg.sender]);

	    // require a valid candidate
	    require(_candidateId > 0 && _candidateId <= candidatesCount);

	    // record that voter has voted
	    voters[msg.sender] = true;

	    // update candidate vote Count
	    candidates[_candidateId].voteCount ++;

	    // trigger voted event
	    votedEvent(_candidateId);
	}
	
}

