require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    sources: './contracts',
  },
  defaultNetwork: 'localhost',
  networks: {
    hardhat: {
      // forking: {
      //   enabled: true,
      //   url: "https://api.calibration.node.glif.io/rpc/v1",
      // },
    },
    localhost: {
      url: 'http://127.0.0.1:8545',
    },
    calibrationnet: {
      chainId: 314159,
      url: "https://api.calibration.node.glif.io/rpc/v1",
    },
    filecoinmainnet: {
      chainId: 314,
      url: "https://api.node.glif.io",
    },
  },
};
