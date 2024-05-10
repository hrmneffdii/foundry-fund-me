// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("USER");
    uint256 constant SEND_VALUE = 2e18;
    uint256 constant STARTING_BALANCES = 10e18;

    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCES);
    }

    function testMinimumUSD() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

   
    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundSucceedsWithEnoughETH() public fund {
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE); // USER has 5 ETH
    }

    modifier fund() {
        vm.prank(USER); // the next tx will be sent from USER
        fundMe.fund{value: SEND_VALUE}(); //USER will send 5 ETH
        _;
    }

    function testAddsFunderToArraysOfFunders() public fund {
        address funders = fundMe.getFunders(0);
        assertEq(funders, USER);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithDrawWithASingleFunder() public fund {
        // arrange
        uint startingOwnerBalances = fundMe.getOwner().balance;
        uint startingFundMeBalance = address(fundMe).balance;

        // act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // assert
        uint endingOwnerBalances = fundMe.getOwner().balance;
        uint endingFundMeBalance = address(fundMe).balance;
        
        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalances, endingOwnerBalances); 
    }

    function testWithDrawWithMultipleFunders() public fund {
        // arrange
        uint160 numbersOfFunders = 10;
        uint160 indexStart = 1;

        for (uint160 i = indexStart ; i < numbersOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint startingOwnerBalances = fundMe.getOwner().balance;
        uint startingFundMeBalance = address(fundMe).balance;


        // act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        // assert
        uint endingOwnerBalances = fundMe.getOwner().balance;
        uint endingFundMeBalance = address(fundMe).balance;
        
        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalances, endingOwnerBalances);
    }

    function testWithDrawWithMultipleFundersCheaper() public fund {
        // arrange
        uint160 numbersOfFunders = 10;
        uint160 indexStart = 1;

        for (uint160 i = indexStart ; i < numbersOfFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint startingOwnerBalances = fundMe.getOwner().balance;
        uint startingFundMeBalance = address(fundMe).balance;


        // act
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperWithdraw();
        vm.stopPrank();

        // assert
        uint endingOwnerBalances = fundMe.getOwner().balance;
        uint endingFundMeBalance = address(fundMe).balance;
        
        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalances, endingOwnerBalances);
    }
}
