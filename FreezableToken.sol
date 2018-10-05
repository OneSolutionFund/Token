pragma solidity ^0.4.24;

import "./StandardToken.sol";
import "./Ownable.sol";


contract FreezableToken is StandardToken, Ownable {

    mapping(address => uint256) freezes;
    mapping(address => uint256) freezeTime;

    function freeze(address from, uint256 amount, uint expired_timestamp) public onlyOwner {

        freezes[from]     = amount;
        freezeTime[from]  = expired_timestamp;
    }

    modifier isUnfreezed(address from, uint256 amount) {

        if (now < freezeTime[from]) {
            require(balances[from] - amount >= freezes[from]);
        }
        _;
    }

    function transfer(
        address _to,
        uint256 _value
    )
        public
        isUnfreezed(msg.sender, _value)
        returns (bool)
    {
        return super.transfer(_to, _value);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    )
        public
        isUnfreezed(_from, _value)
        returns (bool)
    {
        return super.transferFrom(_from, _to, _value);
    }

}