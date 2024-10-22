// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

contract Governor {
    enum ProposalPosition {
        Abstain, // 0
        Approve, // 1
        Decline // 2
    }

    struct Proposal {
        string description;
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        bool executed;
    }

    uint256 VOTE_THRESHOLD = 2;
    Proposal[] private proposals;
    mapping(uint256 => mapping(address => ProposalPosition))
        public votePositions;
    mapping(uint256 => mapping(address => bool)) public alreadyVoted;
    mapping(address => bool) public isMember;

    event NewProposal(uint256 indexed proposalIndex);
    event CastVote(
        uint256 indexed proposalIndex,
        ProposalPosition indexed proposalPosition,
        uint256 yesCount,
        uint256 noCount
    );

    error NotMember(address caller);

    modifier onlyMember() {
        // modifier == decorador
        if (!isMember[msg.sender]) {
            revert NotMember(msg.sender);
        }

        _; // La funcion decorada
    }

    constructor() {
        isMember[msg.sender] = true;
        isMember[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = true;
        isMember[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = true;

        proposals.push(
            Proposal({
                description: "Desc",
                target: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
                data: bytes(
                    "0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000064"
                ),
                yesCount: 0,
                noCount: 0,
                executed: false
            })
        );
    }

    function getProposals() external view returns (Proposal[] memory) {
        return proposals;
    }

    function getProposalByIndex(uint256 index)
        external
        view
        returns (Proposal memory)
    {
        // Check if index exists
        return proposals[index];
    }

    // memory: Es para cuando se va a modificar el valor de un parametro
    // calldata: Cuando no se va a modificar el valor de un parametro
    function newProposal(
        string calldata _description,
        address _target,
        bytes calldata _data
    ) external onlyMember {
        Proposal memory _newProposal = Proposal({
            description: _description,
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0,
            executed: false
        });

        proposals.push(_newProposal);
        uint256 proposalIndex = proposals.length - 1;

        emit NewProposal(proposalIndex);
    }

    function castVote(
        uint256 _proposalIndex,
        ProposalPosition _proposalPosition
    ) external onlyMember {
        // Check if index exists
        Proposal storage proposal = proposals[_proposalIndex];

        if (alreadyVoted[_proposalIndex][msg.sender]) {
            if (
                votePositions[_proposalIndex][msg.sender] ==
                ProposalPosition.Approve
            ) {
                if (proposal.yesCount > 0) proposal.yesCount--;
            } else {
                if (proposal.noCount > 0) proposal.noCount--;
            }
        }

        votePositions[_proposalIndex][msg.sender] = _proposalPosition;
        if (_proposalPosition == ProposalPosition.Approve) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        if (proposal.yesCount == VOTE_THRESHOLD) {
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Call failed");
        }

        emit CastVote(
            _proposalIndex,
            _proposalPosition,
            proposal.yesCount,
            proposal.noCount
        );
    }
}

