// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../interfaces/IWhitehole.sol";
import "../interfaces/IPax.sol";

contract Whitehole is Context, ERC20, IWhitehole {
	using SafeMath for uint256;

	IPax public pax;

	constructor(IPax _pax) ERC20("CND Paxset", "PAXSET") {
		pax = _pax;
	}

	function stake(uint256 amount) external {
		uint256 totalPax = pax.balanceOf(address(this));
		uint256 totalShares = totalSupply();
		if (totalShares == 0 || totalPax == 0) {
			_mint(_msgSender(), amount);
		} else {
			uint256 what = amount.mul(totalShares).div(totalPax);
			_mint(_msgSender(), what);
		}
		pax.transferFrom(_msgSender(), address(this), amount);
		emit Stake(_msgSender(), amount);
	}

	function unstake(uint256 share) external {
		uint256 totalShares = totalSupply();
		uint256 what = share.mul(pax.balanceOf(address(this))).div(totalShares);
		_burn(_msgSender(), share);
		pax.transfer(_msgSender(), what);
		emit Unstake(_msgSender(), share);
	}
}
