# Ethereum Investment Fund

A decentralized investment fund built with **Solidity**, **Ethers.js**, and **GitHub Pages**.

This project demonstrates how investors can deposit ETH into a smart contract while the fund owner distributes profits proportionally to every investor.

The frontend is a lightweight HTML application that connects to MetaMask and interacts directly with the deployed smart contract on the **Sepolia Testnet**.

---

# Features

- Connect MetaMask
- Invest ETH
- View total invested amount
- View fund balance
- View personal investment
- View pending rewards
- Claim rewards
- Owner deposits profits
- Automatic proportional reward distribution
- GitHub Pages ready

---

# Technologies

- Solidity ^0.8.x
- OpenZeppelin
- Ethers.js v6
- HTML
- JavaScript
- MetaMask
- GitHub Pages

---

# Project Structure

```
ethereum-investment-fund/
│
├── contracts/
│   └── Investment.sol
│
├── index.html
│
└── README.md
```

---

# Smart Contract

The investment fund supports the following operations:

## Investor

- Invest ETH
- View investment
- View pending rewards
- Claim rewards

## Owner

- Deposit investment returns
- Automatically distribute profits among investors

Rewards are calculated proportionally according to each investor's share of the total invested amount.

---

# Frontend

The web application allows users to:

- Connect MetaMask
- Invest ETH
- Refresh fund information
- Refresh investor information
- Claim rewards
- Deposit returns (owner only)

No backend server is required.

Everything interacts directly with Ethereum through **ethers.js**.

---

# Deploy Smart Contract

Compile and deploy the contract using your preferred framework:

- Foundry
- Hardhat
- Remix

After deployment, update:

```javascript
const CONTRACT_ADDRESS = "0x7C1F3B1d59F01DfE6F024D739daAca42251ef6F2";
```

inside

```
index.html
```

---

# Run Locally

Clone the repository:

```bash
git clone https://github.com/dappteacher/investment-fund-dapp.git
```

---

You can run this project using this address:

https://dappteacher.github.io/investment-fund-dapp/

---

