// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IWhitehole {
	event Stake(address indexed owner, uint256 amount);
	event Unstake(address indexed owner, uint256 share);

	function stake(uint256 amount) external;

	function unstake(uint256 share) external;
}
