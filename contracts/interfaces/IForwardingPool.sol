// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface IForwardingPool {
	event SetTo(address indexed to);

	function pid() external view returns (uint256);

	function to() external view returns (address);

	function forward() external;
}
