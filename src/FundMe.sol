// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    mapping(address => uint256) private s_addressToAmountFunded;
    address[] private s_funders;

    address private immutable i_owner;
    // tested
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    AggregatorV3Interface private s_priceFeed;

    constructor(address _priceFeed) {
        s_priceFeed = AggregatorV3Interface(_priceFeed);
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
        return s_priceFeed.version();
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) revert FundMe__NotOwner();
        _;
    }

    function withdraw() public onlyOwner {
        uint length = s_funders.length;
        for (uint256 funderIndex = 0; funderIndex < length; funderIndex++) {
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);

        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

    /*
    view and pure functions getters
     */

    function getAddressToAmountFunded(address _address) external view returns (uint256) {
        return s_addressToAmountFunded[_address];
    }

    function getFunders(uint256 _index) external view returns (address) {
        return s_funders[_index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }
}
