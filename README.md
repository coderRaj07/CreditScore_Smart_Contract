# CreditScore Smart Contract 📊

This repository contains a Solidity smart contract `CreditScore` for managing credit scoring based on various user metrics.

## Getting Started 🚀

### Prerequisites 📋

Make sure you have Node.js and npm installed on your machine.

### Installation ⚙️

Clone the repository and install the dependencies:

```bash
git clone https://github.com/coderRaj07/CreditScore_Smart_Contract
cd CreditScore_Smart_Contract
npm install
```

### Testing 🧪

To test the `CreditScore` contract, run the following command:

```bash
npx hardhat test
```

This command runs the test suite using Hardhat, which is a development environment for Ethereum that helps you compile, deploy, test, and debug your smart contracts.

## Contract Details ℹ️

### `CreditScore.sol`

The main contract file `CreditScore.sol` defines the `CreditScore` contract with the following features:

- **Metrics**: Tracks user metrics such as transaction volume, wallet balance, transaction frequency, transaction mix, pursuit of new transactions score, and credit score.
- **Functions**: Provides functions to update user metrics (`updateUserDetails`) and retrieve credit scores (`getCreditScore`).
- **Owner Functions**: Includes modifiers (`onlyAuthorized`, `onlyAfter`) to restrict access to authorized users and control the frequency of updates.

### Usage 🛠️

You can deploy the `CreditScore` contract on a testnet or local blockchain using Hardhat or Remix IDE for development and testing purposes.

## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.