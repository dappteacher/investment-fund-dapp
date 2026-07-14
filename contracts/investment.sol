// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract InvestmentFund is ReentrancyGuard{
    
    struct Investor {
        uint256 invested;
        uint256 rewardDebt;
        uint256 claimed;
        bool exists;
    }

    mapping(address => Investor) public investors;

    uint256 public totalInvested;
    uint256 public accRewardPerShare;

    address public immutable owner;

    uint256 private constant PRECISION = 1e18;

    event Invest(address indexed investor, uint256 amount);
    event ReturnsDeposited(uint256 amount);
    event RewardsClaimed(address indexed investor, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Invest ETH into the fund
    function invest() external payable {
        require(msg.value > 0, "Zero investment");

        Investor storage user = investors[msg.sender];

        if (user.exists == false) {
            user.exists = true;
        }

        if (user.invested > 0) {
            uint256 pending = pendingRewards(msg.sender);
            user.rewardDebt += pending;
        }

        user.invested += msg.value;
        totalInvested += msg.value;

        user.rewardDebt = (user.invested * accRewardPerShare) / PRECISION + user.rewardDebt;

        emit Invest(msg.sender, msg.value);
    }

    // Owner deposits profits to distribute proportionally
    function depositReturns() external payable onlyOwner {
        require(msg.value > 0, "No returns");
        require(totalInvested > 0, "No investors");

        accRewardPerShare += (msg.value * PRECISION) / totalInvested;

        emit ReturnsDeposited(msg.value);
    }

    // View pending rewards
    function pendingRewards(address account) public view returns (uint256) {
        Investor storage user = investors[account];

        if (user.exists == false) {
            return 0;
        }

        uint256 accumulated =  (user.invested * accRewardPerShare) / PRECISION;

        if (accumulated <= user.rewardDebt) {
            return 0;
        }

        return accumulated - user.rewardDebt;
    }

    // Claim accumulated returns
    function claimRewards() external payable nonReentrant {
        Investor storage user = investors[msg.sender];

        uint256 pending = pendingRewards(msg.sender);
        require(pending > 0, "Nothing to claim");

        // Effects
        user.rewardDebt += pending;
        user.claimed += pending;

        // Interaction
        (bool success, ) = payable(msg.sender).call{value: pending}("");
        require(success, "ETH transfer failed");

        emit RewardsClaimed(msg.sender, pending);
    }

    // Investor information
    function getInvestor(address account)external view returns (
            uint256 invested,
            uint256 pending,
            uint256 claimed
        )
    {
        Investor storage user = investors[account];

        return (
            user.invested,
            pendingRewards(account),
            user.claimed
        );
    }

    // Contract balance
    function fundBalance() external view returns (uint256) {
        return address(this).balance;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}