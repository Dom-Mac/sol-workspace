// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/console2.sol";
import "./helper/Setup.sol";
import "contracts/FreeENSToken.sol";
import "contracts/TimelockController.sol";
import {ENSGovernor} from "contracts/ENSGovernor.sol";

contract ENSTest is Setup {
    //*********************************************************************//
    // ----------------------------- storage ----------------------------- //
    //*********************************************************************//

    FreeENSToken public ensToken;
    TimelockController public timelock;
    ENSGovernor public governor;

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
        proposers[0] = address(1);

        ensToken = new FreeENSToken(claimPeriodEnds_, freeSupply, airdropSupply);

        timelock = new TimelockController(minDelay, proposers, proposers);

        // governor = new ENSGovernor(ensToken, timelock);
    }

    //*********************************************************************//
    // ------------------------------ tests ------------------------------ //
    //*********************************************************************//

    function testDeploy() public {
        assertTrue(address(ensToken) != address(0));
        assertTrue(address(timelock) != address(0));
    }

    function testFreeMint() public {
        ensToken.mint(user, freeSupply);

        assertEq(ensToken.balanceOf(user), freeSupply);
    }
}
