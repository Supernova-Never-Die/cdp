async function main() {
    const CDPConcrete = await ethers.getContractFactory("CDPConcrete");
  
    // Replace the constructor arguments with your specific values
    const cdpConcrete = await CDPConcrete.deploy(
      "CDP Token",
      "CDPT",
      "ORACLE_FEEDER_ADDRESS",
      "FEE_TO_ADDRESS",
      "COLLATERAL_TOKEN_ADDRESS",
      "DEBT_TOKEN_ADDRESS",
      5000, // Example maxLTV
      ethers.utils.parseEther("1000"), // Example cap
      100, // Example feeRatio
      200, // Example liquidationPenaltyRatio
      100 // Example liquidationBufferRatio
    );
  
    await cdpConcrete.deployed();
  
    console.log("CDPConcrete deployed to:", cdpConcrete.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  