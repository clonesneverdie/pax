// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../interfaces/IPaxEmitter.sol";
import "../interfaces/IPax.sol";
import "../interfaces/IBurnPool.sol";

contract BurnPool is IBurnPool {
	IPaxEmitter public paxEmitter;
	IPax public pax;
	uint256 public pid;

	constructor(IPaxEmitter _paxEmitter, uint256 _pid) {
		paxEmitter = _paxEmitter;
		pax = _paxEmitter.pax();
		pid = _pid;
	}

	function burn() external {
		paxEmitter.updatePool(pid);
		pax.burn(pax.balanceOf(address(this)));
	}
}
