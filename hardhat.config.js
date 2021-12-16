// hardhat.config.js
require('dotenv').config()

require("@nomiclabs/hardhat-ethers");
require('@openzeppelin/hardhat-upgrades');
require('@openzeppelin/hardhat-defender')

const alchemyApiKey = process.env.ALCHEMY_API;
const privateKey = process.env.PRIVATE_KEY;
const defenderApi = process.env.DEFENDER_API;
const defenderSecret = process.env.DEFENDER_SECRET;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.10",
  defender: {
    apiKey : `${defenderApi}`,
    apiSecret : `${defenderSecret}`,
  },
  networks: {
    polygon: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${alchemyApiKey}`,
      accounts: [`${privateKey}`],
      gas: "auto", //2100000,
	    gasPrice: "auto" //110 * 1000000000, //110 Gwei 
    }
  }
};