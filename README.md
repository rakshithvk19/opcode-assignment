# **CREATE2 Exercise: Uniswap Pair Factory**

# **Objective**

Create a factory contract that deploys new token pair contracts using CREATE2, mimicking Uniswap's pair creation mechanism.

# Outcomes

This exercise will give students practical experience with CREATE2 in a context similar to Uniswap, helping them understand its application in DeFi protocols. It demonstrates how CREATE2 enables predetermining contract addresses without on-chain lookups, which is crucial for gas efficiency and user experience in decentralized exchanges.

# To-Do

1. Implement `createPair` function that creates a pool of 2 tokens and deploys the same using CREATE2 opcode.
2. Implement `calculatePairAddress` function that calculates the pair address of the two tokens.
3. Implement a `getPair` function that returns the pair address for two tokens, creating the pair if it doesn't exist yet.

# How to solve

- Git clone the Repo

- Install dependencies
    ```shell
    $ forge install
    ```
- Fill in the code for the functions.
- Run the following command and make sure all the test cases are passing.
    ```shell
    $ forge test
    ```

# Reading Materials

- [Understanding Keccak256 Hash](https://he3.app/en/blogs/understanding-keccak256-hash-a-guide-for-developers/)
- [Usage of abi.encodePacked](https://medium.com/coinmonks/abi-encode-abi-encodepacked-and-abi-decode-in-solidity-42c19336a589)
- [Type casting in Solidity](https://medium.com/coinmonks/learn-solidity-lesson-22-type-casting-656d164b9991)
- [CREATE2 EIP](https://eips.ethereum.org/EIPS/eip-1014)