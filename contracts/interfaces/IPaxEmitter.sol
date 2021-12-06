// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./IPax.sol";

interface IPaxEmitter {

    event Add(address to, uint256 allocPoint);
    event Set(uint256 indexed pid, uint256 allocPoint);
    event SetEmissionPerBlock(uint256 emissionPerBlock);

    function pax() external view returns (IPax);
    function emissionPerBlock() external view returns (uint256);
    function started() external view returns (bool);

    function poolCount() external view returns (uint256);
    function poolInfo(uint256 pid) external view returns (
        address to,
        uint256 allocPoint,
        uint256 lastEmitBlock
    );
    function totalAllocPoint() external view returns (uint256);

    function pendingPax(uint256 pid) external view returns (uint256);
    function updatePool(uint256 pid) external;
}
