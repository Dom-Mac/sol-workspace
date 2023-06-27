// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import {FreeENSToken} from "contracts/FreeENSToken.sol";
import {MockTimelock} from "contracts/MockTimelock.sol";
import {MockENSGovernor} from "contracts/MockENSGovernor.sol";

contract ENSTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    FreeENSToken public ensToken;
    MockTimelock public timelock;
    MockENSGovernor public governor;

    uint256 public freeSupply = 100_000 ether;
    uint256 public airdropSupply = 100_000 ether;
    uint256 public claimPeriodEnds_ = 100 days;
    address public user = address(333);
    uint256 public minDelay = 1 days;

    //*********************************************************************//
    // ------------------------------ setup ------------------------------ //
    //*********************************************************************//

    function setUp() public virtual override {
        Setup.setUp();

        address[] memory proposers = new address[](1);
        proposers[0] = user;

        ensToken = new FreeENSToken(claimPeriodEnds_, freeSupply, airdropSupply);

        timelock = new MockTimelock(minDelay, proposers, proposers, user);

        governor = new MockENSGovernor(ensToken, timelock);
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testDeploy() public {
        assertTrue(address(ensToken) != address(0));
        assertTrue(address(timelock) != address(0));
        assertTrue(address(governor) != address(0));
    }

    function testFreeMint() public {
        ensToken.freeMint(user, freeSupply);

        assertEq(ensToken.balanceOf(user), freeSupply);
    }
}
