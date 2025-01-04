var ZombieOwnership = artifacts.require("./HelloWorld.sol");

module.exports =  (deployer => {
  deployer.then(async () => {
      await deployer.deploy(ZombieOwnership);
  });
});