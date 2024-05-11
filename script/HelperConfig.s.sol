// 1. Deploy mocks when we are on local anvil chain
// 2. Keep track of contract address across different chains
// testnet and mainnet of contract ETH/USD is different contract and different chain

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";
import {Script} from "../lib/forge-std/src/Script.sol";

contract HelperConfig is Script {
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }

    NetworkConfig public activeNetwork;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetwork = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetwork = getMainnetEthConfig();
        } else {
            activeNetwork = getAnvilEthConfig();
        }
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory config = NetworkConfig(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return config;
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory config = NetworkConfig(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return config;
    }

    function getAnvilEthConfig() public returns (NetworkConfig memory) {
        // if we have active network before
        if (activeNetwork.priceFeed != address(0)) {
            return activeNetwork;
        }

        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory config = NetworkConfig({priceFeed: address(mockV3Aggregator)});
        return config;
    }
}
