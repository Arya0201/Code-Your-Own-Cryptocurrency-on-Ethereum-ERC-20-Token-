var AryaToken = artifacts.require("./AryaToken.sol");

module.exports = function(deployer) {
  deployer.deploy(AryaToken);
}; 