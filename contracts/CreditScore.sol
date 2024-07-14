// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CreditScore
 * @dev A contract to manage credit scoring based on various user metrics.
 */
contract CreditScore {
    // Define a precision factor (10^18 for 18 decimal places)
    uint256 public constant PRECISION_FACTOR = 1e18;

    struct User {
        uint lastUpdateTimestamp;           // Timestamp of the last update
        uint transactionVolume;             // Total transaction volume
        uint walletBalance;                 // Current wallet balance
        uint transactionFrequency;          // Frequency of transactions
        uint transactionMix;                // Mix of transaction types
        uint pursuitOfNewTransactions;      // Pursuit of new transactions score
        uint creditScore;                   // Final credit score
    }

    mapping(address => User) private users;  // Mapping of users to their metrics
    address public immutable owner;          // Owner of the contract

    // Define weightings for credit score calculation
    uint constant TRANSACTION_VOLUME_WEIGHT = 35;
    uint constant WALLET_BALANCE_WEIGHT = 30;
    uint constant TRANSACTION_FREQUENCY_WEIGHT = 15;
    uint constant TRANSACTION_MIX_WEIGHT = 10;
    uint constant PURSUIT_OF_NEW_TRANSACTIONS_WEIGHT = 10;

    // Modifier to restrict function access to the contract owner
    modifier onlyAuthorized() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Modifier to restrict updating user details to every 21 days
    modifier onlyAfter(uint lastUpdated) {
        require(block.timestamp >= lastUpdated + 21 days, "Can only update after 21 days");
        _;
    }

    /**
     * @dev Constructor sets the contract deployer as the owner.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Updates user metrics based on specified parameters.
     * @param user The address of the user whose metrics are being updated.
     * @param volume Total transaction volume of the user.
     * @param balance Current wallet balance of the user.
     * @param frequency Frequency of transactions of the user.
     * @param mix Mix of transaction types of the user.
     * @param newTxs Pursuit of new transactions score of the user.
     */
    function updateUserDetails(address user, uint volume, uint balance, uint frequency, uint mix, uint newTxs) external onlyAuthorized onlyAfter(users[user].lastUpdateTimestamp) {
        require(user != address(0), "Invalid address");

        User storage u = users[user];
        // Adjustments to maintain precision
        u.transactionVolume = (volume * 1e15 / PRECISION_FACTOR) * 1e3 / 1e3; // Scale down and then scale back to avoid overflow
        u.walletBalance = (balance * 1e15 / PRECISION_FACTOR) * 1e3 / 1e3; // Scale down and then scale back to avoid overflow
        u.transactionFrequency = frequency;
        u.transactionMix = mix;
        u.pursuitOfNewTransactions = newTxs;
        u.lastUpdateTimestamp = block.timestamp;
        updateCreditScore(user);
    }

    /**
     * @dev Retrieves the credit score of a specific user.
     * @param user The address of the user.
     * @return The current credit score of the user.
     */
    function getCreditScore(address user) external view returns (uint) {
        return users[user].creditScore;
    }

    /**
     * @dev Updates the credit score of a specific user based on their metrics.
     * @param user The address of the user whose credit score is being updated.
     */
    function updateCreditScore(address user) internal {
        require(user != address(0), "Invalid address");
        User storage u = users[user];

        uint totalScore = u.transactionVolume * TRANSACTION_VOLUME_WEIGHT +
                          u.walletBalance * WALLET_BALANCE_WEIGHT +
                          u.transactionFrequency * TRANSACTION_FREQUENCY_WEIGHT +
                          u.transactionMix * TRANSACTION_MIX_WEIGHT +
                          u.pursuitOfNewTransactions * PURSUIT_OF_NEW_TRANSACTIONS_WEIGHT;

        uint normalizedTotalScore = 300 + (totalScore / 100); // Normalize to a range of 300-850

        if (normalizedTotalScore > 850) {
            normalizedTotalScore = 850;
        }

        u.creditScore = normalizedTotalScore;
    }
}

