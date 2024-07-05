// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenPair.sol";

contract PairFactory {
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    function createPair(address tokenA, address tokenB) public returns (address pair) {
        /**
         * TODO: Implement pair deployment using CREATE2
         *
         * Imagine that you already have 2 tokens present. Your goal is to create pool for the token-pair that is not present yet.
         * You should map the two tokens to the pair created and emit an event once the pair creation is completed.
         * Make sure to handle the following error scenarios and more
         * 1. identical tokens in the pool.
         * 2. having zero address.
         * 3. adding a pair that already exists.
         */
    }

    function calculatePairAddress(address tokenA, address tokenB) public view returns (address) {
        /**
         * TODO: Implement pair address calculation.
         * The goal of this method is to calculate the Pair addresses when two token addresses are provided.
         */
    }

    function getPairs(address tokenA, address tokenB) public returns (address) {
        // TODO: returns the pair address for two tokens, creating the pair if it doesn't exist yet.
    }
}
