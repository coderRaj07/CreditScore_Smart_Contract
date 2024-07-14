# Crypto Payment App Credit Score Feature 🌟

## Overview ℹ️

This repository contains a Solidity smart contract `CreditScore` for managing credit scoring based on various user metrics for a crypto payment app. The credit score ranges from 300 to 850 and is derived from:

- **Transaction Volume History (35%)**
- **Wallet Balance (30%)**
- **Frequency of Transactions (15%)**
- **Transaction Mix (10%)**
- **Pursuit of New Transactions (10%)**

## Features 🚀

### On-Chain Calculation 📊

The `CreditScore.sol` contract manages user metrics and calculates credit scores based on the defined weights for each metric. It includes functions for updating user data and retrieving credit scores.

### Data Collection 📈

Integrate with other crypto apps and wallets to collect transaction data for calculating user metrics. This can be achieved through off-chain data feeds or oracles.

### API Integration 🌐

Expose the credit score data via an API to allow other blockchain-based platforms to access and utilize the credit score for decision-making purposes.

## Getting Started 🚀

### Prerequisites 📋

Make sure you have Node.js and npm installed on your machine.

### Installation ⚙️

Clone the repository and install the dependencies:

```bash
git clone https://github.com/coderRaj07/CreditScore_Smart_Contract/
cd CreditScore_Smart_Contract
npm install
```

### Testing 🧪

To test the `CreditScore` contract, run the following command:

```bash
npx hardhat test
```

This command runs the test suite using Hardhat, a development environment for Ethereum that helps you compile, deploy, test, and debug your smart contracts.

## Contract Details ℹ️

### `CreditScore.sol`

The main contract file `CreditScore.sol` defines the `CreditScore` contract with functions to update user metrics (`updateUserDetails`) and retrieve credit scores (`getCreditScore`), along with modifiers to restrict access (`onlyAuthorized`, `onlyAfter`).

## Usage 💡

Deploy the `CreditScore` contract on an Ethereum testnet or mainnet. Implement data collection mechanisms and set up an API endpoint to provide credit score data.

## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.