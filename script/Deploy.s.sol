// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "forge-std/Script.sol";
import {FreeENSToken} from "contracts/FreeENSToken.sol";
import {MockTimelock} from "contracts/MockTimelock.sol";
import {MockENSGovernor} from "contracts/MockENSGovernor.sol";

contract DeployScript is Script {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    uint256 public freeSupply = 100_000 ether;
    uint256 public airdropSupply = 100_000 ether;
    uint256 public claimPeriodEnds_ = 100 days;
    address public user = address(333);
    uint256 public minDelay = 1 days;

    function run() public returns (FreeENSToken ensToken, MockTimelock timelock, MockENSGovernor governor) {
        // vm.startBroadcast(deployerPrivateKey);

        address[] memory proposers = new address[](1);
        proposers[0] = msg.sender;

        ensToken = new FreeENSToken(claimPeriodEnds_, freeSupply, airdropSupply);

        timelock = new MockTimelock(minDelay, proposers, proposers, msg.sender);

        governor = new MockENSGovernor(ensToken, timelock);

        // vm.stopBroadcast();
    }
}
