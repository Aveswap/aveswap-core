pragma solidity >=0.5.0;

interface IAveswapV2Callee {
    function AveswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external;
}
