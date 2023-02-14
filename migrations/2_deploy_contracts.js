var AryaToken = artifacts.require("./AryaToken.sol");
var AryaTokenSale = artifacts.require("./AryaTokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(AryaToken,1000000).then(function(){
    //token price is 0.001 ether
    var tokenPrice = 1000000000000000; 
    return deployer.deploy(AryaTokenSale,AryaToken.address,tokenPrice);
  });
  
};