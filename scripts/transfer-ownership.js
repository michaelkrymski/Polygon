// scripts/transfer_ownership.js
async function main() {
    const gnosisSafe = '0xC3dd25201AF90ECDbf9FCCAbc95bFF950e72985D';
   
    console.log("Transferring ownership of ProxyAdmin...");
  // The owner of the ProxyAdmin can upgrade our contracts
  await upgrades.admin.transferProxyAdminOwnership(gnosisSafe);
  console.log("Transferred ownership of ProxyAdmin to:", gnosisSafe);
}
 
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });