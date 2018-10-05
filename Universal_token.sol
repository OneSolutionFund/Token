pragma solidity ^0.4.24;

import "./FreezableToken.sol";
import "./MintableToken.sol";

contract UniversalToken is FreezableToken, MintableToken {

    string  public name;
    string  public symbol;
    uint256 public limit;
    uint8   public decimals;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _limit) public {

        name     = _name;
        symbol   = _symbol;
        limit    = _limit;
        decimals = _decimals;

        owner = msg.sender;
    }

    function () public payable { revert(); }

}