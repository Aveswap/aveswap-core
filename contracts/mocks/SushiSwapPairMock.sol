// SPDX-License-Identifier: MIT

pragma solidity 0.5.16;

import "../uniswapv2/AveswapV2Pair.sol";

contract SushiSwapPairMock is AveswapV2Pair {
    constructor() public AveswapV2Pair() {}
}