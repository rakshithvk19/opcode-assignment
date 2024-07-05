// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenPair {
    address public token0;
    address public token1;

    constructor(address _token0, address _token1) {
        require(_token0 != _token1, "IDENTICAL_ADDRESSES");
        (token0, token1) = _token0 < _token1 ? (_token0, _token1) : (_token1, _token0);
    }
}
