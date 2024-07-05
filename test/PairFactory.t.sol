// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/PairFactory.sol";
import "../src/TokenPair.sol";

contract PairFactoryTest is Test {
    PairFactory public factory;
    address public constant TOKEN_A = address(0x1111111111111111111111111111111111111111);
    address public constant TOKEN_B = address(0x2222222222222222222222222222222222222222);
    address public constant TOKEN_C = address(0x3333333333333333333333333333333333333333);

    function setUp() public {
        factory = new PairFactory();
    }

    function testCalculatePairAddress() public view {
        address calculatedAddress = factory.calculatePairAddress(TOKEN_A, TOKEN_B);
        assertFalse(calculatedAddress == address(0), "Calculated address should not be zero");

        address calculatedAddressReverse = factory.calculatePairAddress(TOKEN_B, TOKEN_A);
        assertEq(calculatedAddress, calculatedAddressReverse, "Address calculation should be order-independent");
    }

    function testCreatePair() public {
        address pair = factory.createPair(TOKEN_A, TOKEN_B);
        assertFalse(pair == address(0), "Created pair address should not be zero");

        address storedPair = factory.getPair(TOKEN_A, TOKEN_B);
        assertEq(pair, storedPair, "Stored pair address should match created pair address");

        address storedPairReverse = factory.getPair(TOKEN_B, TOKEN_A);
        assertEq(pair, storedPairReverse, "Stored pair address should be accessible with tokens in either order");
    }

    function testPredictAndCreatePair() public {
        address predictedAddress = factory.calculatePairAddress(TOKEN_A, TOKEN_B);
        address createdPairAddress = factory.createPair(TOKEN_A, TOKEN_B);
        assertEq(predictedAddress, createdPairAddress, "Predicted address should match created pair address");
    }

    function testCannotCreateDuplicatePair() public {
        factory.createPair(TOKEN_A, TOKEN_B);
        vm.expectRevert("PAIR_EXISTS");
        factory.createPair(TOKEN_A, TOKEN_B);
    }

    function testCannotCreatePairWithIdenticalTokens() public {
        vm.expectRevert("IDENTICAL_ADDRESSES");
        factory.createPair(TOKEN_A, TOKEN_A);
    }

    function testCannotCreatePairWithZeroAddress() public {
        vm.expectRevert("ZERO_ADDRESS");
        factory.createPair(TOKEN_A, address(0));
    }

    function testMultiplePairCreation() public {
        address pair1 = factory.createPair(TOKEN_A, TOKEN_B);
        address pair2 = factory.createPair(TOKEN_B, TOKEN_C);
        address pair3 = factory.createPair(TOKEN_A, TOKEN_C);

        assertFalse(pair1 == pair2, "Different token pairs should have different addresses");
        assertFalse(pair1 == pair3, "Different token pairs should have different addresses");
        assertFalse(pair2 == pair3, "Different token pairs should have different addresses");
    }

    function testPairContractState() public {
        address pairAddress = factory.createPair(TOKEN_A, TOKEN_B);
        TokenPair pair = TokenPair(pairAddress);

        assertEq(pair.token0(), TOKEN_A < TOKEN_B ? TOKEN_A : TOKEN_B, "token0 should be the smaller address");
        assertEq(pair.token1(), TOKEN_A < TOKEN_B ? TOKEN_B : TOKEN_A, "token1 should be the larger address");
    }
}
