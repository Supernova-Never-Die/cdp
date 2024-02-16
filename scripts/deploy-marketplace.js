const {
    ethers,
    upgrades,
} = require("hardhat");

async function main() {
    const CDPMarketPlace = await ethers.getContractFactory("CDPMarketPlace");
    const cdpMarketPlace = await upgrades.deployProxy(CDPMarketPlace, [], {
        initializer: "initialize"
    });
    await cdpMarketPlace.deployed();
    console.log("cdpMarketPlace address:", cdpMarketPlace.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });