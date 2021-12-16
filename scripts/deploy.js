// scripts/deploy.js
async function main() {
    const Contract = await ethers.getContractFactory("ContractV5");
    console.log("Deploying Contract proxy...");
    const contract = await upgrades.deployProxy(Contract, [], { initializer: 'initialize' });
    console.log("Contract deployed to:", contract.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });