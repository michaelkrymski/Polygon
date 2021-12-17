// scripts/prepare_upgrade.js
async function main() {
    const proxyAddress = '0x5e8b5080C038749563285E14C0BF1253fb8D32B5';
   
    const ContractV2 = await ethers.getContractFactory("ContractV7");
    console.log("Preparing upgrade...");
    const contractV2Address = await upgrades.prepareUpgrade(proxyAddress, ContractV2);
    console.log("BoxV2 at:", contractV2Address);
  }
   
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });