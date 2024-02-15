require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

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
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      forking: {
        enabled: true,
        url: "https://blast-sepolia-testnet.rpc.thirdweb.com",
      },
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
    blasttestnet: {
      chainId: 168587773,
      url: "https://blast-sepolia-testnet.rpc.thirdweb.com",
      accounts: [process.env.PK],
    }
  },
};