const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("CreditScoreModule", (m) => {
  const CreditScore = m.contract("CreditScore");

  return { CreditScore };
});
