// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "../interfaces/IPax.sol";

contract MultiAirdrop {
	IPax public pax;
	address public owner;

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	constructor(address _pax) {
		pax = IPax(_pax);
		owner = msg.sender;
	}

	function listAirdrop(
		address from,
		address[] memory user,
		uint256[] memory tokenAmount
	) public onlyOwner {
		for (uint256 i = 0; i < user.length; i++) {
			address reciever = user[i];
			uint256 amount = tokenAmount[i];
			pax.transferFrom(from, reciever, amount);
		}
	}
}
