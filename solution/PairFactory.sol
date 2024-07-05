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
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), "ZERO_ADDRESS");
        require(getPair[token0][token1] == address(0), "PAIR_EXISTS");

        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        pair = address(new TokenPair{salt: salt}(token0, token1));

        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // Populate reverse mapping
        allPairs.push(pair);

        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function calculatePairAddress(address tokenA, address tokenB) public view returns (address) {
        /**
         * TODO: Implement pair address calculation.
         * The goal of this method is to calculate the Pair addresses when two token addresses are provided.
         */
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        bytes memory bytecode = type(TokenPair).creationCode;
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), address(this), salt, keccak256(abi.encodePacked(bytecode, abi.encode(token0, token1)))
            )
        );
        return address(uint160(uint256(hash)));
    }

    function getPairs(address tokenA, address tokenB) public returns (address) {
        // TODO: returns the pair address for two tokens, creating the pair if it doesn't exist yet.
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        address pair = getPair[token0][token1];
        if (pair == address(0)) {
            pair = createPair(token0, token1);
        }
        return pair;
    }
}
