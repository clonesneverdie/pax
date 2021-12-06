// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IBooth {
    
    event Stake(address indexed owner, uint256 amount);
    event Unstake(address indexed owner, uint256 share);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function stake(uint256 amount) external;
    function unstake(uint256 share) external;
}
