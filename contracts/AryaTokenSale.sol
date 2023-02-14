// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./AryaToken.sol";

contract AryaTokenSale {
 address admin;
    AryaToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor (AryaToken _tokenContract,uint256 _tokenPrice){

        //Asign an admin
        admin = msg.sender;
        //Token Contract
        tokenContract = _tokenContract;
        
        //Token price
        tokenPrice = _tokenPrice;
    }
    //multiply
    function multiply(uint x,uint y) internal pure returns (uint z) {
        require(y==0 || (z=x*y)/y==x);
    }
    //BUy token
    function buyTokens(uint256 _numberOfTokens) public payable {

        //Require that value is eaual to tokens
        require(msg.value == multiply(_numberOfTokens,tokenPrice));
        //Require that the contract has enough tokens
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        //Require that a transfer is successful

        //Keep track of tokenSold
        tokensSold+= _numberOfTokens;
        //Trigger Sell event
        emit Sell(msg.sender, _numberOfTokens);
    }

     //Ending Token MufidTokenSale
    function endSale() public {
        //require admin
        require(msg.sender == admin);
        // Transfer remaining dapp tokens to admin
        require(tokenContract.transfer(admin,tokenContract.balanceOf(address(this))));
        //Destroy contract
        selfdestruct(payable(admin));
    }
}
