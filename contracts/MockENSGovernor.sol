// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "governance/contracts/ENSGovernor.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract MockENSGovernor is ENSGovernor {
    constructor(ERC20Votes _token, TimelockController _timelock) ENSGovernor(_token, _timelock) {}
}
