// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract AryaToken {
  //name
  string public name="Arya Token";
  //symbol
  string public symbol="Arya";
  //standard
  string public standard="Arya Token v1.0";
  uint256 public totalSupply;

  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _value
    );
    
  //approve
  event Approval(
    address indexed _owner,
    address indexed _spender,
    uint256 _value
  );  
  mapping(address => uint256) public balanceOf;
  mapping(address=>mapping(address => uint256)) public allowance;
  //allowance

  constructor(uint256 _initialSupply){
    balanceOf[msg.sender]=_initialSupply;
    totalSupply=_initialSupply;
    //allocate the initial supply
  }

  //transfer
  function transfer(address _to,uint256 _value) public returns (bool success){
  //exception if account doesn't enough
  require(balanceOf[msg.sender] >= _value);
  //transfer the balance
  balanceOf[msg.sender] -= _value;
  balanceOf[_to] += _value;

 emit Transfer(msg.sender, _to, _value);
  return true;
  }

  //approve function
 function approve(address _spender,uint256 _value) public returns(bool success){
  //allowance
  allowance[msg.sender][_spender]=_value;
  //approve events
  emit Approval(msg.sender,_spender,_value);
  return true;
 }
  //transferFrom
 function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
  //require from has enough tokens
  require(_value<=balanceOf[_from]);
  
  //require allowance is big enough 
  require(_value<=allowance[_from][msg.sender]);
  
  //change the balance
  balanceOf[_from] -= _value;
  balanceOf[_to] += _value;
  
  //update the allowance
  allowance[_from][msg.sender]-=_value;
  
  //transfer event
  emit Transfer(_from, _to, _value);
  
  //return boolean
  return true;
 }
}


