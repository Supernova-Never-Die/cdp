const {
  ethers,
  upgrades,
} = require("hardhat");

async function main() {
  const CDPView = await ethers.getContractFactory("CDPView");
  const cdpView = await upgrades.deployProxy(CDPView, [], {
    initializer: "initialize"
  });
  await cdpView.deployed();
  console.log("cdpView address:", cdpView.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });