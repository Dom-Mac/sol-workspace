// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ENSToken.sol";

/**
 * @dev Free ENS token
 */
contract FreeENSToken is ENSToken {
    constructor(uint256 freeSupply_, uint256 airdropSupply_, uint256 claimPeriodEnds_)
        ENSToken(freeSupply_, airdropSupply_, claimPeriodEnds_)
    {}

    function mint(address to_, uint256 amount_) public override {
        _mint(to_, amount_);
    }
}
