// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IBurnPool {
	function pid() external view returns (uint256);

	function burn() external;
}
