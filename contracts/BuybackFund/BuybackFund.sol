// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/access/Ownable.sol";
import "../openzeppelin/contracts/utils/Context.sol";
import "../interfaces/IPax.sol";

contract BuybackFund is Context, Ownable {
	IPax public pax;
	address public receiver;

	constructor(IPax _pax, address _receiver) {
		pax = _pax;
		receiver = _receiver;
	}

	function setReceiver(address _receiver) external onlyOwner {
		receiver = _receiver;
	}

	function transferToReceiver() external onlyOwner {
		pax.transfer(receiver, pax.balanceOf(address(this)));
	}
}
