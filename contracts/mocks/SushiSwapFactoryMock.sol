// SPDX-License-Identifier: MIT

pragma solidity 0.5.16;

import "../uniswapv2/AveswapV2Factory.sol";

contract SushiSwapFactoryMock is AveswapV2Factory {
    constructor(address _feeToSetter) public AveswapV2Factory(_feeToSetter) {}
}