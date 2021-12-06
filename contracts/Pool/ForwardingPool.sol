// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IPaxEmitter.sol";
import "../interfaces/IPax.sol";
import "../interfaces/IForwardingPool.sol";

contract ForwardingPool is Ownable, IForwardingPool {
	IPaxEmitter public paxEmitter;
	IPax public pax;
	uint256 public pid;
	address public to;

	constructor(
		IPaxEmitter _paxEmitter,
		uint256 _pid,
		address _to
	) {
		paxEmitter = _paxEmitter;
		pax = _paxEmitter.pax();
		pid = _pid;
		to = _to;
	}

	function setTo(address _to) external onlyOwner {
		to = _to;
		emit SetTo(_to);
	}

	function forward() external onlyOwner {
		paxEmitter.updatePool(pid);
		pax.transfer(to, pax.balanceOf(address(this)));
	}
}
