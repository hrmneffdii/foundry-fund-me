// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumUSD() external view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
    
    function testOwnerIsMsgSender() external view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    // What can we do to work with addressses outside the system?
    // 1. Unit - Testing a specific part of our code
    // 2. Integration - Testing how our code works with other parts of our code
    // 3. Forked - Testing our code on a simulated real environment
    // 4. Staging - Testing our code on a real environment that is not production

    function testPriceFeedVersionIsAccurate() external view {
        uint version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
