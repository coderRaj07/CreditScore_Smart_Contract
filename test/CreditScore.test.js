const { time, loadFixture } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");

describe("CreditScore", function () {
  async function deployCreditScoreFixture() {
    const [owner, user] = await ethers.getSigners();

    const CreditScore = await ethers.getContractFactory("CreditScore");
    const creditScore = await CreditScore.deploy();

    return { creditScore, owner, user };
  }

  describe("updateUserDetails", function () {
    it("Should update user details and calculate credit score correctly", async function () {
      const { creditScore, owner, user } = await loadFixture(deployCreditScoreFixture);

      await creditScore.connect(owner).updateUserDetails(
        user.address,
        10000,   // volume
        5000,    // balance
        10,      // frequency
        5,       // mix
        8        // newTxs
      );

      const userCreditScore = await creditScore.getCreditScore(user.address);
      expect(userCreditScore).to.equal(307); // Adjust based on your test case
    });

    it("Should revert if not called by the owner", async function () {
      const { creditScore, user } = await loadFixture(deployCreditScoreFixture);

      await expect(
        creditScore.connect(user).updateUserDetails(
          user.address,
          10000,   // volume
          5000,    // balance
          10,      // frequency
          5,       // mix
          8        // newTxs
        )
      ).to.be.revertedWith("Not authorized");
    });

    it("Should revert if update is attempted before 21 days", async function () {
      const { creditScore, owner, user } = await loadFixture(deployCreditScoreFixture);

      await creditScore.connect(owner).updateUserDetails(
        user.address,
        10000,   // volume
        5000,    // balance
        10,      // frequency
        5,       // mix
        8        // newTxs
      );

      await expect(
        creditScore.connect(owner).updateUserDetails(
          user.address,
          20000,   // volume
          6000,    // balance
          12,      // frequency
          6,       // mix
          10       // newTxs
        )
      ).to.be.revertedWith("Can only update after 21 days");
    });
  });
});
